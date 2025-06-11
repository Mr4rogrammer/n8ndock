const puppeteer = require("puppeteer");

(async () => {
  const username = process.argv[2];

  const browser = await puppeteer.launch({
    headless: true,
    args: ["--no-sandbox", "--disable-setuid-sandbox"]
  });

  const page = await browser.newPage();
  await page.goto(`https://www.instagram.com/${username}/`, {
    waitUntil: "domcontentloaded"
  });

  const html = await page.content();
  const jsonMatch = html.match(/<script type="text\/javascript">window\._sharedData = (.*?);<\/script>/);
  if (!jsonMatch) {
    console.error("Data not found");
    process.exit(1);
  }

  const sharedData = JSON.parse(jsonMatch[1]);
  const edges = sharedData.entry_data?.ProfilePage?.[0]?.graphql?.user?.edge_owner_to_timeline_media?.edges;

  const posts = edges?.map(edge => ({
    image: edge.node.display_url,
    caption: edge.node.edge_media_to_caption.edges[0]?.node.text || "",
    link: `https://www.instagram.com/p/${edge.node.shortcode}/`,
    timestamp: edge.node.taken_at_timestamp
  }));

  console.log(JSON.stringify(posts));
  await browser.close();
})();

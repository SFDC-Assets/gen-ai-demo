#!/usr/bin/env node

const puppeteer = require("puppeteer");
const utils = require("./utils");

(async function () {
  const browser = await puppeteer.launch({
    headless: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-features=site-per-process",

      "--disable-dev-shm-usage",
      "--disable-accelerated-2d-canvas",
      "--no-first-run",
      "--no-zygote",
      "--disable-gpu"
    ]
  });

  console.log(process.argv);
  var targetUsername = process.argv[2]; //0 index

  var frontdoor = null;
  if (targetUsername)
    frontdoor = await utils.runSFDXCommand(
      `sfdx force:org:open -u ${targetUsername} -r --json`
    );
  else frontdoor = await utils.runSFDXCommand(`sfdx force:org:open -r --json`);

  console.log(frontdoor.result.url);

  var urlData = frontdoor.result.url;
  var scubbedUrl = urlData.replace("https://", "");
  var parsedUrl = scubbedUrl.split("/");
  var fqdn = parsedUrl[0];
  var parsedFqdn = fqdn.split(".");

  const timeout = 30000;
  const page = await browser.newPage();
  page.setDefaultTimeout(240000);
  await page.goto(`${frontdoor.result.url}`);

  await utils.sleep(5000);

  // await page.waitFor(10000);
  //go to /lightning/setup/EinsteinGPTSetup/home
  // var targetOSSettings = `https://${parsedFqdn[0]}.scratch.lightning.force.com/lightning/setup/EinsteinGPTSetup/home`;
  // console.log(targetOSSettings);

  // await Promise.all([
  //   page.waitForNavigation({ timeout: timeout, waitUntil: "load" }),
  //   page.waitForNavigation({ timeout: timeout, waitUntil: "networkidle2" }),
  //   page.goto(targetOSSettings)
  // ]);

  // await page.setViewport({ width: 654, height: 813 });
  // await utils.sleep(5000);

  // try {
  //   {
  //     const targetPage = page;
  //     await puppeteer.Locator.race([
  //       targetPage.locator("span.slds-checkbox_faux")
  //     ])
  //       .setTimeout(timeout)
  //       .click({
  //         offset: {
  //           x: 22,
  //           y: 9
  //         }
  //       });
  //   }
  // } catch (error) {
  //   console.log(error);
  // }

  // await utils.sleep(5000);

  //go to /lightning/setup/EinsteinGPTSetup/home
  var targetOSSettings = `https://${parsedFqdn[0]}.scratch.lightning.force.com/lightning/setup/EinsteinCopilot/home`;
  console.log(targetOSSettings);

  await Promise.all([
    page.waitForNavigation({ timeout: timeout, waitUntil: "load" }),
    page.waitForNavigation({ timeout: timeout, waitUntil: "networkidle2" }),
    page.goto(targetOSSettings)
  ]);

  await page.setViewport({ width: 654, height: 813 });
  await utils.sleep(5000);

  try {
    {
      const targetPage = page;
      await puppeteer.Locator.race([
        targetPage.locator("span.slds-checkbox_faux")
      ])
        .setTimeout(timeout)
        .click({
          offset: {
            x: 23,
            y: 11.5
          }
        });
    }
  } catch (error) {
    console.log(error);
  }

  await utils.sleep(5000);

  await browser.close();
})();

import { remote } from "webdriverio";

async function cartTest() {
    console.log("--- 🛒 Starting Cart Test with Direct Taps ---");

    const opts = {
        path: '/',
        port: 4723,
        capabilities: {
            platformName: "Android",
            "appium:deviceName": "509ae2e0",
            "appium:automationName": "UiAutomator2",
            "appium:noReset": true,
            "appium:appPackage": "com.example.laza_app_new",
            "appium:appActivity": ".MainActivity" 
        }
    };

    let driver;
    try {
        driver = await remote(opts);
        await driver.pause(3000); 

        // 1. الضغط على أول منتج (غالبا في نص الشاشة فوق)
        console.log("🎯 Tapping on Product...");
        await driver.touchAction({ action: 'tap', x: 300, y: 800 }); 
        await driver.pause(3000);

        // 2. الضغط على زرار Add to Cart (غالبا بيكون تحت خالص)
        console.log("🎯 Tapping Add to Cart Button...");
        await driver.touchAction({ action: 'tap', x: 500, y: 1800 }); 
        await driver.pause(2000);

        // 3. الضغط على أيقونة السلة (فوق على اليمين غالبا)
        console.log("🎯 Opening Cart...");
        await driver.touchAction({ action: 'tap', x: 900, y: 150 }); 
        await driver.pause(3000);

        console.log("✅ Done! If the screen moved, SAVE THIS.");

    } catch (err) {
        console.error("❌ Error:", err.message);
    } finally {
        if (driver) {
            await driver.deleteSession();
        }
    }
}

cartTest();
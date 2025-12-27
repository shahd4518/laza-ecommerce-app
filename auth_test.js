import { remote } from "webdriverio";

async function main() {
    console.log("--- Connecting to Appium Server ---");

    const opts = {
        path: '/',
        port: 4723,
        capabilities: {
            platformName: "Android",
            "appium:deviceName": "509ae2e0",
            "appium:automationName": "UiAutomator2",
            "appium:newCommandTimeout": 300,
            "appium:noReset": true, // عشان ميمسحش بيانات التطبيق كل شوية
            // لو مش عارفة الـ Package Name، ارجعي لسطر الـ app بس اتأكدي إن الملف مكانه صح
            "appium:appPackage": "com.example.laza_app_new", // اتأكدي من الاسم ده في ملف build.gradle
            "appium:appActivity": ".MainActivity" 
        }
    };

    let driver;
    try {
        driver = await remote(opts);
        console.log("--- Start New Test Case: Login ---");

        // استني الشاشة تظهر بجد مش مجرد وقت وخلاص
        const emailField = await driver.$("//android.widget.EditText[1]");
        await emailField.waitForDisplayed({ timeout: 20000 });

        console.log("Finding Email field and entering value...");
        await emailField.click(); // لازم كليك الأول عشان الـ Focus
        await emailField.clearValue();
        await emailField.setValue("shahd76@gmail.com");
        console.log("✅ Email entered!");

        const passField = await driver.$("//android.widget.EditText[2]");
        await passField.click();
        await passField.clearValue();
        await passField.setValue("shahd maher 5566");
        console.log("✅ Password entered!");

        // لو الكيبورد لسه طالع، اخفيه عشان زرار اللوجن يبان
        if (await driver.isKeyboardShown()) {
            await driver.hideKeyboard();
        }

        const loginBtn = await driver.$("//android.widget.Button");
        await loginBtn.click();
        console.log("✅ Login Clicked!");

        await driver.pause(5000); 
        console.log("--- Test Finished ---");

    } catch (err) {
        console.error("❌ Error during test:", err.message);
    } finally {
        if (driver) {
            await driver.deleteSession();
            console.log("--- Session Closed ---");
        }
    }
}

main();
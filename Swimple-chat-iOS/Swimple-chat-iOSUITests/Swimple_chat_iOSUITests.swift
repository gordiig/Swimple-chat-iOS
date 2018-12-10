//
//  Swimple_chat_iOSUITests.swift
//  Swimple-chat-iOSUITests
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import XCTest

class Swimple_chat_iOSUITests: XCTestCase
{
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func login()
    {
        if !app.buttons["Log in"].isHittable
        {
            return
        }
        
        let usernameField = app.textFields["usernameTextField"]
        let passwordField = app.textFields["passwordTextField"]
        let loginButton = app.buttons["Log in"]
        
        if usernameField.exists
        {
            print("USERNAME TEXT FIELD EXISTS")
        }
        if passwordField.exists
        {
            print("PASSWORD FIELD EXISTS")
        }
        
        usernameField.tap()
        usernameField.typeText("gordiig")
        
        passwordField.tap()
        passwordField.typeText("qwerty123456")
        
        loginButton.tap()
        sleep(3)
    }
    
    func testGoToChatList()
    {
        self.login()
        let table = app.tables["chatListTableView"]
        let cell = table.staticTexts["admin2"]
        cell.tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
//        let cell2 = table.staticTexts["admin"]
//        cell2.tap()
        
        sleep(2)
    }
    
    func testPullToRefresh()
    {
        self.login()
        let table = app.tables["chatListTableView"]
//        let start = table.coordinate(withNormalizedOffset: CGVector(dx: 10, dy: 10))
//        let end = table.coordinate(withNormalizedOffset: CGVector(dx: 10, dy: 21))
        let cell = table.staticTexts["admin2"]
        let start = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let end = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 11))
        start.press(forDuration: 0, thenDragTo: end)
        
        sleep(2)
    }

}

//
//  Instructions.swift
//  Weathered
//
//  Created by Michael Amiro on 06/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

class Instructions {
    static let html = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Instructions on using Weathered</title>
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                        Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans",
                        "Helvetica Neue", sans-serif;
                }
            </style>
        </head>
        <body>
            <h1>Welcome to Weathered</h1>
            <p>Simple four step process of how to use the app is listed below:</p>
            <ol>
                <li>
                    <h3>Location Services</h3>
                    <p>
                        Allow for the app to use your location services. We need
                        access to your location services so as to get where you're
                        using the app from. We show the User location on the app. We
                        promise to keep it private.
                    </p>
                </li>
                <li>
                    <h3>Add a Favourite</h3>
                    <p>
                        Move the map marker around and once satisfied with the
                        location selected, click on the 'Favourite' Button to add it
                        onto your favourites.
                    </p>
                </li>
                <li>
                    <h3>Get the forecast</h3>
                    <p>
                        Select any of the locations on your list of favourites to
                        get the real-time and the 5 day forecast of the location.
                    </p>
                </li>
                <li>
                    <h3>Repeat</h3>
                    <p>
                        You can add as many locations as possible to your list of
                        favourites.
                    </p>
                </li>
            </ol>
            <h2>Upcoming Features</h2>
            <p>
                We are working extremely hard to make this app better and add new
                features, as requested. 😅
            </p>
            <ul>
                <li>
                    <p>Customize the Units desired</p>
                </li>
                <li>
                    <p>Manage your Favourite Locations</p>
                </li>
            </ul>
        </body>
        </html>
    """
}

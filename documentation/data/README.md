# Data Codebook

This guide provides information on the analytics modules in the **In Control of Effects** application and documents that data that is saved in log files.

## Contents

- [Introduction](#introduction)
- [Log Structure](#log-structure)
    - [Notes](#notes) 
- [Extracting Data](#extracting-data)
- [Example Log](#example-log)

## [Introduction](#introduction)

The In Control of Effects application has an analytics modules. This provides a series of methods for logging application interactions to file using a consistent format. This is important for understanding how the app is used (i.e., which buttons are clicked, session duration, etc.), which side effects were selected, results, errors, and other information. The analytics modules ask for or collect user identifying information, such as IP address, device, etc. Accounts are required to use the app, but accounts are anonymous.

## [Log structure](#log-structure)

Logs are saved as individual JSON files. All log filenames include the prefix `analytics_` and the time when the session was started in `yy_mm_dd_hhmmss` format. The structure of the log as a number of properties and nested objects. The basic structure is described in the following table.

| Property | Description |
| -------- | ----------- |
| name [^1](#note-1) | Name of the log file (`ice_analytics_module`) |
| version [^1](#note-1)  | Version of the application the log was generated under
| id | A unique identifier for the session. A random hash generated by Shiny's `session$token`
| timestamps | A nested object for session start and end time
| logged | A logical property that indicates of the user signed in to the application.
| client [^2](#note-2) | A nested object that logs the username and user account type 
| meta | A nested object that provides a session-level summary (errors, app restarts, side effect selections, times signed in and out)
| history | A nested object that contains a complete timeline of session interactions (from start to window close)
| selections [^3](#note-3) | A nested object containing a record of side effects selected.
| results [^3](#note-3) | A nested object containing a record of medication results returned.

### [Notes](#notes)

<ol>
<li id="note-1">These properties are set by the `analytics` module.</li>
<li id="note-2">Accounts are annonymous</li>
<li id="note-3">Each submission and result is assigned an Id that is links selections with corresponding log in `history`</li>
</ol>

## [Extracting Data](#extracting-data)

JSON files can be read into R using any JSON package (e.g., `jsonlite`, `rjson`, etc.).

```r
d <- rjson::fromJSON(file = "~/Github/iceApp/logs/analytics_20_10_20_201903.json")
```

The data is returned as a list and properties can be access using `$`.

```r
d$timestamps                       
#'> $started
#'> [1] "2020-10-20 20:18:55"
#'> 
#'> $ended
#'> [1] "2020-10-20 20:19:56"
```

Use `ls.str(d)` to view a summary of the structure. See the [Example Log](#example-log) section to see how nested properties are structured.

```r
ls.str(d)     
#'> client : List of 2
#'>  $ username: chr "wallaby"
#'>  $ usertype: chr "demo"
#'> history : List of 17
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'>  $ :List of 4
#'> id :  chr "2dc823b44adb341040d7f4d4926c3d54"
#'> logged :  logi TRUE
#'> meta : List of 5
#'>  $ errors        : num 0
#'>  $ restarts      : num 0
#'>  $ sign_in_count : num 1
#'>  $ sign_out_count: num 1
#'>  $ submits       : num 3
#'> name :  chr "ice_analytics_module"
#'> results : List of 3
#'>  $ :List of 3
#'>  $ :List of 3
#'>  $ :List of 3
#'> selections : List of 3
#'>  $ :List of 3
#'>  $ :List of 3
#'>  $ :List of 3
#'> timestamps : List of 2
#'>  $ started: chr "2020-10-20 20:18:55"
#'>  $ ended  : chr "2020-10-20 20:19:56"
#'> version :  chr "0.0.5"
```

## [Example Log](#example-log)

A sample application log is listed below. The filename is: `analytics_20_10_20_201903.json`

```json
{
  "name": "ice_analytics_module",
  "version": "0.0.5",
  "id": "2dc823b44adb341040d7f4d4926c3d54",
  "timestamps": {
    "started": "2020-10-20 20:18:55",
    "ended": "2020-10-20 20:19:56"
  },
  "logged": true,
  "client": {
    "username": "wallaby",
    "usertype": "demo"
  },
  "meta": {
    "errors": 0,
    "restarts": 0,
    "sign_in_count": 1,
    "sign_out_count": 1,
    "submits": 3
  },
  "history": [
    {
      "time": "2020-10-20 20:18:55",
      "id": "init",
      "item": "App Analytics",
      "description": "new session started"
    },
    {
      "time": "2020-10-20 20:19:08",
      "id": "btn_click",
      "item": "login",
      "description": "login form data submitted"
    },
    {
      "time": "2020-10-20 20:19:08",
      "id": "login",
      "item": "user logged in",
      "description": "user signed in as 'wallaby'"
    },
    {
      "time": "2020-10-20 20:19:26",
      "id": "btn_click",
      "item": "side_effects_submit",
      "description": "side effect selections were submitted"
    },
    {
      "time": "2020-10-20 20:19:26",
      "id": "selections",
      "item": "side effect selections",
      "description": "oEVx9eZl4Xx5jpJo"
    },
    {
      "time": "2020-10-20 20:19:26",
      "id": "btn_click",
      "item": "next_page",
      "description": "navigated to 'results' (page 6)"
    },
    {
      "time": "2020-10-20 20:19:26",
      "id": "results",
      "item": "medication recommendations saved",
      "description": "lLAR2Glb7vSsdrvx"
    },
    {
      "time": "2020-10-20 20:19:35",
      "id": "btn_click",
      "item": "side_effects_submit",
      "description": "side effect selections were submitted"
    },
    {
      "time": "2020-10-20 20:19:36",
      "id": "selections",
      "item": "side effect selections",
      "description": "Gs6rV4ZNGuvluH2n"
    },
    {
      "time": "2020-10-20 20:19:36",
      "id": "btn_click",
      "item": "next_page",
      "description": "navigated to 'results' (page 6)"
    },
    {
      "time": "2020-10-20 20:19:36",
      "id": "results",
      "item": "medication recommendations saved",
      "description": "YvlTtf8Bhe8mKGAB"
    },
    {
      "time": "2020-10-20 20:19:44",
      "id": "btn_click",
      "item": "side_effects_submit",
      "description": "side effect selections were submitted"
    },
    {
      "time": "2020-10-20 20:19:44",
      "id": "selections",
      "item": "side effect selections",
      "description": "CwzfgugEc0lZUxSI"
    },
    {
      "time": "2020-10-20 20:19:44",
      "id": "btn_click",
      "item": "next_page",
      "description": "navigated to 'results' (page 6)"
    },
    {
      "time": "2020-10-20 20:19:44",
      "id": "results",
      "item": "medication recommendations saved",
      "description": "WzGYY2VPJJfoyvX2"
    },
    {
      "time": "2020-10-20 20:19:54",
      "id": "logout",
      "item": "user logout",
      "description": "user logged out"
    },
    {
      "time": "2020-10-20 20:19:56",
      "id": "session",
      "item": "onSessionEnded",
      "description": "session has ended"
    }
  ],
  "selections": [
    {
      "time": "2020-10-20 20:19:26",
      "id": "oEVx9eZl4Xx5jpJo",
      "data": [
        {
          "akathisia": 0,
          "anticholinergic": 0,
          "antiparkinson": 0,
          "prolactin": 0,
          "qtc": 0,
          "sedation": 1,
          "weight_gain": 0
        }
      ]
    },
    {
      "time": "2020-10-20 20:19:36",
      "id": "Gs6rV4ZNGuvluH2n",
      "data": [
        {
          "akathisia": 0,
          "anticholinergic": 0,
          "antiparkinson": 0,
          "prolactin": 0,
          "qtc": 0,
          "sedation": 1,
          "weight_gain": 0
        }
      ]
    },
    {
      "time": "2020-10-20 20:19:44",
      "id": "CwzfgugEc0lZUxSI",
      "data": [
        {
          "akathisia": 0,
          "anticholinergic": 0,
          "antiparkinson": 0,
          "prolactin": 0,
          "qtc": 1,
          "sedation": 0,
          "weight_gain": 0
        }
      ]
    }
  ],
  "results": [
    {
      "time": "2020-10-20 20:19:26",
      "id": "lLAR2Glb7vSsdrvx",
      "data": [
        {
          "rx_rec_a": "Pimozide",
          "rx_rec_b": "Fluphenazine",
          "rx_rec_c": "Perphenazine",
          "rx_avoid_a": "Zuclopenthixol",
          "rx_avoid_b": "Zotepine",
          "rx_avoid_c": "Sulpiride"
        }
      ]
    },
    {
      "time": "2020-10-20 20:19:36",
      "id": "YvlTtf8Bhe8mKGAB",
      "data": [
        {
          "rx_rec_a": "Pimozide",
          "rx_rec_b": "Fluphenazine",
          "rx_rec_c": "Perphenazine",
          "rx_avoid_a": "Zuclopenthixol",
          "rx_avoid_b": "Zotepine",
          "rx_avoid_c": "Sulpiride"
        }
      ]
    },
    {
      "time": "2020-10-20 20:19:44",
      "id": "WzGYY2VPJJfoyvX2",
      "data": [
        {
          "rx_rec_a": "Lurasidone",
          "rx_rec_b": "Brexpiprazole",
          "rx_rec_c": "Cariprazine",
          "rx_avoid_a": "Sertindole",
          "rx_avoid_b": "Amisulpride",
          "rx_avoid_c": "Ziprasidone"
        }
      ]
    }
  ]
}
```
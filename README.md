# What is RudderStack?

[RudderStack](https://rudderstack.com/) is a **customer data pipeline tool** for collecting, routing and processing data from your websites, apps, cloud tools, and data warehouse.

With RudderStack, you can build customer data pipelines that connect your whole customer data stack and then make them smarter by triggering enrichment and activation in customer tools based on analysis in your data warehouse. Its easy-to-use SDKs and event source integrations, Cloud Extract integrations, transformations, and expansive library of destination and warehouse integrations makes building customer data pipelines for both event streaming and cloud-to-warehouse ELT simple. 

| Try **RudderStack Cloud Free** - a no time limit, no credit card required, completely free tier of [RudderStack Cloud](https://resources.rudderstack.com/rudderstack-cloud). Click [here](https://app.rudderlabs.com/signup?type=freetrial) to start building a smarter customer data pipeline today, with RudderStack Cloud Free. |
|:------|

Questions? Please join our [Slack channel](https://resources.rudderstack.com/join-rudderstack-slack) or read about us on [Product Hunt](https://www.producthunt.com/posts/rudderstack).

## Integrating CustomerIO with the RudderStack iOS SDK

> **_NOTE:_** `Rudder-CustomerIO` version `1.3.0` is compatible with the `CustomerIO/DataPipelines` version `3.2.2`. 

1. Add [CustomerIO](https://customer.io/) as a destination in the [RudderStack dashboard](https://app.rudderstack.com/).

2. Rudder-CustomerIO is available through [CocoaPods](https://cocoapods.org) and [Swift Package Manager (SPM)](https://www.swift.org/package-manager/). 

### CocoaPods
Add the following line to your Podfile and followed by `pod install`:

```ruby
pod 'Rudder-CustomerIO', '~> 1.3.0'
```

### Swift Package Manager (SPM)

You can also add the RudderStack iOS SDK via Swift Package Mangaer.

* Go to **File** -> **Add Package**, as shown:

![add_package](screenshots/add_package.png)

* Enter the package repository (`https://github.com/rudderlabs/rudder-integration-customerio-ios`) in the search bar.

*  In **Dependency Rule**, select **Exact Version** and enter latest as the value, as shown:

![add_package](screenshots/set_dependency.png)

* Select the project to which you want to add the package.

* Finally, click on **Add Package**.

#### Swift

## Initializing ```RudderClient```

Put this code in your ```AppDelegate.swift``` file under the method ```didFinishLaunchingWithOptions```
```
let configBuilder = RSConfigBuilder()
        .withDataPlaneUrl(DATA_PLANE_URL)
        .withLoglevel(RSLogLevelDebug)
        .withFactory(RudderCustomerIOFactory.instance)
            
RSClient.getInstance(WRITE_KEY, config: configBuilder.build())

```

## Setup the sample iOS app

1. Make a copy of the `SampleRudderConfig.plist` into the RudderConfig directory and rename it to `RudderConfig.plist`.
2. Fill the required details e.g., `WRITE_KEY` and `PROD_DATA_PLANE_URL`.
3. Start sending the events

## Sending Events

Follow the steps from the [RudderStack iOS SDK](https://github.com/rudderlabs/rudder-sdk-ios#sending-events) repo.

## Contact Us

If you come across any issues while configuring or using this integration, please feel free to start a conversation on our [Slack](https://resources.rudderstack.com/join-rudderstack-slack) channel. We will be happy to help you.

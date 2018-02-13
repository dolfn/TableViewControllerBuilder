# TableViewControllerBuilder

We created a framework that helps iOS engineers create **generic** table view controllers, with as little boiler plate code as possible. We don't like to repeat ourselves when we write code for a table view: create a table view data source, a table view delegate. We wanted a **cleaner** way.

## Objectives
1. Easily create a **generic** table view that can have any kind of cells or headers.
2. Focus on configuring the **UI elements** you're interested in (cells, table view headers), not on implementing table view data sources and other boiler plate code that is required to create a generic table view.
3. Use as clean of an architecture as possible

## How does it work
We created a builder (named `TableViewControllerBuilder`). It builds a view controller that can display any kind of cell in that table view.

## Installing the framework
Use our private pod.
1. Add our private podspec, in the first lines of your Podfile:
`source 'https://github.com/dolfn/Specs'`
2. Add the pod:
`pod 'TableViewControllerBuilder', '~> 0.3'`

## How to use it (explaining the basics)
We included an example project in the repository so you can check the code in that example. Or you can follow the instructions below.

You will notice that the framework forces you to create some separation of concerns.

To use the builder and other public resources available in the framework, you'll, of course, need to import it:
`import TableViewControllerBuilder`

The most important important pieces you need to have in your table view are cells. To display them, you need:
1. A **view model**. Its role is to specify the view (the table view controller) the information it needs to display: text, images, if the table view should be scrollable, the edge insets, background color etc.

In order to create one, you will need to implement the `TableViewModel` protocol. It is a generic protocol. So you will need to specify the data type that you will use to configure the cells or headers with:

```
typealias HeaderDisplayDataType = YourSectionHeaderDisplayDataType
typealias CellDisplayDataType = YourCellDisplayDataType
```
If you want more type of cells, create an `enum` that declares all the models that can be used to configure a unique type of cell. Like this:
```
enum ExampleCellDisplayDataType {
    case Complex(ComplexCellDisplayData)
    case Simple(SimpleCellDisplayData)
}
```
and specify this enum type: 
`typealias HeaderDisplayDataType = ExampleCellDisplayDataType`

You can check this in the example project we created.

After doing this, you'll need to implement the two properties, which the builder uses to configure the table view:
```
var shouldBeScrollable: Bool { get }
var sectionsDisplayData: [SectionDisplayDataType] { get }
```
In this way you just specify the information you need to display. That's what your view model should do. No extra nonesense.

2. A cell **configurator factory**. If you need more types of cells, you'll need more configurators. This object would configure the custom cell views that you create (by using a nib or code).

Please implement the `CellConfiguratorFactory` protocol. This protocol is also generic. So please specify the type of cell that you want to configure:

`typealias CellDisplayData = YourCellDisplayDataType`

Again, if you want to configure more types of cells, use an enum, like explained above.

Then you need to implement the generic function specified in the `CellConfiguratorFactory` protocol:
`func cellConfigurator(with cellDisplayData: YourCellDisplayDataType) -> AnyClosureCellConfigurator<YourCellDisplayDataType>`

Here is an example:
```
func cellConfigurator(with cellDisplayData: ExampleCellDisplayDataType) -> AnyClosureCellConfigurator<ExampleCellDisplayDataType> {
        switch cellDisplayData {
        case .Simple(let simpleCellData):
            let simpleCellConfigurator = ClosureCellConfigurator { (cell: DisclosureIndicatorTableViewCell, displayData: SimpleCellDisplayData) -> () in
                cell.textLabel?.text = displayData.title
            }
            return simpleCellConfigurator.erased.with(cellDisplayData: simpleCellData)
            
        case .Complex(let complexCellData):
            let cellConfigurator = ClosureCellConfigurator { (cell: TitleSubtitleTableViewCell, displayData: ComplexCellDisplayData) -> () in
                cell.title?.text = displayData.title
                cell.subtitle?.text = displayData.value
            }
            
            return cellConfigurator.erased.with(cellDisplayData: complexCellData)
        }
    }
```

## Advance usage
If you want more advanced examples, please check the Example project included in this repository.

# ARSelectableView

`ARSelectableView` is a for selection type.


## Selection Type
1. radio
2. checkbox
3. tag

## Usage

Firstly, download `ARSelectableView`.

```swift
add files in your project
```
By code, using initializer. Parameter `frame`

```swift
var selectionView: ARSelectionView?
```

```swift
var selectionView: ARSelectionView?
self.selectionView = ARSelectionView(frame: frame) // set frame as per requirement
self.view.addSubview(self.selectionView!) //add where You want 
```
### Control

Set selection type
```swift
self.selectionView?.selectionType = .radio 
```

Set array for selection of ARSelectModel
Ex 

let items = [ARSelectModel(title: "Shipping"),
                  ARSelectModel(title: "Billing")]

```swift
self.selectionView?.items = items
```

### Change properties

- `defaultButtonColor` : Seletion button default Color (UIColor.black)
- `selectedButtonColor`  : Seletion button selected Color (UIColor.black)
- `defaultTitleColor` :  Default Title Color (UIColor.black)
- `selectedTitleColor` : Selected Title Color (UIColor.black)
- `defaultCellBGColor` : Default Cell BG Color (UIColor.white) 
- `selectedCellBGColor` : Selected Cell BG Color (UIColor.white)
- Othor option available for this please lookout  

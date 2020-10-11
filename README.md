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
self.selectionView = ARSelectionView(frame: CGRect.zero)
self.view.addSubview(self.selectionView!)

selectionView?.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([self.selectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                             self.selectionView!.leftAnchor.constraint(equalTo: view.leftAnchor),
                             self.selectionView!.rightAnchor.constraint(equalTo: view.rightAnchor),
                             self.selectionView!.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/2)])
```
### Control

Set selection type
```swift
self.selectionView?.selectionType = .radio 
```

Set array for selection of ARSelectModel
Ex 

let items = [ARSelectModel(title: "Blues Music"),
                  ARSelectModel(title: "Jazz Music")]

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

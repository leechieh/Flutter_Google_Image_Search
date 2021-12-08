# Flutter_My_Places

A simple Fullter app that allow user to google image search through SerpAPI and display the result in the grid.  

## Run through
Once the app is running, the user is able to type in the term wish to search inside the text field then press submit. A grid view of the searched images will appear. The grid has pagination, and images are prefetched. Tapping the grid will display the original image and user can zoom in/out, save, and return to the gird.

## Dependencies
```yaml
dependencies:
  animations: ^2.0.2
  cached_network_image: ^3.2.0
  gallery_saver: ^2.3.2
  http: ^0.13.4
  permission_handler: ^8.3.0
  photo_view: ^0.13.0
  flutter_spinkit: ^5.1.0
  transparent_image: ^2.0.0
```

## Versioning
Version 1.01 

## Changes
Bug fixes, add animation and loading screen.

## Screenshot
<img src="screenshot/app.png" alt="drawing" width="216"/>

## To do list
* Switch to GetX for state management
* Implementation of RxDart
* Make it more pretty

## License
The contents of this repository are covered under the [MIT](LICENSE) License.
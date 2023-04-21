# auto_pagination

A Flutter package that provides an auto pagination widget to help users create a view that loads new data as the user scrolls down to the end of the page.

## Installation

Add `auto_pagination` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  auto_pagination: ^1.0.0
```

## Usage

1. Import the package:

```dart
import 'package:auto_pagination/auto_pagination.dart';
```

2. Wrap your list of items with the `AutoPagination` widget:

```dart
AutoPagination(
  items: [
    "random1",
    "random2",
    "random3",
    "random4",
    "random5",
    "random6",
    "random7",
    "random8",
    "random9",
    "random10",
    "random11",
    "random12",
    "random13",
    "random14",
  ].map((e) => SizedBox(height: 20, child: Text(e))).toList(),
),
```

3. Customize the `AutoPagination` widget as needed using optional parameters:

```dart
AutoPagination(
  items: _items,
  itemGap:10,
),
```

## Parameters

- `items`: required list of [Widgets] to be displayed
- `itemGap`: optional gap between items if not provided default to 10 px

## Example

For a complete example, see the [example app](https://github.com/iamabhishekthakur/auto_pagination/tree/main/example).

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/iamabhishekthakur/auto_pagination/blob/main/LICENSE) file for details.
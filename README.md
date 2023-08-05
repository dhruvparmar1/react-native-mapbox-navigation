# react-native-mapbox-navigation

Smart Mapbox turn-by-turn routing based on real-time traffic for React Native. A navigation UI ready to drop into your React Native application.

## Installation

```sh
npm install rnc-mapbox-nav
```

## Usage

```jsx
import * as React from "react";
import { StyleSheet, View } from "react-native";
import MapboxNavigation from "rnc-mapbox-nav";

export const SomeComponent = () => {
  return (
    <View style={styles.container}>
      <MapboxNavigation
        origin={[-97.760288, 30.273566]}
        destination={[-97.918842, 30.494466]}
        shouldSimulateRoute
        showsEndOfRouteFeedback
        onLocationChange={(event) => {
          const { latitude, longitude } = event.nativeEvent;
        }}
        onRouteProgressChange={(event) => {
          const {
            distanceTraveled,
            durationRemaining,
            fractionTraveled,
            distanceRemaining,
          } = event.nativeEvent;
        }}
        onError={(event) => {
          const { message } = event.nativeEvent;
        }}
        onCancelNavigation={() => {
          // User tapped the "X" cancel button in the nav UI
          // or canceled via the OS system tray on android.
          // Do whatever you need to here.
        }}
        onArrive={() => {
          // Called when you arrive at the destination.
        }}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
```

### `MapboxNavigation` Props

#### `origin` (**Required**)

Array that contains the longitude and latitude for the starting point.<br>
`[$longitude, $latitude]`

#### `destination` (**Required**)

Array that contains the longitude and latitude for the destination point.<br>
`[$longitude, $latitude]`

#### `shouldSimulateRoute`

Boolean that controls route simulation. Set this as `true` to auto navigate which is useful for testing or demo purposes. Defaults to `false`.

#### `showsEndOfRouteFeedback`

Boolean that controls showing the end of route feedback UI when the route controller arrives at the final destination. Defaults to `false`. Currently this prop is only available for iOS as the Android Mapbox SDK does not support drop-in UI for this functionality. Will need to implement this manually in Android.

#### `mute`

Boolean that toggles voice instructions. Defaults to `false`.

#### `hideStatusView`

Boolean that controls showing the `StatusView` (iOS only). This is the transparent black bar with the "Simulating Navigation" text shown in the above screenshot. Defaults to `false`.

#### `onLocationChange`

Function that is called frequently during route navigation. It receives `latitude` and `longitude` as parameters that represent the current location during navigation.

#### `onRouteProgressChange`

Function that is called frequently during route navigation. It receives `distanceTraveled`, `durationRemaining`, `fractionTraveled`, and `distanceRemaining` as parameters.

#### `onError`

Function that is called whenever an error occurs. It receives a `message` parameter that describes the error that occurred.

#### `onCancelNavigation`

Function that is called whenever a user cancels navigation.

#### `onArrive`

Function that is called when you arrive at the provided destination.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)

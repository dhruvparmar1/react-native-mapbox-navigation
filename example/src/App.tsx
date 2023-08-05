import React, { useEffect } from 'react';

import {
  StyleSheet,
  View,
  PermissionsAndroid,
  Platform,
  Alert,
} from 'react-native';
import MapboxNavigation from 'react-native-mapbox-navigation';

export default function App() {
  useEffect(() => {
    Platform.OS === 'android' && requestLocationPermission();
  }, []);

  const requestLocationPermission = async () => {
    try {
      await PermissionsAndroid.request(
        'android.permission.ACCESS_FINE_LOCATION',
        {
          title: 'Example App',
          message: 'Example App access to your location',
          buttonPositive: 'OK',
        }
      );
    } catch (err) {
      console.warn(err);
    }
  };

  return (
    <View style={styles.container}>
      <MapboxNavigation
        origin={[-105.140629, 39.760194]}
        destination={[-105.156544, 39.761801]}
        style={styles.box}
        shouldSimulateRoute
        showsEndOfRouteFeedback
        hideStatusView
        onLocationChange={(event) => {
          console.log('onLocationChange', event.nativeEvent);
        }}
        onRouteProgressChange={(event) => {
          console.log('onRouteProgressChange', event.nativeEvent);
        }}
        onArrive={() => {
          Alert.alert('You have reached your destination');
        }}
        onCancelNavigation={() => {
          Alert.alert('Cancelled navigation event');
        }}
        onError={(event) => {
          const message = event?.nativeEvent?.message;
          if (message) Alert.alert(message);
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: '100%',
    height: '100%',
    marginVertical: 20,
  },
});

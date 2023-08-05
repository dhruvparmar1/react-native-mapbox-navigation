import { requireNativeComponent, UIManager, Platform } from 'react-native';
import type { IMapboxNavigationProps } from './types';

const LINKING_ERROR =
  `The package 'react-native-mapbox-navigation' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const ComponentName = 'MapboxNavigation';

const MapboxNavigation =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<IMapboxNavigationProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };

export default MapboxNavigation;

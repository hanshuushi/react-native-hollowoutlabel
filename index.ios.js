/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */import React, { Component, PropTypes } from 'react';
 import {
   AppRegistry,
   StyleSheet,
   View,
   requireNativeComponent
 } from 'react-native';
 import Session from './Session';

 const NativeHollowoutLabel = requireNativeComponent('LTHollowoutLabel', HollowoutLabel);

 export default class HollowoutLabel extends Component {
   static propTypes = {
     text: PropTypes.string.isRequired,
     fontSize: PropTypes.number.isRequired,
     iosFontName: PropTypes.string,
     edge: PropTypes.shape({
       left: PropTypes.number.isRequired,
       bottom: PropTypes.number.isRequired,
       right: PropTypes.number.isRequired,
       top: PropTypes.number.isRequired,
     }),
     color: PropTypes.string,
   };

   props: PropsType;

   constructor(props) {
     super(props);
   }

  //  setNativeProps(props: PropsType) {
  //    this.refs.self.setNativeProps(props);
  //  }

   render() {
     const {
       text,
       edge,
       fontSize,
       iosFontName,
       color,
       ...otherProps
     } = this.props;

     if (text.length <= 0) {
       console.warn('text in HollowoutLabel can not be empty');
       return (<View />);
     }

     return (
       <NativeHollowoutLabel fontSize={ fontSize || 12 } edge={(edge || {top:0, bottom:0, right:0, left:0})} ref='self' color={color || 'white'} text={text}  {...otherProps} />
     )
   }
 }

 AppRegistry.registerComponent('HollowoutLabel', () => HollowoutLabel);

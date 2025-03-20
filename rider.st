"Ride Sharing System in Smalltalk"

Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    poolDictionaries: ''.

Ride >> initializeWithID: id pickup: pickup dropoff: dropoff distance: dist
    rideID := id.
    pickupLocation := pickup.
    dropoffLocation := dropoff.
    distance := dist.

Ride >> calculateFare
    self subclassResponsibility.

Ride >> rideDetails
    ^ 'Ride ID: ', rideID asString, ' Pickup: ', pickupLocation, ' Dropoff: ', dropoffLocation, ' Distance: ', distance asString, ' miles'.


"StandardRide Class"
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''.

StandardRide >> calculateFare
    ^ distance * 1.5.

StandardRide >> rideDetails
    ^ super rideDetails, ', Fare: $', self calculateFare asString, ' (Standard Rate)'.


"PremiumRide Class"
Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''.

PremiumRide >> calculateFare
    ^ distance * 3.0.

PremiumRide >> rideDetails
    ^ super rideDetails, ', Fare: $', self calculateFare asString, ' (Premium Rate)'.


"Driver Class"
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''.

Driver >> initializeWithID: id name: n rating: r
    driverID := id.
    name := n.
    rating := r.
    assignedRides := OrderedCollection new.

Driver >> addRide: aRide
    assignedRides add: aRide.

Driver >> getDriverInfo
    ^ 'Driver ID: ', driverID asString, ' Name: ', name, ' Rating: ', rating asString, ' Rides Completed: ', assignedRides size asString.


"Rider Class"
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''.

Rider >> initializeWithID: id name: n
    riderID := id.
    name := n.
    requestedRides := OrderedCollection new.

Rider >> requestRide: aRide
    requestedRides add: aRide.

Rider >> viewRides
    ^ requestedRides collect: [:ride | ride rideDetails].


"Test Cases"
| rider1 driver1 ride1 ride2 |

rider1 := Rider new initializeWithID: 1 name: 'Alice'.
driver1 := Driver new initializeWithID: 101 name: 'Bob' rating: 4.8.

ride1 := StandardRide new initializeWithID: 1001 pickup: 'Downtown' dropoff: 'Airport' distance: 10.
ride2 := PremiumRide new initializeWithID: 1002 pickup: 'Mall' dropoff: 'Hotel' distance: 5.

rider1 requestRide: ride1.
rider1 requestRide: ride2.
driver1 addRide: ride1.
driver1 addRide: ride2.

Transcript show: driver1 getDriverInfo; cr.
Transcript show: (rider1 viewRides) joinSeparatedBy: String cr.

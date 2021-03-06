# AvailableFlatSurface

[Live Demo](https://available-flat-surface.herokuapp.com/ "AvailableFlatSurface")

AvailableFlatSurface is a clone of [OpenTable](opentable.com "OpenTable") using a React + Redux front end calling to a Rails + PostgreSQL backend. 

CRUD features include reservations, reviews, and saved restaurants.

## Index

* [Technologies](https://github.com/MasonChinkin/availableFlatSurface/blob/master/README.md#Technologies)
* [Highlights](https://github.com/MasonChinkin/availableFlatSurface/blob/master/README.md#highlights)
  * [Making Reservations with Redux](https://github.com/MasonChinkin/availableFlatSurface/blob/master/README.md#Making-Reservations-with-redux)
  * [Dynamic icons with React](https://github.com/MasonChinkin/availableFlatSurface/blob/master/README.md#Dynamic-icons-with-react)
  * [Make, edit, and delete reviews](https://github.com/MasonChinkin/availableFlatSurface/blob/master/README.md#Make-edit-and-delete-reviews)
  * [Styling: Attention to Detail!](https://github.com/MasonChinkin/availableFlatSurface/blob/master/README.md#styling-attention-to-detail)

## Technologies

* Ruby on Rails backend using a normalized PostgreSQL database, RESTful routes, and JBuilder
* React + Redux front end with SASS styling
* Secure photo hosting on Amazon Web Services S3 with Rails Active Storage
* Compiled to ES5 using Webpack and Babel.js

## Highlights

### Making Reservations with redux

One of the biggest functional challenges was gathering all necessary data to make a reservation upon clicking the time buttons on the search page. Hello Redux! I tracked the party size and dateTime of a reservation using the ui slice of state.

![](/app/assets/images/readme/reservation-demo.gif?raw=true)

```javascript
// UI REDUCER
Object.freeze(oldState);
let newState = Object.assign({}, oldState);
switch (action.type) {
  case RECEIVE_RESERVATION_FORM_CHANGE:
    newState.reservationForm = action.reservationData
    return newState

// RESERVATION BUTTON CONTAINER
const mapStateToProps = ({ ui, session }) => ({
  searchedDateTime: ui.reservationForm.resDateTime || null,
  numPeople: ui.reservationForm.numPeople,
  userId: (session.currentUser === null) ? null : session.currentUser.id
});

// RESERVATION BUTTON COMPONENT
handleReservation(e) {
  e.preventDefault();

  if (this.props.userId === null) return this.props.history.push(`/search/signin`);

  let reservation = {
    reservation: (this.props.searchedDateTime.getTime()) / 1000, // divide by 1000 for rails
    num_people: this.props.numPeople,
    user_id: this.props.userId,
    restaurant_id: this.props.restaurantId // threaded in from above
  };

  this.props.makeReservation(reservation)
    .then(this.props.history.push(`/profile/${this.props.userId}/reservations`));
}

// RESERVATION BUTTON RENDER
<Link onClick={this.handleReservation}
  key={i}
  className="submit-button res-submit-button"
  to={`/profile/${this.props.userId}/reservations`}>{buttonTime}
</Link>
```

### Dynamic icons with React

Early in the project, when I was thinking about how to implement OpenTable's heavy use of icons in a clean, dynamic way, I had one of those Beautiful Mind/orchestral background music moments when React really started to make sense to me. Below, you can see how I built and then mapped over a nested array library to make the restaurant page sidebar.

AvailableFlatSurface            |  OpenTable
:-------------------------:|:-------------------------:
![](/app/assets/images/readme/myShowDetails.png?raw=true) | ![](/app/assets/images/readme/openTableShowDetails.png?raw=true)

```javascript
function sidebarDataArr(rest) {
  let details = [
    ['Address', rest.address, 'fas fa-map-marker-alt'],
    ['Cross Street', rest.crossStreet, 'fas fa-car-alt'],
    ['Neighborhood', rest.neighborhood, 'far fa-building'],
    ['Hours', rest.hours, 'far fa-clock'],
    ['Cuisine', rest.cuisine, 'fas fa-utensils'],
    ['Dress Code', rest.dressCode, 'fas fa-tshirt'],
    ['Parking Details', rest.parkingDetails, 'fas fa-parking'],
    ['Payment Options', rest.paymentOptions, 'fas fa-credit-card'],
    ['Phone Number', rest.phone, 'fas fa-phone'],
    ['Website', rest.website, 'far fa-share-square'],
  ]

  return details.map((detail, i) => {
    if (!details[1]) return null;

    let label = detail[0];
    let val = detail[1] || 'N/A';
    let icon = detail[2];

    val = (label === 'Website' && val !== 'N/A') ? <a href={val}>{val}</a> : val

    return (
      <li key={i}>
        <i className={icon} />
        <div>
          <label>{label}</label>
          <p>{val}</p>
        </div>
      </li>
    )
  })
}
```

### Make, edit, and delete reviews

![](/app/assets/images/readme/review-demo.gif?raw=true)

### Styling: Attention to Detail!

This project sought to closely replicate the design of OpenTable. At times (see below), one could argue that AvailableFlatSurface has a more even, aesthetically pleasing arrangement of elements.

AvailableFlatSurface            |  OpenTable
:-------------------------:|:-------------------------:
![](/app/assets/images/readme/myListItem.png?raw=true) | ![](/app/assets/images/readme/openTableListItem.png?raw=true)

import { connect } from 'react-redux';
import ResButtons from './ResButtons';
import { makeReservation } from '../../../../actions/reservationActions';

const mSP = ({ ui, session }) => ({
  searchedDateTime: ui.reservationForm.resDateTime || null,
  numPeople: ui.reservationForm.numPeople,
  currentUserId: session.currentUser.id,
});

const mDP = dispatch => ({
  makeReservation: reservation => dispatch(makeReservation(reservation))
});

const ResButtonsContainer = connect(mSP, mDP)(ResButtons);

export default ResButtonsContainer;
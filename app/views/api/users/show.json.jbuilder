json.user do
  json.set! @user.id do
    json.extract! @user, :id, :name, :email
  end
end

saved_and_reserved_rests = @user.saved_restaurants_data + @user.reserved_restaurants_data

json.restaurants do
  saved_and_reserved_rests.each do |rest|
    json.set! rest.id do
      json.extract! rest, :id, :name, :cuisine, :neighborhood, :rating
      json.profilePhotoURL url_for(rest.profile_photo)
    end
  end
end

json.saved_restaurants_join do
  @user.saved_restaurants.each do |saved|
    json.set! saved.id do
      json.extract! saved, :id, :restaurant_id, :user_id
    end
  end
end

json.reservations do
  @user.reservations.each do |res|
    json.set! res.id do
      json.extract! res, :id, :num_people, :notes, :canceled, :canceled_at, :restaurant_id, :user_id, :created_at
      json.reservation (res.reservation.to_f * 1000)
    end
  end
end

for user_id in 1 2 3
  	do echo "UserID : '$user_id'"
  	cmd="curl --location --request POST 'http://localhost/v1/users' \
		--header 'Accept: application/json' \
		--header 'X-User-Id: $user_id' \
		--header 'Authorization: XXXX'"
	eval $cmd
done

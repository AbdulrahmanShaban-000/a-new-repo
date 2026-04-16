<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Profile</title>
</head>
<body>
    <!DOCTYPE html>
<html lang="en">
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            direction: ltr;
        }

        .profile-card {
            width: 350px;
            margin: 50px auto;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .profile-card h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .images {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .images img {
            width: 150px;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
            border: 1px solid #ccc;
        }

        .info {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .info span {
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="profile-card">
        <h2>Profile</h2>

        <div class="images">
            <div>
                <p>personal photo</p>
                <img src="http://127.0.0.1:8000/storage/{{$client->personal_photo}}" alt="صورة شخصية">
            </div>
            <div>
                <p>An ID photo</p>
                <img src="http://127.0.0.1:8000/storage/{{$client->An_ID_photo}}" alt="صورة هوية">
            </div>
        </div>

        <div class="info">
            <span>First Name : </span>  {{$client->first_name}}
        </div>

        <div class="info">
            <span>Last Name : </span>  {{$client->last_name}}
        </div>

        <div class="info">
            <span>date of birth : </span>  {{$client->date_of_birth}}
        </div>

        <div class="info">
            <span>Number Phone : </span>  {{$client->phone}}
        </div>
        <div class="info">
            <span>role : </span>  {{$client->role}}
        </div>
        <div class="info">
            <span>wallet : </span>  {{$client->wallet}}
        </div>
    </div>

</body>
</html>

</body>
</html>
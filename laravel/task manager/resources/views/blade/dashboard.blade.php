<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <style>
        body {
    margin: 0;
    padding: 0;
    font-family: "Tajawal", sans-serif;
    background-color: #0b1a33;
    color: #fff;
    scroll-behavior: smooth;
}
.links ul li a {
    visibility: hidden;
}
.user {
    scroll-margin-top: 150px;
}
.user {
}
.links:hover ul li a {
    visibility: visible;
}
/* الخلفية تكون شفافة افتراضياً */
.links ul {
    background-color: transparent;
    display: none;
}
#User {
    margin-top: 120px;
}
/* تظهر الخلفية فقط عند اللمس (hover) */
.links:hover ul{
    background-color: #F6F6F6;
    display: block;
}

html{
    /* اي سكرول لح يصير بالhtml لح يكون سلس */
    scroll-behavior: smooth;
}
.special-heading{
    color: #ebeced;
    font-size: 100px;
    text-align: center;
    margin: 0;
    font-weight: 800;
    letter-spacing: -3px;
}
.special-heading + p{
margin: -30px 0 0 ;
font-size: 20px;
text-align: center;
color:#797979;
}

.container { width: 100%;
}

.head nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 30px;
    background-color: #102544;
}

.head nav ul {
    list-style: none;
    display: flex;
    gap: 20px;
}

.head nav ul li a {
    color: #cdd9e8;
    text-decoration: none;
}

hr { border: none; border-top: 1px solid #1f3558; }

.layout { display: flex; }

aside {
    width: 220px;
    background-color: #102544;
    padding: 20px;
    min-height: 100vh;
}

aside a {
    display: block;
    padding: 12px;
    margin-bottom: 10px;
    color: #cdd9e8;
    text-decoration: none;
    border-radius: 6px;
    transition: 0.3s;
}

aside a:hover,
aside .active {
    background-color: #1f3558;
    color: #fff;
}

.main { flex: 1; padding: 25px; }

.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #102544;
    padding: 15px 20px;
    border-radius: 8px;
    margin-bottom: 25px;
}

.user span {
    background-color: #1f3558;
    padding: 8px 12px;
    border-radius: 6px;
}
 .links{
    position: relative;
}

 .links:hover .icon span:nth-child(2){
    width: 100%;
}

.links .icon{
    width: 30px;
    display: flex;
    flex-wrap: wrap;
    justify-content:flex-end ;
}

.links .icon span{
    background-color: #333333;
    height: 2px;
    margin-bottom: 5px;
}
 .links .icon span:first-child{
    width: 100%;
}

 .links .icon span:nth-child(2){
    width: 50%;
    transition-duration: 0.3s;
}

 .links .icon span:last-child{
    width: 100%;
}

 .links ul {
    list-style: none;
    margin: 0px;
    padding: 0px;
    position: absolute;
    right: 0px;
    min-width: 200px;
    top: calc(100% + 15px);
    display: none;
    z-index: 1;
}


.user{
    margin-bottom: 50px;
}

.links:hover ul{
    display: block;
}

 .links ul li a{
   display: block;
   padding: 15px;
   text-decoration: none;
   color: #333;
   transition: 0.3s; 
}
.links ul li a:hover{
    padding-left:25px;  
}
.links:hover ul li a{
color: #000;
}

 .links ul li:not(:last-child) a {
    border-bottom: 1px solid #ddd;
}

/* الكروت */
.cards {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
}

.card {
    background-color: #102544;
    padding: 20px;
    border-radius: 10px;
    flex: 1;
    text-align: center;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

.card h3 { margin-bottom: 10px; color: #cdd9e8; }

.card p { font-size: 22px; font-weight: bold; }

/* قسم الجدول الجديد */
.table-section { margin-top: 20px; }

.table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.table-header input {
    padding: 8px 12px;
    border-radius: 6px;
    border: none;
    outline: none;
    background-color: #1f3558;
    color: #fff;
}


table {
    width: 50%;
    border-collapse: collapse;
    background-color: #102544;
    border-radius: 10px;
    overflow: hidden;
    margin: 0 auto;
    left: 50%;
}

thead {
    background-color: #1f3558;
}

thead th {
    padding: 12px;
    text-align: left;
}

tbody td {
    padding: 12px;
    border-bottom: 1px solid #1f3558;
}

.wide { width: 50%; }

/* حالات */
.status {
    padding: 6px 10px;
    border-radius: 6px;
    color: #fff;
    font-weight: bold;
}
.buttons{
    display: flex;
    justify-content: space-between; 
    width: 100%; 
    transition: 1s;
}
.buttons button{
    border: none;
    background-color: transparent;
    border: 2px white solid;
    border-radius: 30%;
    padding: 5px;
    color: white;
}
.success { background-color: #28a745; }
.pending { background-color: #ffc107; color: #000; }
.canceled { background-color: #dc3545; }
    </style>
    <div class="container">
        <div class="head">
            <nav>
                <div class="links">
                <span class="icon">
                    <span></span>
                    <span></span>
                    <span></span>
                </span>
            </div>
            </nav>
        </div>

        <hr>

        <div class="layout">
            <aside>
                <div class="one">
                    <nav>
                         <a class = "active" href="#User">USER</a>
                         <a class = "active" href="#Financial">Financial requests</a>
                    </nav>
                </div>
            </aside>

            <main class="main">
                <header class="topbar">
                    <h1>Welcome</h1>
                 
                </header>

                <section class="cards">
                    <div class="card">
                        <h3>Number Of Users</h3>
                        <p>{{$numberOfUsers}}</p>
                    </div>
                    <div class="card">
                        <h3>Number Of Requests</h3>
                        <p>{{$numberOfClients}}</p>
                    </div>
                </section>

                <section class="table-section">

<table>
                        <thead>
                            <tr>
                                <th class="wide">Clients Requests</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach ($clients as $item)
                            <tr>
                                <td class="wide">{{$item->first_name}} {{$item->last_name}}</td>
                                <td class="status pending">
                                    <div class="buttons">
                                        <a href="{{route('detailsClient.show',$item->id)}}">details</a>
                                        <form method="post" action="{{route('storeClient',$item->id)}}">
                                            @csrf
                                            <button>ADD</button>
                                        </form>
                                        <form method="post" action="{{route('deleteClient',$item->id)}}">
                                            @csrf
                                            @method("Delete")
                                            <button>DELET</button>
                                        </form>
                                        
                                </div>
                            </tr> 
                            @endforeach
                            
                        </tbody>
                    </table>
                </section>

             
                <section class="table-section" id ="Financial">

                    <table>
                        <thead>
                            <tr>
                                <th class="wide">Financial requests</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($requests as $item)
                            <tr>
                                <td class="wide">
                                    <p>{{$item->name}}</p>
                                    <p>wants to top up his wallet with {{$item->value}}</p>
                                </td>
                                <td class="status pending">
                                    <div class="buttons">
                                        <form action="{{route('Yes',[$item->id,$item->client_id,$item->value])}}" method="POST">
                                            @csrf
                                            <button>Accept</button>

                                        </form>
                                        <form action="{{route('No',$item->id)}}" method="POST">
                                            @csrf
                                            @method('Delete')
                                            <button>Reject</button> 
                                        </form>
                                </div>
                            </tr> 
                            @endforeach
                        </tbody>
                    </table>
                </section>

            </main>
        </div>
            <div class="user" id="User">
            <h2 class="special-heading">USER</h2>
            </div>
                        <table>
                        <thead class="TABLE1">
                            <tr>
                                <th class="wide">Users</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($users as $item)
                             <tr>
                                <td class="wide">{{$item->phone}}</td>
                                <td class="status success">
                                    <div class="buttons">
                                        <form action="{{route('deleteUser',$item->id)}}" method="POST">
                                            @csrf
                                                @method('Delete')
                                                <a href="{{route('detailsUser.show',$item->id)}}">details</a>
                                            <button>DELET</butto>
                                        </form>
                                    </div>
                                </td>
                                
                            </tr>
                            @endforeach
                           
                        </tbody>
                    </table>
            </div>
</body>
</html>

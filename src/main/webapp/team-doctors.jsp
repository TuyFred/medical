<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctors Team</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .carousel-inner img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .card-deck .card {
            margin-bottom: 20px;
        }
        .card-body h5 {
            font-size: 18px;
        }
        .card-body p {
            font-size: 14px;
        }
        .footer {
            background-color: #343a40;
            color: #fff;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
        }
         .footer a {
            color: #fff;
            margin: 0 10px;
        }
        .footer a:hover {
            color: #e0e0e0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="#">Online Medical Facility</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="team-doctors.jsp">Doctors Team</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp">Contact</a>
                </li>
                <!-- Add more links as needed -->
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="text-center mb-4">Meet Our Doctors</h2>
        <div class="row">
            <%-- Doctor Card 1 --%>
            <div class="col-md-3 col-sm-6">
                <div class="card">
                    <div id="carouselDoc1" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="images/doctor1-1.jpg" class="d-block w-100" alt="Doctor 1 Image 1">
                            </div>
                            <div class="carousel-item">
                                <img src="images/doctor1-2.jpg" class="d-block w-100" alt="Doctor 1 Image 2">
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselDoc1" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselDoc1" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Dr. John Doe</h5>
                        <p class="card-text">Cardiologist</p>
                        <p class="card-text"><i class="fas fa-envelope"></i> john.doe@example.com</p>
                        <p class="card-text"><i class="fas fa-phone"></i> (123) 456-7890</p>
                    </div>
                </div>
            </div>

            <%-- Doctor Card 2 --%>
            <div class="col-md-3 col-sm-6">
                <div class="card">
                    <div id="carouselDoc2" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="images/doctor2-1.jpg" class="d-block w-100" alt="Doctor 2 Image 1">
                            </div>
                            <div class="carousel-item">
                                <img src="images/doctor2-2.jpg" class="d-block w-100" alt="Doctor 2 Image 2">
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselDoc2" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselDoc2" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Dr. Jane Smith</h5>
                        <p class="card-text">Dermatologist</p>
                        <p class="card-text"><i class="fas fa-envelope"></i> jane.smith@example.com</p>
                        <p class="card-text"><i class="fas fa-phone"></i> (321) 654-9870</p>
                    </div>
                </div>
            </div>

            <%-- Doctor Card 3 --%>
            <div class="col-md-3 col-sm-6">
                <div class="card">
                    <div id="carouselDoc3" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="images/doctor3-1.jpg" class="d-block w-100" alt="Doctor 3 Image 1">
                            </div>
                            <div class="carousel-item">
                                <img src="images/doctor3-2.jpg" class="d-block w-100" alt="Doctor 3 Image 2">
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselDoc3" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselDoc3" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Dr. Robert Brown</h5>
                        <p class="card-text">Pediatrician</p>
                        <p class="card-text"><i class="fas fa-envelope"></i> robert.brown@example.com</p>
                        <p class="card-text"><i class="fas fa-phone"></i> (456) 789-0123</p>
                    </div>
                </div>
            </div>

            <%-- Doctor Card 4 --%>
            <div class="col-md-3 col-sm-6">
                <div class="card">
                    <div id="carouselDoc4" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="images/doctor4-1.jpg" class="d-block w-100" alt="Doctor 4 Image 1">
                            </div>
                            <div class="carousel-item">
                                <img src="images/doctor4-2.jpg" class="d-block w-100" alt="Doctor 4 Image 2">
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselDoc4" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselDoc4" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Dr. Emily Wilson</h5>
                        <p class="card-text">Gynecologist</p>
                        <p class="card-text"><i class="fas fa-envelope"></i> emily.wilson@example.com</p>
                        <p class="card-text"><i class="fas fa-phone"></i> (789) 012-3456</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

   <footer class="footer">
        <p>&copy; 2024 Online Medical Facility</p>
        <a href="https://www.youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
        <a href="https://www.instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
        <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
        <a href="https://www.otherwebsite.com" target="_blank"><i class="fas fa-globe"></i></a>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
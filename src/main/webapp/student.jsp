<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Portal</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    /* Smooth Scrolling */
    html {
      scroll-behavior: smooth;
    }

    /* Custom Keyframes for Animations */
    @keyframes showRight {
      from {
        opacity: 0;
        transform: translateX(50px);
      }
      to {
        opacity: 1;
        transform: translateX(0);
      }
    }

    /* Logo Animation */
    .logo {
      animation: showRight 1s ease forwards;
      animation-delay: 0.2s;
    }

    /* Brand Title Animation */
    .brand-title {
      animation: showRight 1.5s ease forwards;
      animation-delay: 0.6s;
    }
    .bg-bright {
      filter: brightness(1.2);
    }
  </style>
</head>
<body class="relative bg-cover bg-center sm:bg-auto lg:bg-cover" style="background-image: url('pictures/grad3.jpg');">

<!-- Navigation Bar -->
<nav class="bg-gray-900 text-white shadow-md fixed w-full top-0 z-20">
  <div class="container mx-auto px-6 py-4 flex justify-between items-center">
    <div class="flex items-center space-x-2">
      <!-- Logo Animation -->
      <img src="images/nibm.jpg" alt="EVEX Logo"
           class="logo w-30 cursor-pointer max-h-20 px-5">

      <!-- Text Animation -->
      <span class="brand-title text-white text-2xl font-bold">
                NIBM EVEX
            </span>
    </div>
    <!-- Navigation Links -->
    <div class="flex space-x-6">
      <a href="#" class="hover:text-green-400 transition">Home</a>
    </div>
  </div>
</nav>
<!-- Brightened background overlay -->
<div class="absolute inset-0 bg-bright bg-opacity-70"></div>

<!-- Parent container with background image -->
<div class="relative min-h-screen flex items-center justify-center">
  <div class="w-full max-w-3xl mx-auto px-6 py-12 bg-white bg-opacity-20 shadow-lg rounded-xl mt-12">
    <h1 class="text-4xl font-extrabold text-gray-800 text-center mb-10">
      Welcome to the <span class="text-blue-500">Student Portal</span>
    </h1>
    <p class="text-center text-lg text-gray-600 mb-8">
      Explore your options and manage your student activities.
    </p>
    <div class="space-y-8">
      <!-- Update Profile -->
      <div class="block p-8 bg-gradient-to-r from-blue-300 to-blue-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="profile.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">Update Profile</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Keep your profile up to date and stay connected.
          </p>
        </a>
      </div>

      <!-- Career Portfolio -->
      <div class="block p-8 bg-gradient-to-r from-pink-300 to-pink-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="careerportfolio.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">Career Portfolio</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Build and manage your professional portfolio.
          </p>
        </a>
      </div>

      <!-- View Events -->
      <div class="block p-8 bg-gradient-to-r from-green-300 to-green-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="Interviews.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">View Interviews</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Check out the latest Interviews.
          </p>
        </a>
      </div>

      <!-- View Workshops -->
      <div class="block p-8 bg-gradient-to-r from-orange-300 to-orange-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="Workshops.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">View Workshops</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Check out the latest Workshops.
          </p>
        </a>
      </div>

      <!-- Search Events -->
      <div class="block p-8 bg-gradient-to-r from-red-300 to-red-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="Events.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">Search Events</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Search Events based on date, name, or type.
          </p>
        </a>
      </div>

      <!-- Submit Feedback -->
      <div class="block p-8 bg-gradient-to-r from-yellow-300 to-yellow-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="feedback.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">Submit Feedback</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Share your thoughts and help us improve.
          </p>
        </a>
      </div>

      <!-- View Feedback -->
      <div class="block p-8 bg-gradient-to-r from-purple-300 to-purple-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="viewfeedback.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">View Feedback</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            See feedback you’ve received from lecturers.
          </p>
        </a>
      </div>

      <!-- Announcements -->
      <div class="block p-8 bg-gradient-to-r from-teal-300 to-teal-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
        <a href="viewannouncements.jsp" class="block">
          <h2 class="text-2xl font-bold text-center">View Announcements</h2>
          <p class="mt-2 text-center text-white/90 hover:text-white">
            Stay updated with the latest news and announcements.
          </p>
        </a>
      </div>

    </div>
  </div>
</div>




<!-- Footer Section -->
<footer class="bg-black/60 text-white">
  <div class="container mx-auto px-5 py-8">
    <!-- Top Divider -->
    <hr class="mb-4 border-gray-500">

    <!-- Footer Content -->
    <div class="flex flex-col md:flex-row justify-center items-center text-center">
      <!-- Contact Section -->
      <section id="Contact-section" class="drop-shadow-lg px-4 sm:px-6 md:px-20 py-2 mx-4">
        <h6 class="mx-auto text-xl font-semibold mb-3">Contact Us</h6>
        <ul class="space-y-2">
          <li>
            <a href="#" class="hover:text-green-400 transition">
              <i class="fa-solid fa-phone text-white mr-2"></i> +94 117 321 000
            </a>
          </li>
          <li>
            <a href="#" class="hover:text-green-400 transition">
              <i class="fa-solid fa-house text-white mr-2"></i> National Institute of Business Management <br>
              Galle Campus<br>
              No. 132, Pettigalawatta, Matara Road,Galle.
            </a>
          </li>
          <li>
            <a href="#" class="hover:text-green-400 transition">
              <i class="fa-solid fa-envelope text-white mr-2"></i>nibmevex.edu.lk
            </a>
          </li>
        </ul>
      </section>
    </div>

    <!-- Bottom Divider -->
    <hr class="my-4 border-gray-500">

    <!-- Footer Bottom -->
    <div class="text-center text-gray-300 text-sm">
      &copy; 2024 Event Management. All rights reserved.
    </div>
  </div>
</footer>
</body>
</html>
# histo_view

Este proyecto está desarrollado en Flutter y es el Trabajo final de máster DADM de la UOC.

Esta app utiliza el MVVM, por lo cual el proyecto está dividido en View, ViewModel y Model.

El proyecto está principalmente dividido en dos partes, el Login/Register y Favorite/Map/Profile.

**Login/Register**. Esta parte es la que se encuentra al principio de la app, y en ella se puede registrar un nuevo usuario o loguearse en la app. Esta parte está compuesta por las pantallas de Login y Register.
Login: Permite el registro de un usuario y la navegación a la pantalla de login. Al realizar un login correcto la app redirige al usuario a la segunda parte.
Register: Permite registrar un usuario en la app si completa correctamente todos los campos y permite acceder a la pantalla de login.

**Favorite/Map/Profile**. Es la parte principal del proyecto, la cual contiene la mayoría de funcionalidades. Desde la creación de reviews, hasta la modificación del perfil, y las interacciones con las reviews. Esta parte cuenta con un menú de tabs inferior que permite la navegación entre las pantallas de Favorite, Map y Profile. Se puede acceder a estas pantallas después de haber realizado el login.

- **Favorite**: Muestra las reviews favoritas de un usuario.

- **Map**: Permite al usuario crear nuevas reviews, visualizar reviews en el mapa e incluso buscar reviews utilizando la barra de búsqueda. Es la pantalla más importante de la app, dado que presenta las funcionalidades más importantes.

- **Profile**: Muestra el perfil de un usuario y en caso de que sea el perfil del propio usuario permite al usuario editar sus datos. Este perfil muestra las reviews creadas, los seguidos, los seguidores y la presentación del usuario.

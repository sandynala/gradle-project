FROM  openjdk
WORKDIR /var/www/html
COPY ./code/product-service/* ./product-service
COPY ./code/review-service/* ./review-service
COPY ./code/user-service/* ./user-service 

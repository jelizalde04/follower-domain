# Usa una imagen oficial de Ruby
FROM ruby:3.4.4

# Instala dependencias de sistema (nodejs y yarn para Rails)
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn

# Define carpeta de trabajo dentro del contenedor
WORKDIR /app

# Copia el Gemfile y Gemfile.lock primero (para aprovechar la cache de Docker)
COPY Gemfile Gemfile.lock ./

# Instala gems
RUN bundle install

# Copia el resto del código de tu proyecto
COPY . .

# Expone el puerto Rails (7001)
EXPOSE 7003

# Comando para arrancar el servidor
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "7003"]

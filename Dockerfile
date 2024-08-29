FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:35792ea4ad1db051981f62b313f1be3b46b1f45cadbaa3c288cd0d3056eefb83 AS build-env
WORKDIR /App
EXPOSE 5027
# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore PizzaStore.csproj
# Build and publish a release
#RUN dotnet publish -c Release -o out 
RUN dotnet build PizzaStore.csproj -o out

# Build runtime image
FROM FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "PizzaStore.dll"]

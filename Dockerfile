# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy everything
COPY . ./

# Restore using solution or specific .csproj
RUN dotnet restore eShopOnWeb.sln

# Publish the web project
RUN dotnet publish src/Web/eshoponweb.Web.csproj -c Release -o /out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "eshoponweb.Web.dll"]

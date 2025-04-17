# Use .NET 8.0 SDK for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app
COPY . ./
RUN dotnet restore eShopOnWeb.sln
RUN dotnet publish src/Web/Web.csproj -c Release -o out

# Use .NET 8.0 ASP.NET runtime for final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "Web.dll"]

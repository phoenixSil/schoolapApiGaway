FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["schoolapApiGaway.Api/schoolapApiGaway.Api.csproj", "schoolapApiGaway.Api/"]
RUN dotnet restore "schoolapApiGaway.Api/schoolapApiGaway.Api.csproj"
COPY . .
WORKDIR "/src/schoolapApiGaway.Api"
RUN dotnet build "schoolapApiGaway.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "schoolapApiGaway.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
EXPOSE 5012
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "schoolapApiGaway.Api.dll"]
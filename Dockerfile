#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://*8080
ENV COMPlus_EnableDiagnostics=0
EXPOSE 443

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
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "schoolapApiGaway.Api.dll"]
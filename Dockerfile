FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["schoolapApiGaway.Api/schoolapApiGaway.Api.csproj", "schoolapApiGaway.Api/"]
COPY ["schoolapApiGaway.Domain/schoolapApiGaway.Domain.csproj", "schoolapApiGaway.Domain/"]
COPY ["schoolapApiGaway.InjectionDeDependance/schoolapApiGaway.InjectionDeDependance.csproj", "schoolapApiGaway.InjectionDeDependance/"]
COPY ["schoolapApiGaway.Application/schoolapApiGaway.Application.csproj", "schoolapApiGaway.Application/"]
COPY ["schoolapApiGaway.Features/schoolapApiGaway.Features.csproj", "schoolapApiGaway.Features/"]
COPY ["schoolapApiGaway.Data/schoolapApiGaway.Data.csproj", "schoolapApiGaway.Data/"]
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
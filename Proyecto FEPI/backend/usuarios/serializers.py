from rest_framework import serializers
from .models import Usuario


class UsuarioSerializer(serializers.ModelSerializer):
    rol = serializers.CharField(source="rol.nombre")

    class Meta:
        model = Usuario
        fields = [
            "id",
            "username",
            "nombre_completo",
            "email",
            "rol",
        ]
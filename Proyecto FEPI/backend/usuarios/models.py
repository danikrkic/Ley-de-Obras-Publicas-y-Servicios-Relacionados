from django.db import models
from django.contrib.auth.models import AbstractUser


class Rol(models.Model):
    nombre = models.CharField(
        max_length=50,
        unique=True,
        verbose_name="Nombre del Rol"
    )

    class Meta:
        db_table = "roles"
        verbose_name = "Rol"
        verbose_name_plural = "Roles"

    def __str__(self):
        return self.nombre


class Usuario(AbstractUser):
    nombre_completo = models.CharField(
        max_length=100,
        verbose_name="Nombre completo"
    )

    rol = models.ForeignKey(
        Rol,
        on_delete=models.PROTECT,
        related_name="usuarios",
        null=True,
        blank=True
    )

    class Meta:
        db_table = "usuarios"
        verbose_name = "Usuario"
        verbose_name_plural = "Usuarios"

    def __str__(self):
        return self.username
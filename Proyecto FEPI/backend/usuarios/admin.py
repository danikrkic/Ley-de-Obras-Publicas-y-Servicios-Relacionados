from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import Rol, Usuario


@admin.register(Rol)
class RolAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre")
    search_fields = ("nombre",)


@admin.register(Usuario)
class UsuarioAdmin(UserAdmin):
    model = Usuario

    list_display = (
        "username",
        "nombre_completo",
        "rol",
        "is_active",
        "is_staff",
    )

    fieldsets = UserAdmin.fieldsets + (
        (
            "Información adicional",
            {
                "fields": (
                    "nombre_completo",
                    "rol",
                )
            },
        ),
    )

    add_fieldsets = UserAdmin.add_fieldsets + (
        (
            "Información adicional",
            {
                "fields": (
                    "nombre_completo",
                    "rol",
                )
            },
        ),
    )
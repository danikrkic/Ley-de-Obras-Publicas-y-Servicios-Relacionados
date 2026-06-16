from django.core.management.base import BaseCommand
from django.core.management import call_command

from usuarios.models import Rol, Usuario


class Command(BaseCommand):
    help = "Configura el proyecto FEPI con datos iniciales."

    def handle(self, *args, **kwargs):

        self.stdout.write(self.style.SUCCESS("Aplicando migraciones..."))
        call_command("migrate")

        self.stdout.write(self.style.SUCCESS("Creando roles..."))

        roles = [
            "Dependencia",
            "Residente de Obra",
            "Superintendente",
            "Supervisión",
            "Finanzas",
        ]

        for nombre in roles:
            Rol.objects.get_or_create(nombre=nombre)

        self.stdout.write(self.style.SUCCESS("Creando usuario administrador..."))

        admin, created = Usuario.objects.get_or_create(
            username="admin",
            defaults={
                "email": "admin@fepi.local",
                "nombre_completo": "Administrador FEPI",
            }
        )

        if created:
            admin.set_password("1234")
            admin.is_staff = True
            admin.is_superuser = True

        admin.rol = Rol.objects.get(nombre="Dependencia")
        admin.save()

        self.stdout.write(
            self.style.SUCCESS(
                "Proyecto configurado correctamente."
            )
        )
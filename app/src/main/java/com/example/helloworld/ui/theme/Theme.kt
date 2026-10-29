package com.example.helloworld.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Typography
import androidx.compose.material3.ColorScheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private val DarkColorScheme = darkColorScheme(
    primary = Color(0xFF66A3FF),
    primaryContainer = Color(0xFF003366),
    secondary = Color(0xFFB0CCFF),
    secondaryContainer = Color(0xFF1D2A43),
    tertiary = Color(0xFFD0BCFF),
    tertiaryContainer = Color(0xFF381E72),
    background = Color(0xFF121212),
    surface = Color(0xFF121212),
    onPrimary = Color(0xFF001D3D),
    onPrimaryContainer = Color(0xFFD1E3FF),
    onSecondary = Color(0xFF0E1C3B),
    onSecondaryContainer = Color(0xFFD0E2FF),
    onTertiary = Color(0xFF2D005E),
    onTertiaryContainer = Color(0xFFE8DDFF),
    onBackground = Color(0xFFE6E1E5),
    onSurface = Color(0xFFE6E1E5),
    outline = Color(0xFF8E9098),
)

private val LightColorScheme = lightColorScheme(
    primary = Color(0xFF0066CC),
    primaryContainer = Color(0xFFD1E3FF),
    secondary = Color(0xFF4A6280),
    secondaryContainer = Color(0xFFD0E2FF),
    tertiary = Color(0xFF6A0080),
    tertiaryContainer = Color(0xFFE8DDFF),
    background = Color(0xFFFFFBFE),
    surface = Color(0xFFFFFBFE),
    onPrimary = Color(0xFFFFFFFF),
    onPrimaryContainer = Color(0xFF001D3D),
    onSecondary = Color(0xFFFFFFFF),
    onSecondaryContainer = Color(0xFF0E1C3B),
    onTertiary = Color(0xFFFFFFFF),
    onTertiaryContainer = Color(0xFF2D005E),
    onBackground = Color(0xFF1D1B1E),
    onSurface = Color(0xFF1D1B1E),
    outline = Color(0xFF73777F),
)

@Composable
fun Theme(
    darkTheme: Boolean = false,
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme
    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography(),
        content = content
    )
}
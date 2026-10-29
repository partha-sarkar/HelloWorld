package com.example.helloworld

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.material3.Surface
import androidx.compose.material3.Column
import androidx.compose.material3.Row
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.unit.px

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            HelloWorldScreen()
        }
    }
}

@Composable
fun HelloWorldScreen() {
    var count by remember { mutableStateOf(0) }
    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = androidx.compose.foundation.layout.Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Hello, World!",
            fontSize = 48.sp,
            fontWeight = FontWeight.Bold,
            color = Color(0xFF0066CC)
        )
        androidx.compose.foundation.layout.Spacer(modifier = Modifier.padding(16.dp))
        Text(
            text = "Button clicked $count time${if (count != 1) "s" else ""}",
            fontSize = 24.sp,
            color = Color(0xFF666666)
        )
        androidx.compose.foundation.layout.Spacer(modifier = Modifier.padding(32.dp))
        Button(
            onClick = { count++ },
            modifier = Modifier.padding(16.dp)
        ) {
            Text(
                text = "Click Me!",
                fontSize = 24.sp,
                fontWeight = FontWeight.Medium
            )
        }
    }
}
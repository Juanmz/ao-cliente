VERSION 5.00
Begin VB.Form frmMapa 
   BackColor       =   &H80000007&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   6780
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8775
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6780
   ScaleWidth      =   8775
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Label lblTexto 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   240
      TabIndex        =   0
      Top             =   5040
      Width           =   8175
   End
   Begin VB.Image imgMapDungeon 
      Height          =   4935
      Left            =   0
      Top             =   0
      Width           =   8775
   End
   Begin VB.Image imgMap 
      Height          =   4935
      Left            =   0
      Top             =   0
      Width           =   8775
   End
End
Attribute VB_Name = "frmMapa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

''
' Checks what Key is down. If the key is const vbKeyDown or const vbKeyUp, it toggles the maps, else the form unloads.
'
' @param KeyCode Specifies the key pressed
' @param Shift Specifies if Shift Button is pressed
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
'*************************************************
'Author: Marco Vanotti (MarKoxX)
'Last modified: 24/07/08
'
'*************************************************

    Select Case KeyCode
        Case vbKeyDown, vbKeyUp 'Cambiamos el "nivel" del mapa, al estilo Zelda ;D
            ToggleImgMaps
        Case Else
            Unload Me
    End Select
    
End Sub

''
' Toggle which image is visible.
'
Private Sub ToggleImgMaps()
'*************************************************
'Author: Marco Vanotti (MarKoxX)
'Last modified: 24/07/08
'
'*************************************************

    imgMap.Visible = Not imgMap.Visible
    imgMapDungeon.Visible = Not imgMapDungeon.Visible
End Sub

''
' Load the images. Resizes the form, adjusts image's left and top and set lblTexto's Top and Left.
'
Private Sub Form_Load()
'*************************************************
'Author: Marco Vanotti (MarKoxX)
'Last modified: 24/07/08
'
'*************************************************

    On Error GoTo error
    
    'Cargamos las imagenes de los mapas
    imgMap.Picture = LoadPicture(App.path & "\Graficos\mapa1.jpg")
    imgMapDungeon.Picture = LoadPicture(App.path & "\Graficos\mapa2.jpg")
    
    lblTexto.Caption = "Mapa de Argentum Online, Presione Arriba y Abajo para cambiar entre mapa global / laberintos. Presione cualquier otra tecla para salir."
    
    'Ajustamos el tama�o del formulario a la imagen m�s grande
    If imgMap.Width > imgMapDungeon.Width Then
        Me.Width = imgMap.Width
    Else
        Me.Width = imgMapDungeon.Width
    End If
    
    If imgMap.Height > imgMapDungeon.Height Then
        Me.Height = imgMap.Height + lblTexto.Height
    Else
        Me.Height = imgMapDungeon.Height + lblTexto.Height
    End If
    
    'Movemos ambas im�genes al centro del formulario
    imgMap.Left = Me.Width * 0.5 - imgMap.Width * 0.5
    imgMap.Top = (Me.Height - lblTexto.Height) * 0.5 - imgMap.Height * 0.5
    
    imgMapDungeon.Left = Me.Width * 0.5 - imgMapDungeon.Width * 0.5
    imgMapDungeon.Top = (Me.Height - lblTexto.Height) * 0.5 - imgMapDungeon.Height * 0.5
    
    lblTexto.Top = Me.Height - lblTexto.Height
    lblTexto.Left = Me.Width * 0.5 - lblTexto.Width * 0.5
    
    imgMapDungeon.Visible = False
    Exit Sub
error:
    MsgBox Err.Description, vbInformation, "Error: " & Err.number
    Unload Me
End Sub
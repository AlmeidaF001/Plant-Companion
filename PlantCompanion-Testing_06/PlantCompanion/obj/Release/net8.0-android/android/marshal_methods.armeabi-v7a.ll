; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [137 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [274 x i32] [
	i32 39109920, ; 0: Newtonsoft.Json.dll => 0x254c520 => 51
	i32 42639949, ; 1: System.Threading.Thread => 0x28aa24d => 126
	i32 67008169, ; 2: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 72070932, ; 3: Microsoft.Maui.Graphics.dll => 0x44bb714 => 50
	i32 117431740, ; 4: System.Runtime.InteropServices => 0x6ffddbc => 117
	i32 165246403, ; 5: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 61
	i32 175567532, ; 6: UtcTimeLibrary => 0xa76f2ac => 56
	i32 182336117, ; 7: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 79
	i32 195452805, ; 8: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 9: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 10: System.ComponentModel => 0xc38ff48 => 93
	i32 230752869, ; 11: Microsoft.CSharp.dll => 0xdc10265 => 86
	i32 246610117, ; 12: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 115
	i32 280992041, ; 13: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 317674968, ; 14: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 15: Xamarin.AndroidX.Activity.dll => 0x13031348 => 57
	i32 336156722, ; 16: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 17: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 68
	i32 356389973, ; 18: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 379916513, ; 19: System.Threading.Thread.dll => 0x16a510e1 => 126
	i32 385762202, ; 20: System.Memory.dll => 0x16fe439a => 105
	i32 393699800, ; 21: Firebase => 0x177761d8 => 36
	i32 395744057, ; 22: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 414084274, ; 23: UtcTimeLibrary.dll => 0x18ae6cb2 => 56
	i32 435591531, ; 24: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 25: System.Collections => 0x1a61054f => 90
	i32 450948140, ; 26: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 67
	i32 459347974, ; 27: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 121
	i32 469710990, ; 28: System.dll => 0x1bff388e => 131
	i32 498788369, ; 29: System.ObjectModel => 0x1dbae811 => 110
	i32 500358224, ; 30: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 31: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 32: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 45
	i32 530272170, ; 33: System.Linq.Queryable => 0x1f9b4faa => 103
	i32 539058512, ; 34: Microsoft.Extensions.Logging => 0x20216150 => 42
	i32 589163584, ; 35: PlantCompanion.dll => 0x231dec40 => 85
	i32 592146354, ; 36: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 610194910, ; 37: System.Reactive.dll => 0x245ed5de => 53
	i32 627609679, ; 38: Xamarin.AndroidX.CustomView => 0x2568904f => 65
	i32 627931235, ; 39: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 662205335, ; 40: System.Text.Encodings.Web.dll => 0x27787397 => 54
	i32 672442732, ; 41: System.Collections.Concurrent => 0x2814a96c => 87
	i32 688181140, ; 42: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 43: System.Xml.Linq.dll => 0x29293ff5 => 128
	i32 706645707, ; 44: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 45: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 46: System.Runtime.Loader.dll => 0x2b15ed29 => 118
	i32 759454413, ; 47: System.Net.Requests => 0x2d445acd => 108
	i32 775507847, ; 48: System.IO.Compression => 0x2e394f87 => 101
	i32 777317022, ; 49: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 50: Microsoft.Extensions.Options => 0x2f0980eb => 44
	i32 804715423, ; 51: System.Data.Common => 0x2ff6fb9f => 95
	i32 823281589, ; 52: System.Private.Uri.dll => 0x311247b5 => 111
	i32 830298997, ; 53: System.IO.Compression.Brotli => 0x317d5b75 => 100
	i32 904024072, ; 54: System.ComponentModel.Primitives.dll => 0x35e25008 => 91
	i32 926902833, ; 55: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 56: Newtonsoft.Json => 0x38f24a24 => 51
	i32 967690846, ; 57: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 68
	i32 975874589, ; 58: System.Xml.XDocument => 0x3a2aaa1d => 130
	i32 992768348, ; 59: System.Collections.dll => 0x3b2c715c => 90
	i32 1012816738, ; 60: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 78
	i32 1019214401, ; 61: System.Drawing => 0x3cbffa41 => 99
	i32 1028951442, ; 62: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 41
	i32 1029334545, ; 63: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 64: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 58
	i32 1036536393, ; 65: System.Drawing.Primitives.dll => 0x3dc84a49 => 98
	i32 1044663988, ; 66: System.Linq.Expressions.dll => 0x3e444eb4 => 102
	i32 1052210849, ; 67: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 70
	i32 1082857460, ; 68: System.ComponentModel.TypeConverter => 0x408b17f4 => 92
	i32 1084122840, ; 69: Xamarin.Kotlin.StdLib => 0x409e66d8 => 83
	i32 1098259244, ; 70: System => 0x41761b2c => 131
	i32 1118262833, ; 71: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 72: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 73: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 75
	i32 1203215381, ; 74: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1234928153, ; 75: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 76: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1293217323, ; 77: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 66
	i32 1324164729, ; 78: System.Linq => 0x4eed2679 => 104
	i32 1373134921, ; 79: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 80: Xamarin.AndroidX.SavedState => 0x52114ed3 => 78
	i32 1406073936, ; 81: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 62
	i32 1408764838, ; 82: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 120
	i32 1430672901, ; 83: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1461004990, ; 84: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 85: System.IO.Compression.dll => 0x57261233 => 101
	i32 1469204771, ; 86: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 59
	i32 1470490898, ; 87: Microsoft.Extensions.Primitives => 0x57a5e912 => 45
	i32 1480492111, ; 88: System.IO.Compression.Brotli.dll => 0x583e844f => 100
	i32 1493001747, ; 89: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 90: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 91: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 125
	i32 1551623176, ; 92: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1622152042, ; 93: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 72
	i32 1624863272, ; 94: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 81
	i32 1636350590, ; 95: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 64
	i32 1639515021, ; 96: System.Net.Http.dll => 0x61b9038d => 106
	i32 1639986890, ; 97: System.Text.RegularExpressions => 0x61c036ca => 125
	i32 1657153582, ; 98: System.Runtime => 0x62c6282e => 122
	i32 1658251792, ; 99: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 82
	i32 1677501392, ; 100: System.Net.Primitives.dll => 0x63fca3d0 => 107
	i32 1679769178, ; 101: System.Security.Cryptography => 0x641f3e5a => 123
	i32 1729485958, ; 102: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 60
	i32 1736233607, ; 103: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 104: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1746115085, ; 105: System.IO.Pipelines.dll => 0x68139a0d => 52
	i32 1763938596, ; 106: System.Diagnostics.TraceSource.dll => 0x69239124 => 97
	i32 1766324549, ; 107: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 79
	i32 1770582343, ; 108: Microsoft.Extensions.Logging.dll => 0x6988f147 => 42
	i32 1780572499, ; 109: Mono.Android.Runtime.dll => 0x6a216153 => 135
	i32 1782862114, ; 110: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 111: Xamarin.AndroidX.Fragment => 0x6a96652d => 67
	i32 1793755602, ; 112: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 113: Xamarin.AndroidX.Loader => 0x6bcd3296 => 72
	i32 1813058853, ; 114: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 83
	i32 1813201214, ; 115: Xamarin.Google.Android.Material => 0x6c13413e => 82
	i32 1818569960, ; 116: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 76
	i32 1818960736, ; 117: PlantCompanion => 0x6c6b2360 => 85
	i32 1824175904, ; 118: System.Text.Encoding.Extensions => 0x6cbab720 => 124
	i32 1824722060, ; 119: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 120
	i32 1828688058, ; 120: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 43
	i32 1842015223, ; 121: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 122: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 123: System.Linq.Expressions => 0x6ec71a65 => 102
	i32 1870277092, ; 124: System.Reflection.Primitives => 0x6f7a29e4 => 116
	i32 1875935024, ; 125: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1910275211, ; 126: System.Collections.NonGeneric.dll => 0x71dc7c8b => 88
	i32 1939592360, ; 127: System.Private.Xml.Linq => 0x739bd4a8 => 112
	i32 1968388702, ; 128: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 38
	i32 2003115576, ; 129: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 130: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 70
	i32 2025202353, ; 131: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 132: System.Private.Xml => 0x79eb68ee => 113
	i32 2055257422, ; 133: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 69
	i32 2066184531, ; 134: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 135: System.Diagnostics.TraceSource => 0x7b6f419e => 97
	i32 2079903147, ; 136: System.Runtime.dll => 0x7bf8cdab => 122
	i32 2090596640, ; 137: System.Numerics.Vectors => 0x7c9bf920 => 109
	i32 2127167465, ; 138: System.Console => 0x7ec9ffe9 => 94
	i32 2142473426, ; 139: System.Collections.Specialized => 0x7fb38cd2 => 89
	i32 2159891885, ; 140: Microsoft.Maui => 0x80bd55ad => 48
	i32 2169148018, ; 141: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 142: Microsoft.Extensions.Options.dll => 0x820d22b3 => 44
	i32 2192057212, ; 143: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 43
	i32 2193016926, ; 144: System.ObjectModel.dll => 0x82b6c85e => 110
	i32 2201107256, ; 145: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 84
	i32 2201231467, ; 146: System.Net.Http => 0x8334206b => 106
	i32 2207618523, ; 147: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2216717168, ; 148: Firebase.Auth.dll => 0x84206b70 => 35
	i32 2266799131, ; 149: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 39
	i32 2270573516, ; 150: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 151: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 77
	i32 2303942373, ; 152: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 153: System.Private.CoreLib.dll => 0x896b7878 => 133
	i32 2353062107, ; 154: System.Net.Primitives => 0x8c40e0db => 107
	i32 2368005991, ; 155: System.Xml.ReaderWriter.dll => 0x8d24e767 => 129
	i32 2371007202, ; 156: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 38
	i32 2395872292, ; 157: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 158: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 159: System.Console.dll => 0x912896e5 => 94
	i32 2471841756, ; 160: netstandard.dll => 0x93554fdc => 132
	i32 2475788418, ; 161: Java.Interop.dll => 0x93918882 => 134
	i32 2480646305, ; 162: Microsoft.Maui.Controls => 0x93dba8a1 => 46
	i32 2538310050, ; 163: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 115
	i32 2550873716, ; 164: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 165: Microsoft.CSharp => 0x98ba5a04 => 86
	i32 2570120770, ; 166: System.Text.Encodings.Web => 0x9930ee42 => 54
	i32 2585220780, ; 167: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 124
	i32 2593496499, ; 168: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 169: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 84
	i32 2617129537, ; 170: System.Private.Xml.dll => 0x9bfe3a41 => 113
	i32 2620871830, ; 171: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 64
	i32 2626831493, ; 172: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2663698177, ; 173: System.Runtime.Loader => 0x9ec4cf01 => 118
	i32 2664396074, ; 174: System.Xml.XDocument.dll => 0x9ecf752a => 130
	i32 2665622720, ; 175: System.Drawing.Primitives => 0x9ee22cc0 => 98
	i32 2676780864, ; 176: System.Data.Common.dll => 0x9f8c6f40 => 95
	i32 2724373263, ; 177: System.Runtime.Numerics.dll => 0xa262a30f => 119
	i32 2732626843, ; 178: Xamarin.AndroidX.Activity => 0xa2e0939b => 57
	i32 2737747696, ; 179: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 59
	i32 2752995522, ; 180: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 181: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 47
	i32 2764765095, ; 182: Microsoft.Maui.dll => 0xa4caf7a7 => 48
	i32 2778768386, ; 183: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 80
	i32 2785988530, ; 184: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 185: Microsoft.Maui.Graphics => 0xa7008e0b => 50
	i32 2806116107, ; 186: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 187: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 62
	i32 2831556043, ; 188: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2853208004, ; 189: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 80
	i32 2861189240, ; 190: Microsoft.Maui.Essentials => 0xaa8a4878 => 49
	i32 2909740682, ; 191: System.Private.CoreLib => 0xad6f1e8a => 133
	i32 2916838712, ; 192: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 81
	i32 2919462931, ; 193: System.Numerics.Vectors.dll => 0xae037813 => 109
	i32 2959614098, ; 194: System.ComponentModel.dll => 0xb0682092 => 93
	i32 2978675010, ; 195: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 66
	i32 3038032645, ; 196: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 197: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 73
	i32 3059408633, ; 198: Mono.Android.Runtime => 0xb65adef9 => 135
	i32 3059793426, ; 199: System.ComponentModel.Primitives => 0xb660be12 => 91
	i32 3077302341, ; 200: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3159123045, ; 201: System.Reflection.Primitives.dll => 0xbc4c6465 => 116
	i32 3178803400, ; 202: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 74
	i32 3220365878, ; 203: System.Threading => 0xbff2e236 => 127
	i32 3258312781, ; 204: Xamarin.AndroidX.CardView => 0xc235e84d => 60
	i32 3265493905, ; 205: System.Linq.Queryable.dll => 0xc2a37b91 => 103
	i32 3305363605, ; 206: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 207: System.Net.Requests.dll => 0xc5b097e4 => 108
	i32 3317135071, ; 208: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 65
	i32 3322403133, ; 209: Firebase.dll => 0xc607d93d => 36
	i32 3346324047, ; 210: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 75
	i32 3357674450, ; 211: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 212: System.Text.Json => 0xc82afec1 => 55
	i32 3362522851, ; 213: Xamarin.AndroidX.Core => 0xc86c06e3 => 63
	i32 3366347497, ; 214: Java.Interop => 0xc8a662e9 => 134
	i32 3374999561, ; 215: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 77
	i32 3381016424, ; 216: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3428513518, ; 217: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 40
	i32 3430777524, ; 218: netstandard => 0xcc7d82b4 => 132
	i32 3463511458, ; 219: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3471940407, ; 220: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 92
	i32 3476120550, ; 221: Mono.Android => 0xcf3163e6 => 136
	i32 3479583265, ; 222: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 223: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 224: System.Text.Json.dll => 0xcfbaacae => 55
	i32 3509114376, ; 225: System.Xml.Linq => 0xd128d608 => 128
	i32 3580758918, ; 226: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3596207933, ; 227: LiteDB.dll => 0xd659c73d => 37
	i32 3608519521, ; 228: System.Linq.dll => 0xd715a361 => 104
	i32 3629588173, ; 229: LiteDB => 0xd8571ecd => 37
	i32 3641597786, ; 230: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 69
	i32 3643446276, ; 231: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 232: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 74
	i32 3657292374, ; 233: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 39
	i32 3672681054, ; 234: Mono.Android.dll => 0xdae8aa5e => 136
	i32 3697841164, ; 235: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3724971120, ; 236: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 73
	i32 3731644420, ; 237: System.Reactive => 0xde6c6004 => 53
	i32 3748608112, ; 238: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 96
	i32 3786282454, ; 239: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 61
	i32 3792276235, ; 240: System.Collections.NonGeneric => 0xe2098b0b => 88
	i32 3802395368, ; 241: System.Collections.Specialized.dll => 0xe2a3f2e8 => 89
	i32 3823082795, ; 242: System.Security.Cryptography.dll => 0xe3df9d2b => 123
	i32 3841636137, ; 243: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 41
	i32 3849253459, ; 244: System.Runtime.InteropServices.dll => 0xe56ef253 => 117
	i32 3889960447, ; 245: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 246: System.Collections.Concurrent.dll => 0xe839deed => 87
	i32 3896760992, ; 247: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 63
	i32 3928044579, ; 248: System.Xml.ReaderWriter => 0xea213423 => 129
	i32 3931092270, ; 249: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 76
	i32 3955647286, ; 250: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 58
	i32 3980434154, ; 251: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 252: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4023392905, ; 253: System.IO.Pipelines => 0xefd01a89 => 52
	i32 4024013275, ; 254: Firebase.Auth => 0xefd991db => 35
	i32 4025784931, ; 255: System.Memory => 0xeff49a63 => 105
	i32 4046471985, ; 256: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 47
	i32 4054681211, ; 257: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 114
	i32 4068434129, ; 258: System.Private.Xml.Linq.dll => 0xf27f60d1 => 112
	i32 4073602200, ; 259: System.Threading.dll => 0xf2ce3c98 => 127
	i32 4094352644, ; 260: Microsoft.Maui.Essentials.dll => 0xf40add04 => 49
	i32 4099507663, ; 261: System.Drawing.dll => 0xf45985cf => 99
	i32 4100113165, ; 262: System.Private.Uri => 0xf462c30d => 111
	i32 4102112229, ; 263: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 264: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 265: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 40
	i32 4147896353, ; 266: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 114
	i32 4150914736, ; 267: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4181436372, ; 268: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 121
	i32 4182413190, ; 269: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 71
	i32 4213026141, ; 270: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 96
	i32 4271975918, ; 271: Microsoft.Maui.Controls.dll => 0xfea12dee => 46
	i32 4274976490, ; 272: System.Runtime.Numerics => 0xfecef6ea => 119
	i32 4292120959 ; 273: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 71
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [274 x i32] [
	i32 51, ; 0
	i32 126, ; 1
	i32 33, ; 2
	i32 50, ; 3
	i32 117, ; 4
	i32 61, ; 5
	i32 56, ; 6
	i32 79, ; 7
	i32 30, ; 8
	i32 31, ; 9
	i32 93, ; 10
	i32 86, ; 11
	i32 115, ; 12
	i32 2, ; 13
	i32 30, ; 14
	i32 57, ; 15
	i32 15, ; 16
	i32 68, ; 17
	i32 14, ; 18
	i32 126, ; 19
	i32 105, ; 20
	i32 36, ; 21
	i32 34, ; 22
	i32 56, ; 23
	i32 26, ; 24
	i32 90, ; 25
	i32 67, ; 26
	i32 121, ; 27
	i32 131, ; 28
	i32 110, ; 29
	i32 13, ; 30
	i32 7, ; 31
	i32 45, ; 32
	i32 103, ; 33
	i32 42, ; 34
	i32 85, ; 35
	i32 21, ; 36
	i32 53, ; 37
	i32 65, ; 38
	i32 19, ; 39
	i32 54, ; 40
	i32 87, ; 41
	i32 1, ; 42
	i32 128, ; 43
	i32 16, ; 44
	i32 4, ; 45
	i32 118, ; 46
	i32 108, ; 47
	i32 101, ; 48
	i32 25, ; 49
	i32 44, ; 50
	i32 95, ; 51
	i32 111, ; 52
	i32 100, ; 53
	i32 91, ; 54
	i32 28, ; 55
	i32 51, ; 56
	i32 68, ; 57
	i32 130, ; 58
	i32 90, ; 59
	i32 78, ; 60
	i32 99, ; 61
	i32 41, ; 62
	i32 3, ; 63
	i32 58, ; 64
	i32 98, ; 65
	i32 102, ; 66
	i32 70, ; 67
	i32 92, ; 68
	i32 83, ; 69
	i32 131, ; 70
	i32 16, ; 71
	i32 22, ; 72
	i32 75, ; 73
	i32 20, ; 74
	i32 18, ; 75
	i32 2, ; 76
	i32 66, ; 77
	i32 104, ; 78
	i32 32, ; 79
	i32 78, ; 80
	i32 62, ; 81
	i32 120, ; 82
	i32 0, ; 83
	i32 6, ; 84
	i32 101, ; 85
	i32 59, ; 86
	i32 45, ; 87
	i32 100, ; 88
	i32 10, ; 89
	i32 5, ; 90
	i32 125, ; 91
	i32 25, ; 92
	i32 72, ; 93
	i32 81, ; 94
	i32 64, ; 95
	i32 106, ; 96
	i32 125, ; 97
	i32 122, ; 98
	i32 82, ; 99
	i32 107, ; 100
	i32 123, ; 101
	i32 60, ; 102
	i32 23, ; 103
	i32 1, ; 104
	i32 52, ; 105
	i32 97, ; 106
	i32 79, ; 107
	i32 42, ; 108
	i32 135, ; 109
	i32 17, ; 110
	i32 67, ; 111
	i32 9, ; 112
	i32 72, ; 113
	i32 83, ; 114
	i32 82, ; 115
	i32 76, ; 116
	i32 85, ; 117
	i32 124, ; 118
	i32 120, ; 119
	i32 43, ; 120
	i32 29, ; 121
	i32 26, ; 122
	i32 102, ; 123
	i32 116, ; 124
	i32 8, ; 125
	i32 88, ; 126
	i32 112, ; 127
	i32 38, ; 128
	i32 5, ; 129
	i32 70, ; 130
	i32 0, ; 131
	i32 113, ; 132
	i32 69, ; 133
	i32 4, ; 134
	i32 97, ; 135
	i32 122, ; 136
	i32 109, ; 137
	i32 94, ; 138
	i32 89, ; 139
	i32 48, ; 140
	i32 12, ; 141
	i32 44, ; 142
	i32 43, ; 143
	i32 110, ; 144
	i32 84, ; 145
	i32 106, ; 146
	i32 14, ; 147
	i32 35, ; 148
	i32 39, ; 149
	i32 8, ; 150
	i32 77, ; 151
	i32 18, ; 152
	i32 133, ; 153
	i32 107, ; 154
	i32 129, ; 155
	i32 38, ; 156
	i32 13, ; 157
	i32 10, ; 158
	i32 94, ; 159
	i32 132, ; 160
	i32 134, ; 161
	i32 46, ; 162
	i32 115, ; 163
	i32 11, ; 164
	i32 86, ; 165
	i32 54, ; 166
	i32 124, ; 167
	i32 20, ; 168
	i32 84, ; 169
	i32 113, ; 170
	i32 64, ; 171
	i32 15, ; 172
	i32 118, ; 173
	i32 130, ; 174
	i32 98, ; 175
	i32 95, ; 176
	i32 119, ; 177
	i32 57, ; 178
	i32 59, ; 179
	i32 21, ; 180
	i32 47, ; 181
	i32 48, ; 182
	i32 80, ; 183
	i32 27, ; 184
	i32 50, ; 185
	i32 6, ; 186
	i32 62, ; 187
	i32 19, ; 188
	i32 80, ; 189
	i32 49, ; 190
	i32 133, ; 191
	i32 81, ; 192
	i32 109, ; 193
	i32 93, ; 194
	i32 66, ; 195
	i32 34, ; 196
	i32 73, ; 197
	i32 135, ; 198
	i32 91, ; 199
	i32 12, ; 200
	i32 116, ; 201
	i32 74, ; 202
	i32 127, ; 203
	i32 60, ; 204
	i32 103, ; 205
	i32 7, ; 206
	i32 108, ; 207
	i32 65, ; 208
	i32 36, ; 209
	i32 75, ; 210
	i32 24, ; 211
	i32 55, ; 212
	i32 63, ; 213
	i32 134, ; 214
	i32 77, ; 215
	i32 3, ; 216
	i32 40, ; 217
	i32 132, ; 218
	i32 11, ; 219
	i32 92, ; 220
	i32 136, ; 221
	i32 24, ; 222
	i32 23, ; 223
	i32 55, ; 224
	i32 128, ; 225
	i32 31, ; 226
	i32 37, ; 227
	i32 104, ; 228
	i32 37, ; 229
	i32 69, ; 230
	i32 28, ; 231
	i32 74, ; 232
	i32 39, ; 233
	i32 136, ; 234
	i32 33, ; 235
	i32 73, ; 236
	i32 53, ; 237
	i32 96, ; 238
	i32 61, ; 239
	i32 88, ; 240
	i32 89, ; 241
	i32 123, ; 242
	i32 41, ; 243
	i32 117, ; 244
	i32 32, ; 245
	i32 87, ; 246
	i32 63, ; 247
	i32 129, ; 248
	i32 76, ; 249
	i32 58, ; 250
	i32 27, ; 251
	i32 9, ; 252
	i32 52, ; 253
	i32 35, ; 254
	i32 105, ; 255
	i32 47, ; 256
	i32 114, ; 257
	i32 112, ; 258
	i32 127, ; 259
	i32 49, ; 260
	i32 99, ; 261
	i32 111, ; 262
	i32 22, ; 263
	i32 17, ; 264
	i32 40, ; 265
	i32 114, ; 266
	i32 29, ; 267
	i32 121, ; 268
	i32 71, ; 269
	i32 96, ; 270
	i32 46, ; 271
	i32 119, ; 272
	i32 71 ; 273
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ a8cd27e430e55df3e3c1e3a43d35c11d9512a2db"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}

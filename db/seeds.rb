#seed parameter category
fisika = ParameterCategory.create("name"=>"Fisika")
kimia = ParameterCategory.create("name"=>"Kimia")
kimiaOrganik = ParameterCategory.create("name"=>"Kimia Organik")
mikroBiologi = ParameterCategory.create("name"=>"Mikro Biologi")

#seed parameter
fisikaParam1 = Parameter.create("name"=>"Tempratur", "unit"=>"°C")
fisikaParam2 = Parameter.create("name"=>"Residu Terlarut", "unit"=>"mg/l")
fisikaParam3 = Parameter.create("name"=>"Residu Tersuspensi", "unit"=>"mg/l")
fisikaParam4 = Parameter.create("name"=>"Debit", "unit"=>"l/hari")

fisika.parameters << fisikaParam1
fisika.parameters << fisikaParam2
fisika.parameters << fisikaParam3
fisika.parameters << fisikaParam4

kimiaParams1 = Parameter.create("name"=>"pH", "unit"=>"-")
kimiaParams2 = Parameter.create("name"=>"BOD", "unit"=>"mg/l")
kimiaParams3 = Parameter.create("name"=>"COD", "unit"=>"mg/l")
kimiaParams4 = Parameter.create("name"=>"DO", "unit"=>"mg/l")
kimiaParams5 = Parameter.create("name"=>"Total Fosfat sbg P", "unit"=>"mg/l")
kimiaParams6 = Parameter.create("name"=>"NO3 sbg N", "unit"=>"mg/l")
kimiaParams7 = Parameter.create("name"=>"Kobalt (Co)", "unit"=>"mg/l")
kimiaParams8 = Parameter.create("name"=>"Kadmium (Cd)", "unit"=>"mg/l")
kimiaParams9 = Parameter.create("name"=>"Khrom (Cr+6)", "unit"=>"mg/l")
kimiaParams10 = Parameter.create("name"=>"Tembaga (Cu)", "unit"=>"mg/l")
kimiaParams11 = Parameter.create("name"=>"Timbal (Pb)", "unit"=>"mg/l")
kimiaParams12 = Parameter.create("name"=>"Air Raksa (Hg)", "unit"=>"mg/l")
kimiaParams13 = Parameter.create("name"=>"Seng (Zn)", "unit"=>"mg/l")
kimiaParams14 = Parameter.create("name"=>"Sianida (CN)", "unit"=>"mg/l")
kimiaParams15 = Parameter.create("name"=>"Khlorida bebas", "unit"=>"mg/l")
kimiaParams16 = Parameter.create("name"=>"Nitrit sbg N (NO2)", "unit"=>"mg/l")
kimiaParams17 = Parameter.create("name"=>"Belerang sbg (H2S)", "unit"=>"mg/l")

kimia.parameters << kimiaParams1
kimia.parameters << kimiaParams2
kimia.parameters << kimiaParams3
kimia.parameters << kimiaParams4
kimia.parameters << kimiaParams5
kimia.parameters << kimiaParams6
kimia.parameters << kimiaParams7
kimia.parameters << kimiaParams8
kimia.parameters << kimiaParams9
kimia.parameters << kimiaParams10
kimia.parameters << kimiaParams11
kimia.parameters << kimiaParams12
kimia.parameters << kimiaParams13
kimia.parameters << kimiaParams14
kimia.parameters << kimiaParams15
kimia.parameters << kimiaParams16
kimia.parameters << kimiaParams17

kimiaOrganikParams1 = Parameter.create("name"=>"Detergen sbg MBAS", "unit"=>"μg/")
kimiaOrganikParams2 = Parameter.create("name"=>"Seny. Fenol sbg Fenol", "unit"=>"μg/")

kimiaOrganik.parameters << kimiaOrganikParams1
kimiaOrganik.parameters << kimiaOrganikParams2

mikroBiologiParams1 = Parameter.create("name"=>"Fecal Coliform", "unit"=>"MPN/100ml")
mikroBiologiParams2 = Parameter.create("name"=>"Total Coliform", "unit"=>"MPN/100ml")

mikroBiologi.parameters << mikroBiologiParams1
mikroBiologi.parameters << mikroBiologiParams2

#seed location
Location.create("code"=>"GL-1", "river_name"=>"Sungai Gung Lama", "spot_name"=>"titik-1", "address"=>"Jembatan Jl. Werkudoro, Kelurahan Kejambon, Kecamatan Tegal Timur, Kota Tegal", "longitude"=>6.9205555555556, "latitude"=>-109.19472222222)
Location.create("code"=>"GL-2", "river_name"=>"Sungai Gung Lama", "spot_name"=>"titik-2", "address"=>"Jl. Cempaka, Kelurahan Kejambon, Kecamatan Tegal Timur, Kota Tegal", "longitude"=>6.9205555555556, "latitude"=>-109.19472222222)
Location.create("code"=>"GL-3", "river_name"=>"Sungai Gung Lama", "spot_name"=>"titik-3", "address"=>"Jl. Kol. Sugiono, Kelurahan Panggung, Kecamatan Tegal Timur, Kota Tegal", "longitude"=>6.9991666666667, "latitude"=>-109.26972222222)
Location.create("code"=>"GL-4", "river_name"=>"Sungai Gung Lama", "spot_name"=>"titik-4", "address"=>"Kali Anyar, Kelurahan Mintaragen, Kecamatan Tegal Timur, Kota Tegal ", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)
Location.create("code"=>"GL-5", "river_name"=>"Sungai Gung Lama", "spot_name"=>"titik-5", "address"=>"Jl. Yos Sudarso, Kelurahan Mintaragen, Kecamatan Tegal Timur, Kota Tegal", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)

Location.create("code"=>"SB-1", "river_name"=>"Sungai Sibelis", "spot_name"=>"titik-1", "address"=>"Jembatan Jl. Gatot Subroto, Kelurahan Keturen, Kecamatan Tegal Selatan", "longitude"=>7.1122222222222, "latitude"=>-109.12555555556)
Location.create("code"=>"SB-2", "river_name"=>"Sungai Sibelis", "spot_name"=>"titik-2", "address"=>"Depan Hotel Bahari Inn, Kelurahan Kemandungan, Kecamatan Tegal Barat", "longitude"=>6.9202777777778, "latitude"=>-109.13805555556)
Location.create("code"=>"SB-3", "river_name"=>"Sungai Sibelis", "spot_name"=>"titik-3", "address"=>"Belakang Rita Mall, Kelurahan Kemandungan, Kecamatan Tegal Barat", "longitude"=>6.9202777777778, "latitude"=>-109.13805555556)
# longitude latitude belom
Location.create("code"=>"SB-4", "river_name"=>"Sungai Sibelis", "spot_name"=>"titik-4", "address"=>"Jembatan Jl. Tegal-Brebes (Jl. Kol. Sugiono) Kelurahan Kemandungan, Kecamatan Tegal Barat ", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)
Location.create("code"=>"SB-5", "river_name"=>"Sungai Sibelis", "spot_name"=>"titik-5", "address"=>"Muara Sungai Sibelis Jelmbatan Jl. Ayang, Kelurahan Tegalsari, Kecamatan Tegal Barat", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)

Location.create("code"=>"KM-1", "river_name"=>"Sungai Kemiri", "spot_name"=>"titik-1", "address"=>"Kelurahan Kalinyamat Wetan, Kecamatan Tegal Selatan", "longitude"=>6.9205555555556, "latitude"=>-109.19472222222)
Location.create("code"=>"KM-2", "river_name"=>"Sungai Kemiri", "spot_name"=>"titik-2", "address"=>"Kelurahan Kalinyamat Kulon, Kecamatan Tegal Selatan", "longitude"=>6.9205555555556, "latitude"=>-109.19472222222)
Location.create("code"=>"KM-3", "river_name"=>"Sungai Kemiri", "spot_name"=>"titik-3", "address"=>"Anak Sungai Kemiri Kelurahan Sumurpanggang, Kecamatan Margadana", "longitude"=>6.9991666666667, "latitude"=>-109.26972222222)
Location.create("code"=>"KM-4", "river_name"=>"Sungai Kemiri", "spot_name"=>"titik-4", "address"=>"Anak Sungai Kemiri (Saluran Pesing) Kelurahan Sumurpanggang, Kecamatan Margadana", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)
Location.create("code"=>"KM-5", "river_name"=>"Sungai Kemiri", "spot_name"=>"titik-5", "address"=>"Kelurahan Sumurpanggang, Kecamatan Margadana", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)
Location.create("code"=>"KM-6", "river_name"=>"Sungai Kemiri", "spot_name"=>"titik-6", "address"=>"Muara Sungai Kemiri, Kelurahan Muarareja, Kecamatan Tegal Barat", "longitude"=>6.9366666666667, "latitude"=>-109.23166666667)

adminRole = Role.create("name"=>"Administrator")
staffRole = Role.create("name"=>"Staff")

userAdmin = User.create("email"=>"administrator@prokasih.com", "name"=>"Administrator Prokasih", "password"=>"123456", "password_confirmation"=>"123456")
userAdmin.roles << adminRole

userAdmin.articles.create("title"=>"Air bersih sumber kehidupan kita", "content"=>"<p>Banyak sekali diantara kita tidak perduli perduli akan kebersihan air dilingkungan kita. banyak sekali yang mencemari perairan diindonesia hanya untuk kepentingan mereka semata. padahal air menjadi sumber kehidupan setiap makhluk dibumi ini. Setiap makhluk memerlukan sedikitnya 75% air didalam tubuhnya.&nbsp;</p><p>Diindonesia tingkat pencemaran air sangatlah menghawatirkan, dimuali dari masyarakat yang membuang sampah ke sungai sampai para industri2 yang membuang limbahnya ke perairan menjadikan indonesia memiliki pencemaran perairan yang tinggi.</p><p>oleh karena itu kita sebagai masyarakat yang baik mari kita jaga lingkungan terutama perariran karena air adalah sumber kehidupan kita semua.&nbsp;</p>", "content_preview"=>"Banyak sekali diantara kita tidak perduli perduli akan kebersihan air dilingkungan kita. banyak sek")
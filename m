From: Matt Conner <matt.conner@keepertech.com>
Subject: Re: Kernel RBD hang on OSD Failure
Date: Thu, 10 Dec 2015 18:16:55 -0500
Message-ID: <CAKeiORTAr1oO-yo2xNsKoiiEPWedVaTHBRqNNiMykGqPCsn20A@mail.gmail.com>
References: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
	<CAOi1vP-ZvpDTQ1ej0Um2hJSG-LpquTMZAY8e3P2BtpSkNnL4Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35690 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbLJXQ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Dec 2015 18:16:56 -0500
Received: by oige206 with SMTP id e206so55288745oig.2
        for <ceph-devel@vger.kernel.org>; Thu, 10 Dec 2015 15:16:55 -0800 (PST)
In-Reply-To: <CAOi1vP-ZvpDTQ1ej0Um2hJSG-LpquTMZAY8e3P2BtpSkNnL4Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ilya,

Took me a little time to reproduce, but I'm once again got into the
state. In the past I had reproduced the issue with a single OSD
failure but in this case I failed an entire server. Ignore the "noout"
flag as I set it to prevent rebalance during my attempts to reproduce
the issue.

osdmap:

epoch 6191
flags
pool 0 pg_num 64 (63) read_tier -1 write_tier -1
pool 1 pg_num 64 (63) read_tier -1 write_tier -1
pool 2 pg_num 64 (63) read_tier -1 write_tier -1
pool 3 pg_num 2048 (2047) read_tier -1 write_tier -1
pool 5 pg_num 2048 (2047) read_tier -1 write_tier -1
pool 6 pg_num 2048 (2047) read_tier -1 write_tier -1
pool 7 pg_num 2048 (2047) read_tier -1 write_tier -1
osd0 10.10.30.55:6830 100% (exists, up) 100%
osd1 10.10.30.53:6809 100% (exists, up) 100%
osd2 10.10.30.54:6839 100% (exists, up) 100%
osd3 10.10.30.56:6833 100% (exists, up) 100%
osd4 10.10.30.55:6848 100% (exists, up) 100%
osd5 10.10.30.53:6854 100% (exists, up) 100%
osd6 10.10.30.56:6818 100% (exists, up) 100%
osd7 10.10.30.54:6830 100% (exists, up) 100%
osd8 10.10.30.55:6839 100% (exists, up) 100%
osd9 10.10.30.56:6845 100% (exists, up) 100%
osd10 10.10.30.53:6860 100% (exists, up) 100%
osd11 10.10.30.54:6842 100% (exists, up) 100%
osd12 10.10.30.55:6836 100% (exists, up) 100%
osd13 10.10.30.56:6863 100% (exists, up) 100%
osd14 10.10.30.53:6839 100% (exists, up) 100%
osd15 10.10.30.54:6866 100% (exists, up) 100%
osd16 10.10.30.55:6869 100% (exists, up) 100%
osd17 10.10.30.56:6812 100% (exists, up) 100%
osd18 10.10.30.53:6824 100% (exists, up) 100%
osd19 10.10.30.54:6818 100% (exists, up) 100%
osd20 10.10.30.55:6833 100% (exists, up) 100%
osd21 10.10.30.56:6869 100% (exists, up) 100%
osd22 10.10.30.53:6857 100% (exists, up) 100%
osd23 10.10.30.54:6833 100% (exists, up) 100%
osd24 10.10.30.55:6803 100% (exists, up) 100%
osd25 10.10.30.56:6821 100% (exists, up) 100%
osd26 10.10.30.54:6848 100% (exists, up) 100%
osd27 10.10.30.53:6848 100% (exists, up) 100%
osd28 10.10.30.55:6863 100% (exists, up) 100%
osd29 10.10.30.56:6827 100% (exists, up) 100%
osd30 10.10.30.54:6836 100% (exists, up) 100%
osd31 10.10.30.53:6863 100% (exists, up) 100%
osd32 10.10.30.55:6845 100% (exists, up) 100%
osd33 10.10.30.56:6839 100% (exists, up) 100%
osd34 10.10.30.54:6851 100% (exists, up) 100%
osd35 10.10.30.53:6845 100% (exists, up) 100%
osd36 10.10.30.55:6854 100% (exists, up) 100%
osd37 10.10.30.56:6851 100% (exists, up) 100%
osd38 10.10.30.54:6806 100% (exists, up) 100%
osd39 10.10.30.53:6824  0% (doesn't exist) 100%
osd40 10.10.30.55:6815 100% (exists, up) 100%
osd41 10.10.30.56:6842 100% (exists, up) 100%
osd42 10.10.30.54:6863 100% (exists, up) 100%
osd43 10.10.30.53:6806 100% (exists, up) 100%
osd44 10.10.30.55:6821 100% (exists, up) 100%
osd45 10.10.30.56:6803 100% (exists, up) 100%
osd46 10.10.30.54:6812 100% (exists, up) 100%
osd47 10.10.30.53:6866 100% (exists, up) 100%
osd48 10.10.30.55:6812 100% (exists, up) 100%
osd49 10.10.30.56:6815 100% (exists, up) 100%
osd50 10.10.30.53:6842 100% (exists, up) 100%
osd51 10.10.30.54:6854 100% (exists, up) 100%
osd52 10.10.30.55:6842 100% (exists, up) 100%
osd53 10.10.30.56:6836 100% (exists, up) 100%
osd54 10.10.30.53:6803 100% (exists, up) 100%
osd55 10.10.30.54:6869 100% (exists, up) 100%
osd56 10.10.30.55:6866 100% (exists, up) 100%
osd57 10.10.30.56:6860 100% (exists, up) 100%
osd58 10.10.30.53:6800 100% (exists, up) 100%
osd59 10.10.30.54:6803 100% (exists, up) 100%
osd60 10.10.30.55:6824 100% (exists, up) 100%
osd61 10.10.30.56:6804 100% (exists, up) 100%
osd62 10.10.30.53:6815 100% (exists, up) 100%
osd63 10.10.30.54:6857 100% (exists, up) 100%
osd64 10.10.30.55:6800 100% (exists, up) 100%
osd65 10.10.30.56:6866 100% (exists, up) 100%
osd66 10.10.30.53:6836 100% (exists, up) 100%
osd67 10.10.30.54:6845 100% (exists, up) 100%
osd68 10.10.30.55:6860 100% (exists, up) 100%
osd69 10.10.30.56:6824 100% (exists, up) 100%
osd70 10.10.30.53:6821 100% (exists, up) 100%
osd71 10.10.30.54:6809 100% (exists, up) 100%
osd72 10.10.30.55:6806 100% (exists, up) 100%
osd73 10.10.30.56:6809 100% (exists, up) 100%
osd74 10.10.30.53:6818 100% (exists, up) 100%
osd75 10.10.30.54:6815 100% (exists, up) 100%
osd76 10.10.30.55:6827 100% (exists, up) 100%
osd77 10.10.30.56:6830 100% (exists, up) 100%
osd78 10.10.30.53:6833 100% (exists, up) 100%
osd79 10.10.30.54:6800 100% (exists, up) 100%
osd80 10.10.30.55:6851 100% (exists, up) 100%
osd81 10.10.30.56:6800 100% (exists, up) 100%
osd82 10.10.30.53:6812 100% (exists, up) 100%
osd83 10.10.30.54:6821 100% (exists, up) 100%
osd84 10.10.30.55:6857 100% (exists, up) 100%
osd85 10.10.30.56:6848 100% (exists, up) 100%
osd86 10.10.30.53:6830 100% (exists, up) 100%
osd87 10.10.30.54:6827 100% (exists, up) 100%
osd88 10.10.30.55:6809 100% (exists, up) 100%
osd89 10.10.30.56:6854 100% (exists, up) 100%
osd90 10.10.30.53:6827 100% (exists, up) 100%
osd91 10.10.30.54:6860 100% (exists, up) 100%
osd92 10.10.30.55:6818 100% (exists, up) 100%
osd93 10.10.30.56:6857 100% (exists, up) 100%
osd94 10.10.30.53:6851 100% (exists, up) 100%
osd95 10.10.30.54:6824 100% (exists, up) 100%
osd96 10.10.30.52:6863 100% (exists, up) 100%
osd97 10.10.30.51:6841 100% (exists) 100%
osd98 10.10.30.52:6854 100% (exists, up) 100%
osd99 10.10.30.51:6844 100% (exists) 100%
osd100 10.10.30.52:6809 100% (exists, up) 100%
osd101 10.10.30.51:6853 100% (exists) 100%
osd102 10.10.30.52:6857 100% (exists, up) 100%
osd103 10.10.30.51:6807 100% (exists) 100%
osd104 10.10.30.51:6810 100% (exists) 100%
osd105 10.10.30.52:6827 100% (exists, up) 100%
osd106 10.10.30.52:6881 100% (exists, up) 100%
osd107 10.10.30.51:6801 100% (exists) 100%
osd108 10.10.30.52:6803 100% (exists, up) 100%
osd109 10.10.30.51:6835 100% (exists) 100%
osd110 10.10.30.52:6878 100% (exists, up) 100%
osd111 10.10.30.51:6825 100% (exists) 100%
osd112 10.10.30.51:6804 100% (exists) 100%
osd113 10.10.30.52:6860 100% (exists, up) 100%
osd114 10.10.30.51:6838 100% (exists) 100%
osd115 10.10.30.52:6845 100% (exists, up) 100%
osd116 10.10.30.52:6872 100% (exists, up) 100%
osd117 10.10.30.51:6862 100% (exists) 100%
osd118 10.10.30.52:6806 100% (exists, up) 100%
osd119 10.10.30.51:6832 100% (exists) 100%
osd120 10.10.30.52:6842 100% (exists, up) 100%
osd121 10.10.30.51:6816 100% (exists) 100%
osd122 10.10.30.52:6824 100% (exists, up) 100%
osd123 10.10.30.51:6859 100% (exists) 100%
osd124 10.10.30.52:6839 100% (exists, up) 100%
osd125 10.10.30.51:6868 100% (exists) 100%
osd126 10.10.30.51:6829 100% (exists) 100%
osd127 10.10.30.52:6848 100% (exists, up) 100%
osd128 10.10.30.51:6883 100% (exists) 100%
osd129 10.10.30.52:6836 100% (exists, up) 100%
osd130 10.10.30.52:6812 100% (exists, up) 100%
osd131 10.10.30.51:6819 100% (exists) 100%
osd132 10.10.30.52:6821 100% (exists, up) 100%
osd133 10.10.30.51:6874 100% (exists) 100%
osd134 10.10.30.52:6828 100% (exists, up) 100%
osd135 10.10.30.51:6871 100% (exists) 100%
osd136 10.10.30.52:6833 100% (exists, up) 100%
osd137 10.10.30.51:6813 100% (exists) 100%
osd138 10.10.30.52:6869 100% (exists, up) 100%
osd139 10.10.30.51:6865 100% (exists) 100%
osd140 10.10.30.52:6875 100% (exists, up) 100%
osd141 10.10.30.51:6822 100% (exists) 100%
osd142 10.10.30.52:6800 100% (exists, up) 100%
osd143 10.10.30.51:6880 100% (exists) 100%
osd144 10.10.30.52:6851 100% (exists, up) 100%
osd145 10.10.30.51:6877 100% (exists) 100%
osd146 10.10.30.52:6815 100% (exists, up) 100%
osd147 10.10.30.51:6850 100% (exists) 100%
osd148 10.10.30.52:6866 100% (exists, up) 100%
osd149 10.10.30.51:6800 100% (exists) 100%
osd150 10.10.30.52:6818 100% (exists, up) 100%
osd151 10.10.30.51:6856 100% (exists) 100%

osdc:

2064277 osd136 3.79a01658 rbd_data.f659f6ca5381e.0000000000003e0d read
2066619 osd29 3.a54ffb5 rbd_data.f54f37207fb18.0000000000000013 read
2067420 osd29 3.8ca62e20 rbd_data.f54f921268b0f.0000000000001a0f read
2068773 osd136 3.6145463c rbd_data.f65ad4ab53d2.0000000000002c0c read
2069250 osd29 3.a54ffb5 rbd_data.f54f37207fb18.0000000000000013
set-alloc-hint,write
2069272 osd136 3.e9f670ce rbd_data.12621d18fb34.00000000000011c7 read
2069838 osd136 3.5c533eb5 rbd_data.f65adcf2a53f.0000000000000000 read
2069872 osd136 3.5c533eb5 rbd_data.f65adcf2a53f.0000000000000000 read
2069880 osd136 3.b4d593da rbd_data.f663471f4e3a4.0000000000000035
set-alloc-hint,write
2069994 osd43 3.485e015f rbd_header.f42e85cd8f5d2 192438'26551487823872 watch
2069995 osd23 3.967f0ac rbd_header.f54f943ff3510 271821'26551487823872 watch
2069996 osd22 3.1679d3fd rbd_header.f54f346170e75 248651'26551487823872 watch
2069997 osd132 3.4c72415a rbd_header.f659f6ca5381e 212921'26551487823872 watch
2069998 osd40 3.dcb615cd rbd_header.f659f3b6599ce 281696'26551487823872 watch
2069999 osd4 3.2c5dc7d9 rbd_header.f659f7b8275f8 265762'26551487823872 watch
2070000 osd29 3.49c607ca rbd_header.f66343de35900 230429'26551487823872 watch
2070001 osd140 3.a030d1d8 rbd_header.f66341d1ccf35 290629'26551487823872 watch
2070002 osd45 3.ce94805a rbd_header.f66345f368639 295864'26551487823872 watch
2070003 osd52 3.854e4dfc rbd_header.593b6491ec9f 280116'26551487823872 watch
2070004 osd38 3.5cce84bc rbd_header.f42e822939526 163677'26551487823872 watch
2070005 osd47 3.13094d0 rbd_header.f42e869ead798 165850'26551487823872 watch
2070006 osd92 3.b72d8628 rbd_header.f42e8534aeb08 220526'26551487823872 watch
2070007 osd41 3.a44fd23b rbd_header.1262487bcab5 170538'26551487823872 watch
2070008 osd0 3.184871e7 rbd_header.12622ffb8aff 221268'26551487823872 watch
2070009 osd73 3.41d03b49 rbd_header.12628c3de5a 188527'26551487823872 watch
2070010 osd38 3.b63d7b6c rbd_header.126253d67973 116592'26551487823872 watch
2070011 osd115 3.e6b3a4e rbd_header.1262614d8810 231173'26551487823872 watch
2070012 osd72 3.d9ede1c3 rbd_header.1262115f0cf 140197'26551487823872 watch
2070013 osd12 3.6642c157 rbd_header.12621e7fc115 187593'26551487823872 watch
2070014 osd91 3.b3705118 rbd_header.593b7323f25f 243419'26551487823872 watch
2070015 osd57 3.abcf9bf6 rbd_header.593b363a4411 209538'26551487823872 watch
2070016 osd53 3.72c67cfe rbd_header.593b6072b1c7 291406'26551487823872 watch
2070017 osd70 3.10504835 rbd_header.593b35e9ba2b 205415'26551487823872 watch
2070018 osd45 3.8b381aaa rbd_header.593b418e8823 272511'26551487823872 watch
2070019 osd142 3.2b5318b7 rbd_header.593b46f1aa31 210594'26551487823872 watch
2070020 osd68 3.25c6ad00 rbd_header.4e449416a8478 72833'26551487823872 watch
2070021 osd57 3.3df2d8ae rbd_header.4e44968299a31 74608'26551487823872 watch
2070022 osd13 3.5102bd35 rbd_header.4e449723d5105 87452'26551487823872 watch
2070023 osd46 3.d0ad9250 rbd_header.4e449104e5eea 75590'26551487823872 watch
2070024 osd148 3.7fb7b2bd rbd_header.4e4491321fb8d 68317'26551487823872 watch
2070025 osd18 3.f82976fd rbd_header.4e449402e564a 57095'26551487823872 watch
2070026 osd10 3.39b4da2e rbd_header.4e44914acd83 60123'26551487823872 watch
2070027 osd2 3.8fe8ba4d rbd_header.e6ec56f5dcb51 200753'26551487823872 watch
2070028 osd6 3.66d6ca30 rbd_header.e6ec57072b44a 235673'26551487823872 watch
2070029 osd80 3.25b25299 rbd_header.e6ec57e4a0ef9 188214'26551487823872 watch
2070030 osd46 3.58e2250 rbd_header.e6ec550078b66 190030'26551487823872 watch
2070031 osd116 3.b29b37d3 rbd_header.e6ec521c83559 180643'26551487823872 watch
2070032 osd80 3.eca20f5e rbd_header.e6ec570293241 160701'26551487823872 watch
2070033 osd80 3.b20df8a9 rbd_header.e6ec53b631e5a 144384'26551487823872 watch
2070034 osd40 3.6cb419d5 rbd_header.e6ec54ba29f38 200692'26551487823872 watch
2070035 osd102 3.7a15b5b6 rbd_header.f42e823bececa 182482'26551487823872 watch
2070036 osd96 3.2ceb4f46 rbd_header.f42e867b637bd 175132'26551487823872 watch
2070037 osd57 3.6daeb5a2 rbd_header.f42e82ecebca5 156055'26551487823872 watch
2070038 osd37 3.a133da1c rbd_header.f42e816513fa7 196719'26551487823872 watch
2070039 osd43 3.c0125aba rbd_header.f42e84c075b37 192587'26551487823872 watch
2070040 osd51 3.20cb2f53 rbd_header.f42e81f94a5be 134631'26551487823872 watch
2070041 osd69 3.a3527e5a rbd_header.f65a150a4c7f4 223891'26551487823872 watch
2070042 osd146 3.ee1e56f3 rbd_header.f65a15677948f 200523'26551487823872 watch
2070043 osd21 3.672cde13 rbd_header.f65a143514fd 198930'26551487823872 watch
2070044 osd36 3.97cc7470 rbd_header.f65a11185e747 201523'26551487823872 watch
2070045 osd70 3.18fcd272 rbd_header.f65a1158abf02 197611'26551487823872 watch
2070046 osd82 3.8208b836 rbd_header.f65a12c47fed6 287608'26551487823872 watch
2070047 osd78 3.9ce9d2d8 rbd_header.f54f3f3f78ae 216654'26551487823872 watch
2070048 osd16 3.99d5db06 rbd_header.f54f32ea892e4 250640'26551487823872 watch
2070049 osd68 3.9f1c071a rbd_header.f54f35d7af2cf 223450'26551487823872 watch
2070050 osd90 3.c8100cf5 rbd_header.f54f331b392f7 303745'26551487823872 watch
2070051 osd60 3.c41f015d rbd_header.f659f6f6c01c3 174666'26551487823872 watch
2070052 osd24 3.22b6834c rbd_header.f659f7570a216 252853'26551487823872 watch
2070053 osd100 3.4355d651 rbd_header.f659f4963d64c 245170'26551487823872 watch
2070054 osd80 3.133cf6eb rbd_header.f659f4da10e75 245743'26551487823872 watch
2070055 osd1 3.eb339cb3 rbd_header.f659f7eb5f195 245316'26551487823872 watch
2070056 osd82 3.918d4e00 rbd_header.f659f7c4753bc 220074'26551487823872 watch
2070057 osd42 3.ff1718f5 rbd_header.f659f2b730b02 230028'26551487823872 watch
2070058 osd92 3.e4e19983 rbd_header.f659f314a46f 269470'26551487823872 watch
2070059 osd56 3.25c96e8a rbd_header.f659f119f370d 266582'26551487823872 watch
2070060 osd115 3.642e224e rbd_header.f659f584de7fd 291576'26551487823872 watch
2070061 osd144 3.45280ccc rbd_header.f54f91f78d63 225918'26551487823872 watch
2070062 osd118 3.50873837 rbd_header.f54f921268b0f 245740'26551487823872 watch
2070063 osd55 3.dcad1c74 rbd_header.f54f91e0c08fc 216768'26551487823872 watch
2070064 osd7 3.877d0e06 rbd_header.f54f9253d6b46 230906'26551487823872 watch
2070065 osd63 3.c87ca915 rbd_header.f54f94f111989 299124'26551487823872 watch
2070066 osd8 3.7031dc84 rbd_header.f54f967833a1e 179952'26551487823872 watch
2070067 osd98 3.9fa8711e rbd_header.f54f9412b530 228333'26551487823872 watch
2070068 osd54 3.a56ea23f rbd_header.f65ad31c25f40 304518'26551487823872 watch
2070069 osd80 3.13e40a42 rbd_header.f65ad65e773b1 250650'26551487823872 watch
2070070 osd55 3.38db7474 rbd_header.f65adcf2a53f 216765'26551487823872 watch
2070071 osd54 3.1f5c8bf4 rbd_header.f65ad16be944c 255781'26551487823872 watch
2070072 osd3 3.73a827db rbd_header.f65ad4ab53d2 219699'26551487823872 watch
2070073 osd16 3.d4745306 rbd_header.f66347b1b9a6e 250637'26551487823872 watch
2070074 osd69 3.e8130397 rbd_header.f6634622f70bc 207323'26551487823872 watch
2070075 osd74 3.7f33b105 rbd_header.f66347871909c 214234'26551487823872 watch
2070076 osd44 3.27439970 rbd_header.f663436a83873 221219'26551487823872 watch
2070077 osd110 3.e75d1953 rbd_header.f663475df588b 283149'26551487823872 watch
2070078 osd4 3.5396c89b rbd_header.f6634a9aaa27 208564'26551487823872 watch
2070079 osd14 3.cbdfe123 rbd_header.f663455329544 215780'26551487823872 watch
2070080 osd129 3.c80e056e rbd_header.f54f9422698a8 279482'26551487823872 watch
2070081 osd48 3.7adea980 rbd_header.4e4495a579b90 73658'26551487823872 watch
2070082 osd138 3.42b95d27 rbd_header.f42e83bfec56b 154232'26551487823872 watch
2070083 osd124 3.5af1eb91 rbd_header.f54f97996dd85 230331'26551487823872 watch
2070084 osd35 3.658c8f8 rbd_header.f54f319d0e468 252143'26551487823872 watch
2070085 osd35 3.fe6122f9 rbd_header.f65ad565c0a5d 216244'26551487823872 watch
2070086 osd93 3.71d7a587 rbd_header.593b5906fecb 248271'26551487823872 watch
2070087 osd2 3.8a1702f8 rbd_header.f65a1f9017a4 229537'26551487823872 watch
2070088 osd67 3.264a59c8 rbd_header.f65ad2e962255 234483'26551487823872 watch
2070089 osd138 3.776060c2 rbd_header.f65a11e3967ed 209128'26551487823872 watch
2070090 osd138 3.5d6d3b8 rbd_header.f65a132381bb4 173801'26551487823872 watch
2070103 osd29 3.50cfcfca rbd_data.f66344509891b.0000000000003402 read


ceph status:

    cluster f1885784-0159-11e4-be58-a0d3c1f1936c
     health HEALTH_WARN 4594 pgs degraded; 4594 pgs stuck unclean; 635
requests are blocked > 32 sec; recovery 4052687/22088253 objects
degraded (18.348%); 28/151 in osds are down; noout flag(s) set
     monmap e6: 3 mons at
{ic2mon01=10.10.30.115:6789/0,ic2mon02=10.10.30.116:6789/0,ic2mon03=10.10.30.117:6789/0},
election epoch 74, quorum 0,1,2 ic2mon01,ic2mon02,ic2mon03
     osdmap e6191: 151 osds: 123 up, 151 in
            flags noout
      pgmap v2318683: 8384 pgs, 7 pools, 28006 GB data, 7190 kobjects
            36799 GB used, 511 TB / 547 TB avail
            4052687/22088253 objects degraded (18.348%)
                4594 active+degraded
                   1 active+clean+scrubbing+deep
                3789 active+clean


Matt Conner
Keeper Technology



On Tue, Dec 8, 2015 at 5:59 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Mon, Dec 7, 2015 at 9:56 PM, Matt Conner <matt.conner@keepertech.com> wrote:
>> Hi,
>>
>> We have a Ceph cluster in which we have been having issues with RBD
>> clients hanging when an OSD failure occurs. We are using a NAS gateway
>> server which maps RBD images to filesystems and serves the filesystems
>> out via NFS. The gateway server has close to 180 NFS clients and
>> almost every time even 1 OSD goes down during heavy load, the NFS
>> exports lock up and the clients are unable to access the NAS share via
>> NFS. When the OSD fails, Ceph recovers without issue, but the gateway
>> kernel RBD module appears to get stuck waiting on the now failed OSD.
>> Note that this works correctly when under lighter loads.
>>
>> From what we have been able to determine, the NFS server daemon hangs
>> waiting for I/O from the OSD that went out and never recovers.
>> Similarly, attempting to access files from the exported FS locally on
>> the gateway server will result in a similar hang. We also noticed that
>> Ceph health details will continue to report blocked I/O on the now
>> down OSD until either the OSD is recovered or the gateway server is
>> rebooted.  Based on a few kernel logs from NFS and PVS, we were able
>> to trace the problem to the RBD kernel module.
>>
>> Unfortunately, the only way we have been able to recover our gateway
>> is by hard rebooting the server.
>>
>> Has anyone else encountered this issue and/or have a possible solution?
>> Are there suggestions for getting more detailed debugging information
>> from the RBD kernel module?
>
> Dumping osdc, osdmap and ceph status when it gets stuck would be
> a start:
>
> # cat /sys/kernel/debug/ceph/*/osdmap
> # cat /sys/kernel/debug/ceph/*/osdc
> $ ceph status
>
> Thanks,
>
>                 Ilya

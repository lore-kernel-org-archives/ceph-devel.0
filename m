From: lixiaobing10@otcaix.iscas.ac.cn
Subject: Re: error of ceph
Date: Sat, 24 Mar 2012 10:46:35 +0800 (CST)
Message-ID: <f2fb90.5a.136429929dc.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
References: <CABAwU-amSExToGzVUH2nT35kib02dZVuS4iLdqjBj+UsJ3YMXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_313_16399877.1332557195739"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [124.16.137.195] ([124.16.137.195]:39461 "EHLO
	otcaix.iscas.ac.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab2CXCyi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 22:54:38 -0400
In-Reply-To: <CABAwU-amSExToGzVUH2nT35kib02dZVuS4iLdqjBj+UsJ3YMXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

------=_Part_313_16399877.1332557195739
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: quoted-printable

hi Huangjun,

The attachment is my ceph.conf. And I use the following command to initiali=
ze ceph:
mkfs.btrfs /dev/sdb
mkdir /data/osd.0
mount /dev/sdb /data/osd.0
mkcephfs -a -c ceph.conf

After initialization, I use 'init-ceph -c ceph.conf -a start' to start ceph=
.

The 'ceph -s' show mds is always in 'creating' status, and 'ceph health det=
ail' show 'HEALTH_WARN 6 pgs degraded'. Hoping to get your suggestion. Than=
ks for your attention!

Best,
Xiaobing

P.S. the log file is a little big, because I set the debug level as 20. If =
you need them, I can send them to you separately.=20

> -----=D4=AD=CA=BC=D3=CA=BC=FE-----
> =B7=A2=BC=FE=C8=CB: "huang jun" <hjwsm1989@gmail.com>
> =B7=A2=CB=CD=CA=B1=BC=E4: 2012=C4=EA3=D4=C223=C8=D5 =D0=C7=C6=DA=CE=E5
> =CA=D5=BC=FE=C8=CB: lixiaobing10@otcaix.iscas.ac.cn
> =B3=AD=CB=CD:=20
> =D6=F7=CC=E2: error of ceph
>=20
> hi,
> maybe you should send your ceph.conf file to the list
> i think it about the OSD didn't work well, so that MDS can not create
> it metadata file on OSD.
>=20
>=20
> --=20
> huangjun

------=_Part_313_16399877.1332557195739
Content-Type: application/octet-stream; name="ceph.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ceph.conf"

W2dsb2JhbF0KICA7dXNlciA9IHJvb3QKCiAga2V5cmluZyA9IC9kYXRhL2tleXJpbmcuJG5hbWUK
CiAgbWF4IG9wZW4gZmlsZXMgPSAxMzEwNzIKICBsb2cgZmlsZSA9IC92YXIvbG9nL2NlcGgvJG5h
bWUubG9nCiAgcGlkIGZpbGUgPSAvdmFyL3J1bi9jZXBoLyRuYW1lLnBpZCAKIAo7bW9uaXRvcnMK
W21vbl0KICBtb24gZGF0YSA9IC9kYXRhL21vbi4kaWQKCiAgZGVidWcgbXMgPSAxICAgICA7IHNl
ZSBtZXNzYWdlIHRyYWZmaWMKICBkZWJ1ZyBtb24gPSAyMCAgIDsgbW9uaXRvciAKICBkZWJ1ZyBw
YXhvcyA9IDIwIDsgbW9uaXRvciByZXBsaWNhdGlvbgogIGRlYnVnIGF1dGggPSAyMCAgOyBhdXRo
ZW50aWNhdGlvbiBjb2RlCgpbbW9uLjBdCiAgaG9zdCA9IGZkci12Y2VwaC0wCiAgbW9uIGFkZHIg
PSAxOTIuMTY4LjEyMi4yMjA6Njc4OQoKO21ldGFkYXRhIHNlcnZlcnMKW21kc10KCiAgZGVidWcg
bXMgPSAxICAgICAgICAgICAgOyBtZXNzYWdlIHRyYWZmaWMKICBkZWJ1ZyBtZHMgPSAyMCAgICAg
ICAgICA7IG1kcwogIGRlYnVnIG1kcyBiYWxhbmNlciA9IDIwIDsgbG9hZCBiYWxhbmNpbmcKICBk
ZWJ1ZyBtZHMgbG9nID0gMjAgICAgICA7IG1kcyBqb3VybmFsaW5nCiAgZGVidWcgbWRzX21pZ3Jh
dG9yID0gMjAgOyBtZXRhZGF0YSBtaWdyYXRpb24KICBkZWJ1ZyBtb25jID0gMjAgICAgICAgICA7
IG1vbml0b3IgaW50ZXJhY3Rpb24sIHN0YXJ0dXAKClttZHMuMF0KICBob3N0ID0gZmRyLXZjZXBo
LTAKCjtPU0RzCltvc2RdCiAgO3N1ZG8gPSB0cnVlCgogIG9zZCBkYXRhID0gL2RhdGEvb3NkLiRp
ZAogIDtvc2Qgam91cm5hbCA9IC9kZXYvc2RiMgogIG9zZCBqb3VybmFsID0gL2RhdGEvb3NkLiRp
ZC5qb3VybmFsCiAgb3NkIGpvdXJuYWwgc2l6ZSA9IDEwMDAKCiAgZGVidWcgbXMgPSAxICAgICAg
ICAgOyBtZXNzYWdlIHRyYWZmaWMKICBkZWJ1ZyBvc2QgPSAyMCAgIAogIGRlYnVnIGZpbGVzdG9y
ZSA9IDIwIDsgbG9jYWwgb2JqZWN0IHN0b3JhZ2UKICBkZWJ1ZyBqb3VybmFsID0gMjAgICA7IGxv
Y2FsIGpvdXJuYWxpbmcKICBkZWJ1ZyBtb25jID0gMjAgICAgICA7IG1vbml0b3IgaW50ZXJhY3Rp
b24sIHN0YXJ0dXAKCltvc2QuMF0KICBob3N0ID0gZmRyLXZjZXBoLTAKICA7YnRyZnMgZGV2cz0v
ZGV2L3NkYgoKO1tncm91cCBldmVyeW9uZV0KO2FkZHI9MC4wLjAuMC8wCgo7W21vdW50IC9dCjth
bGxvdz0lZXZlcnlvbmUK
------=_Part_313_16399877.1332557195739--


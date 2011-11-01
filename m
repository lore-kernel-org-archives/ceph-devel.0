From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: sync Ceph 0.37 with Debian
Date: Tue, 01 Nov 2011 09:59:29 +0100
Message-ID: <1320137969.22458.173.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-bIyDkiQvr+S5j794YFHw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:52682 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab1KAJHy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Nov 2011 05:07:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.routers.hu (Postfix) with ESMTP id 6F5BE164D98
	for <ceph-devel@vger.kernel.org>; Tue,  1 Nov 2011 10:59:04 +0100 (CET)
Received: from mail.routers.hu ([127.0.0.1])
	by localhost (sum.routers.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2rF-XXlFx0S for <ceph-devel@vger.kernel.org>;
	Tue,  1 Nov 2011 10:59:04 +0100 (CET)
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.routers.hu (Postfix) with ESMTPA id B80AF164D0C
	for <ceph-devel@vger.kernel.org>; Tue,  1 Nov 2011 10:58:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-bIyDkiQvr+S5j794YFHw
Content-Type: multipart/mixed; boundary="=-X5zHi+fdu0cPEFd5AHkH"


--=-X5zHi+fdu0cPEFd5AHkH
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

There are some mistakes and difference with Debian packages and your
work.
Please add debian/watch (attached).
libceph packages are renamed to libcephfs , but the related packager
files are not. The following should fix this:
git mv debian/libceph1.install debian/libcephfs1.install
git mv debian/libceph1.postinst debian/libcephfs1.postinst
git mv debian/libceph1.postrm debian/libcephfs1.postrm
git mv debian/libceph-dev.install debian/libcephfs-dev.install

Still on the renames, some conflicts-replaces are needed (attached).

As I see, the primary VCS location changed to github, state this in
debian/control as well (attached).

Either add the logrotate_missingok.patch (attached) or add missingok
to src/logrotate.conf [1].

Per policy and multiarch support, Debian packages have to empty their
dependency_libs in *.la files (attached).

Thanks,
Laszlo/GCS
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D645651

--=-X5zHi+fdu0cPEFd5AHkH
Content-Type: application/x-fluid; name="watch"
Content-Disposition: attachment; filename="watch"
Content-Transfer-Encoding: base64

dmVyc2lvbj0zCmh0dHA6Ly9jZXBoLm5ld2RyZWFtLm5ldC9kb3dubG9hZC9jZXBoLShcZC4qKVwu
dGFyXC5nego=


--=-X5zHi+fdu0cPEFd5AHkH
Content-Disposition: attachment; filename="vcs.diff"
Content-Type: text/x-patch; name="vcs.diff"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RlYmlhbi9jb250cm9sIGIvZGViaWFuL2NvbnRyb2wNCmluZGV4IDk2NmY5
OGIuLjFiNWUwOGQgMTAwNjQ0DQotLS0gYS9kZWJpYW4vY29udHJvbA0KKysrIGIvZGViaWFuL2Nv
bnRyb2wNCkBAIC0yLDggKzIsOCBAQCBTb3VyY2U6IGNlcGgNCiBTZWN0aW9uOiBhZG1pbg0KIFBy
aW9yaXR5OiBvcHRpb25hbA0KIEhvbWVwYWdlOiBodHRwOi8vY2VwaC5uZXdkcmVhbS5uZXQvDQot
VmNzLUdpdDogZ2l0Oi8vY2VwaC5uZXdkcmVhbS5uZXQvZ2l0L2NlcGguZ2l0DQotVmNzLUJyb3dz
ZXI6IGh0dHA6Ly9jZXBoLm5ld2RyZWFtLm5ldC9naXQvP3A9Y2VwaC5naXQ7YT1zdW1tYXJ5DQor
VmNzLUdpdDogZ2l0Oi8vZ2l0aHViLmNvbS9OZXdEcmVhbU5ldHdvcmsvY2VwaC5naXQNCitWY3Mt
QnJvd3NlcjogaHR0cHM6Ly9naXRodWIuY29tL05ld0RyZWFtTmV0d29yay9jZXBoDQogTWFpbnRh
aW5lcjogTGFzemxvIEJvc3pvcm1lbnlpIChHQ1MpIDxnY3NAZGViaWFuLmh1Pg0KIFVwbG9hZGVy
czogU2FnZSBXZWlsIDxzYWdlQG5ld2RyZWFtLm5ldD4NCiBCdWlsZC1EZXBlbmRzOiBkZWJoZWxw
ZXIgKD49IDYuMC43fiksIGF1dG90b29scy1kZXYsIGF1dG9jb25mLCBhdXRvbWFrZSwgbGliZnVz
ZS1kZXYsIGxpYmJvb3N0LWRldiAoPj0gMS4zNCksIGxpYmVkaXQtZGV2LCBsaWJjcnlwdG8rKy1k
ZXYsIGxpYnRvb2wsIGxpYmV4cGF0MS1kZXYsIGxpYmZjZ2ktZGV2LCBsaWJhdG9taWMtb3BzLWRl
diwgbGliZ29vZ2xlLXBlcmZ0b29scy1kZXYgW2kzODYgYW1kNjRdLCBwa2ctY29uZmlnLCBsaWJn
dGttbS0yLjQtZGV2LCBweXRob24sIHB5dGhvbi1zdXBwb3J0LCBsaWJjdXJsNC1nbnV0bHMtZGV2
LCBsaWJrZXl1dGlscy1kZXYNCg==


--=-X5zHi+fdu0cPEFd5AHkH
Content-Disposition: attachment; filename="logrotate_missingok.patch"
Content-Type: text/x-patch; name="logrotate_missingok.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

RGVzY3JpcHRpb246IGFkZCBtaXNzaW5nb2sgdG8gbG9ncm90YXRlDQogV2hlbiBjZXBoIGlzIG5v
dCBydW5uaW5nLCBpdCBoYXMgbm8gbG9ncy4gVGh1cyBsb2dyb3RhdGUgaGFzIG5vdGhpbmcgdG8N
CiByb3RhdGUuIFRoZSBtaXNzaW5nb2sgZGlyZWN0aXZlIGhhbmRsZXMgdGhpcyBzaXR1YXRpb24u
DQpBdXRob3I6IExhc3psbyBCb3N6b3JtZW55aSAoR0NTKSA8Z2NzQGRlYmlhbi5odT4NCg0KLS0t
DQpPcmlnaW46IExhc3psbyBCb3N6b3JtZW55aSAoR0NTKQ0KQnVnLURlYmlhbjogaHR0cDovL2J1
Z3MuZGViaWFuLm9yZy9jZ2ktYmluL2J1Z3JlcG9ydC5jZ2k/YnVnPTY0NTY1MQ0KTGFzdC1VcGRh
dGU6IDwyMDExLTEwLTMxPg0KDQotLS0gY2VwaC0wLjM3Lm9yaWcvc3JjL2xvZ3JvdGF0ZS5jb25m
DQorKysgY2VwaC0wLjM3L3NyYy9sb2dyb3RhdGUuY29uZg0KQEAgLTYsNCArNiw1IEBADQogICAg
IHBvc3Ryb3RhdGUNCiAgICAgICAgIGludm9rZS1yYy5kIGNlcGggcmVsb2FkID4vZGV2L251bGwg
fHwgc2VydmljZSBjZXBoIHJlbG9hZCA+L2Rldi9udWxsDQogICAgIGVuZHNjcmlwdA0KKyAgICBt
aXNzaW5nb2sNCiB9DQo=


--=-X5zHi+fdu0cPEFd5AHkH
Content-Disposition: attachment; filename="empty-dependency_libs.patch"
Content-Type: text/x-patch; name="empty-dependency_libs.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RlYmlhbi9ydWxlcyBiL2RlYmlhbi9ydWxlcw0KaW5kZXggNDA4MDQ5Yi4u
YTIwMjU4ZCAxMDA3NTUNCi0tLSBhL2RlYmlhbi9ydWxlcw0KKysrIGIvZGViaWFuL3J1bGVzDQpA
QCAtODEsNiArODEsNyBAQCBpbnN0YWxsOiBidWlsZA0KIAlkaF9pbnN0YWxsZGlycw0KIA0KIAkk
KE1BS0UpIERFU1RESVI9JChERVNURElSKSBpbnN0YWxsDQorCXNlZCAtaSAiL2RlcGVuZGVuY3lf
bGlicy8gcy8nLionLycnLyIgYGZpbmQgLiAtbmFtZSAnKi5sYSdgDQogCWluc3RhbGwgLUQgLW0g
NjQ0IHVkZXYvNTAtcmJkLnJ1bGVzICQoREVTVERJUikvbGliL3VkZXYvcnVsZXMuZC81MC1yYmQu
cnVsZXMNCiANCiAjIEFkZCBoZXJlIGNvbW1hbmRzIHRvIGluc3RhbGwgdGhlIHBhY2thZ2UgaW50
byBkZWJpYW4vdGVzdHBhY2suDQo=


--=-X5zHi+fdu0cPEFd5AHkH
Content-Disposition: attachment; filename="conflicts_replaces.patch"
Content-Type: text/x-patch; name="conflicts_replaces.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RlYmlhbi9jb250cm9sIGIvZGViaWFuL2NvbnRyb2wNCmluZGV4IDk2NmY5
OGIuLjZkZTE1ODAgMTAwNjQ0DQotLS0gYS9kZWJpYW4vY29udHJvbA0KKysrIGIvZGViaWFuL2Nv
bnRyb2wNCkBAIC04OCw2ICs4OCw4IEBAIERlc2NyaXB0aW9uOiBkZWJ1Z2dpbmcgc3ltYm9scyBm
b3IgY2VwaC1mdXNlDQogUGFja2FnZTogY2VwaC1jb21tb24NCiBBcmNoaXRlY3R1cmU6IGxpbnV4
LWFueQ0KIERlcGVuZHM6ICR7c2hsaWJzOkRlcGVuZHN9LCAke21pc2M6RGVwZW5kc30sIGxpYnJi
ZDEgKD0gJHtiaW5hcnk6VmVyc2lvbn0pDQorQ29uZmxpY3RzOiBjZXBoLWNsaWVudC10b29scw0K
K1JlcGxhY2VzOiBjZXBoLWNsaWVudC10b29scw0KIFN1Z2dlc3RzOiBjZXBoDQogRGVzY3JpcHRp
b246IGNvbW1vbiB1dGlsaXRpZXMgdG8gbW91bnQgYW5kIGludGVyYWN0IHdpdGggYSBjZXBoIGZp
bGVzeXN0ZW0NCiAgQ2VwaCBpcyBhIGRpc3RyaWJ1dGVkIG5ldHdvcmsgZmlsZSBzeXN0ZW0gZGVz
aWduZWQgdG8gcHJvdmlkZQ0KQEAgLTk4LDYgKzEwMCw4IEBAIERlc2NyaXB0aW9uOiBjb21tb24g
dXRpbGl0aWVzIHRvIG1vdW50IGFuZCBpbnRlcmFjdCB3aXRoIGEgY2VwaCBmaWxlc3lzdGVtDQog
UGFja2FnZTogY2VwaC1jb21tb24tZGJnDQogQXJjaGl0ZWN0dXJlOiBsaW51eC1hbnkNCiBEZXBl
bmRzOiBjZXBoLWNvbW1vbiAoPSAke2JpbmFyeTpWZXJzaW9ufSksICR7bWlzYzpEZXBlbmRzfQ0K
K0NvbmZsaWN0czogY2VwaC1jbGllbnQtdG9vbHMtZGJnDQorUmVwbGFjZXM6IGNlcGgtY2xpZW50
LXRvb2xzLWRiZw0KIFNlY3Rpb246IGRlYnVnDQogUHJpb3JpdHk6IGV4dHJhDQogRGVzY3JpcHRp
b246IGRlYnVnZ2luZyBzeW1ib2xzIGZvciBjZXBoLWNvbW1vbg0KQEAgLTE4OSw4ICsxOTMsOCBA
QCBEZXNjcmlwdGlvbjogUkFET1MgYmxvY2sgZGV2aWNlIGNsaWVudCBsaWJyYXJ5IChkZXZlbG9w
bWVudCBmaWxlcykNCiAgbGluayBhZ2FpbnN0IGxpYnJiZDEuDQogDQogUGFja2FnZTogbGliY2Vw
aGZzMQ0KLUNvbmZsaWN0czogbGliY2VwaGZzDQotUmVwbGFjZXM6IGxpYmNlcGhmcw0KK0NvbmZs
aWN0czogbGliY2VwaGZzLCBsaWJjZXBoLCBsaWJjZXBoMQ0KK1JlcGxhY2VzOiBsaWJjZXBoZnMs
IGxpYmNlcGgsIGxpYmNlcGgxDQogQXJjaGl0ZWN0dXJlOiBsaW51eC1hbnkNCiBTZWN0aW9uOiBs
aWJzDQogRGVwZW5kczogJHtzaGxpYnM6RGVwZW5kc30sICR7bWlzYzpEZXBlbmRzfQ0KQEAgLTIw
NSw2ICsyMDksOCBAQCBBcmNoaXRlY3R1cmU6IGxpbnV4LWFueQ0KIFNlY3Rpb246IGRlYnVnDQog
UHJpb3JpdHk6IGV4dHJhDQogRGVwZW5kczogbGliY2VwaGZzMSAoPSAke2JpbmFyeTpWZXJzaW9u
fSksICR7bWlzYzpEZXBlbmRzfQ0KK0NvbmZsaWN0czogbGliY2VwaDEtZGJnDQorUmVwbGFjZXM6
IGxpYmNlcGgxLWRiZw0KIERlc2NyaXB0aW9uOiBkZWJ1Z2dpbmcgc3ltYm9scyBmb3IgbGliY2Vw
aGZzMQ0KICBDZXBoIGlzIGEgZGlzdHJpYnV0ZWQgbmV0d29yayBmaWxlIHN5c3RlbSBkZXNpZ25l
ZCB0byBwcm92aWRlDQogIGV4Y2VsbGVudCBwZXJmb3JtYW5jZSwgcmVsaWFiaWxpdHksIGFuZCBz
Y2FsYWJpbGl0eS4gIFRoaXMgaXMgYQ0KQEAgLTIxNyw4ICsyMjMsOCBAQCBQYWNrYWdlOiBsaWJj
ZXBoZnMtZGV2DQogQXJjaGl0ZWN0dXJlOiBsaW51eC1hbnkNCiBTZWN0aW9uOiBsaWJkZXZlbA0K
IERlcGVuZHM6ICR7bWlzYzpEZXBlbmRzfSwgbGliY2VwaGZzMSAoPSAke2JpbmFyeTpWZXJzaW9u
fSkNCi1Db25mbGljdHM6IGxpYmNlcGhmczEtZGV2DQotUmVwbGFjZXM6IGxpYmNlcGhmczEtZGV2
DQorQ29uZmxpY3RzOiBsaWJjZXBoZnMxLWRldiwgbGliY2VwaDEtZGV2LCBsaWJjZXBoLWRldg0K
K1JlcGxhY2VzOiBsaWJjZXBoZnMxLWRldiwgbGliY2VwaDEtZGV2LCBsaWJjZXBoLWRldg0KIERl
c2NyaXB0aW9uOiBDZXBoIGRpc3RyaWJ1dGVkIGZpbGUgc3lzdGVtIGNsaWVudCBsaWJyYXJ5IChk
ZXZlbG9wbWVudCBmaWxlcykNCiAgQ2VwaCBpcyBhIGRpc3RyaWJ1dGVkIG5ldHdvcmsgZmlsZSBz
eXN0ZW0gZGVzaWduZWQgdG8gcHJvdmlkZQ0KICBleGNlbGxlbnQgcGVyZm9ybWFuY2UsIHJlbGlh
YmlsaXR5LCBhbmQgc2NhbGFiaWxpdHkuICBUaGlzIGlzIGENCg==


--=-X5zHi+fdu0cPEFd5AHkH--

--=-bIyDkiQvr+S5j794YFHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk6vtPEACgkQMDatjqUaT91w2gCfZGU5lALdRrV7rJ6h58bXCogS
3ngAn1L0nbWnQO+Y4FlviFOqTIjww0NC
=ZbHm
-----END PGP SIGNATURE-----

--=-bIyDkiQvr+S5j794YFHw--


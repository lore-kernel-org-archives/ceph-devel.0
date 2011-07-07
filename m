From: AnnyRen <annyren6@gmail.com>
Subject: Ceph didn't migrate data when I kill one osd daemon
Date: Thu, 7 Jul 2011 17:35:04 +0800
Message-ID: <CADF7qQWnfLKkAFbWeq2FwGD1sRRZiqzwikV+urhKOVbRM4B7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba6e86ae941c8804a7776edd
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36560 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1GGJfF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2011 05:35:05 -0400
Received: by iwn6 with SMTP id 6so681343iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2011 02:35:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--90e6ba6e86ae941c8804a7776edd
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I have one questions about osd degraded.

My environment was set up with 3 mon, 2 mds and 25 osd, all daemon are
running on physical machines.
Ceph Version:  0.30
File system format: EXT4

Q1.   When I'm testing osd stability, I kill an osd daemon (osd2) to
observe the behavior of data migration.
    For all I know, I could see the pg degraded ratio down to zero,
and all pgs become active+clean.
    but Ceph file system didn't migrate the data on the osd (which I
already killed its daemon) to other osds.
    The degraded ratio still remain at 4.xxx%.
    After then, I run "cosd -i 2 -c /etc/ceph/ceph.conf"and then run "ceph -w",
    I saw all pgs suddenly become active+clean.

  Could anyone tell me why Ceph didn't migrate data when I kill one osd daemon?


Thanks a lot~  ^__^

Best Regards,
Anny

--90e6ba6e86ae941c8804a7776edd
Content-Type: text/plain; charset=US-ASCII; name="ceph.conf.txt"
Content-Disposition: attachment; filename="ceph.conf.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gptiseye0

W2dsb2JhbF0NCiAgICAgICAgcGlkIGZpbGUgPSAvdmFyL3J1bi9jZXBoLyRuYW1lLnBpZA0KICAg
ICAgICA7IGRlYnVnIG1zID0xDQoNCiAgICAgICAgOyBlbmFibGUgc2VjdXJlIGF1dGhlbnRpY2F0
aW9uDQogICAgICAgIDsgYXV0aCBzdXBwb3J0ZWQgPSBjZXBoeA0KDQoNClttb25dDQogICAgICAg
IG1vbiBkYXRhID0gL21vbi9tb24kaWQNCiAgICAgICAgZGVidWcgbW9uID0gMA0KDQoNClttb24u
YV0NCiAgICAgICAgaG9zdCA9IE1PTjENCiAgICAgICAgbW9uIGFkZHIgPSAxOTIuMTY4LjEwLjE6
Njc4OQ0KDQpbbW9uLmJdDQogICAgICAgIGhvc3QgPSBNT04yDQogICAgICAgIG1vbiBhZGRyID0g
MTkyLjE2OC4xMC4yOjY3ODkNCg0KW21vbi5jXQ0KICAgICAgICBob3N0ID0gTU9OMw0KICAgICAg
ICBtb24gYWRkciA9IDE5Mi4xNjguMTAuMzo2Nzg5DQoNCg0KW21kc10NCg0KICAgICAgICBkZWJ1
ZyBtZHMgPSAwDQoNCg0KW21kcy5hXQ0KICAgICAgICBob3N0ID0gTURTMQ0KW21kcy5iXQ0KICAg
ICAgICBob3N0ID0gTURTMg0KDQpbb3NkXQ0KDQogICAgICAgIG9zZCBkYXRhID0gL21udC9leHQ0
L29zZCRpZA0KDQogICAgICAgIG9zZCBqb3VybmFsID0gL2RhdGEvb3NkJGlkL2pvdXJuYWwNCiAg
ICAgICAgb3NkIGpvdXJuYWwgc2l6ZSA9IDUxMiA7IGpvdXJuYWwgc2l6ZSwgaW4gbWVnYWJ5dGVz
DQoNCiAgICAgICAgZmlsZXN0b3JlIGJ0cmZzIHNuYXAgPSBmYWxzZQ0KICAgICAgICBmaWxlc3Rv
cmUgZnN5bmMgZmx1c2hlcyBqb3VybmFsIGRhdGEgPSB0cnVlDQoNCiAgICAgICAgZGVidWcgb3Nk
ID0gMA0KDQoNCltvc2QuMF0NCiAgICAgICAgaG9zdCA9IE9TRDENCg0KW29zZC4xXQ0KICAgICAg
ICBob3N0ID0gT1NEMg0KDQpbb3NkLjJdDQogICAgICAgIGhvc3QgPSBPU0QzDQoNCltvc2QuM10N
CiAgICAgICAgaG9zdCA9IE9TRDQNCg0KW29zZC40XQ0KICAgICAgICBob3N0ID0gT1NENQ0KDQpb
b3NkLjVdDQogICAgICAgIGhvc3QgPSBPU0Q2DQoNCltvc2QuNl0NCiAgICAgICAgaG9zdCA9IE9T
RDcNCg0KW29zZC43XQ0KICAgICAgICBob3N0ID0gT1NEOA0KDQpbb3NkLjhdDQogICAgICAgIGhv
c3QgPSBPU0Q5DQoNCltvc2QuOV0NCiAgICAgICAgaG9zdCA9IE9TRDEwDQoNCltvc2QuMTBdDQog
ICAgICAgIGhvc3QgPSBPU0QxMQ0KDQpbb3NkLjExXQ0KICAgICAgICBob3N0ID0gT1NEMTINCg0K
W29zZC4xMl0NCiAgICAgICAgaG9zdCA9IE9TRDEzDQoNCltvc2QuMTNdDQogICAgICAgIGhvc3Qg
PSBPU0QxNA0KDQpbb3NkLjE0XQ0KICAgICAgICBob3N0ID0gT1NEMTUNCg0KW29zZC4xNV0NCiAg
ICAgICAgaG9zdCA9IE9TRDE2DQoNCltvc2QuMTZdDQogICAgICAgIGhvc3QgPSBPU0QxNw0KDQpb
b3NkLjE3XQ0KICAgICAgICBob3N0ID0gT1NEMTgNCg0KW29zZC4xOF0NCiAgICAgICAgaG9zdCA9
IE9TRDE5DQoNCltvc2QuMTldDQogICAgICAgIGhvc3QgPSBPU0QyMA0KDQpbb3NkLjIwXQ0KICAg
ICAgICBob3N0ID0gT1NEMjENCg0KW29zZC4yMV0NCiAgICAgICAgaG9zdCA9IE9TRDIyDQoNCltv
c2QuMjJdDQogICAgICAgIGhvc3QgPSBPU0QyMw0KDQpbb3NkLjIzXQ0KICAgICAgICBob3N0ID0g
T1NEMjQNCg0KW29zZC4yNF0NCiAgICAgICAgaG9zdCA9IE9TRDI1
--90e6ba6e86ae941c8804a7776edd--

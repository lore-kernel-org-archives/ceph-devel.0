From: Loic Dachary <loic@dachary.org>
Subject: running make check in the cloud, with locally attached SSD
Date: Mon, 2 May 2016 10:57:23 +0200
Message-ID: <57271673.1060009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp26.services.sfr.fr ([93.17.128.163]:64019 "EHLO
	smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbcEBI51 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2016 04:57:27 -0400
Received: from [192.168.2.120] (LPuteaux-657-1-295-15.w90-63.abo.wanadoo.fr [90.63.253.15])
	by msfrf2603.sfr.fr (SMTP Server) with ESMTP id CF7241C001016
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2016 10:57:24 +0200 (CEST)
Received: from [192.168.2.120] (LPuteaux-657-1-295-15.w90-63.abo.wanadoo.fr [90.63.253.15])	(using TLSv1
	with cipher ECDHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)	(Authenticated sender: loic.dachary@sfr.fr)
	by msfrf2603.sfr.fr (SMTP Server) with ESMTPSA
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2016 10:57:23 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

A short note to let you know there are new OVH flavors that have locall=
y attached SSD instead of 3-replica network attached RBD devices.

$ openstack flavor list
+--------------------------------------+----------------+--------+-----=
-+-----------+-------+-----------+
| ID                                   | Name           |    RAM | Disk=
 | Ephemeral | VCPUs | Is Public |
+--------------------------------------+----------------+--------+-----=
-+-----------+-------+-----------+
| 0297d7ac-fe6f-4ff1-b6e7-0b8b0908c94f | hg-60          |  60000 | 1600=
 |         0 |    16 | True      |
| 0417a0e6-f68a-4b8b-a642-ca5ecb9652f7 | win-sp-60      |  60000 |  400=
 |         0 |     4 | True      |
| 042aefc6-b713-4a7e-ada5-3ff81daa1960 | hg-120-ssd     | 120000 |  800=
 |         0 |    32 | True      |
| 07885848-8831-486d-8525-91484c09cc7e | win-sp-240     | 240000 | 1600=
 |         0 |    16 | True      |
| 079aa0a2-5e48-4e58-8205-719bc962736e | win-hg-60-ssd  |  60000 |  600=
 |         0 |    16 | True      |
| 164fcc7e-7771-414f-a607-b388cb7b7aa0 | vps-ssd-1      |   2000 |   10=
 |         0 |     1 | True      |
| 1788102b-ab80-4a0c-b819-541deaca7515 | win-sp-30-ssd  |  30000 |  100=
 |         0 |     2 | True      |
| 1f1efedf-ec91-4a42-acd7-f5cf64b02d3c | hg-120         | 120000 | 1600=
 |         0 |    32 | True      |
| 23c21ecc-9ee8-4ad3-bd9f-aa17a3faf84e | win-sp-120-ssd | 120000 |  400=
 |         0 |     8 | True      |
| 24e293ed-bc54-4f26-8fb7-7b9457d08e66 | win-hg-15-ssd  |  15000 |  200=
 |         0 |     4 | True      |
| 325b602f-ecc4-4444-90bd-5a2cf4e0da53 | win-sp-240-ssd | 240000 |  800=
 |         0 |    16 | True      |
| 377ded36-491f-4ad7-9eb4-876798b2aea9 | win-hg-7       |   7000 |  200=
 |         0 |     2 | True      |
| 382f2831-4dba-40c4-bb7a-6fadff71c4db | sp-30-ssd      |  30000 |  100=
 |         0 |     2 | True      |
| 3c1d6170-0097-4b5c-a3b3-adff1b7a86e0 | hg-30          |  30000 |  800=
 |         0 |     8 | True      |
| 5c54dc08-28b9-4860-9f24-a2451b2a28ec | win-hg-30-ssd  |  30000 |  400=
 |         0 |     8 | True      |
| 675558ea-04fe-47a2-83de-40be9b2eacd4 | hg-15          |  15000 |  400=
 |         0 |     4 | True      |
| 6ab72807-e0a5-4e9f-bbb9-7cbbf0038b26 | hg-30-ssd      |  30000 |  400=
 |         0 |     8 | True      |
| 6e12cae3-0492-483c-aa39-54a0dcaf86dd | win-hg-30      |  30000 |  800=
 |         0 |     8 | True      |
| 6ead771c-e8b9-424c-afa0-671280416422 | win-hg-7-ssd   |   7000 |  100=
 |         0 |     2 | True      |
| 7568d834-3b16-42ce-a2c1-0654e0781160 | sp-240-ssd     | 240000 |  800=
 |         0 |    16 | True      |
| 7939cc5c-79b1-45c0-be2d-aa935d92faa1 | vps-ssd-2      |   4000 |   20=
 |         0 |     1 | True      |
| 80d8510a-79cc-4307-8db7-d1965c9e8ddb | sp-60          |  60000 |  400=
 |         0 |     4 | True      |
| 8be9dc29-3eca-499b-ae2d-e3c99699131a | win-sp-30      |  30000 |  200=
 |         0 |     2 | True      |
| 97824a8c-e683-49a8-a70a-ead64240395c | sp-120-ssd     | 120000 |  400=
 |         0 |     8 | True      |
| 9831d7f1-3e79-483d-8958-88e3952c7ea2 | hg-60-ssd      |  60000 |  600=
 |         0 |    16 | True      |
| aa753e73-dadb-4528-9c4a-24e36fc41bf4 | win-hg-120-ssd | 120000 |  800=
 |         0 |    32 | True      |
| ac74cb45-d895-47dd-b9cf-c17778033d83 | sp-120         | 120000 |  800=
 |         0 |     8 | True      |
| ae900175-72bd-4fbc-8ab2-4673b468aa5b | win-hg-15      |  15000 |  400=
 |         0 |     4 | True      |
| b1dc776c-b6e3-4a96-b230-850f570db3d5 | hg-7-ssd       |   7000 |  100=
 |         0 |     2 | True      |
| b24df495-10f3-466e-95ab-26f0f6839a2f | sp-60-ssd      |  60000 |  200=
 |         0 |     4 | True      |
| b798e44e-bf71-488c-9335-f20bf5976547 | win-hg-120     | 120000 | 1600=
 |         0 |    32 | True      |
| d1acf88d-6f55-4c5c-a914-4ecbdbd50d6b | sp-30          |  30000 |  200=
 |         0 |     2 | True      |
| def75cbd-a4b1-4f82-9152-90c65df9587b | win-hg-60      |  60000 | 1600=
 |         0 |    16 | True      |
| e43d7458-6b82-4a78-a712-3a4dc6748cf4 | vps-ssd-3      |   8000 |   40=
 |         0 |     2 | True      |
| ed286e2c-769f-4c47-ac52-b8de7a4891f6 | sp-240         | 240000 | 1600=
 |         0 |    16 | True      |
| ed835a73-d9a0-43ee-bd89-999c51d8426d | win-sp-60-ssd  |  60000 |  200=
 |         0 |     4 | True      |
| f247dc56-395b-49de-9a62-93ccc4fff4ed | win-sp-120     | 120000 |  800=
 |         0 |     8 | True      |
| fa3cc551-0358-4170-be64-56ea432b064c | hg-7           |   7000 |  200=
 |         0 |     2 | True      |
| ff48c2cf-c17f-4682-aaf6-31d66786f808 | hg-15-ssd      |  15000 |  200=
 |         0 |     4 | True      |
+--------------------------------------+----------------+--------+-----=
-+-----------+-------+-----------+

=46or instance hg-60 is the 3 replicas version and hg-60-ssd is the ssd=
 version. The pricing is the same (the web page has not been updated ye=
t but the proprietary OVH web panel shows the per-hour price).

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

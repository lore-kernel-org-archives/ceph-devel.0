From: AnnyRen <annyren6@gmail.com>
Subject: rejoin mds daemon, 17 osd are suddenly down and out
Date: Thu, 14 Jul 2011 11:54:47 +0800
Message-ID: <CADF7qQWkza=j_dapnRqJdPX-2i9HnEqpJ6aQ10CGFCDmU5KZCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba6e8bd280edc004a7ff7e2c
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56950 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab1GNDys (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 23:54:48 -0400
Received: by iyb12 with SMTP id 12so6134923iyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 20:54:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--90e6ba6e8bd280edc004a7ff7e2c
Content-Type: text/plain; charset=ISO-8859-1

Hi, developers:

My environment is 3 mons, 2 mds, 25 osds, and ceph version is v0.30.
This morning, I found one mds(standby one) lost when I run "ceph -w"

The original mds info should be  {mds e42: 1/1/1 up {0=b=up:active}, 1
up:standby}
but I found the standby one lost

so I ssh to mds1 to run "cmds -i a -c /etc/ceph/ceph.conf" , and check
the mds daemon run correctly.

After then, I found 17 osds suddenly down and out,
---------------------------------------------------------------------------------------------------------
osd0 up   in  weight 1 up_from 139 up_thru 229 down_at 138
last_clean_interval 120-137 192.168.10.10:6800/11191
192.168.10.10:6801/11191 192.168.10.10:6802/11191
osd1 down out up_from 141 up_thru 160 down_at 166 last_clean_interval 117-139
osd2 up   in  weight 1 up_from 147 up_thru 222 down_at 146
last_clean_interval 125-145 192.168.10.12:6800/10173
192.168.10.12:6801/10173 192.168.10.12:6802/10173
osd3 down out up_from 154 up_thru 160 down_at 166 last_clean_interval 130-152
osd4 down out up_from 155 up_thru 160 down_at 166 last_clean_interval 130-153
osd5 down out up_from 153 up_thru 160 down_at 166 last_clean_interval 134-151
osd6 down out up_from 153 up_thru 160 down_at 170 last_clean_interval 135-151
osd7 down out up_from 157 up_thru 160 down_at 162 last_clean_interval 133-155
osd8 down out up_from 154 up_thru 160 down_at 166 last_clean_interval 134-152
osd9 down out up_from 155 up_thru 160 down_at 168 last_clean_interval 133-153
osd10 down out up_from 141 up_thru 160 down_at 168 last_clean_interval 118-139
osd11 down out up_from 145 up_thru 160 down_at 168 last_clean_interval 119-143
osd12 down out up_from 142 up_thru 160 down_at 166 last_clean_interval 123-140
osd13 down out up_from 147 up_thru 160 down_at 166 last_clean_interval 123-145
osd14 up   in  weight 1 up_from 143 up_thru 223 down_at 142
last_clean_interval 124-141 192.168.10.24:6800/10122
192.168.10.24:6801/10122 192.168.10.24:6802/10122
osd15 down out up_from 147 up_thru 160 down_at 164 last_clean_interval 121-145
osd16 up   in  weight 1 up_from 148 up_thru 222 down_at 147
last_clean_interval 124-146 192.168.10.26:6800/9881
192.168.10.26:6801/9881 192.168.10.26:6802/9881
osd17 up   in  weight 1 up_from 148 up_thru 223 down_at 147
last_clean_interval 122-146 192.168.10.27:6800/9986
192.168.10.27:6801/9986 192.168.10.27:6802/9986
osd18 down out up_from 146 up_thru 160 down_at 168 last_clean_interval 124-144
osd19 down out up_from 147 up_thru 160 down_at 166 last_clean_interval 125-145
osd20 up   in  weight 1 up_from 148 up_thru 222 down_at 147
last_clean_interval 126-146 192.168.10.30:6800/9816
192.168.10.30:6801/9816 192.168.10.30:6802/9816
osd21 down out up_from 148 up_thru 160 down_at 168 last_clean_interval 126-146
osd22 up   in  weight 1 up_from 149 up_thru 220 down_at 148
last_clean_interval 127-147 192.168.10.32:6800/9640
192.168.10.32:6801/9640 192.168.10.32:6802/9640
osd23 down out up_from 153 up_thru 160 down_at 166 last_clean_interval 128-151
osd24 up   in  weight 1 up_from 150 up_thru 225 down_at 149
last_clean_interval 132-148 192.168.10.34:6800/10581
192.168.10.34:6801/10581 192.168.10.34:6802/10581
---------------------------------------------------------------------------------------------------------

Many pgs are degraded, I ssh to every down and out osd host to see log
(/var/log/ceph/osd.x.log), but there is nothing recorded in logs...
Why the logs stopped logging anything?

So I run "cosd -i x -c /etc/ceph/ceph.conf" on every down osd
individually to make them up and in, and then I can read/write files
form ceph....


Could anyone tell me what's going on in my environment?
1. OSD Stability problem?
2. Ceph didn't write logs unexpectedly.

 Thanks a lot!  :)

--90e6ba6e8bd280edc004a7ff7e2c
Content-Type: text/plain; charset=US-ASCII; name="ceph.conf.txt"
Content-Disposition: attachment; filename="ceph.conf.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq35vmkr0

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
--90e6ba6e8bd280edc004a7ff7e2c--

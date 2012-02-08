From: huang jun <hjwsm1989@gmail.com>
Subject: can't read/write after inserting new crushmap
Date: Wed, 8 Feb 2012 17:58:32 +0800
Message-ID: <CABAwU-ZZ2Nz20i0SjWT2_1USJRToTELqSU++5pz4MOcH1g7EGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d044784973958eb04b870f010
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41124 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751294Ab2BHJ6d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2012 04:58:33 -0500
Received: by obcva7 with SMTP id va7so574887obc.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2012 01:58:33 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

--f46d044784973958eb04b870f010
Content-Type: text/plain; charset=ISO-8859-1

hi,all
    we test with 8 OSDs and group into 2 racks, each has 4 OSDs.
    write the crushmap file and export it into ceph cluster.(crushmap
file attached)
    all PGs distribute allow the crush rule.

   then one group(4OSDs) powered off  and "ceph -w "shows:
         2012-02-08 17:03:57.518285    pg v633: 1584 pgs: 1092 active,
490 active+clean+degraded, 2 degraded+peering; 3992 MB data, 6665 MB
used, 4642 GB / 4657 GB      avail; 349/2040 degraded (17.108%)
         2012-02-08 17:03:57.520698   mds e4: 1/1/1 up {0=0=up:active}
         2012-02-08 17:03:57.520729   osd e86: 8 osds: 4 up, 4 in
         2012-02-08 17:03:57.521199   log 2012-02-08 15:26:21.761073
mon0 192.168.0.116:6789/0 27 : [INF] osd7 out (down for 304.299392)
         2012-02-08 17:03:57.521249   mon e1: 1 mons at {0=192.168.0.116:6789/0}
   2 PGs' state is "degraded+peering", and it seems never goto normal
"active+clean " state.(we use ceph v0.35,maybe it matters)

 check the pg dump output:
        2.1p3   0       0       0       0       0       0       0
 0       active  0'0     4'120   [3]     [3,0]   0'0
        2.0p2   0       0       0       0       0       0       0
 0       active  0'0     3'119   [2]     [2,0]   0'0
        0.1p1   0       0       0       0       0       0       0
 0       active  0'0     3'103   [1]     [1,0]   0'0
        0.0p0   0       0       0       0       0       0       0
 0       active  0'0     2'126   [0]     [0,1]   0'0
        1.1p0   0       0       0       0       0       0       0
 0       active  0'0     2'123   [0]     [0,2]   0'0
        1.0p1   0       0       0       0       0       0       0
 0       active  0'0     3'102   [1]     [1,0]   0'0
        2.0p3   0       0       0       0       0       0       0
 0       active  0'0     4'122   [3]     [3,0]   0'0
        2.1p2   0       0       0       0       0       0       0
 0       active  0'0     3'122   [2]     [2,0]   0'0
        0.0p1   0       0       0       0       0       0       0
 0       active  0'0     3'116   [1]     [1,0]   0'0
        0.1p0   0       0       0       0       0       0       0
 0       active  0'0     2'115   [0]     [0,2]   0'0
        1.0p0   0       0       0       0       0       0       0
 0       active  0'0     2'115   [0]     [0,2]   0'0
        1.1p1   0       0       0       0       0       0       0
 0       active  0'0     3'116   [1]     [1,0]   0'0
        2.1p1   0       0       0       0       0       0       0
 0       active  0'0     3'121   [1]     [1,0]   0'0
        2.0p0   0       0       0       0       0       0       0
 0       active  0'0     2'121   [0]     [0,2]   0'0
        0.1p3   0       0       0       0       0       0       0
 0       active  0'0     4'115   [3]     [3,0]   0'0
        0.0p2   0       0       0       0       0       0       0
 0       active  0'0     3'117   [2]     [2,0]   0'0
        1.1p2   0       0       0       0       0       0       0
 0       active  0'0     3'119   [2]     [2,0]   0'0
        1.0p3   0       0       0       0       0       0       0
 0       active  0'0     4'115   [3]     [3,0]   0'0
         2.0p1   0       0       0       0       0       0       0
  0       active  0'0     3'116   [1]     [1,0]   0'0
         2.1p0   0       0       0       0       0       0       0
  0       active  0'0     2'124   [0]     [0,1]   0'0
    let's take pg 2.1p3 for example,
    why  the up and acting set are not equals?
    Does  data migration  occurs in OSD cluster on this condition?
that is what we are most concerned about.
    if so, the data distribution didn't follow the rules setted by crushmap.
-- 
thanks,
huangjun

--f46d044784973958eb04b870f010
Content-Type: text/plain; charset=US-ASCII; name="crush.txt"
Content-Disposition: attachment; filename="crush.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gye5qkkx0

IyBiZWdpbiBjcnVzaCBtYXAKCiMgZGV2aWNlcwpkZXZpY2UgMCBkZXZpY2UwCmRldmljZSAxIGRl
dmljZTEKZGV2aWNlIDIgZGV2aWNlMgpkZXZpY2UgMyBkZXZpY2UzCmRldmljZSA0IGRldmljZTQK
ZGV2aWNlIDUgZGV2aWNlNQpkZXZpY2UgNiBkZXZpY2U2CmRldmljZSA3IGRldmljZTcKCiMgdHlw
ZXMKdHlwZSAwIGRldmljZQp0eXBlIDEgaG9zdAp0eXBlIDIgcmFjawp0eXBlIDMgcm9vdAoKIyBi
dWNrZXRzCmhvc3QgaG9zdDAgewoJaWQgLTEJCSMgZG8gbm90IGNoYW5nZSB1bm5lY2Vzc2FyaWx5
CgkjIHdlaWdodCAyLjAwMAoJYWxnIHN0cmF3CgloYXNoIDAJIyByamVua2luczEKCWl0ZW0gZGV2
aWNlMCB3ZWlnaHQgMS4wMDAKCWl0ZW0gZGV2aWNlMSB3ZWlnaHQgMS4wMDAKfQpob3N0IGhvc3Qx
IHsKCWlkIC0yCQkjIGRvIG5vdCBjaGFuZ2UgdW5uZWNlc3NhcmlseQoJIyB3ZWlnaHQgMi4wMDAK
CWFsZyBzdHJhdwoJaGFzaCAwCSMgcmplbmtpbnMxCglpdGVtIGRldmljZTIgd2VpZ2h0IDEuMDAw
CglpdGVtIGRldmljZTMgd2VpZ2h0IDEuMDAwCn0KaG9zdCBob3N0MiB7CglpZCAtMwkJIyBkbyBu
b3QgY2hhbmdlIHVubmVjZXNzYXJpbHkKCSMgd2VpZ2h0IDIuMDAwCglhbGcgc3RyYXcKCWhhc2gg
MAkjIHJqZW5raW5zMQoJaXRlbSBkZXZpY2U0IHdlaWdodCAxLjAwMAoJaXRlbSBkZXZpY2U1IHdl
aWdodCAxLjAwMAp9Cmhvc3QgaG9zdDMgewoJaWQgLTQJCSMgZG8gbm90IGNoYW5nZSB1bm5lY2Vz
c2FyaWx5CgkjIHdlaWdodCAyLjAwMAoJYWxnIHN0cmF3CgloYXNoIDAJIyByamVua2luczEKCWl0
ZW0gZGV2aWNlNiB3ZWlnaHQgMS4wMDAKCWl0ZW0gZGV2aWNlNyB3ZWlnaHQgMS4wMDAKfQpyYWNr
IHJhY2swIHsKCWlkIC01CQkjIGRvIG5vdCBjaGFuZ2UgdW5uZWNlc3NhcmlseQoJIyB3ZWlnaHQg
NC4wMDAKCWFsZyBzdHJhdwoJaGFzaCAwCSMgcmplbmtpbnMxCglpdGVtIGhvc3QwIHdlaWdodCAy
LjAwMAoJaXRlbSBob3N0MSB3ZWlnaHQgMi4wMDAKfQpyYWNrIHJhY2sxIHsKCWlkIC02CQkjIGRv
IG5vdCBjaGFuZ2UgdW5uZWNlc3NhcmlseQoJIyB3ZWlnaHQgNC4wMDAKCWFsZyBzdHJhdwoJaGFz
aCAwCSMgcmplbmtpbnMxCglpdGVtIGhvc3QyIHdlaWdodCAyLjAwMAoJaXRlbSBob3N0MyB3ZWln
aHQgMi4wMDAKfQpyb290IHJvb3QgewoJaWQgLTcJCSMgZG8gbm90IGNoYW5nZSB1bm5lY2Vzc2Fy
aWx5CgkjIHdlaWdodCA4LjAwMAoJYWxnIHN0cmF3CgloYXNoIDAJIyByamVua2luczEKCWl0ZW0g
cmFjazAgd2VpZ2h0IDQuMDAwCglpdGVtIHJhY2sxIHdlaWdodCA0LjAwMAp9CgojIHJ1bGVzCnJ1
bGUgZGF0YSB7CglydWxlc2V0IDAKCXR5cGUgcmVwbGljYXRlZAoJbWluX3NpemUgMgoJbWF4X3Np
emUgMgoJc3RlcCB0YWtlIHJvb3QKCXN0ZXAgY2hvb3NlbGVhZiBmaXJzdG4gMCB0eXBlIHJhY2sK
CXN0ZXAgZW1pdAp9CnJ1bGUgbWV0YWRhdGEgewoJcnVsZXNldCAxCgl0eXBlIHJlcGxpY2F0ZWQK
CW1pbl9zaXplIDIKCW1heF9zaXplIDIKCXN0ZXAgdGFrZSByb290CglzdGVwIGNob29zZWxlYWYg
Zmlyc3RuIDAgdHlwZSByYWNrCglzdGVwIGVtaXQKfQpydWxlIHJiZCB7CglydWxlc2V0IDIKCXR5
cGUgcmVwbGljYXRlZAoJbWluX3NpemUgMgoJbWF4X3NpemUgMgoJc3RlcCB0YWtlIHJvb3QKCXN0
ZXAgY2hvb3NlbGVhZiBmaXJzdG4gMCB0eXBlIHJhY2sKCXN0ZXAgZW1pdAp9CgoKCiMgZW5kIGNy
dXNoIG1hcAo=
--f46d044784973958eb04b870f010--

From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: OSDs are flapping and marked down wrongly
Date: Mon, 17 Oct 2016 07:16:44 +0000
Message-ID: <BY2PR02MB3964B80170065D0141B7931F4D00@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:65056
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756546AbcJQHQr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Oct 2016 03:16:47 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage et. al,

I know this issue is reported number of times in community and attributed t=
o either network issue or unresponsive OSDs.
Recently, we are seeing this issue when our all SSD cluster (Jewel based)  =
is stressed with large block size and very high QD. Lowering QD it is worki=
ng just fine.
We are seeing the lossy connection message like below and followed by the o=
sd marked down by monitor.

2016-10-15 14:30:13.957534 7f6297bff700  0 -- 10.10.10.94:6810/2461767 subm=
it_message osd_op_reply(1463 rbd_data.55246b8b4567.000000000000d633 [set-al=
loc-hint object_size 4194304 write_size 4194304,write 3932160~262144] v222'=
95890 uv95890 ondisk =3D 0) v7 remote, 10.10.10.98:0/1174431362, dropping m=
essage

In the monitor log, I am seeing the osd is reported down by peers and subse=
quently monitor is marking it down.
OSDs is rejoining the cluster after detecting it is marked down wrongly and=
 rebalancing started. This is hurting performance very badly.

My question is the following.

1. I have 40Gb network and I am seeing network is not utilized beyond 10-12=
Gb/s , no network error is reported. So, why this lossy connection message =
is coming ? what could go wrong here ? Is it network prioritization issue o=
f smaller ping packets ? I tried to gaze ping round time during this and no=
thing seems abnormal.

2. Nothing is saturated on the OSD side , plenty of network/memory/cpu/disk=
 is left. So, I doubt my osds are unresponsive but yes it is really busy on=
 IO path. Heartbeat is going through separate messenger and threads as well=
, so, busy op threads should not be making heartbeat delayed. Increasing os=
d heartbeat grace is only delaying this phenomenon , but, eventually happen=
s after several hours. Anything else we can tune here ?

3. What could be the side effect of big grace period ? I understand that de=
tecting a faulty osd will be delayed, anything else ?

4. I saw if an OSD is crashed, monitor will detect the down osd almost inst=
antaneously and it is not waiting till this grace period. How it is disting=
uishing between unresponsive and crashed osds ? In which scenario this hear=
tbeat grace is coming into picture ?

Any help on clarifying this would be very helpful.

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).

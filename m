From: GuangYang <yguang11@outlook.com>
Subject: Cascading failure
Date: Wed, 29 Jul 2015 08:55:40 -0700
Message-ID: <BLU175-W41630FF0C30C4393F3B3F2DF8C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s10.hotmail.com ([65.55.111.149]:65269 "EHLO
	BLU004-OMC4S10.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbbG2Pzk convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 11:55:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Cephers,
I have a (test) ceph cluster, on which I had some wrong CRUSH weight (m=
y mistake to set wrong CRUSH weight), then I tried to set the correct C=
RUSH weight (e.g. change the weight from 20 to 5), right after that, th=
e cluster became cascading failure mode, lots of OSDs starts getting do=
wn, and as I started some of them, others went down. I tried the follow=
ing:
=A0 1> Stop all the client traffic. I changed the weight with the clien=
t traffic, which triggered the failures.
=A0 2> Increase osd_op_thread_timeout to make sure OSD does not crash i=
tself due to heavy load (e.g. load from peering).
=A0 3> Set osd nodown flag sometimes to avoid too many map changes back=
 and forth.

With all those changes, I don't see OSD crash anymore, however, I am st=
ill not able to bring the down OSD up, although the daemon themselves a=
re alive, and that seems stuck forever. For those (down) OSDs, they are=
 still processing the peering event, from my observation, they are in t=
hat state for at least 12 hours, constantly log the following messages,=
 and do it over and over again.

2015-07-29 15:49:16.953804 7f46b7281700 10 osd.297 pg_epoch: 56499 pg[6=
=2Ecd7s0( v 3699'7919 lc 0'0 (0'0,3699'7919] local-les=3D56499 n=3D7919=
 ec=3D387 les/c 56237/2872 56496/56498/56498) [297,512,1,118,127,161,99=
,132,23,451,2147483647] r=3D0 lpr=3D56498 pi=3D2639-56497/316 crt=3D369=
9'7919 mlcod 0'0 inactive m=3D7919 u=3D7919] search_for_missing 2f402cd=
7/default.12598.168_osd042c014.cos.bf2.yahoo.com_7a46ad192c5fdb7ff235ef=
9a2b68760f/head//6 2930'4649 also missing on osd.297(0)
2015-07-29 15:49:16.963061 7f46b7281700 10 osd.297 pg_epoch: 56499 pg[6=
=2Ecd7s0( v 3699'7919 lc 0'0 (0'0,3699'7919] local-les=3D56499 n=3D7919=
 ec=3D387 les/c 56237/2872 56496/56498/56498) [297,512,1,118,127,161,99=
,132,23,451,2147483647] r=3D0 lpr=3D56498 pi=3D2639-56497/316 crt=3D369=
9'7919 mlcod 0'0 inactive m=3D7919 u=3D7919] search_for_missing 80502cd=
7/default.12598.122_osd033c014.cos.bf2.yahoo.com_b9d89ace80b6ff88485269=
fd20676697/head//6 2829'1511 also missing on osd.297(0)
2015-07-29 15:49:16.972281 7f46b7281700 10 osd.297 pg_epoch: 56499 pg[6=
=2Ecd7s0( v 3699'7919 lc 0'0 (0'0,3699'7919] local-les=3D56499 n=3D7919=
 ec=3D387 les/c 56237/2872 56496/56498/56498) [297,512,1,118,127,161,99=
,132,23,451,2147483647] r=3D0 lpr=3D56498 pi=3D2639-56497/316 crt=3D369=
9'7919 mlcod 0'0 inactive m=3D7919 u=3D7919] search_for_missing e1502cd=
7/default.12598.135_osd004c014.cos.bf2.yahoo.com_ffc8e0df7eee2ff7fb0ddf=
6fe90d18b0/head//6 2783'1 also missing on osd.297(0)
2015-07-29 15:49:16.981487 7f46b7281700 10 osd.297 pg_epoch: 56499 pg[6=
=2Ecd7s0( v 3699'7919 lc 0'0 (0'0,3699'7919] local-les=3D56499 n=3D7919=
 ec=3D387 les/c 56237/2872 56496/56498/56498) [297,512,1,118,127,161,99=
,132,23,451,2147483647] r=3D0 lpr=3D56498 pi=3D2639-56497/316 crt=3D369=
9'7919 mlcod 0'0 inactive m=3D7919 u=3D7919] search_for_missing b4502cd=
7/default.14462.240_osd030c014.cos.bf2.yahoo.com_cd3acb61271cffa73b9bb6=
d1622ff294/head//6 2845'3668 also missing on osd.297(0)

I have several questions:
=A0 1> What could trigger that OSD down (when the daemon is alive), the=
 only thing I can think of is that the OSD does not respond to a heartb=
eat ping, but I failed to find some logs for that.
=A0 2> I thought setting the nodown flag should help for such case, but=
 even after a long time, when I reset the flag, those OSDs are kicked d=
own immediately. Is that expected.

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Very slow recovery/peering with latest master
Date: Wed, 16 Sep 2015 23:59:16 +0100
Message-ID: <55F9F444.8060805@suse.de>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com> <CAJ4mKGa1vr6Zp9ZUaT8rrHDgRFJgdkO2c8LZqMQuwxwYt7TJ+A@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE49E1A@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41468 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281AbbIPW7S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Sep 2015 18:59:18 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE49E1A@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 09/16/2015 10:19 PM, Somnath Roy wrote:
>=20
> Sage/Greg,
>=20
> Yeah, as we expected, it is not happening probably because of recover=
y settings. I reverted it back in my ceph.conf , but, still seeing this=
 problem.
>=20
> Some observation :
> ----------------------
>=20
> 1. First of all, I don't think it is something related to my environm=
ent. I recreated the cluster with Hammer and this problem is not there.
>=20
> 2. I have enabled the messenger/monclient log (Couldn't attach here) =
in one of the OSDs and found monitor is taking long time to detect the =
up OSDs. If you see the log, I have started OSD at 2015-09-16 16:13:07.=
042463 , but, there is no communication (only getting KEEP_ALIVE) till =
2015-09-16 16:16:07.180482 , so, 3 mins !!
>=20
> 3. During this period, I saw monclient trying to communicate with mon=
itor but not able to probably. It is sending osd_boot at 2015-09-16 16:=
16:07.180482 only..
>=20
> 2015-09-16 16:16:07.180450 7f65377fe700 10 monclient: _send_mon_messa=
ge to mon.a at 10.60.194.10:6789/0
> 2015-09-16 16:16:07.180482 7f65377fe700  1 -- 10.60.194.10:6820/20102=
 --> 10.60.194.10:6789/0 -- osd_boot(osd.10 booted 0 features 720575940=
37927935 v45) v6 -- ?+0 0x7f6523c19100 con 0x7f6542045680
> 2015-09-16 16:16:07.180496 7f65377fe700 20 -- 10.60.194.10:6820/20102=
 submit_message osd_boot(osd.10 booted 0 features 72057594037927935 v45=
) v6 remote, 10.60.194.10:6789/0, have pipe.

Is this the only monitor in your cluster? Are there others?

Logs would certainly be helpful. The more the merrier, I'd think.

If you can't send them to the list, please find some place where we can
reach them, or drop them in cephdrop and point us to them.

Thanks!

  -Joao



> 4. BTW, the osd down scenario is detected very quickly (ceph -w outpu=
t) , problem is during coming up I guess.
>=20
>=20
> So, something related to mon communication getting slower ?
> Let me know if more verbose logging is required and how should I shar=
e the log..
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Gregory Farnum [mailto:gfarnum@redhat.com]
> Sent: Wednesday, September 16, 2015 11:35 AM
> To: Somnath Roy
> Cc: ceph-devel
> Subject: Re: Very slow recovery/peering with latest master
>=20
> On Tue, Sep 15, 2015 at 8:04 PM, Somnath Roy <Somnath.Roy@sandisk.com=
> wrote:
>> Hi,
>> I am seeing very slow recovery when I am adding OSDs with the latest=
 master.
>> Also, If I just restart all the OSDs (no IO is going on in the clust=
er) , cluster is taking a significant amount of time to reach in active=
+clean state (and even detecting all the up OSDs).
>>
>> I saw the recovery/backfill default parameters are now changed (to l=
ower value) , this probably explains the recovery scenario , but, will =
it affect the peering time during OSD startup as well ?
>=20
> I don't think these values should impact peering time, but you could =
configure them back to the old defaults and see if it changes.
> -Greg
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

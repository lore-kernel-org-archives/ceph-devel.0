From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: filestore flusher = false  , correct my problem of constant write (need info on this parameter)
Date: Sat, 23 Jun 2012 19:46:26 +0200 (CEST)
Message-ID: <ba1bddc4-aaed-4ba9-8119-fdf954ec347d@mailpro>
References: <4FE5F17C.5070708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33899 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab2FWRqu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 13:46:50 -0400
In-Reply-To: <4FE5F17C.5070708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org, Stefan Priebe <s.priebe@profihost.ag>, Sage Weil <sage@inktank.com>

>>I was just talking with Elder on IRC yesterday about looking into how=
=20
>>much small network transfers are hurting us in cases like these. Even=
=20
>>with SSD based OSDs I haven't seen a very dramatic improvement in sma=
ll=20
>>request performance. How tough would it be to aggregate requests into=
=20
>>larger network transactions? There would be a latency penalty of=20
>>course, but we could flush a client side dirty cache pretty quickly a=
nd=20
>>still benefit if we are getting bombarded with lots of tiny requests.=
=20

Yes, I see no improvement with journal on tmpfs ...this is strange..

Also, I have tried with rbd_cache=3Dtrue, so ios should be already aggr=
egate in bigger transaction.
But I didnt't have see any improvement.

I'm around 2000 ios.

Do you know what is the bottleneck ? rbd protocol (some kind of overhea=
d for each io ?)


----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.kernel.=
org, "Stefan Priebe" <s.priebe@profihost.ag>=20
Envoy=C3=A9: Samedi 23 Juin 2012 18:40:28=20
Objet: Re: filestore flusher =3D false , correct my problem of constant=
 write (need info on this parameter)=20

On 6/23/12 10:38 AM, Sage Weil wrote:=20
> On Fri, 22 Jun 2012, Alexandre DERUMIER wrote:=20
>> Hi Sage,=20
>> thanks for your response.=20
>>=20
>>>> If you turn off the journal compeletely, you will see bursty write=
 commits=20
>>> >from the perspective of the client, because the OSD is periodicall=
y doing=20
>>>> a sync or snapshot and only acking the writes then.=20
>>>> If you enable the journal, the OSD will reply with a commit as soo=
n as the=20
>>>> write is stable in the journal. That's one reason why it is there-=
-file=20
>>>> system commits of heavyweight and slow.=20
>>=20
>> Yes of course, I don't wan't to desactivate journal, using a journal=
 on a fast ssd or nvram is the right way.=20
>>=20
>>>> If we left the file system to its own devices and did a sync every=
 10=20
>>>> seconds, the disk would sit idle while a bunch of dirty data accum=
ulated=20
>>>> in cache, and then the sync/snapshot would take a really long time=
=2E This=20
>>>> is horribly inefficient (the disk is idle half the time), and usel=
ess (the=20
>>>> delayed write behavior makes sense for local workloads, but not se=
rvers=20
>>>> where there is a client on the other end batching its writes). To =
prevent=20
>>>> this, 'filestore flusher' will prod the kernel to flush out any wr=
itten=20
>>>> data to the disk quickly. Then, when we get around to doing the=20
>>>> sync/snapshot it is pretty quick, because only fs metadata and=20
>>>> just-written data needs to be flushed.=20
>>=20
>> mmm, I disagree.=20
>>=20
>> If you flush quickly, it's works fine with sequential write workload=
=2E=20
>>=20
>> But if you have a lot of random write with 4k block by exemple, you =
are=20
>> going to have a lot of disk seeks. The way zfs works or netapp san=20
>> storage works, they take random writes in a fast journal then flush =
them=20
>> sequentially each 20s to slow storage.=20
>=20
> Oh, I see what you're getting at. Yes, that is not ideal for small ra=
ndom=20
> writes. There is a branch in ceph.git called wip-flushmin that just s=
ets=20
> a minimum write size for the flush that will probably do a decent job=
 of=20
> dealing with this: small writes won't get flushed, large ones will.=20
> Picking the right value will depend on how expensive seeks are for yo=
ur=20
> storage system.=20
>=20
> You'll want to cherry-pick just the top commit on top of whatever it =
is=20
> you're running...=20

I was just talking with Elder on IRC yesterday about looking into how=20
much small network transfers are hurting us in cases like these. Even=20
with SSD based OSDs I haven't seen a very dramatic improvement in small=
=20
request performance. How tough would it be to aggregate requests into=20
larger network transactions? There would be a latency penalty of=20
course, but we could flush a client side dirty cache pretty quickly and=
=20
still benefit if we are getting bombarded with lots of tiny requests.=20

Mark=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

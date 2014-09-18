From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Thu, 18 Sep 2014 11:49:18 +0200 (CEST)
Message-ID: <1ab9d756-bbc9-4fbe-8f51-0a33dbab1a8d@mailpro>
References: <CACJqLyYQDrHyxMEtiMKMNaBQ_fHuu-hGqO_ZNHra0+VsUZrzXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:32852 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbaIRJt1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 05:49:27 -0400
In-Reply-To: <CACJqLyYQDrHyxMEtiMKMNaBQ_fHuu-hGqO_ZNHra0+VsUZrzXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Somnath Roy <Somnath.Roy@sandisk.com>

>>According http://tracker.ceph.com/issues/9513, do you mean that rbd=20
>>cache will make 10x performance degradation for random read?=20

Hi, on my side, I don't see any degradation performance on read (seq or=
 rand)  with or without.

firefly : around 12000iops (with or without rbd_cache)
giant : around 12000iops  (with or without rbd_cache)

(and I can reach around 20000-30000 iops on giant with disabling optrac=
ker).


rbd_cache only improve write performance for me (4k block )



----- Mail original -----=20

De: "Haomai Wang" <haomaiwang@gmail.com>=20
=C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <josh.durgin@inktank.=
com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 18 Septembre 2014 04:27:56=20
Objet: Re: severe librbd performance degradation in Giant=20

According http://tracker.ceph.com/issues/9513, do you mean that rbd=20
cache will make 10x performance degradation for random read?=20

On Thu, Sep 18, 2014 at 7:44 AM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:=20
> Josh/Sage,=20
> I should mention that even after turning off rbd cache I am getting ~=
20% degradation over Firefly.=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: Somnath Roy=20
> Sent: Wednesday, September 17, 2014 2:44 PM=20
> To: Sage Weil=20
> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: RE: severe librbd performance degradation in Giant=20
>=20
> Created a tracker for this.=20
>=20
> http://tracker.ceph.com/issues/9513=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Somnath Roy=20
> Sent: Wednesday, September 17, 2014 2:39 PM=20
> To: Sage Weil=20
> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: RE: severe librbd performance degradation in Giant=20
>=20
> Sage,=20
> It's a 4K random read.=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: Sage Weil [mailto:sweil@redhat.com]=20
> Sent: Wednesday, September 17, 2014 2:36 PM=20
> To: Somnath Roy=20
> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: RE: severe librbd performance degradation in Giant=20
>=20
> What was the io pattern? Sequential or random? For random a slowdown =
makes sense (tho maybe not 10x!) but not for sequentail....=20
>=20
> s=20
>=20
> On Wed, 17 Sep 2014, Somnath Roy wrote:=20
>=20
>> I set the following in the client side /etc/ceph/ceph.conf where I a=
m running fio rbd.=20
>>=20
>> rbd_cache_writethrough_until_flush =3D false=20
>>=20
>> But, no difference. BTW, I am doing Random read, not write. Still th=
is setting applies ?=20
>>=20
>> Next, I tried to tweak the rbd_cache setting to false and I *got bac=
k* the old performance. Now, it is similar to firefly throughput !=20
>>=20
>> So, loks like rbd_cache=3Dtrue was the culprit.=20
>>=20
>> Thanks Josh !=20
>>=20
>> Regards=20
>> Somnath=20
>>=20
>> -----Original Message-----=20
>> From: Josh Durgin [mailto:josh.durgin@inktank.com]=20
>> Sent: Wednesday, September 17, 2014 2:20 PM=20
>> To: Somnath Roy; ceph-devel@vger.kernel.org=20
>> Subject: Re: severe librbd performance degradation in Giant=20
>>=20
>> On 09/17/2014 01:55 PM, Somnath Roy wrote:=20
>> > Hi Sage,=20
>> > We are experiencing severe librbd performance degradation in Giant=
 over firefly release. Here is the experiment we did to isolate it as a=
 librbd problem.=20
>> >=20
>> > 1. Single OSD is running latest Giant and client is running fio rb=
d on top of firefly based librbd/librados. For one client it is giving =
~11-12K iops (4K RR).=20
>> > 2. Single OSD is running Giant and client is running fio rbd on to=
p of Giant based librbd/librados. For one client it is giving ~1.9K iop=
s (4K RR).=20
>> > 3. Single OSD is running latest Giant and client is running Giant =
based ceph_smaiobench on top of giant librados. For one client it is gi=
ving ~11-12K iops (4K RR).=20
>> > 4. Giant RGW on top of Giant OSD is also scaling.=20
>> >=20
>> >=20
>> > So, it is obvious from the above that recent librbd has issues. I =
will raise a tracker to track this.=20
>>=20
>> For giant the default cache settings changed to:=20
>>=20
>> rbd cache =3D true=20
>> rbd cache writethrough until flush =3D true=20
>>=20
>> If fio isn't sending flushes as the test is running, the cache will =
stay in writethrough mode. Does the difference remain if you set rbd ca=
che writethrough until flush =3D false ?=20
>>=20
>> Josh=20
>>=20
>> ________________________________=20
>>=20
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named ab=
ove. If the reader of this message is not the intended recipient, you a=
re hereby notified that you have received this message in error and tha=
t any review, dissemination, distribution, or copying of this message i=
s strictly prohibited. If you have received this communication in error=
, please notify the sender by telephone or e-mail (as shown above) imme=
diately and destroy any and all copies of this message in your possessi=
on (whether hard copies or electronically stored copies).=20
>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20
Best Regards,=20

Wheat=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

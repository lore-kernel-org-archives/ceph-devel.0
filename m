From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: newstore performance update
Date: Wed, 29 Apr 2015 06:31:50 +0200 (CEST)
Message-ID: <364863347.772740036.1430281910806.JavaMail.zimbra@oxygem.tv>
References: <554016E2.3000104@redhat.com> <CAKKTCLX31EBc8oOs6tVVRu4c5prUYD=3G=8fK3pMvLQTM+1iSQ@mail.gmail.com> <554020DC.6020009@redhat.com> <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52677 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbD2Ebx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 00:31:53 -0400
In-Reply-To: <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

>>I am trying to measure 4k RW performance on Newstore, and I am not=20
>>anywhere close to the numbers you are getting!=20
>>
>>Could you share your ceph.conf for these test ?=20

I'll try also to help testing newstore with my ssd cluster.

what is used for benchmark ? rados bench ?=20
any command line to reproduce the same bechmark ?



----- Mail original -----
De: "kernel neophyte" <neophyte.hacker001@gmail.com>
=C3=80: "Mark Nelson" <mnelson@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 29 Avril 2015 04:59:55
Objet: Re: newstore performance update

Hi Mark,=20

I am trying to measure 4k RW performance on Newstore, and I am not=20
anywhere close to the numbers you are getting!=20

Could you share your ceph.conf for these test ?=20

-Neo=20

On Tue, Apr 28, 2015 at 5:07 PM, Mark Nelson <mnelson@redhat.com> wrote=
:=20
> Nothing official, though roughly from memory:=20
>=20
> ~1.7GB/s and something crazy like 100K IOPS for the SSD.=20
>=20
> ~150MB/s and ~125-150 IOPS for the spinning disk.=20
>=20
> Mark=20
>=20
>=20
> On 04/28/2015 07:00 PM, Venkateswara Rao Jujjuri wrote:=20
>>=20
>> Thanks for sharing; newstore numbers look lot better;=20
>>=20
>> Wondering if we have any base line numbers to put things into perspe=
ctive.=20
>> like what is it on XFS or on librados?=20
>>=20
>> JV=20
>>=20
>> On Tue, Apr 28, 2015 at 4:25 PM, Mark Nelson <mnelson@redhat.com> wr=
ote:=20
>>>=20
>>> Hi Guys,=20
>>>=20
>>> Sage has been furiously working away at fixing bugs in newstore and=
=20
>>> improving performance. Specifically we've been focused on write=20
>>> performance=20
>>> as newstore was lagging filestore but quite a bit previously. A lot=
 of=20
>>> work=20
>>> has gone into implementing libaio behind the scenes and as a result=
=20
>>> performance on spinning disks with SSD WAL (and SSD backed rocksdb)=
 has=20
>>> improved pretty dramatically. It's now often beating filestore:=20
>>>=20
>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf=20
>>>=20
>>> On the other hand, sequential writes are slower than random writes =
when=20
>>> the=20
>>> OSD, DB, and WAL are all on the same device be it a spinning disk o=
r SSD.=20
>>> In this situation newstore does better with random writes and somet=
imes=20
>>> beats filestore (such as in the everything-on-spinning disk tests, =
and=20
>>> when=20
>>> IO sizes are small in the everything-on-ssd tests).=20
>>>=20
>>> Newstore is changing daily so keep in mind that these results are a=
lmost=20
>>> assuredly going to change. An interesting area of investigation wil=
l be=20
>>> why=20
>>> sequential writes are slower than random writes, and whether or not=
 we=20
>>> are=20
>>> being limited by rocksdb ingest speed and how.=20
>>>=20
>>> I've also uploaded a quick perf call-graph I grabbed during the "al=
l-SSD"=20
>>> 32KB sequential write test to see if rocksdb was starving one of th=
e=20
>>> cores,=20
>>> but found something that looks quite a bit different:=20
>>>=20
>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf=20
>>>=20
>>> Mark=20
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
>>> the body of a message to majordomo@vger.kernel.org=20
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
>>=20
>>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
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

From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Erasure encoding as a storage backend
Date: Sat, 4 May 2013 11:47:30 -0700
Message-ID: <C38EEFE7-DC29-4325-B268-5BB85B1E4D9A@cs.ucsc.edu>
References: <5185428B.6070109@dachary.org> <C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu> <51855512.20207@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61592 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab3EDSr2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 May 2013 14:47:28 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1403994pbc.3
        for <ceph-devel@vger.kernel.org>; Sat, 04 May 2013 11:47:28 -0700 (PDT)
In-Reply-To: <51855512.20207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


On May 4, 2013, at 11:36 AM, Loic Dachary <loic@dachary.org> wrote:

>=20
>=20
> On 05/04/2013 08:27 PM, Noah Watkins wrote:
>>=20
>> On May 4, 2013, at 10:16 AM, Loic Dachary <loic@dachary.org> wrote:
>>=20
>>> it would be great to get feedback before the ceph summit to address=
 the most prominent issues.
>>=20
>> One thing that has been in the back of my mind is how this proposal =
is influenced (if at all) by a future that includes declustered per-fil=
e raid in CephFS. I realize that may be a distant future, but it seems =
as though there could be a lot of overlap for the (non-client driven) r=
ebuild/recovery component of such an architecture.
>=20
> Hi Noah,
>=20
> I'm not sure what declustered per-file raid is, which means it had no=
 influence on this proposal ;-) Would you be so kind as to educate me ?

I'm definitely far from an expert on the topic. But briefly the way I t=
hink about it is:

Currently CephFS stripes a file byte stream across a set of objects (e.=
g. first MB in object 0, 2nd in object 1, etc..), and each of these obj=
ects is in turn replicated. Following a failure, PGs re-replicate objec=
ts.

In client drive raid the striping algorithm is changed, and clients are=
 calculating and distributing parity. In this case the parity rather th=
an replication provides redundancy. So, one might consider storing obje=
cts in a pool with replication size 1. However, the standard PG that do=
es replication wouldn't be able to handle faults correctly (parity rebu=
ild, rather than re-replication), and a smart PG like the ErasureCodedP=
G would be needed.

So it seems like the problems are related, but I'm not sure exactly how=
 much overlap there is :)

-Noah


> Cheers
>=20
>> -Noah
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

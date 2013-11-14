From: Arne Wiebalck <Arne.Wiebalck@cern.ch>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 20:30:59 +0000
Message-ID: <92F612DDE3CDEA439793C598481F5702CDE43FD2@CERNXCHG02.cern.ch>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
 <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
 <CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com>
 <CAPYLRzhKNT6Tx9LRV6bfHXpAsG1m3MhWriK-i-T+wSGfBVwh-A@mail.gmail.com>
 <CABZ+qqnfkEOVH2QRM8fu95eGEVBZ8JHX-KLGRAca76AymXothg@mail.gmail.com>
 <CAPYLRzh=DfpVx1Z04+XhbYY9yiyGD9HvG4rRp8=xi9B3SKb50A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:44984 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664Ab3KNUbD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 15:31:03 -0500
In-Reply-To: <CAPYLRzh=DfpVx1Z04+XhbYY9yiyGD9HvG4rRp8=xi9B3SKb50A@mail.gmail.com>
Content-Language: en-US
Content-ID: <253EC044F13A9D4BA33EFBF3615559EB@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan van der Ster <dan@vanderster.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Andrea Ieri <andrea.ieri@cern.ch>


On Nov 14, 2013, at 5:37 PM, Gregory Farnum <greg@inktank.com>
 wrote:

> On Thu, Nov 14, 2013 at 8:21 AM, Dan van der Ster <dan@vanderster.com=
> wrote:
>> On Thu, Nov 14, 2013 at 4:55 PM, Gregory Farnum <greg@inktank.com> w=
rote:
>>> Ah, I hadn't gotten that from skimming the blueprint. So this isn't
>>> just about hooking into Kerberos when we do a mount, you want to
>>> dynamically retrieve different caps from the monitors as users log =
on,
>>> and have that single client choose between them based on who's maki=
ng
>>> the request?
>>=20
>> In our proposal the "additional capabilities" (which allow IOs with =
a
>> particular file/object) are encrypted and sent by the MDS to the
>> client who passes it on to the OSD for object IOs.
>=20
> I'm confused; if two different people are using the same client mount=
,
> the MDS can't distinguish between them unless the client is
> cooperating. Isn't that what you were saying it needs to do?

It's the "who passes it on" which created the confusion? This was to sa=
y that
the client kernel module can't decrypt the additional capability (as it=
 does not
have the corresponding key). That does however not mean that the MDS or
the CephFS client module can't distinguish between users as all communi=
cation
is done using session keys. That's at least how I understood it :)

>>>>> the MDS tickets in a lot more detail than you have there, though =
=97 for
>>>>> instance, with your current description you'll need a shared secr=
et
>>>>> between the OSD and MDS, and you'll need to expire the client ext=
ra
>>>>=20
>>>> Right, the shared secret is the kerberos service key in our model.
>>>=20
>>> So the whole Ceph cluster has one shared service key, and they use
>>> that for securing everything that anybody does? (Sorry, that's
>>> probably an elementary question, but I haven't looked at Kerberos
>>> since Yehuda implemented the initial CephX auth.)
>>=20
>> We've used the shared service key in the past with other distributed
>> file systems. But perhaps the model can be changed to per-OSD/MDS
>> keys.
>>=20
>>> By the time I arrived this was all history; you'll have to wait unt=
il
>>> Sage gets back for that one. I suspect he didn't like the performan=
ce
>>> enough and the trees had diverged non-trivially by the time Maat wa=
s
>>> in a useful state. But if you are brave, you can go back in time
>>> (couple years ago) and look for the "security" folder, which I thin=
k
>>> contained the Maat changes, and see what would be involved in
>>> extracting them. :)
>>=20
>> Is it this one?
>>   https://github.com/ceph/ceph/tree/historic/aleung_mds_security/
>=20
> Specifically the branches/aleung/security1/ folder in there. (This is
> all svn branches converted to a git repository, etc, so the
> organization is a bit weird.)

Cheers,
 Arne




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

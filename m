From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 15:47:00 -0700
Message-ID: <CA6CF0E3-F03F-4F51-B5E9-960A5B2EF15A@cs.ucsc.edu>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu> <4D23FD899165483BAF0CEEDC9FF75D61@dreamhost.com> <D283FDD9-61D3-4F93-9650-5A27F61C9E60@cs.ucsc.edu> <2A75BD433C7F498CAB63CC83680D90C0@dreamhost.com> <48DC15FE-3A1B-4CB1-8968-A40EF9743F47@cs.ucsc.edu> <029236CD17D048BEA83B9FFF308C2395@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37690 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab2DKWrB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 18:47:01 -0400
In-Reply-To: <029236CD17D048BEA83B9FFF308C2395@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org


On Apr 11, 2012, at 3:39 PM, Greg Farnum wrote:

> On Wednesday, April 11, 2012 at 3:18 PM, Noah Watkins wrote:
>> One could pair the pointer with a magic value in a separate structur=
e, but even libc doesn't go to these lengths to protect users...
>=20
> At that point we'd run a pretty high risk of segfaulting when trying =
to deref and look at the magic value anyway. Nothing useful we can do h=
ere, I think. :/

Actually I meant:

struct container {
  int magic;
  struct ceph_mount_info *ptr;
};

ceph_chdir(struct container something);

Then, container.magic should equal INITIALIZED where INITIALIZED is "so=
me value that is unlikely to ever be present at a memory location where=
 container is allocated". Lol=85 overkill and not bullet-proof.

> On Wednesday, April 11, 2012 at 3:29 PM, Noah Watkins wrote:
>=20
>>=20
>> On Apr 11, 2012, at 11:32 AM, Greg Farnum wrote:
>>=20
>>> On Wednesday, April 11, 2012 at 11:25 AM, Noah Watkins wrote:
>>>>=20
>>>> On Apr 11, 2012, at 11:22 AM, Greg Farnum wrote:
>>>>=20
>>>>> On Wednesday, April 11, 2012 at 11:12 AM, Noah Watkins wrote:
>>>>>> Hi all,
>>>>>>=20
>>>>>> -Noah =20
>>>>> I'm not sure where the "-1004" came from,
>>>>=20
>>>>=20
>>>>=20
>>>> ceph_mount(..) seems to return some random error codes (-1000, 100=
1) already :)
>>>=20
>>> <grumble> legacy undocumented grr </grumble>
>>> Let's try to use standard error codes where available, and (if we h=
ave to create our own) document any new ones with user-accessible names=
 and explanations. I don't know which one is "best" but I see a lot of =
applicable choices when scanning errno-base et al.
>>=20
>>=20
>>=20
>> If I'm choosing from from errno-base I might go with
>>=20
>> #define ENXIO 6 /* No such device or address */
>>=20
>> It's used:
>>=20
>> osd/OSD.cc (http://OSD.cc)
>> void OSD::handle_misdirected_op(PG *pg, OpRequest *op)
>> =85
>> reply_op_error(op, -ENXIO)
>>=20
>> I'm wondering if you happen to know if this will be propagated back =
to the client? I'd be nice to have an exclusive not-mounted condition o=
n the client side.
>>=20
>> -Noah =20
> Unfortunately it is. (I just grepped and see it's returned by both th=
e MDS and the OSD, but it's not in Objecter et al so it's not filtered =
out anywhere.)
>=20
> ENODEV isn't returned from anything; do you think that makes sense?
> -Greg
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

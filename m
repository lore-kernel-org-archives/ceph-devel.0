From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Publishing hammer v0.94.6
Date: Fri, 29 Jan 2016 10:55:25 -0700
Message-ID: <CAANLjFp54JrWP7uf9GZM7NtF3p-=gjW9VwbWANgf2to7tx=_Ug@mail.gmail.com>
References: <56AAFAB2.9010103@dachary.org>
	<alpine.DEB.2.11.1601290951320.6524@cpach.fuggernut.com>
	<CAANLjFqWTCGBTbzRkhPXTAnj=UiYVmzDKJMKR2b62FJ7ThzgqA@mail.gmail.com>
	<56AB9875.7020609@dachary.org>
	<CAANLjFp9nB9Qh+ruBvSW7fkpKZ7dTTFiuq22fgkcn0uCSuAhSg@mail.gmail.com>
	<56ABA4D3.4060009@dachary.org>
	<CAANLjFpumroXL1gbjmNfDU=oxnq9136OJ0jL1Hevjq6i7LzPNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35898 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbcA2Rz0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 12:55:26 -0500
Received: by mail-vk0-f45.google.com with SMTP id n1so46149550vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 09:55:26 -0800 (PST)
In-Reply-To: <CAANLjFpumroXL1gbjmNfDU=oxnq9136OJ0jL1Hevjq6i7LzPNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Sorry, I'm not familiar with teuthology.

Robert LeBlanc
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Jan 29, 2016 at 10:49 AM, Robert LeBlanc  wrote:
> Sorry, I'm not familiar with teuthology.
>
> Robert LeBlanc
>
> Sent from a mobile device please excuse any typos.
>
> On Jan 29, 2016 10:43 AM, "Loic Dachary"  wrote:
>>
>>
>>
>> On 30/01/2016 00:06, Robert LeBlanc wrote:
>> > I've ran it through run-make-check.sh and it passed. Is that what =
you
>> > are asking?
>>
>> I'm refering to the rados suite (see
>> http://pulpito.ceph.com/loic-2016-01-29_02:04:23-rados-hammer-backpo=
rts---basic-multi/
>> for instance). I can explain further if teuthology is unfamiliar.
>>
>> Cheers
>>
>> >
>> > Thanks,
>> > ----------------
>> > Robert LeBlanc
>> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >
>> >
>> > On Fri, Jan 29, 2016 at 9:51 AM, Loic Dachary  wrote:
>> >> Hi Robert,
>> >
>> >> Thanks for the comments update :-) It needs a rados run before it=
 is
>> >> merged. Can you do that ?
>> >
>> >> Cheers
>> >
>> >> On 29/01/2016 23:35, Robert LeBlanc wrote:
>> >>> We'd really like to have http://tracker.ceph.com/issues/14329 in
>> >>> 0.94.6. I think I fixed the comments. Please let me know.
>> >>> ----------------
>> >>> Robert LeBlanc
>> >>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9=
=461
>> >>>
>> >>>
>> >>> On Fri, Jan 29, 2016 at 7:51 AM, Sage Weil  wrote:
>> >>>> Let's do it!
>> >>>
>> >>>> On Fri, 29 Jan 2016, Loic Dachary wrote:
>> >>>
>> >>>>> Hi Sage,
>> >>>>>
>> >>>>> Now that the test infrastructure is back, we could try to publ=
ish
>> >>>>> v0.94.6. These are the issues it fixes:
>> >>>>> http://tracker.ceph.com/versions/505. And these are the backpo=
rts that are
>> >>>>> in flight and would not be in v0.94.6 if we decide to cut the =
release today:
>> >>>>> http://tracker.ceph.com/projects/ceph/issues?query_id=3D78
>> >>>>>
>> >>>>> What do you think ?
>> >>>>>
>> >>>>> --
>> >>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> >>>>>
>> >>>>>
>> >>>
>> >>>
>> >
>> >> --
>> >> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> >
>> >
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWq6eLCRDmVDuy+mK58QAALWQP/iApYFt1MBZyiS4jTfvW
mMEU+GYrsLO3ZEl6TIc8u9kYWrxIdINedtHXRzPlLVyVSxnpvaNXO+turIZO
PVjp/LCKRDh4jPz5bJEiVjGmkDRepzjtXUsZCIPGF/RPYaTc36dz+NisW55v
cH/3ceLXEUCz39H3jTwoWq9GRLWag3IR/tjA+rQKxqw6gilgLF+jE+ES9aPn
qqRA2xxTR4dfv0JD4E3anFcnFzTrHuvU9p2iF52qgLCJmWFNfpZ/AE3o3x0E
z5NuTwEYOCEHDIybyWo+Eu6mmWA/mWClZ50z404TkFT1/Y7xAcvHYkOqAUiu
bigvbKy+yf51vTHpRnJnEGjda4CLMyrkjDwOBwjrd4gKmE3ENcP1yx3dDHMR
TqYcZcHTORSoNqfGRXrGuWWHODA0Sqo29otf90loUxYGYLZOolye9wV8pJ/r
tyguJ/SQOuNVYIC79sVXvR1bW0kG4iAtCRnz+n72BTVLahehRuFjyAFH11sE
ZQwm5TWi6/V74HnOL/ICOaPG+fj6w4Po4oTXope9e16YQuitiX7WY4HFpXxo
KGYPuDrm5d5KItkmADqGtNDngfZ7AbrdepQ7oqEqiMdkWxEJ2Q1zA2JPJuW/
cjeKwN9acV6LBy8rWjh+THW8GoXDt4AQL0I0mBEUF8Rhei9RfYWqlg+KFlaV
VMRI
=3Dvuzq
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

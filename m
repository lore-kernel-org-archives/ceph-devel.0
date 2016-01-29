From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Publishing hammer v0.94.6
Date: Fri, 29 Jan 2016 09:35:18 -0700
Message-ID: <CAANLjFqWTCGBTbzRkhPXTAnj=UiYVmzDKJMKR2b62FJ7ThzgqA@mail.gmail.com>
References: <56AAFAB2.9010103@dachary.org>
	<alpine.DEB.2.11.1601290951320.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33473 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567AbcA2QfU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 11:35:20 -0500
Received: by mail-vk0-f51.google.com with SMTP id e64so45138780vkg.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 08:35:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601290951320.6524@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

We'd really like to have http://tracker.ceph.com/issues/14329 in
0.94.6. I think I fixed the comments. Please let me know.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Jan 29, 2016 at 7:51 AM, Sage Weil  wrote:
> Let's do it!
>
> On Fri, 29 Jan 2016, Loic Dachary wrote:
>
>> Hi Sage,
>>
>> Now that the test infrastructure is back, we could try to publish v0=
=2E94.6. These are the issues it fixes: http://tracker.ceph.com/version=
s/505. And these are the backports that are in flight and would not be =
in v0.94.6 if we decide to cut the release today: http://tracker.ceph.c=
om/projects/ceph/issues?query_id=3D78
>>
>> What do you think ?
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWq5TECRDmVDuy+mK58QAAHL4QALVBKscjlQrDo9LuMMRb
0nI8DIDnuCeMfI996Tmvg4MRtWRbRBqL6StHSlUDZQtOgFLfMnVNmGDfFnHK
dkWrjE993O05cCd/+L5Y4elDksMK1Mv1c4gw6hqT/5zNRwyQJHhKsPgVA0bd
DvPBSJp/Dbkm5rEGpa4NwiOIqEgFsGVXYSSs5qI+TM+squjnxm4X/hjuAYJB
9Wk+XSvZhIfWFkGozwat1Od2NH44fBt5IynM//TFrIoM4U2llhP9+4DZusCJ
LaVwrdtcyHDwEv1IZeIH8myKIQv30rjCUrwhnytUAOjLEvPm2aJcWwvFGOAc
nnaWXHHqGDDugEx0jonxULSXJyuMVCq4AslpzbAHfYQGzf9LkZ1O1RRUmrYd
t6jkm7//Q0y8LJvsGRIF9zaHWZVcKNevEwzDXLBKUnVe7rqeCVqF0oYvnrVj
nMbErft6SkdhVYRjq0TrAlJbSBmrZ8NVw+GCedLajntR2vm7x+wJRY0XYqEJ
yq6h3ASpdei+CGazUAQiWWm17emHiqCQmIJY5FpYKT81VSzFAD8A/Kx4vZ9u
iGjJnAgOFGhLcUBhenbwrujOlTUPmk0+poh4Phj+ycqh+cD2xTCveKONfRGQ
twXlDqOuykrQYs9F81AyYiNyZ3DUOnsDQbu4i1s/WHVAbx+3N7zp2E1QVWgu
Q0rS
=3DDXWG
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

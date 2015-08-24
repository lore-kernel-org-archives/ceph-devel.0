From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Mon, 24 Aug 2015 11:01:18 -0600
Message-ID: <CAANLjFrCSP-RX29Mqtf5xB2-6AiGbxUdgFz25uMwa8BiAdWcYw@mail.gmail.com>
References: <55D409F0.3050802@redhat.com>
	<1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com>
	<55D4E470.9030501@profihost.ag>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12841@SACMBXIP01.sdcorp.global.sandisk.com>
	<55D4E793.9040408@profihost.ag>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com>
	<55D4E9BE.8000309@profihost.ag>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com>
	<EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com>
	<CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com>
	<alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33719 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbbHXRGz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 13:06:55 -0400
Received: by vkd66 with SMTP id 66so60802090vkd.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 10:06:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Probably possible. The question is if it would it be worth the extra
logic. It seems a lot more complicated than an include line. I don't
know if you would have to use introspection or if you could assume
that functions exist.

https://en.m.wikipedia.org/wiki/Dynamic_loading

Robert LeBlanc

Sent from a mobile device please excuse any typos.

On Aug 22, 2015 7:55 AM, "Sage Weil"  wrote:
On Fri, 21 Aug 2015, Milosz Tanski wrote:
> On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
>  wrote:
> > Hi All,
> >
> > Have sent out a pull request which enables building librados/librbd with either tcmalloc(as default)  or jemalloc.
> >
> > Please find the pull request @ https://github.com/ceph/ceph/pull/5628
> >
> > With regards,
> > Shishir
>
> Unless I'm missing something here, this seams like the wrong thing to.
> Libraries that will be linked in by other external applications should
> not have a 3rd party malloc linked in there. That seams like an
> application choice. At the very least the default should not be to
> link in a 3rd party malloc.

Yeah, I think you're right.

Note that this isn't/wasn't always the case, though.. on precise, for
instance, libleveldb links libtcmalloc.  They stopped doing this
sometime before trusty.

sage
- --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.0.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV203VCRDmVDuy+mK58QAA4nkQAMjitAd+qP7o6Oq6T/Xq
QnAhiUXzgIW4EPcuKl6CsuQp2jeKn0QYzhbf0qqARnIwTisM7PiKyH7lMgYR
izH7ZA9IJt5KeCrgOJrbpOxWNWHAJgUwPqFPCkOIvjeQjjLa8vh4oki072dC
A8cIgMAo/baRNiRtPn+B4OUpgkzYBUvePHfBMACFfwB6Tu+7p4kqRSXMshOs
3zdV8dG3S4vTS5hJO0zMKN3XDq9Nz0p/+XsSQ9C8bw2LMD/ctVxBBn+g9jiD
HsImeSRHoZpna/XZ8EFdwDaEPiRRdCLxueVMpcwTDQYh86DoPL9tqnmzJeD4
lgFnBJfAztvfSqwTaA0BZWAZyt5XkdUZrY365/ZfhfBpdLeXb8ozdaQcWNd4
nE28ce47m6nU8MenC1/cVSFF1VJ9cxsvc3jOqxcvObs6OwzblGWboxAxMhXD
kS4IdTbOdixiWKgCBvmWvjgI9dUSr00EMaW6LtrPiNjRjF+fiEzKNQrvYkZJ
gVTcXJQVpYZirUj7z+PjnmuFVOuq1aQ0cscl/cDfew/II9ZLtf5+nScE+z2c
SqWfi+q/FI+Z7yJtzHlmY5No19rlFycP4pjawCZhuy7bZts5adh+JhciVv9B
7Y7NM3K4/nmU4DYwC0RbyK1ty2xVwuvME/Ws6Ds4ywjGi29uXBA9ryf8Cgvq
c7zh
=MlV0
-----END PGP SIGNATURE-----

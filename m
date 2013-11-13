From: Loic Dachary <loic@dachary.org>
Subject: Re: Building Ceph statically linked
Date: Wed, 13 Nov 2013 21:24:32 +0100
Message-ID: <5283E000.3040707@dachary.org>
References: <5283DF7D.9080203@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:36661 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3KMUYf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 15:24:35 -0500
In-Reply-To: <5283DF7D.9080203@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 13/11/2013 21:22, Wido den Hollander wrote:
> Hi,
>
> While doing some tests I'm trying to build Ceph statically. I have a =
bunch of machines where I run Ceph on for these test (mostly RGW now) a=
nd I'm running into some library issues when switching from branches.
>
> To make my life a bit easier I tried compiling Ceph (especially RGW) =
statically linked, but somehow I keep ending up with a dynamically link=
ed binary.
>
> What I tried:
>
> $ env CXXFLAGS=3D"-static" ./configure --enable-static --disable-shar=
ed
> $ make
>
> Usually that should spit out a static binary, but 'radosgw' is still =
dynamic.
>

I suspect it's because you did not --with-radosgw and it was not recomp=
iled.

Cheers

> I'm not such a autoconf nor automake guru, so does anybody ever build=
 static binaries with Ceph?
>
> Yes, I'm aware they can become very large, but that's not my concern =
right now. I just want to upload a binary to a machine, run it and see =
if it does what I'm hoping it does and not having to worry about all th=
e dependencies being there and being the right version.
>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

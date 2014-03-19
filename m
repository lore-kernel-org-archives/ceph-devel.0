From: Kevin Cox <kevincox@kevincox.ca>
Subject: Re: Wireshark Dissector
Date: Tue, 18 Mar 2014 23:24:41 -0400
Message-ID: <53290DF9.1080306@kevincox.ca>
References: <5328DDAB.3050606@kevincox.ca> <alpine.DEB.2.00.1403181659470.5823@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sVUgF5gg7hTs2TNvTR4Sotfjpkib18Wu3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38524 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbaCSDYr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Mar 2014 23:24:47 -0400
Received: by mail-ie0-f177.google.com with SMTP id rl12so7868063iec.8
        for <ceph-devel@vger.kernel.org>; Tue, 18 Mar 2014 20:24:47 -0700 (PDT)
Received: from [192.168.1.11] (CPE68b6fc405da3-CM68b6fc405da0.cpe.net.cable.rogers.com. [99.245.224.23])
        by mx.google.com with ESMTPSA id ro10sm30497847igb.6.2014.03.18.20.24.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 20:24:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1403181659470.5823@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sVUgF5gg7hTs2TNvTR4Sotfjpkib18Wu3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 18, 2014 8:04 PM, "Sage Weil" <sage@inktank.com
<mailto:sage@inktank.com>> wrote:
>
> I think you're on the right track.  I suspect it would go something lik=
e:
>
>  - get environment, infrastructure up and running
>  - parse basic message exhcange, but not messages
>  - add support for individual message types by subsystem
>    - mon<->client (including authentication and such)   (small)
>    - osd<->client    (small)
>    - osd<->osd       (big)
>    - mon<->mon       (medium)
>    - client<->mds    (medium)
>    - mds<->mds       (big)
>

Thanks, this is exactly what I was looking for.

> The nice thing here is that the stop point is moveable.  Getting the
> basics in place will make it easy for others to add or update additiona=
l
> message decodings later, and with just the few most common messages the=

> tool is immediately useful.
>

I was thinking the same think.  While I think I can finish all the
protocols in the
given time I obviously don't know enough to be sure.  I'm writing my
proposal
so that even if I got hit by a bus the finished work should be a solid
foundation.

> At some point early I would engage with the Wireshark folks too to make=

> sure things are appropriate for upstreaming.  Getting the initial suppo=
rt
> in early and following up with support for additional message types lat=
er
> might be a good strategy foundation

Sounds like a good plan.

Thanks,
Kevin



--sVUgF5gg7hTs2TNvTR4Sotfjpkib18Wu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlMpDfwACgkQwHWKOzTVLnSJbQD9G7TKyRkilCBbCo7r+wYHKqAM
GQulCCOjT4nENT38MvcA/1OT6PBe8IAuALr8W+BVTNyCa/eeCqtumMnwWq1yfjA8
=qBZz
-----END PGP SIGNATURE-----

--sVUgF5gg7hTs2TNvTR4Sotfjpkib18Wu3--

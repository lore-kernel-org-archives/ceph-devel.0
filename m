From: Tony Lill <ajlill@ajlc.waterloo.on.ca>
Subject: Re: 5.4.20 - high load - lots of incoming data - small data read.
Date: Thu, 9 Apr 2020 18:47:35 -0400
Message-ID: <f131fc4a-112d-2bea-f254-ed268579cf7e@ajlc.waterloo.on.ca>
References: <CAED-sidS3jt5f0nTvLp6_xL+sgk0FFJGaX-X7cCDav-8nwj4TA@mail.gmail.com>
 <db72c749125519b9c042c9664918eacbe8744985.camel@kernel.org>
 <CAED-sie+qsrr3yZVAiB=t6cAzWUwX9Y=32srJY2dwyRpSXvgxg@mail.gmail.com>
 <e9c9ffb60265aebdab6edd7ce1565402eb787270.camel@kernel.org>
 <CAED-sicefQuJ3GGWh2bBXz6R=BFr1EQ=h6Sz-W_mh3u+-tO0wA@mail.gmail.com>
 <cbbc31d2041601b3e0d2c9b1e8b657ffa23ed97e.camel@kernel.org>
 <CAED-sic=eDaXz-A6_ejZOYcJYs=-tJtmxXLcONdQRRCod59L_g@mail.gmail.com>
 <25bc975e164a73f18653156d6591dda785c8d0c1.camel@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7hwlOzcgik1dA81mUcSYy4VxbzO15Ggqx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alouette.ajlc.waterloo.on.ca ([45.55.22.104]:45376 "EHLO
        mail.ajlc.waterloo.on.ca" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbgDIXBV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Apr 2020 19:01:21 -0400
In-Reply-To: <25bc975e164a73f18653156d6591dda785c8d0c1.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Jesper Krogh <jesper.krogh@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7hwlOzcgik1dA81mUcSYy4VxbzO15Ggqx
Content-Type: multipart/mixed; boundary="T7NV443CMz0ULVcyiXnodPGZIaBgwkEql";
 protected-headers="v1"
From: Tony Lill <ajlill@ajlc.waterloo.on.ca>
To: Jeff Layton <jlayton@kernel.org>, Jesper Krogh <jesper.krogh@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>
Message-ID: <f131fc4a-112d-2bea-f254-ed268579cf7e@ajlc.waterloo.on.ca>
Subject: Re: 5.4.20 - high load - lots of incoming data - small data read.
References: <CAED-sidS3jt5f0nTvLp6_xL+sgk0FFJGaX-X7cCDav-8nwj4TA@mail.gmail.com>
 <db72c749125519b9c042c9664918eacbe8744985.camel@kernel.org>
 <CAED-sie+qsrr3yZVAiB=t6cAzWUwX9Y=32srJY2dwyRpSXvgxg@mail.gmail.com>
 <e9c9ffb60265aebdab6edd7ce1565402eb787270.camel@kernel.org>
 <CAED-sicefQuJ3GGWh2bBXz6R=BFr1EQ=h6Sz-W_mh3u+-tO0wA@mail.gmail.com>
 <cbbc31d2041601b3e0d2c9b1e8b657ffa23ed97e.camel@kernel.org>
 <CAED-sic=eDaXz-A6_ejZOYcJYs=-tJtmxXLcONdQRRCod59L_g@mail.gmail.com>
 <25bc975e164a73f18653156d6591dda785c8d0c1.camel@kernel.org>
In-Reply-To: <25bc975e164a73f18653156d6591dda785c8d0c1.camel@kernel.org>

--T7NV443CMz0ULVcyiXnodPGZIaBgwkEql
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 4/9/20 12:30 PM, Jeff Layton wrote:
> On Thu, 2020-04-09 at 18:00 +0200, Jesper Krogh wrote:
>> Thanks Jeff - I'll try that.
>>
>> I would just add to the case that this is a problem we have had on a
>> physical machine - but too many "other" workloads at the same time -
>> so we isolated it off to a VM - assuming that it was the mixed
>> workload situation that did cause us issues. I cannot be sure that it
>> is "excactly" the same problem we're seeing but symptoms are
>> identical.
>>
>=20
> Do you see the "page allocation failure" warnings on bare metal hosts
> too? If so, then maybe we're dealing with a problem that isn't
> virtio_net specific. In any case, let's get some folks more familiar
> with that area involved first and take it from there.
>=20
> Feel free to cc me on the bug report too.
>=20
> Thanks,
>=20

In 5.4.20, the default rsize and wsize is 64M. This has caused me page
allocation failures in a different context. Try setting it to something
sensible.
--=20
Tony Lill, OCT,                     ajlill@AJLC.Waterloo.ON.CA
President, A. J. Lill Consultants               (519) 650 0660
539 Grand Valley Dr., Cambridge, Ont. N3H 2S2   (519) 241 2461
-------------- http://www.ajlc.waterloo.on.ca/ ---------------




--T7NV443CMz0ULVcyiXnodPGZIaBgwkEql--

--7hwlOzcgik1dA81mUcSYy4VxbzO15Ggqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAl6PpgcACgkQGS8yZq1uvxCcJgCfaMUXt+E7wsbV9NCCweAHJDcM
GHsAn2lemZCAvMFwWf7akKEqFkpdTlzk
=Ez07
-----END PGP SIGNATURE-----

--7hwlOzcgik1dA81mUcSYy4VxbzO15Ggqx--

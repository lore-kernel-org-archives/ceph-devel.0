From: Martin Millnert <martin@millnert.se>
Subject: RGW Indexing-in-PostgreSQL?
Date: Tue, 31 Jan 2017 00:56:29 +0100
Message-ID: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kgvnfjlztjgreiat"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([52.57.105.132]:64277 "EHLO mail.millnert.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdAaACK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 19:02:10 -0500
Received: from 134d30345a13d6cf85884e4b (unknown [31.208.64.196])
        by mail.millnert.se (Postfix) with ESMTPSA id 07E1960196
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2017 00:58:31 +0100 (CET)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--kgvnfjlztjgreiat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we're running RGW with indexes placed on fast pools, whereas the data is
placed on slow pools. The write throughput is approximately 10% of rados
bench and I guess we're experiencing some locking/syncronization
feature, because parallelisation doesn't really speed it up.
I've seen the sharding option, and the indexless option, but neither one
of these seems like /the/ fix to me.
My limited knowledge of the RGW code makes me guess it's due to the
indexes, and possibly even additional metadata that RGW keeps
up-to-date?

Assuming that the index objectes must be downloaded, rewritten, and
re-uploaded to the index pools by RGW (and that this should be
locking?), the thought that I've had for a while now is:
How hard is it to abstract these index operations and add support for
actually using PostgreSQL as a backend?

I don't mean to say bad words vis-a-vis a completely self-contained data
management system, etc, but (more) right(*) (optional) tool for the job has some
quality to it too. :-)

I'd be willing to take a look at it, I guess.

Thoughts?

Best,
Martin

(* Latency/HA/etc tradeoffs may vary based on use-case and
requirements.)

--kgvnfjlztjgreiat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEESLPKMkyDRgSuNvksqCto11mvDEwFAliP0qoACgkQqCto11mv
DEwMZg/+LOGgOcOgy8MTbcfoFF5lMrNiJ1mDoKo7x9X6G2tpyeNFZQqclhC4gAdh
v3otusuY/Z9NldM6mmwO0j4an9hinIJHOodUHdAlHPX8XhxJp9N5JRCpfFrJ/dN4
5/DFhB38soeCKYy5Y7XVa+mGx6VwP8HpblkXq12Mhh6+LWOWug8sCd43SPNzy1qt
f0Cky1s4lVT/BYJsYWZ7uh0A//c+Xg9+dDpO1USvOHujNOggWn/8xnjWiBMqNdlL
BzbrDMnURX2YJ5mdIsbTis6jykoS3IGZwAf3PlONYk43z4vZoXutej3nuclZOssA
AOcmao+YA/qU0dTjCWE0LNd7Rk9fUy+jzwJovKLnMe+upjsEC5GJoE+SY9z3ig2G
fxmeoc5wgqx+DY5pzALRJK+Jumz2CasuFTuveH9PBB+1zXiiFPfSXUj7C/4NEBc8
14kogQWtxBIKAky6oxOed2WXNzUfujs97gpbwdy+s1FoCF6pUUoz7q2p3brvsU8X
aKdi7FrVzXKoP9uajAxEHkJ7r1U6OOBo1Jzn910+x0rnFeU9C76jnlZ8+WD1uwMb
T4QxAyK0URoMaGHjcFSB5tO8Uf5847ULdK+9j8JqRrjSORUrG6nsnDa1UGFzD2Km
MhH6/hr0lHipUQ6fw+VLJXj+jOGAQTgzFyO69xVNIPEbdzP3nhw=
=xeg3
-----END PGP SIGNATURE-----

--kgvnfjlztjgreiat--

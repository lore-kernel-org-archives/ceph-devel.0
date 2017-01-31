From: Martin Millnert <martin@millnert.se>
Subject: Re: RGW Indexing-in-PostgreSQL?
Date: Tue, 31 Jan 2017 01:19:23 +0100
Message-ID: <20170131001923.pap3b24na4lrzqxc@134d30345a13d6cf85884e4b>
References: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
 <28fa42fd-4d60-9d73-bfd0-997b183b1320@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qo7ucxyunkbbrwfj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([52.57.105.132]:64356 "EHLO mail.millnert.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753464AbdAaAT2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 19:19:28 -0500
Content-Disposition: inline
In-Reply-To: <28fa42fd-4d60-9d73-bfd0-997b183b1320@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


--qo7ucxyunkbbrwfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, Jan 30, 2017 at 06:09:44PM -0600, Mark Nelson wrote:
>=20
>=20
> On 01/30/2017 05:56 PM, Martin Millnert wrote:
> > Hi,
> >=20
> > we're running RGW with indexes placed on fast pools, whereas the data is
> > placed on slow pools. The write throughput is approximately 10% of rados
> > bench and I guess we're experiencing some locking/syncronization
> > feature, because parallelisation doesn't really speed it up.
> > I've seen the sharding option, and the indexless option, but neither one
> > of these seems like /the/ fix to me.
> > My limited knowledge of the RGW code makes me guess it's due to the
> > indexes, and possibly even additional metadata that RGW keeps
> > up-to-date?
> >=20
> > Assuming that the index objectes must be downloaded, rewritten, and
> > re-uploaded to the index pools by RGW (and that this should be
> > locking?), the thought that I've had for a while now is:
> > How hard is it to abstract these index operations and add support for
> > actually using PostgreSQL as a backend?
>=20
> The indexes are definitely something to watch!  It would be very interest=
ing
> to see how your write benchmark does with indexless buckets.

Yeah we'll try to get some comparative data to try to find the
bottleneck(s), though what I want is fast indexes. :-)

> we've seen in the past is when the bucket indexes are slow (in that
> particular case because the bucket index pool only had 8 PGs!), RGW is
> spending most of it's time waiting on bucket index updates.  You can grab=
 a
> couple of GDB stacktraces of the RGW process to see if this is happening =
in
> your case.

Thanks for the pointer, I'll see what we can do.

> > I don't mean to say bad words vis-a-vis a completely self-contained data
> > management system, etc, but (more) right(*) (optional) tool for the job=
 has some
> > quality to it too. :-)
> >=20
> > I'd be willing to take a look at it, I guess.
> >=20
> > Thoughts?
>=20
> I think first figure out if it's actually the bucket indexes.

Sure, data first makes very good sense. :-)
> Like you said, there's more metadata associated with RGW, so at least some
> of what you are seeing could be metadata getting pushed out of the inode =
and
> into separate extents.  Are you writing out lots of really small objects =
or fewer
> larger objects?

We're throughput limited when uploading single chunk or multi chunk
large objects (10+ MB), this is the main concern.
Data pool is on a wide EC (10+4), where rados bench saturate CPU on hosts,
but give 10x throughput. Have to double check if our config is doing additi=
onal
striping/chunking of incoming objects, and how this interacts with EC.

Thanks,
Martin

--qo7ucxyunkbbrwfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEESLPKMkyDRgSuNvksqCto11mvDEwFAliP2AsACgkQqCto11mv
DExEqA/9F+uUiCo6wW7W7LC1zOpuajdDmUb6lrSeq9s+RYnNBixkvJ+v9CJ7QyPi
G6RVWVutKvR1wLmkIgEfZhrWxgKzc3JaxwnCFT02wC0M4XSWcORwMZ2r9uVVkb/N
e9oYtBvCmTjQWV0rJrFrIncoWw82/djAQeasfzCA8mJl8GdvXs2rVJK3WvFtQ9yJ
RstQSaMYD/rxR2BauaTblH/bJRAiDBGDd/hgWknodgWtEBcN9S2u7R9p5oxSGeXl
lxDu6Yrg4n/QJK//hMjaxHCnqdrE4+Z63l7+2fmxnvR/foqrN8oAecXXjvt1cQjg
FUydVGuROA7e8qRdIAUg8XTNtauwXj7NJFE4m0jMoGcoHqV5jMfyJGGx1Y+Y5nFJ
AZRHcoTJyYLzys8oQKkr518Sl3c00b1u4fXqLwzPEMi22H3EhXWskBfCstOA2SoY
fYMDAWJbnr/2wTDajgjGWL7IFZ8r1xEoTQz6BM6gYI2wTXaq+rNP+Lh2k1nCbduM
/a9OjGfooVsm4L1/oK8DASQVEfIHiw72ULkIu3t2SbE4dYbIzHP6BCqR2WKvnqA7
FpAFZUNbREFh7C+KIAkFR17nuMUL0zWcu+Ey/IhXvBJ+AN0m8LMe3Ddik9LXVMEs
6V0xOnFWwV3YICaM3sFQzSNHGXl9IhawIUNqEXdjJAyWiflk3ZE=
=YHk1
-----END PGP SIGNATURE-----

--qo7ucxyunkbbrwfj--

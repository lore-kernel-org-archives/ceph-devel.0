From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 0/2]: CEPHFS: allow for races between direct and buffered writes
Date: Thu, 01 Sep 2016 11:13:36 +1000
Message-ID: <87mvjscthb.fsf@notabene.neil.brown.name>
References: <874m61eje0.fsf@notabene.neil.brown.name> <CAAM7YA=p9EdH6Kd2t_b5ZzbEHm5PSvEVakcSTtCiH=5o5sNi1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753793AbcIABNp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 21:13:45 -0400
In-Reply-To: <CAAM7YA=p9EdH6Kd2t_b5ZzbEHm5PSvEVakcSTtCiH=5o5sNi1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Wed, Aug 31 2016, Yan, Zheng wrote:

> On Wed, Aug 31, 2016 at 10:56 AM, NeilBrown <neilb@suse.com> wrote:
>>
>> Hi,
>>  it is quite possible for O_DIRECT and buffered writes to a file to
>>  race.
>>  The xfstests test suite has a test - generic/036 - which tests this
>>  case.
>>
>>  Unlike most filesystems, cephfs does not hold inode_lock() across
>>  direct writes.  This means that buffer pages can become dirty while
>>  direct writes are happening.  This confused ceph a little.
>
> how about make ceph_write_iter() hold inode_lock() for direct/sync write?

You could probably do that.  You could even use inode_lock_shared() to
allow multiple writers to perform O_DIRECT writes to the same file in
parallel.

But I don't know why ceph did this differently from every other
filesystem, and the git commit message doesn't shine any light on that
question.  I didn't want to propose a change that I didn't understand
the consequences of.

If you did extend the locking over ceph_direct_read_write(), it would
probably make sense to remove the truncate_inode_pages_range() call as
it should be redundant.

Thanks,
NeilBrown


>
> Regards
> Yan, Zheng
>>
>>  The following two patches allow ceph to handle this possibility a
>>  little more cleanly.  The more important patch removes a WARN_ON() for
>>  a circumstance which can easily be triggered.
>>
>> Thanks,
>> NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXx4DAAAoJEDnsnt1WYoG5vmcQAJ268DBmwkXjZxKLhSA3LkEl
44vpuk+p7BF+4dc5epK4bCxPztolFwPkOH4GPbgYIUq5/8joiLzKd1vInUdEncQK
Ke82JSp66X8Hjyrjq0OpWPTfDz2RPEgA7biII1gLGtCVR5OhHAW2y+4jRbzKn8wh
xH96/Dh65tMJDk4K50qnNyOpPeSfRMDbiWG0DcwzLzswlHmWqaSg685m9nR8PfMN
zNeMc09fTWuCUDKZ1gEEryIqpuCGB+/BlcxuFnTrSyP1u7vZamZnSNfR8zLOM5jJ
OCg+JaEkeTMzj1Pks4VOUvTydpK0ZEInX6jNw15dn4TlinBShA+gX9M3tjgCFD/e
sIU9kWzB222VEQgvdL0RMz7/mX0yCZzL3XTtd3UpWY5Sfdtg11VbVDIAuK3RDHBZ
xiLH6rqxoJXwA042oXAuQlAJyHw7+oU/r4lzS87fJ5UJHpGtRDRS63ou1sJ3a525
m1lx5toQoXu9vp9QikZG9M2o1nj27airTITjfFbeh3+0681uP9ufOkw1opbIp8Td
Wr9cNB4Ubdr+dFkCqk16j6x1DWWXs7g8qmY/udi2mIJsYOmpwfgvU0uupuvgEXhu
ki9tbdt11HyzMm8Oux76Lp/0P0gEIw9Uii4PMuvxMhdUqrYv985IvccK68OkTsV/
rbM0L9n6TpkdrRvygE5w
=NjDM
-----END PGP SIGNATURE-----
--=-=-=--

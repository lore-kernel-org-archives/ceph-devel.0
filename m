Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068563;
	b=rqnQmi98heUH7xi31Xj0P0n711+NKU4saWhpkn3j/Ke9T6b8MfJ/Lv3VjhtxwvkSbMah
	 sEGey1fOoVxZPnFrIIe9KDvTYGah/+3Drv4R3nCz2aAWae2HtWzZHXwcZNONfjrgTVwdk
	 Lnk5j+McNzJO/QGnEW6LeQPAByjRMHgFg/RtATabScy/tW1RYgzVrrd+RxwB0dehVngR4
	 X32iVp5lXIX35+9M+dm3bOOMmb9WGr96XdfoaNMo6mCBDiKiobpqM3OmVW7jisslF193l
	 oIsAuI/lUCQO5AtMfsj+hpLcXPdgbIQvFBegwmeKE3RAhPR7rCIN0RKhejWFLz0qJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068563;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5h64b3lSE3ujigmsgpFzt/NTN80f5We4jkDpq2nIL/0=;
	b=4hNtLl5hEtL6MrLjKBi2QW507dGoBTDa06jSI5zXYNY36AVGwdCqbuk2gr0fy1vD52uq
	 BrJf50IzqQPquG2phno9XLXMUVYmxbqs1kRXrhQfK2wqWJK9tIwq2wo/0BV2y4CbYPNd6
	 4K5jdeWhLbBWl1nvrioi4A6COojXwwmIryhpsfV/YtVfzdi+P7Mk7XOm+ZDRXwRdrfDmf
	 39d9j9Eo27qQRe8SEP7+QdaBQCyKqQ6rxdAiU7lgtSE2G8EnZJRcPBEy170wEGkvKp9dA
	 srgdeXfk+40UnxqTY+4VnWhP0GNx/0i/bFZywOOS+twxxqDQBtiR+ZLU2/upkrHYgcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIWhfDWW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8986606A31A
	for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIWhfDWW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D541F01825
	for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 02:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793068562;
	bh=5h64b3lSE3ujigmsgpFzt/NTN80f5We4jkDpq2nIL/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EIWhfDWWQCqKAkE9sdDGCSVgao99ZXhe6HteBPj/JIhmjLXP/YEBs9SbEWZS89GrT
	 moXXAD1bC8Eyv7iGUmTIm0wT9aMyPHcMQt/OQM9V5bKBaasScL3VFSKFFMf379Y0WJ
	 +0e7tux3dnuXldoKNAbmTWZ8Mo2RVClJLoivvEKSOl2j9kB2TXYlJ5U/Qr2YWMWknl
	 YEblS5eW9sCWdRmcydfx3dU89fn/wMTq3FRbazwSp8rnEM2sKBOJ/1Ei1W3fFxEzKb
	 LvBSgi390YdxvDmm72D8mxdmYsQAOuJFyxt3yuaWFBBfk450ua87SPLMRXD+39OMGV
	 ryJUUdGOjbKaQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso392285e87.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2026 19:36:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcox7li+LNidHrgrMvok3ZxNDWleaB3XiOwkdickRnzYvh8Ng1OspcIXdZbEeQHaUVNtDG1rm0cpY2@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5CDbEE9N4P5PQVBS1dccfwKIaU9uaSrnFnh9+96/bMUXyZV+c
	Mvq0z76H7+TzlLbV7oWinLX7dSjADa/i7vYZdzDx/V37RHy3PkawDORy19gtoZMLLd9cIQuHKzo
	JdoSB9GVFxR4Gm/19C4iQf66J4BfBp0E=
X-Received: by 2002:a05:6512:61b1:b0:5bf:c17e:a642 with SMTP id
 2adb3069b0e04-5bfc60f2b45mr401062e87.1.1793068561417; Mon, 26 Oct 2026
 19:36:01 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com> <CAJ4mKGYnN8eya1z=1a4VzJ2z=s9kRMz058dM10LeY7QpMWiPxw@mail.gmail.com>
In-Reply-To: <CAJ4mKGYnN8eya1z=1a4VzJ2z=s9kRMz058dM10LeY7QpMWiPxw@mail.gmail.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 27 Oct 2026 03:35:50 +0100
X-Gmail-Original-Message-ID: <CAOuZWzw3vL0wt+ymRrb+jU4TENQpCdoELjM16YcosFVuxTWzUQ@mail.gmail.com>
X-Gm-Features: AclHuK8jgFQYTEr-seugc-2kCtXBtdUXYU553_q481tzXnAas7Xh-d3Ny6I5iu0
Message-ID: <CAOuZWzw3vL0wt+ymRrb+jU4TENQpCdoELjM16YcosFVuxTWzUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ceph: fix lazyio for shared-file writers
To: Gregory Farnum <gfarnum@redhat.com>
Cc: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Dan van der Ster <dan.vanderster@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 11:34 PM Gregory Farnum <gfarnum@redhat.com> wrote:
> Is it appropriate to try and get lazyio to work for the IO500 test?
> [...]
> Is there any utility to these besides the IO500 hero run?

Hi Greg,

Good questions.

This series is not lazyio tuned for IO500.  We found these bugs while
running IO500 for performance and testing lazyio functionally, and the
patches came out of that.  The bug it fixes is a general one: with
lazyio, a client that writes part of a page writes the whole page
back, and the bytes around its own write (read before the write, or
zeros beyond its local EOF) overwrite whatever another client wrote to
the same page.

Lazy I/O allows stale reads and late visibility until the application
synchronizes.  It does not allow a client to write bytes it never
wrote.  No synchronization in the application can prevent this,
because the application cannot see page boundaries: two clients
writing disjoint, non-page-aligned ranges of one file clobber each
other even with an fsync and a barrier after every write.

Any N-to-1 workload that writes a shared file at disjoint offsets hits
it, e.g. MPI-IO, HDF5 or checkpointing, where record sizes come from
the application and are rarely page multiples.  ior-hard is simply a
convenient reproducer: its 47008-byte records put a boundary in almost
every shared page.

We tested lazyio semantics and the cap protocol well beyond IO500:
truncates that cut into or drop a lazy dirty range, a session that goes
stale while holding dirty lazy pages, cap revokes with lazy writers
active, and non-lazy writeback, which takes the same paths as before.
We ran IO500 to make sure the series costs no performance, with its
read-back check as one more correctness test.

The cap patches (1, 2, 4, 5) fix a revoke hang and redundant cap
traffic that any lazyio user can hit.

Thanks,
Xiubo

Gregory Farnum <gfarnum@redhat.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=80 23:34=E5=86=99=E9=81=93=EF=BC=9A
>
> [ Dropped linux-kernel for this email ]
>
> On Wed, Oct 21, 2026 at 5:00=E2=80=AFAM Xiubo Li via B4 Relay
> <devnull+xiubo.li.clyso.com@kernel.org> wrote:
> >
> > The lazyio mount option lets several clients buffer and cache writes to
> > one shared file.  With it, the io500 ior-hard phase fails its read
> > verification and the whole run is marked invalid.  ior-hard has every
> > process write 47008-byte records (11 pages plus 2112 bytes) into one
> > shared file, interleaved with the records of the other processes, so
> > the record boundaries fall inside pages that two clients share.  A
> > client writes such a page back whole, and the bytes around its own
> > record, read before the write or zero-filled beyond its local EOF,
> > overwrite the records another client wrote into the same page.  In the
> > tests below each client is a separate kernel client mount.
> >
> > Patch 3 is the fix: a page that a lazy I/O write dirtied only in part
> > keeps its dirty byte range, and writeback sends only that range.  A
> > write without lazy I/O starts no range, so non-lazy writeback is
> > unchanged and sends whole pages as before.
>
> I don't have any particular opinion on individual code changes here,
> but I do have a question:
>
> Is it appropriate to try and get lazyio to work for the IO500 test?
> The whole premise of lazy IO is that we turn off Ceph's consistency
> mechanisms and the application promises to do things correctly and
> manage caches on its own. The docs for userspace lazio talk about
> specific synchronization primitives you need to invoke:
> https://docs.ceph.com/en/latest/cephfs/lazyio/
> I presume that the IO 500 test *doesn't* do any of that, so is it
> plausible to make this work? Is there any utility to these besides the
> IO500 hero run?
> -Greg
>
> >
> > Patches 1, 2 and 4 fix cap handling problems found while testing it:
> >
> >  - Patch 1: ceph_check_caps() could put off invalidating a cache whose
> >    CACHE or LAZYIO was being revoked while the session's cap was stale,
> >    and nothing checked it again.  The MDS then waited for the revoke
> >    for good.  A lazy writer on a slow client (arm64, 64K pages, under
> >    QEMU) hung that way after shared-file writes.
> >
> >  - Patches 2 and 4: a lazy I/O open no longer asks for LAZYIO while
> >    CACHE (for a reader) or BUFFER (for a writer) is available, and asks
> >    for it only once the MDS turns those down.  This saves a cap update
> >    and a grant per lazy open of a cached inode, and the LAZYIO revoke
> >    when the only client of a file opened for writing becomes its loner.
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > One host, 3 OSDs on NVMe, 3 active MDS with a distributed tree pin on
> > the mdtest directories, 4 kernel client mounts, 16 io500 processes
> > (4 per client), io500 with all phases unless noted.
> >
> > Data verification, lazyio mount option:
> >
> > +-------------------------------+------------------+------------------+
> > | Test                          | Without series   | With series      |
> > +-------------------------------+------------------+------------------+
> > | ior-hard only, bad records    | 131881           | 0 (3 runs)       |
> > | Full io500, bad records       | 142876, 73999    | 0 (10 runs)      |
> > | Full io500 result             | invalid          | valid            |
> > +-------------------------------+------------------+------------------+
> >
> > Full io500, unpatched kernel without lazyio vs this series with
> > lazyio (2 runs each):
> >
> > +---------------------------+-----------------+-----------------+-----+
> > | Phase / score             | Unpatched       | Series + lazyio | Diff|
> > +---------------------------+-----------------+-----------------+-----+
> > | ior-hard-write (GiB/s)    | 0.193 / 0.192   | 0.267 / 0.272   | +40%|
> > | ior-hard-read (GiB/s)     | 0.459 / 0.457   | 0.460 / 0.458   | +1% |
> > | BW score                  | 0.914 / 0.908   | 0.982 / 0.980   | +8% |
> > | MD score                  | 27.30 / 26.36   | 27.45 / 27.53   | +3% |
> > | TOTAL                     | 4.994 / 4.893   | 5.192 / 5.193   | +5% |
> > +---------------------------+-----------------+-----------------+-----+
> >
> > Without the lazyio mount option the series changes nothing measurable:
> > full io500 TOTAL 4.932 / 4.929 unpatched vs 4.935 / 4.910 with patches
> > 1-3 (patch 4 only changes lazy I/O opens).  A non-lazy fio sub-page
> > overwrite test was within the run-to-run spread (about +-4%).
> >
> > arm64 with 64K pages (QEMU guest): fsx, overwrites checked from a
> > second mount, and lazy writes of 47008-byte and 3000-byte records from
> > 4 mounts all pass, with 0 bad words, in crc, legacy and secure
> > messenger modes.
> >
> > Known issues, not addressed here
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  - mdtest's read phase opens files read-write.  With lazyio that still
> >    costs about one LAZYIO revoke per file in io500 mdtest-hard-read
> >    (2.5-2.7M per run, against a few dozen without lazyio); patch 4
> >    removes it only in a smaller reproducer.  Opening the files read-onl=
y
> >    in mdtest removes the revokes in both modes.
> >
> >  - A lazy read that starts about a second after a lazy write of the
> >    same file can hang in __ceph_get_caps(): a LAZYIO revoke is held bac=
k
> >    while the cap is in use, and nothing calls ceph_check_caps() again
> >    once the use ends.  Full io500 runs, which have other phases between
> >    ior-hard-write and ior-hard-read, have not hit it.
> >
> > Xiubo Li (4):
> >   ceph: invalidate a revoked cache even while its cap is stale
> >   ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
> >   ceph: write back only the dirty bytes of a lazy I/O write
> >   ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
> >
> >  fs/ceph/addr.c       | 360 ++++++++++++++++++++++++++++++++++++++-----
> >  fs/ceph/caps.c       |  44 +++++-
> >  fs/ceph/file.c       |   4 +
> >  fs/ceph/mds_client.c |  10 ++
> >  fs/ceph/super.h      |   1 +
> >  5 files changed, 381 insertions(+), 38 deletions(-)
> >
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> > Changes in v2:
> > - Patch 3: when a truncate clips a lazy dirty range to nothing, or EOF
> >   moves below the range, drop the folio's dirty state instead of writin=
g
> >   the whole folio up to EOF, which sent the stale bytes in front of the
> >   range.  Fixed in ceph_invalidate_folio(), ceph_check_folio_before_wri=
te()
> >   and write_folio_nounlock().  The new ceph_folio_drop_dirty() also
> >   decrements mdsc->dirty_folios. (Alex)
> > - Link to v1: https://patch.msgid.link/20261020-b4-wip-ceph-lazyio-fix-=
v1-0-f4cc62459d37@clyso.com
> >
> > ---
> > Xiubo Li (5):
> >       ceph: invalidate a revoked cache even while its cap is stale
> >       ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
> >       ceph: write back only the dirty bytes of a lazy I/O write
> >       ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
> >       ceph: keep LAZYIO with the read caps of a closed file
> >
> >  fs/ceph/addr.c       | 391 +++++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  fs/ceph/caps.c       |  51 ++++++-
> >  fs/ceph/file.c       |   4 +
> >  fs/ceph/mds_client.c |  10 ++
> >  fs/ceph/super.h      |   1 +
> >  5 files changed, 417 insertions(+), 40 deletions(-)
> > ---
> > base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
> > change-id: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc
> >
> > Best regards,
> > --
> > Xiubo Li <xiubo.li@clyso.com>
> >
> >
> >
>
>

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793116800;
	b=iTfVrrFYPbT4aCQEA/gBmJMTcATpRH2YOOQNJru/9jRltJFsbcYHani1Ab5RTzT9NgRL
	 rQatRNPY04lngXvjqK6wFEM7z01sP5S15udppfcvNg/d1UhWln0rdsLfpQhsVwr7UtqJ6
	 Oa1BZRRU3ecN2L46JQGpr0HN2XckqHW6X2fXggc7t7LBJJZwWBxDz/12CrX7he1PHNxT3
	 wesUgOJ0ag+0KXzoW84jGzkCVe/iwJL9m+Xw3ogvSO0zopXusMx1LJf6U7wll0TQXoDb8
	 Giqna0DrXaoIHcPdTP5+FNxDT81140g+hyYYMqy3og4RTEpYCxW+hDir5oq9zhEnUDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116800;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=W+uhoxoemiTAukHloeObi2pl7ogzpkBIOHio071I4PQ=;
	b=kp0CQjhDXSDhcNx6WQJacnD97wCU+EQ6os4I29dGL9kJrD7vj4vGZEzTP7mPKwv90ioX
	 2TZS0z4wekXpL6vkCOIiplzFwq5ADZWpWVF1ILAyheURwLjo1+kdKIgbym0rwahBK8nUY
	 sdp9uvn/zfptlI6qQ691r5Ty/tePYl74UILtXjSbGEWKVYjbfl87RtFaDOyEfrRulF224
	 MZUR1SR/pKCMzuowGBXAbY4pexVCjFWJt9oqJfBL+lzP5Rnfm14+gqK9jBIF2gKktZQet
	 CS7R40yldSslRZYpcK6cZv2WlNgvgjc5s24f4gN05+LaDCqdjCLWoNiTCXpUJb4ag9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aOrEiYUJ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NUdvAGJb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E9606A31A
	for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 15:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aOrEiYUJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NUdvAGJb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793116798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+uhoxoemiTAukHloeObi2pl7ogzpkBIOHio071I4PQ=;
	b=aOrEiYUJNgTY1aKcbyUrkGMCKq7HGkW6kxmkD4mhAA7pGnbtgEksPP6R07Kyw3ibCut6N2
	7eujEpG41qs6D+tdGfRYkTHWvFCLVfazjeB8icEDbkSPaq0HcoD6GIsvTXdGKiJNh3KD8p
	hTR2iKrph1PrGuD0c2RwsX7aWzZvWqU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-g8MrXCx6Oravs8BKNPV46w-1; Tue, 27 Oct 2026 11:59:57 -0400
X-MC-Unique: g8MrXCx6Oravs8BKNPV46w-1
X-Mimecast-MFC-AGG-ID: g8MrXCx6Oravs8BKNPV46w_1793116796
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c41f85ee4a3so399582866b.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 08:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793116796; cv=none;
        d=google.com; s=arc-20260327;
        b=R+aH6dmfXlREB3izPihxGpOZr0iwW6ZcqvTO6P6XOJyNXFvot+NxYBojltRVMDNOiY
         o4rzqOcGTzPlAY3I7bgWgrHc8SNLic00wpQ1khEoPRyTCO6Ymi9rL5hWwvXYukB8Uycq
         8MtGRiZ1Y8Z5/Dc4BgQ1jUmQtl6KYZWTImzSCT0WvkZQJNjWOUDVi/fXd/QR3xeiA6nm
         qxyP53GJIUIO8h2rw38oHfIf1wJQJW/dWkIUN+o2DE7uH00sFRsBjEpOHd9QE86MmEUY
         icmk+TEWyShmFNUpN3XAE9GMzd8fz2oYc0b73d00NRAaYimXMsMFqnrGOGykwk2Pms5A
         tBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W+uhoxoemiTAukHloeObi2pl7ogzpkBIOHio071I4PQ=;
        fh=IMJr9Ic3y4f3hJqTe8HdeRhOhX+aSzuHoL8Zu9mfgec=;
        b=dl5TBE+SUPNDO09ufQPzinhSo/dMM5BEoWzociwYuiFjKtn596Ync1vHJDd0dtOswN
         GNmT54MrQv0EreDeTUYUOd3p/LundSR30h+gCqP04ibtZhYDPBeW18iOx35oAeBa7MSV
         W+rKZnpiEwObvesf+tfkB2pNZtGCQMSAjxWNOWhCByesp8d9bT1AGxuh7dsqdsrv6VTl
         2wptnD+TkoZjA6lRXlm52sL33PIsBXT/x7GwcITRCi1yyw+HqIdZ5n1VVA0em9Ej5aAj
         /bG/8E+3wQipNOJZKGVmx21TMic2WYGL3bd+baBg6xCwhW2n4og6fi5//OCNeAfgp0gB
         y2dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793116796; x=1793721596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+uhoxoemiTAukHloeObi2pl7ogzpkBIOHio071I4PQ=;
        b=NUdvAGJbOhS38po2kNtvhfkGIjdLr8uiYOLdQJvZmgY/VJAc2x8WcjqLADvuXtFACt
         /TSnhB2qTh3Xe6m12A9OIJu2SQEp1wiA9myBmvGPCuiDJUhZrH0mJxL7qjc0rqZoP7C/
         mzXNNKWIOjDNL5qcMhreUSqx98FhtXycwv7kCQ82LNBA0ttlmhacy4MSWfULXrOk3ofl
         bkMVNRWLiQQDC1V4oFcR5rJvJ5thiyBBzPq4MY3H6J1PKoAlrq9behdJpvQTrwINq8HL
         qw1vuk+/LLBJaVbYF7WLhLFWbi0c+W0jXMGAky+bV7potmGL4b1a2flcoHL3GFCzb096
         f7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116796; x=1793721596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+uhoxoemiTAukHloeObi2pl7ogzpkBIOHio071I4PQ=;
        b=lpN0faam/Psf/o3Yn8w+bvE4BIOjbAaQQ0dyDB15+cUj5q1hFjR5rQRR8TXhbs6qNR
         ojp06Pc+DTaSopX5QpE/G49TGg3TFM1YkPxcVefzjfaJIITW5DPScReMNqnn9/eTqP2g
         SEnCyMrNcIoU7/f8ZE3GiiT2j4LkKQ8VqX/XvsV+6HULxz/qLWBhKn34wpsd9x4cyIv1
         p/+WFY6A2KC/2KTVW+tUyhuKxnccHE44B13grn/LWKr9tHIQLIfg5EHGHCzFqspezSWb
         qNEYyNZECVSS5n563BlQiz9sbfo3ahC+hzn+rfXFoFogulG/Ba08a8BQUR6iMQeCHN2c
         UGHg==
X-Forwarded-Encrypted: i=1; AKwUvBx2WohrMnG47/2jJdLSSw81YKcbIssrZOsrsb696V/qWVuuEt7lXRiAUTMn6mqzKDyQB+tyv6nq/lVn@vger.kernel.org
X-Gm-Message-State: AFq9FYKAWVK0JwsujA60cv5rphw254+bZfBvOGXxU/iuqaHkmUo9bYTj
	R2Aee8IvAMaS5O3FSp6atWWrY1xLxDU0mxLJUOWNLMJDWQysXVdQHw7Yezetfuzlkts9iAEyQKj
	qCtE7qQgd87dLqtc1r4cf498z/ocM/4n9EwGZBtC/xCz0dwa1y2rzdrlYjdVMy6uBr+TrSRwDln
	GVRYuq0WruVs6QNvfQiRArh0dPrdCW4n8BwiAiFA==
X-Gm-Gg: AYBFou0KWswtVHZFOc2pURQ+lQCpOvJ7QUdazbOvIEV6Stg3nYntanTqg1VotrJuOjO
	IzCGXa0dCtLXfWiEiiVOpq6JVoxChzWNQdcF8qUbUnl33J46RBUts6PUTmBdrGa2tRiMVsunGDo
	/NC4ONvFtAwz/yV4YWiGova72/8bAqKnVWTA8NCKEZDkCJP1caDwXw2rbn9LmrAqvt+lW4WvSij
	+I=
X-Received: by 2002:a17:907:944b:b0:c42:2f4e:522c with SMTP id a640c23a62f3a-c46bde1abedmr1107688166b.22.1793116795488;
        Tue, 27 Oct 2026 08:59:55 -0700 (PDT)
X-Received: by 2002:a17:907:944b:b0:c42:2f4e:522c with SMTP id
 a640c23a62f3a-c46bde1abedmr1107684866b.22.1793116794810; Tue, 27 Oct 2026
 08:59:54 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
 <CAJ4mKGYnN8eya1z=1a4VzJ2z=s9kRMz058dM10LeY7QpMWiPxw@mail.gmail.com> <CAOuZWzw3vL0wt+ymRrb+jU4TENQpCdoELjM16YcosFVuxTWzUQ@mail.gmail.com>
In-Reply-To: <CAOuZWzw3vL0wt+ymRrb+jU4TENQpCdoELjM16YcosFVuxTWzUQ@mail.gmail.com>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Tue, 27 Oct 2026 08:59:42 -0700
X-Gm-Features: AclHuK_sEyjemYEv1AC2D5zp0MCdPtchS-QFbYbDMd2r2HoZdfjxwg25_TouD4c
Message-ID: <CAJ4mKGaXrdBCycBubwpOUkRh7q=wyDvYt4x90+41DX+1Jqy1DQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ceph: fix lazyio for shared-file writers
To: Xiubo Li <xiubli@kernel.org>
Cc: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Dan van der Ster <dan.vanderster@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 7:36=E2=80=AFPM Xiubo Li <xiubli@kernel.org> wrote:
>
> On Mon, Oct 26, 2026 at 11:34 PM Gregory Farnum <gfarnum@redhat.com> wrot=
e:
> > Is it appropriate to try and get lazyio to work for the IO500 test?
> > [...]
> > Is there any utility to these besides the IO500 hero run?
>
> Hi Greg,
>
> Good questions.
>
> This series is not lazyio tuned for IO500.  We found these bugs while
> running IO500 for performance and testing lazyio functionally, and the
> patches came out of that.  The bug it fixes is a general one: with
> lazyio, a client that writes part of a page writes the whole page
> back, and the bytes around its own write (read before the write, or
> zeros beyond its local EOF) overwrite whatever another client wrote to
> the same page.
>
> Lazy I/O allows stale reads and late visibility until the application
> synchronizes.  It does not allow a client to write bytes it never
> wrote.  No synchronization in the application can prevent this,
> because the application cannot see page boundaries: two clients
> writing disjoint, non-page-aligned ranges of one file clobber each
> other even with an fsync and a barrier after every write.
>
> Any N-to-1 workload that writes a shared file at disjoint offsets hits
> it, e.g. MPI-IO, HDF5 or checkpointing, where record sizes come from
> the application and are rarely page multiples.  ior-hard is simply a
> convenient reproducer: its 47008-byte records put a boundary in almost
> every shared page.
>
> We tested lazyio semantics and the cap protocol well beyond IO500:
> truncates that cut into or drop a lazy dirty range, a session that goes
> stale while holding dirty lazy pages, cap revokes with lazy writers
> active, and non-lazy writeback, which takes the same paths as before.
> We ran IO500 to make sure the series costs no performance, with its
> read-back check as one more correctness test.
>
> The cap patches (1, 2, 4, 5) fix a revoke hang and redundant cap
> traffic that any lazyio user can hit.

Okay, thanks, Xiubo. :)
-Greg

>
> Thanks,
> Xiubo
>
> Gregory Farnum <gfarnum@redhat.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=B8=80 23:34=E5=86=99=E9=81=93=EF=BC=9A
> >
> > [ Dropped linux-kernel for this email ]
> >
> > On Wed, Oct 21, 2026 at 5:00=E2=80=AFAM Xiubo Li via B4 Relay
> > <devnull+xiubo.li.clyso.com@kernel.org> wrote:
> > >
> > > The lazyio mount option lets several clients buffer and cache writes =
to
> > > one shared file.  With it, the io500 ior-hard phase fails its read
> > > verification and the whole run is marked invalid.  ior-hard has every
> > > process write 47008-byte records (11 pages plus 2112 bytes) into one
> > > shared file, interleaved with the records of the other processes, so
> > > the record boundaries fall inside pages that two clients share.  A
> > > client writes such a page back whole, and the bytes around its own
> > > record, read before the write or zero-filled beyond its local EOF,
> > > overwrite the records another client wrote into the same page.  In th=
e
> > > tests below each client is a separate kernel client mount.
> > >
> > > Patch 3 is the fix: a page that a lazy I/O write dirtied only in part
> > > keeps its dirty byte range, and writeback sends only that range.  A
> > > write without lazy I/O starts no range, so non-lazy writeback is
> > > unchanged and sends whole pages as before.
> >
> > I don't have any particular opinion on individual code changes here,
> > but I do have a question:
> >
> > Is it appropriate to try and get lazyio to work for the IO500 test?
> > The whole premise of lazy IO is that we turn off Ceph's consistency
> > mechanisms and the application promises to do things correctly and
> > manage caches on its own. The docs for userspace lazio talk about
> > specific synchronization primitives you need to invoke:
> > https://docs.ceph.com/en/latest/cephfs/lazyio/
> > I presume that the IO 500 test *doesn't* do any of that, so is it
> > plausible to make this work? Is there any utility to these besides the
> > IO500 hero run?
> > -Greg
> >
> > >
> > > Patches 1, 2 and 4 fix cap handling problems found while testing it:
> > >
> > >  - Patch 1: ceph_check_caps() could put off invalidating a cache whos=
e
> > >    CACHE or LAZYIO was being revoked while the session's cap was stal=
e,
> > >    and nothing checked it again.  The MDS then waited for the revoke
> > >    for good.  A lazy writer on a slow client (arm64, 64K pages, under
> > >    QEMU) hung that way after shared-file writes.
> > >
> > >  - Patches 2 and 4: a lazy I/O open no longer asks for LAZYIO while
> > >    CACHE (for a reader) or BUFFER (for a writer) is available, and as=
ks
> > >    for it only once the MDS turns those down.  This saves a cap updat=
e
> > >    and a grant per lazy open of a cached inode, and the LAZYIO revoke
> > >    when the only client of a file opened for writing becomes its lone=
r.
> > >
> > > Testing
> > > =3D=3D=3D=3D=3D=3D=3D
> > >
> > > One host, 3 OSDs on NVMe, 3 active MDS with a distributed tree pin on
> > > the mdtest directories, 4 kernel client mounts, 16 io500 processes
> > > (4 per client), io500 with all phases unless noted.
> > >
> > > Data verification, lazyio mount option:
> > >
> > > +-------------------------------+------------------+-----------------=
-+
> > > | Test                          | Without series   | With series     =
 |
> > > +-------------------------------+------------------+-----------------=
-+
> > > | ior-hard only, bad records    | 131881           | 0 (3 runs)      =
 |
> > > | Full io500, bad records       | 142876, 73999    | 0 (10 runs)     =
 |
> > > | Full io500 result             | invalid          | valid           =
 |
> > > +-------------------------------+------------------+-----------------=
-+
> > >
> > > Full io500, unpatched kernel without lazyio vs this series with
> > > lazyio (2 runs each):
> > >
> > > +---------------------------+-----------------+-----------------+----=
-+
> > > | Phase / score             | Unpatched       | Series + lazyio | Dif=
f|
> > > +---------------------------+-----------------+-----------------+----=
-+
> > > | ior-hard-write (GiB/s)    | 0.193 / 0.192   | 0.267 / 0.272   | +40=
%|
> > > | ior-hard-read (GiB/s)     | 0.459 / 0.457   | 0.460 / 0.458   | +1%=
 |
> > > | BW score                  | 0.914 / 0.908   | 0.982 / 0.980   | +8%=
 |
> > > | MD score                  | 27.30 / 26.36   | 27.45 / 27.53   | +3%=
 |
> > > | TOTAL                     | 4.994 / 4.893   | 5.192 / 5.193   | +5%=
 |
> > > +---------------------------+-----------------+-----------------+----=
-+
> > >
> > > Without the lazyio mount option the series changes nothing measurable=
:
> > > full io500 TOTAL 4.932 / 4.929 unpatched vs 4.935 / 4.910 with patche=
s
> > > 1-3 (patch 4 only changes lazy I/O opens).  A non-lazy fio sub-page
> > > overwrite test was within the run-to-run spread (about +-4%).
> > >
> > > arm64 with 64K pages (QEMU guest): fsx, overwrites checked from a
> > > second mount, and lazy writes of 47008-byte and 3000-byte records fro=
m
> > > 4 mounts all pass, with 0 bad words, in crc, legacy and secure
> > > messenger modes.
> > >
> > > Known issues, not addressed here
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >  - mdtest's read phase opens files read-write.  With lazyio that stil=
l
> > >    costs about one LAZYIO revoke per file in io500 mdtest-hard-read
> > >    (2.5-2.7M per run, against a few dozen without lazyio); patch 4
> > >    removes it only in a smaller reproducer.  Opening the files read-o=
nly
> > >    in mdtest removes the revokes in both modes.
> > >
> > >  - A lazy read that starts about a second after a lazy write of the
> > >    same file can hang in __ceph_get_caps(): a LAZYIO revoke is held b=
ack
> > >    while the cap is in use, and nothing calls ceph_check_caps() again
> > >    once the use ends.  Full io500 runs, which have other phases betwe=
en
> > >    ior-hard-write and ior-hard-read, have not hit it.
> > >
> > > Xiubo Li (4):
> > >   ceph: invalidate a revoked cache even while its cap is stale
> > >   ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
> > >   ceph: write back only the dirty bytes of a lazy I/O write
> > >   ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
> > >
> > >  fs/ceph/addr.c       | 360 ++++++++++++++++++++++++++++++++++++++---=
--
> > >  fs/ceph/caps.c       |  44 +++++-
> > >  fs/ceph/file.c       |   4 +
> > >  fs/ceph/mds_client.c |  10 ++
> > >  fs/ceph/super.h      |   1 +
> > >  5 files changed, 381 insertions(+), 38 deletions(-)
> > >
> > > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > > ---
> > > Changes in v2:
> > > - Patch 3: when a truncate clips a lazy dirty range to nothing, or EO=
F
> > >   moves below the range, drop the folio's dirty state instead of writ=
ing
> > >   the whole folio up to EOF, which sent the stale bytes in front of t=
he
> > >   range.  Fixed in ceph_invalidate_folio(), ceph_check_folio_before_w=
rite()
> > >   and write_folio_nounlock().  The new ceph_folio_drop_dirty() also
> > >   decrements mdsc->dirty_folios. (Alex)
> > > - Link to v1: https://patch.msgid.link/20261020-b4-wip-ceph-lazyio-fi=
x-v1-0-f4cc62459d37@clyso.com
> > >
> > > ---
> > > Xiubo Li (5):
> > >       ceph: invalidate a revoked cache even while its cap is stale
> > >       ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
> > >       ceph: write back only the dirty bytes of a lazy I/O write
> > >       ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER do=
wn
> > >       ceph: keep LAZYIO with the read caps of a closed file
> > >
> > >  fs/ceph/addr.c       | 391 +++++++++++++++++++++++++++++++++++++++++=
+++++-----
> > >  fs/ceph/caps.c       |  51 ++++++-
> > >  fs/ceph/file.c       |   4 +
> > >  fs/ceph/mds_client.c |  10 ++
> > >  fs/ceph/super.h      |   1 +
> > >  5 files changed, 417 insertions(+), 40 deletions(-)
> > > ---
> > > base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
> > > change-id: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc
> > >
> > > Best regards,
> > > --
> > > Xiubo Li <xiubo.li@clyso.com>
> > >
> > >
> > >
> >
> >
>


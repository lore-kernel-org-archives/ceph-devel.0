Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793053923;
	b=Qew9MRzcLtI+GwcCbsYEhdwGE3bP+/zZ8e9+Cj14KglX0Xkz0UrHjdNdMIauIZaqBp5X
	 LZVWXtKryq1XNpIEA1bNqfWiLRTQV+a6mzWVSLsiUeyZH3Cw+0bLP5SyxMeTqdaMemcp2
	 ApguHpk3VKsPiicKqujvV1Kr+H1cau+nAHzQqHtgCw6kNd2/mAy3K86SYJu2Xfa6pHj98
	 RXYR7bjZg5XQFuQURV+tgWOWIhrVVhVIDsihcPJrgpCk20hZsvHpjh8ZuADK8+tlhOZWv
	 ny3I6AVp/frVcWPKy6oLsqeIqCeCrZeaSRgQqNrKEsKqIua12wzd2QCKmqtN/uD09ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053923;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=+hn/BtKaroY0rjluspQRY9mUcGTga1K0HoUE8pMcnLg=;
	b=i1cuWUkDAlPg2sZxdaRYwlKRyIz9VfUBni/ZjmHkvhrq0LDenv/KsJILNNkl6Qa2Wlbh
	 jbtRuSL/1uoBJndfg8jglSJgNFk0bgSnK6sOLhQDeq9IurCdbT7xWfAOXq42GsMyTR/AC
	 Jb11PpH8GX0sNve7d3g7c7m8+Ryp1z+ikk/KV3mynht5ta8+1aL2v8fKvkwPzTBTAjeNu
	 ms7VIdQpltcghfsl/WWgp1xxxITKuX5TghU5s2Ob12KW79FHx+5RIiBwuUiAdMa9ko1XV
	 MHM+GLw4mBn5vAFW7hAx/RUmaoTgnipnjgI34R6/77vEnZxxyCzvMoUIO8wi92ELBVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fy1O9+vX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hbrLwaly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95F606A31A
	for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2026 22:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F95F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fy1O9+vX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hbrLwaly
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793053921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hn/BtKaroY0rjluspQRY9mUcGTga1K0HoUE8pMcnLg=;
	b=fy1O9+vXpgUXxvOUDMFr6y4zDdgEz0lQd7/q1/Gq0DMTIvcDDaVCLM4WXfll+2aRZM6/uX
	+ybuTLV3T/ie+CNwI/62JyDHO+36b8up/k2yN9nPFcY1kz9wKFo06Xri4mkbMb9tjsHbSc
	Dw8FlWQDv2UX8XRf6Elw/lVri8Z7deI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-7Oc0669_Ng2l5Yi9pHELpQ-1; Mon, 26 Oct 2026 18:31:59 -0400
X-MC-Unique: 7Oc0669_Ng2l5Yi9pHELpQ-1
X-Mimecast-MFC-AGG-ID: 7Oc0669_Ng2l5Yi9pHELpQ_1793053919
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so4271678a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2026 15:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053918; cv=none;
        d=google.com; s=arc-20260327;
        b=oBpSjyZpq+IkPksg0hwXiClS/wLF6+x6cLvSzdrg4o3rFDoH3jNP59mDNWMyZ9OgXA
         UdZhyQgdWIAnk2eGtj3baoaFtHvHuyv1b76KLp1Y1scYdrj5goV2BGm3ph61ABAJinmg
         HBM2MWwTUcFbiu47wwhYyWYNBiKpRYDZ26wrKgWNQX5tV2jn26PsEv/r+vVg9bk79bD1
         5h3kVxw7gzvYtKqf/xxU0c+KgSm2gUFm1soFB5QIczlBSAsEtUU5qFB7vFwwPDSAdAKo
         u/OECwGNPH8m5+6BWAHbGZ9wugDCOQVc7Xmq3Q6gu6KC38e2rKsh3kQAiJhBzWihLuSa
         taig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+hn/BtKaroY0rjluspQRY9mUcGTga1K0HoUE8pMcnLg=;
        fh=wlTdckbRsc5Fk0CIL3C5nF7yxCJhK0Y6HS4S7YzUDX8=;
        b=r2xKTZlGbsvtdRKN6bLBW49Rzh4e9ynBFRqYE0SugXrdA/dv0nT/XcsbsIKt3MW5Ll
         O7M7pLJJj3Xvs2RDwKkDeUNhKydX3ym+0mfLqIBC7mgz6TWTK5G3B+9/11ixH/Kx7oqM
         J+fj4R89lwrGrKhKRnF6zxlJ0FjLtBWocmEjBk8UHFBwtgY0UvHscvjWVSIxt5eyfw6N
         sBrjZ4P5tn1Z5PhUl0JLlSxTTkRcP+sOjzTIF2m2aYOT5f+oWRKND2viw1RqnjQtVqcZ
         QNucAY133HLak7mgluigO62I+PgUfu796R61QWGSvfe9OoNOqcm6sXjvmapZ+1E6H8Y1
         FUNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793053918; x=1793658718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hn/BtKaroY0rjluspQRY9mUcGTga1K0HoUE8pMcnLg=;
        b=hbrLwaly2nvb4HSMhlVMyfuniGbb+6POWFjwQ4h8jTvlF/tm1dZCJIwxgMMt0P6OFT
         hNurL03464puw0BBzkFAKrP1lA+KfE6bYvRONBng+Lw9cgC0Skuv87YRs6h7qLNKr0DH
         0+y3fguZPiXPaFcFsvaH7IdraNH3q0qIOyUpR2SZwEpHAXlJXc/1hAVqMSQTXD9TD0XZ
         lteQViRmE0NWXR4DS4r+nUZsgasAErPLzX2ym+naK+D9XDLe+nMO//d66BBblIMz84O4
         zaQj+9bQXTHIUAqC40qOh691scHu/ScTsSTJFjbkj0gJwIDOPkjbgZWY4wYx/YYQopTq
         WE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053918; x=1793658718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hn/BtKaroY0rjluspQRY9mUcGTga1K0HoUE8pMcnLg=;
        b=cQetTJIRglxW3mv4Yjm98yRYqqOOhy23pfUv2On17IrA2qztYdZNqiqpIkWEVcIS3S
         hY0aE0zZDafjlTlwZu070V2JI99IDE1r8MSXQ6ETZCxcOZj1FXOvrCGmusuY9aXvgWag
         1nLIVDCSGpRYVRf/hlSzvNpNmbHnUJlnlLiEj5DGsmdpqVztBS3wiHcYabbHgTHRBnkY
         jP5PlnBGn7CqB3QI8kZfUEDbs6lzYXwp3/hF+rccPrVU8Z6AbyDl5NTbb7cSULJjNU39
         xaeYKe1UZ8XllsMbQZDgYGOq8DlreUrVYPZ9fWdFvp8iiQYM/suvQHAE+IgmoTsqxfXf
         iYsw==
X-Forwarded-Encrypted: i=1; AKwUvBz8YT8kpg6EwlH1PKyjJjSqFJt+paDKuUUSgsmrh78hATVUQyIf1QwRLFj7bVYA8UXTLHCAqNTI68gl@vger.kernel.org
X-Gm-Message-State: AFq9FYI9JsZM6erjF5A9LCDtImWsM84gyrFWZ72PmR3osvheoTquAQsB
	8gWPZgnj2GC1NKmneMr99w1Q1h8AoMBliCkyg8iCgb9aLexWs2gCWGSH2FDOrvN8fa9KwCUdCRV
	gc995rqAiwqRr+BYofNyqIG4oy4mEoFmSjyPkyMt7F/o1inWufOrDxZnQde7NfB04z6LkQObyZ/
	18Eooo4U4mIznUFaWIIENN1aCc6jhBb/p7fL96Rg==
X-Gm-Gg: AYBFou1lACkFr1WKpKnz48kX1G9TPIH+RErnpn22eQ0LJF4A2KAZaHXNea1dJhU63M2
	ClDOshA3QIgxTEthUoGGiZYtT1sSgyrxTjXRO7gKR8gMMXd1ztqjWN8sVoBbOkqYSZSUgFau52p
	Mp4T04L2cru+xiGAb9+Ji6y/V/RZ6lRHQNFzXQNQSjOKAO0kh717RYLTBJ9Hd11yTr3m0xOe9K5
	5w=
X-Received: by 2002:a17:906:c141:b0:c40:c6c8:6bd8 with SMTP id a640c23a62f3a-c46bde0a0e9mr952955366b.20.1793053918636;
        Mon, 26 Oct 2026 15:31:58 -0700 (PDT)
X-Received: by 2002:a17:906:c141:b0:c40:c6c8:6bd8 with SMTP id
 a640c23a62f3a-c46bde0a0e9mr952953666b.20.1793053918108; Mon, 26 Oct 2026
 15:31:58 -0700 (PDT)
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
In-Reply-To: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Mon, 26 Oct 2026 15:31:46 -0700
X-Gm-Features: AclHuK8UDPys699fzOh631Ki1SGmpWeXaCieksojNv11GRh-n3OSUhD88R0br9o
Message-ID: <CAJ4mKGYnN8eya1z=1a4VzJ2z=s9kRMz058dM10LeY7QpMWiPxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ceph: fix lazyio for shared-file writers
To: xiubo.li@clyso.com
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Dan van der Ster <dan.vanderster@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Dropped linux-kernel for this email ]

On Wed, Oct 21, 2026 at 5:00=E2=80=AFAM Xiubo Li via B4 Relay
<devnull+xiubo.li.clyso.com@kernel.org> wrote:
>
> The lazyio mount option lets several clients buffer and cache writes to
> one shared file.  With it, the io500 ior-hard phase fails its read
> verification and the whole run is marked invalid.  ior-hard has every
> process write 47008-byte records (11 pages plus 2112 bytes) into one
> shared file, interleaved with the records of the other processes, so
> the record boundaries fall inside pages that two clients share.  A
> client writes such a page back whole, and the bytes around its own
> record, read before the write or zero-filled beyond its local EOF,
> overwrite the records another client wrote into the same page.  In the
> tests below each client is a separate kernel client mount.
>
> Patch 3 is the fix: a page that a lazy I/O write dirtied only in part
> keeps its dirty byte range, and writeback sends only that range.  A
> write without lazy I/O starts no range, so non-lazy writeback is
> unchanged and sends whole pages as before.

I don't have any particular opinion on individual code changes here,
but I do have a question:

Is it appropriate to try and get lazyio to work for the IO500 test?
The whole premise of lazy IO is that we turn off Ceph's consistency
mechanisms and the application promises to do things correctly and
manage caches on its own. The docs for userspace lazio talk about
specific synchronization primitives you need to invoke:
https://docs.ceph.com/en/latest/cephfs/lazyio/
I presume that the IO 500 test *doesn't* do any of that, so is it
plausible to make this work? Is there any utility to these besides the
IO500 hero run?
-Greg

>
> Patches 1, 2 and 4 fix cap handling problems found while testing it:
>
>  - Patch 1: ceph_check_caps() could put off invalidating a cache whose
>    CACHE or LAZYIO was being revoked while the session's cap was stale,
>    and nothing checked it again.  The MDS then waited for the revoke
>    for good.  A lazy writer on a slow client (arm64, 64K pages, under
>    QEMU) hung that way after shared-file writes.
>
>  - Patches 2 and 4: a lazy I/O open no longer asks for LAZYIO while
>    CACHE (for a reader) or BUFFER (for a writer) is available, and asks
>    for it only once the MDS turns those down.  This saves a cap update
>    and a grant per lazy open of a cached inode, and the LAZYIO revoke
>    when the only client of a file opened for writing becomes its loner.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> One host, 3 OSDs on NVMe, 3 active MDS with a distributed tree pin on
> the mdtest directories, 4 kernel client mounts, 16 io500 processes
> (4 per client), io500 with all phases unless noted.
>
> Data verification, lazyio mount option:
>
> +-------------------------------+------------------+------------------+
> | Test                          | Without series   | With series      |
> +-------------------------------+------------------+------------------+
> | ior-hard only, bad records    | 131881           | 0 (3 runs)       |
> | Full io500, bad records       | 142876, 73999    | 0 (10 runs)      |
> | Full io500 result             | invalid          | valid            |
> +-------------------------------+------------------+------------------+
>
> Full io500, unpatched kernel without lazyio vs this series with
> lazyio (2 runs each):
>
> +---------------------------+-----------------+-----------------+-----+
> | Phase / score             | Unpatched       | Series + lazyio | Diff|
> +---------------------------+-----------------+-----------------+-----+
> | ior-hard-write (GiB/s)    | 0.193 / 0.192   | 0.267 / 0.272   | +40%|
> | ior-hard-read (GiB/s)     | 0.459 / 0.457   | 0.460 / 0.458   | +1% |
> | BW score                  | 0.914 / 0.908   | 0.982 / 0.980   | +8% |
> | MD score                  | 27.30 / 26.36   | 27.45 / 27.53   | +3% |
> | TOTAL                     | 4.994 / 4.893   | 5.192 / 5.193   | +5% |
> +---------------------------+-----------------+-----------------+-----+
>
> Without the lazyio mount option the series changes nothing measurable:
> full io500 TOTAL 4.932 / 4.929 unpatched vs 4.935 / 4.910 with patches
> 1-3 (patch 4 only changes lazy I/O opens).  A non-lazy fio sub-page
> overwrite test was within the run-to-run spread (about +-4%).
>
> arm64 with 64K pages (QEMU guest): fsx, overwrites checked from a
> second mount, and lazy writes of 47008-byte and 3000-byte records from
> 4 mounts all pass, with 0 bad words, in crc, legacy and secure
> messenger modes.
>
> Known issues, not addressed here
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - mdtest's read phase opens files read-write.  With lazyio that still
>    costs about one LAZYIO revoke per file in io500 mdtest-hard-read
>    (2.5-2.7M per run, against a few dozen without lazyio); patch 4
>    removes it only in a smaller reproducer.  Opening the files read-only
>    in mdtest removes the revokes in both modes.
>
>  - A lazy read that starts about a second after a lazy write of the
>    same file can hang in __ceph_get_caps(): a LAZYIO revoke is held back
>    while the cap is in use, and nothing calls ceph_check_caps() again
>    once the use ends.  Full io500 runs, which have other phases between
>    ior-hard-write and ior-hard-read, have not hit it.
>
> Xiubo Li (4):
>   ceph: invalidate a revoked cache even while its cap is stale
>   ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
>   ceph: write back only the dirty bytes of a lazy I/O write
>   ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
>
>  fs/ceph/addr.c       | 360 ++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/caps.c       |  44 +++++-
>  fs/ceph/file.c       |   4 +
>  fs/ceph/mds_client.c |  10 ++
>  fs/ceph/super.h      |   1 +
>  5 files changed, 381 insertions(+), 38 deletions(-)
>
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> Changes in v2:
> - Patch 3: when a truncate clips a lazy dirty range to nothing, or EOF
>   moves below the range, drop the folio's dirty state instead of writing
>   the whole folio up to EOF, which sent the stale bytes in front of the
>   range.  Fixed in ceph_invalidate_folio(), ceph_check_folio_before_write=
()
>   and write_folio_nounlock().  The new ceph_folio_drop_dirty() also
>   decrements mdsc->dirty_folios. (Alex)
> - Link to v1: https://patch.msgid.link/20261020-b4-wip-ceph-lazyio-fix-v1=
-0-f4cc62459d37@clyso.com
>
> ---
> Xiubo Li (5):
>       ceph: invalidate a revoked cache even while its cap is stale
>       ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
>       ceph: write back only the dirty bytes of a lazy I/O write
>       ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
>       ceph: keep LAZYIO with the read caps of a closed file
>
>  fs/ceph/addr.c       | 391 +++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  fs/ceph/caps.c       |  51 ++++++-
>  fs/ceph/file.c       |   4 +
>  fs/ceph/mds_client.c |  10 ++
>  fs/ceph/super.h      |   1 +
>  5 files changed, 417 insertions(+), 40 deletions(-)
> ---
> base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
> change-id: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc
>
> Best regards,
> --
> Xiubo Li <xiubo.li@clyso.com>
>
>
>


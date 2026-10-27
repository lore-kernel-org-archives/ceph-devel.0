Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084535;
	b=4sucUZ8G9SbdwHeQDG1F61LLaXr0BihaGLD9cuRMovg3sqA2ItJ8DBbbH3L4YnJJS8uU
	 kAeSN3bWgaVmxNPs4eMNl9tXOBbyZUwjYP4IY/5kJ0rhKpIVju9IZvFrjZy4qHUscB/ba
	 6/hRDb5qJN0M/sOsum7ML2pkMUjVPPXQbTCKZDpkZGHx6rGvxoS/v1vI/vlUDj37+LnWU
	 xbolXDw31DVtdjnlpZX77O9/eAuYjefYG38tpOClZCRSPLiVEX2cxNnc/kY4cSwl5tDMR
	 mPLGp1u7Li9RZv5qeb5JBAFmlaUteUuTHWc3hHlG8F/8CcLtu44/TmKtDGi4AgHZ3aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=UUQ8S0GTnuBbwoRKhlA9FMz1qn29M2mSBTIjxTA6nmc=;
	b=uEDzSrYJKs4hLCLy36dRgvWUq7519IEVqR4+h1nJ/d7oPHMdmYv3CMuxWWFaaMSsokc0
	 rCBLKnrWo8sKhiv8oyM1j4dmBkvxaWlyo1xcA41ipycOxrcwMv8MNS/LBLK9ahgwf+DJn
	 B5np8YivtSD/vQ98udHbcEwMDpesAcCKFrFD7TUiOdar6tLCML54gKcB/eTfak4ZOruw7
	 Bbm1OpSIswr05GITc90UjZBPT5cN9bPXw5XJ4olDlz6tlAelSculZ4Z36HhcoMochDvgl
	 8hPsjX6k+dA1nXZxl3060mRFGqgMoBCOKEM+5ViJlYu01ZTOjp1nUlUeP+GSaxw2O5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=GRZ26zWU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A626606A31A
	for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 07:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A626606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=GRZ26zWU
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4677aad67bso397818566b.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 00:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793084532; cv=none;
        d=google.com; s=arc-20260327;
        b=nnCY+Ya8GbBn7qAiyQGP5g1Mkt3nD2AG0of4NoILATEn5ChFqX4PyQqifG8OVer4Re
         kUHwFuAr6LaguB953iqPDWlikn3Y9HBwkYLWkgmSzcJA4T+1siLkr361t9kiI5AL9TE7
         vFh0IJwJeP9sTRhUjK5Af7+szVaA6PLHltnxitVYOrbPtaSOji3E74jlOxMxBPjDZ3AT
         v+TxXzLrwKdw0pZ0S1ShVLz2i9pWjOg3Fxdkw+4K+yasbNu/5ETkEpSpvbBMrITi/iz0
         6qW2MmjmVEni/U7RBRFYgK0APd9lBz3RgVUr6kTwUyTNY7utIm9hb/xHnYQA02lPjBcw
         QHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UUQ8S0GTnuBbwoRKhlA9FMz1qn29M2mSBTIjxTA6nmc=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=nkjYmtxb/lFuGNtKKoXhjnuyJeKUp8prJRjSyU8tKyeM8Ah2WeUEV91Du4rFmsQlfN
         Qss5EMLnomgXHCXOv69VcxPza4aFMGtBxVyNAxRpehHA5SKhmO5pyCDssDFWBEnj91A2
         F5YbFMQ9pIFFWu58Ra/BjyDobWo+fgP82D5kNX45Ed2RWMU5muClUdZP8wB6nPwR7Q/3
         dJLm/71SpCVOFdOGf5zfBOZtYpc1xRXvjo16d829XxYqT3N8A9Y/onV1tj60qV4TYQsA
         oDYNaAoRY+8BFad45eyaaTxo+6y12N/CfI6IPdU71qv35Nw6bwiajleMHF9Qtvu4N/Gw
         yKhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1793084532; x=1793689332; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUQ8S0GTnuBbwoRKhlA9FMz1qn29M2mSBTIjxTA6nmc=;
        b=GRZ26zWU/cCTA7/ijpBNSIEujurg+n/CmOJEUg1YyU1jLrxIjpk9IUWrwdc77Q5zMt
         3k1OPgT/LCGkXoBhWjuZN9161SCa5CB1tPn2LZbqCiB21HPBnAiTiNGcgQ763v3ToIJB
         AgXU7lpSV/CeyzbmYXtfwa/xG2zAmbXZcM5PFFlRkSkat6G7fR00Xqwcj0qmX8sy9omi
         NF0ClYEC6DKaBdVODAmU3DKEN97RXedhTCgC5hTScxRnEtDOU71YhObHjJH+eIFImdVT
         JbYqFImgQSEVGjYHqFPYUX1tyWm52u0qq8rxpfTQcv8uryB9pS8oByrGrb06vy7KCWtQ
         /Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084532; x=1793689332;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UUQ8S0GTnuBbwoRKhlA9FMz1qn29M2mSBTIjxTA6nmc=;
        b=n96YH8nmkPVsnAZ1CyoC3zRX845VFXIE263OBEyIVvjqWj5tIWt/bPg8WBYmc/5okt
         tkUEoLU0Kt4u4IRjhrJlK4MYbWaS9VWwhdKRC1QXk1JteLklTCaLRaD0gL6l8OM2tqHM
         e1QFneK9bolDrL4iKLR7wQ7TiE/RHVEMQN/tAPmwhNYCpWCQywl3q8O9yMZh+PpeD5QU
         lOHAIlMok55GBlUEHsxP0aiw1J+YcnIHK/+P+DH0QOPsV3ME0SG/Mt+Ms38nXfs7YrKw
         Qc9C5AoPtM29jYEnFyVtmS8SR7QBZrtxF8V2T28HGF1S3rwzWNl7rQmORst9H7kyUIVU
         7hcQ==
X-Gm-Message-State: AFq9FYJXGX7E7iiuURj0aO6ddMsra3dOjvkx/NRFpNaTKieGcH7XzR6P
	wvRL8Wld+QfzbhGoWTAWHYkGDoxu1OASv/ILMLXAYfJn+b110TwOuTdYRVLnKsVZJNWTsdgGyj7
	y8MJIxKwNObVt2o/J+XNxAF77KQ4YNTK5LcYrSizbEnpxmvfVRX6RJX+4VQ==
X-Gm-Gg: AYBFou399uXb5DI/2F/lffsculZG7UeiqyWmCnHzKwaMAstIHmwMsaVFLH/ceugebBU
	Fn+mVF4U6ZDbnRSFm5cWrLuac//5gqgbqruI7xdYbEho37flW1rxM6BH5few/Fp+MbimquURr/I
	3kuyJgIGs8uUiaQV2y5RNR+jMCmt3JMJnTE13hBytI2zWT3ASZq85lzSJKZMkQaeFC1PdsAzG+e
	mUH5RlmcvB7HpzEyUVlNOEGw0EexsE704KaMPGX6CBdbcK+/gg2F3DuXGrla8iyb4KmdCB3rRRD
	CAqqwVnb3PzIYCWtLxcCpg7zpLnqZqblTCg3GmhuhII+IkpS63w9nBMHu6c35D6U/VW1xFGk1y0
	W+oTUaaShDPdoIG6EglVQeblIDX540QhXK/FLkvU=
X-Received: by 2002:a17:907:971e:b0:c3f:4d1:8cd7 with SMTP id
 a640c23a62f3a-c46bde3aec9mr1045654466b.25.1793084532356; Tue, 27 Oct 2026
 00:02:12 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-wip-ceph-lazyio-fix-v2-3-25d28479d6ea@clyso.com> <179294903374.2850169.9863420725827161378.lazyio-v2-nack@redhat.com>
In-Reply-To: <179294903374.2850169.9863420725827161378.lazyio-v2-nack@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 27 Oct 2026 08:02:01 +0100
X-Gm-Features: AclHuK-yOf8pAy2vy6N6k3OnS8w9p9T3EEv1luHNY5lqpmpkSKjd00sxr37AxTI
Message-ID: <CAOJNxRK_77w3i1LRLOLVceevJChCeO3bhHmDPeyb9Ub=zxGeFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ceph: write back only the dirty bytes of a lazy
 I/O write
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks, you are right, and it reproduces.  A writable pin taken before
the folio's last writeback can write any byte of it; once a lazy write
has dirtied the folio again with a narrow range, the unpin skips
folio_mark_dirty(), so the range never becomes whole and writeback
drops the pinned bytes.

Reproducer, on two lazyio mounts: mmap a file and use it as the buffer
of a 2 MiB O_DIRECT read from a dm-delay device.  While the read is in
flight, fsync the file, then do a 100-byte write into each page.  When
the read completes, bio_check_pages_dirty() finds every folio dirty and
releases the pins without dirtying them.  v2 then writes back only the
100-byte ranges, and the other client reads back stale data for the
remaining 3996 bytes of every page; 3 of 3 runs failed.  The bio must
not have a clean folio left, or bio_dirty_fn() dirties them all again
and the ranges become whole.

v3 makes ceph_folio_note_write() start no range on a folio that
folio_maybe_dma_pinned() reports as pinned, so it goes out whole as
before.  A pin taken after the range is set up must write-fault first,
since writeback write-protected the PTEs, and ceph_page_mkwrite()
already makes the range whole.  A false positive only costs a
whole-folio write.  The reproducer passes 3 of 3 on v3, as do the
truncate, stale-session and ior-hard tests.

Thanks,
Xiubo

On Sun, 25 Oct 2026 at 18:24, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> NACK. Please respin the series.
>
> A writable GUP pin can survive writeback. A later lazy write can then
> install a narrow dirty range while the pin remains held. If the pin
> holder writes outside that range, unpin_user_pages_dirty_lock() sees
> the folio already dirty and skips folio_mark_dirty(). The range never
> becomes whole, so writeback omits those bytes.
>
> Please handle these pinned-page writes before limiting writeback to
> the tracked range. This is from source inspection, not a live-cluster
> reproduction.
>
> --
> Alex Markuze
>

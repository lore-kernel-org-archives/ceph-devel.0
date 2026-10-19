Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792425958;
	b=drVlxKcL97SvDktH3pkA4ARKqHG9joErWkNqRvXPdhsRMUEmaNQ/OG31AUu3AcRzIpQH
	 WOaYtzbwGA52ZCWHXsulNpyOWH2sa+nTrgMnuP432UdWTNqKvGgnnBZ0tlZF4rGluyRKu
	 HrgBUJgBAnxdqpPY8P2O3LArAMEtcH9yCJnDAWqZ8uPl0iYL4sPbsDyE8ZCXqAYMbHCwf
	 eOj1pOCY37wo/Cu+kQops9N9n5KoYQeh42HAtUD0LsB49rRduGiLuoLpaX7uJh1ZEZ5/q
	 +7KYxYNPmeaLCiutqQX6H8jJNAxdjA9IccBkvj+0Vxdvg9cjkPqGVVqwRPhg8Vvyppw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425958;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=rJCzmqkUyBuAMTS2sRPCTNp4WMacGY+Q2zZ1Nvd28kE=;
	b=cHiUP3QDaX3aQu3tJg+TKrM+CMZoxIvZSB1gEfTqfTPyv0qn2ORbecYGVxZAT1fPSfGJ
	 VMHPjrpvHA+Z7w3tpNAv30BPHZ1TmsFXB4HYHYWILxIjg5m2lWW/FcYo+yuwQMM4fVPdk
	 ktlbIc17AOZ42ecudnrpbnC4Pyu4z6xYJer4NUpb2gRo264Nf2X9x+1lIquhStPj3/OtF
	 xrVGF25B7X0+ZEc1se1smKnl6iCNnRpeywAtuuHq5fIzTQkJfr6VHOOzLHL+6S5qzBRhy
	 3N517Tw6dGKvE3a63mkTIFQQ7JCRxa6bZ/XIr+GUxPW8rF79wI+GOHU4s2ltqoBo+qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="C6HXPia/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p7w3l47y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854476078840
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 16:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854476078840
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C6HXPia/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p7w3l47y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792425956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJCzmqkUyBuAMTS2sRPCTNp4WMacGY+Q2zZ1Nvd28kE=;
	b=C6HXPia/f/Md33TAUwjgBr6a2d1PItYKc8mFtfz+SH/PPTGo/eWTYqxlxi3TjxOK39qH2e
	Qd291qBENHuLvaVHJg31MfpUrkQmG+l2okcBvwZaD1BZGLn72CxpN4zJnbWne4pjH9w8Mr
	zjQUOjocDtAdH8juWYAZV3usXuiFv+s=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ldff8eOVOpiaiJnDRX5DdA-1; Mon, 19 Oct 2026 16:05:43 +0000
X-MC-Unique: ldff8eOVOpiaiJnDRX5DdA-1
X-Mimecast-MFC-AGG-ID: ldff8eOVOpiaiJnDRX5DdA_1792425942
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc37ee6562so174629137.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 09:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792425942; cv=none;
        d=google.com; s=arc-20260327;
        b=CR77XqUTmb2rqngTpjkyUvkSOpb/Sm9rGkzGrcNRMRzjVYwB+TyYvJg0jDhKpiW2fQ
         DkKKucTJbaLQCSROtIXE/Hv8HdvbR7Lj2jSFdnr+VMviZZ39NK5ZWCVQTBkG6yMNTxNx
         jjzgYgASg91OQX29TqBPabBqhGngfr7HGHzOquPvrEguTwSia6DwfuftDa4JQ2vvpFtB
         dut/HQsV3/zfDe2OKDWRYLrssm6i8DDdEShKcmnCkr6dqFAxSDmTKzyLsPczb5/VYCJc
         GTRReDenKS1hU/y0K+FH1HmWQGeaf2kjNM08pEw8vwW9f1wVE9THJfhths1DugA5Lf0u
         GR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rJCzmqkUyBuAMTS2sRPCTNp4WMacGY+Q2zZ1Nvd28kE=;
        fh=tHOndL2JelxkSdMzIYQD3RtI6lCeZZ41VYSiY0eFqA8=;
        b=HfmOZ0O2ujH2zvZ5ZaqPHiGaqzH4vezwxykedIsuiGuLXWDc5GhCNmQoxEYFffXvX/
         eDiYoSKwoVxbBkqLUOJyInrCUPcJjtmDKb0mjU6JAUhz28SW3PaJIOFQbe7Nt0AKQTBz
         m8pg3Ic5rWTQd6q9SLM3XGHamHHmQJITJNtN1ED9YG+4FuqH/savxV/7+ylLsUlGEKS+
         CsBZzJYkN0UxB2Bl497+PiS9riM8PuW5a/0GOlLn55JJrmuVeHueZJaopwaZw5+KkocN
         y6ZBrQJKWRlgZ1qJcyS8gUa3AqSGHqQL/682Pnsoeke8XzPyidvdC+0xiSlvbhRgFnqh
         Y/jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792425942; x=1793030742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJCzmqkUyBuAMTS2sRPCTNp4WMacGY+Q2zZ1Nvd28kE=;
        b=p7w3l47yyRW55YfMqlNOH87cD1yw0iklbf5fRZyOnaET1x0v93WzI1df4OKEBnXjNF
         FEacgH0Cg2wcEtKtQd+AEjmxeFbhhOYRC+7imrucDnOy6zIcDOzyJkCj3o4urQHRF6WD
         NS30ZPMtVozwYFnzzIj4FFOYfGF/CPcML5ak3nuyjQx2fYZd/cvLWnVCvtTqJGwO4xJs
         3xeWbHxw+xwNgNNspLvG72RuMr0YTFqqoe3VyaQ5LfT12IE+ycZV9efI5111tl/lsF+i
         sLR5BQvvXCz29W1x4xupMxtQ1ozTyv1j4zQKEUA0jf/vzHQFPRVgh1PhdaNEhZA2+nCa
         6t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425942; x=1793030742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJCzmqkUyBuAMTS2sRPCTNp4WMacGY+Q2zZ1Nvd28kE=;
        b=S4wsQ0DJzbFGkz8KNcG7QcXs2bdSR2VLcHHiUdaYAb0RGvSGaLjl7+koRUlq9DuPOm
         kiR/Jgu5hroOQmQmv8I8jmlyE9+A170us67h3jY8NYo/UKU0BvO7h53jGaaMjl6E3erQ
         fbhyD/S3ylutT6pjHDXdzQeTmoWYvM/Z1eloWWg++BpH7//JarskUV2oqSQ4xSPggsUJ
         1kRXQ38t1MxuLKbEvQbwF8mo4Vl+hzBc8JurFVEfFmZBFJu30H5bT4BEcOcaAN7iptuL
         NXP5v80rLke32eVMPhwL/dJ2FLdMpT97fr8IpIShLVEDMJ1QHVLBJxJl3bvwlsuwYB1y
         9RdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpG2ylrOolzICWM87gSALscB979WvfWXQLWG1bulpRneawNLHR4HN3SuA8BIum93WQuK4GtOUmUnNW@vger.kernel.org
X-Gm-Message-State: AFq9FYJDyqXbWgbiAf3n1pq8wEK54ItKge6t+lFtB8kb11ddBv5KJeWE
	aNlO3gmWedUdql+zpgcqrGGbgab8UyBrN6s3ehy7jYA451eNrRS+Tl7DN2Ja3YQUzRSWWVvNcu8
	Xul4NicPHcgI4iumifXRGzk5SW12f7JEXXOD70b9WO5YcT5dodB8sX1bVmmTQsZPsrhmIlCBSNB
	IAooeBASSfsIC0nCPf7N446TOTZI8pmXl8zRP9WA==
X-Gm-Gg: AYBFou1V81WgIayBYZNM1iY3IFRcpkaxgDi1GyzqlSajOsm/t5XlbyocwkPUKA5iZkN
	/+1tpXpsL06QLQjVF5FMmZkVCs+eRJ7rfZiN0QmFHUPIRZKHAEwEwXZHqAIaF9SnWXu8cQ6YF+7
	vUAOKldNTpN3SjYjRYGWgr5SJjXSzFRKHxWnvvLF+nWSltm5iXus7rCZc2GWJZMxo/Mn85kDNOr
	CNxHBzxfQsoboCFoUUIjUCd2s1vX2A0GjBCKmmBUdTpg+8agsWq5LWnqZ4+AWzjaYFAxBHfBvVs
	UP5zHaAcxKTO9aSJ16nzN7rtoA==
X-Received: by 2002:a05:6102:5249:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7cc36b48339mr1807114137.37.1792425942335;
        Mon, 19 Oct 2026 09:05:42 -0700 (PDT)
X-Received: by 2002:a05:6102:5249:b0:7a7:19aa:f0d8 with SMTP id
 ada2fe7eead31-7cc36b48339mr1807101137.37.1792425941758; Mon, 19 Oct 2026
 09:05:41 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a01d0a297a3e174d21741a3ad586ce546327603e.1792081664.git.amarkuze@redhat.com>
 <20261015183548.GE2170687@google.com> <CAO8a2Sjr6XSizdgobZK1ZAO8PUd5tCDFKjdD-=3TXHwqOU6qfg@mail.gmail.com>
 <20261015193800.GH2170687@google.com> <CAO8a2SgiFTarbcg-qgTLgjk1RsOMLwHsjj9ko8HgT99F1DAYrg@mail.gmail.com>
 <CAOJNxR+zWN=UPKf5NcZDHDsTghu9XHuQuWDkTaHjA1j2rU_42w@mail.gmail.com>
In-Reply-To: <CAOJNxR+zWN=UPKf5NcZDHDsTghu9XHuQuWDkTaHjA1j2rU_42w@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 19 Oct 2026 19:05:30 +0300
X-Gm-Features: AclHuK836x2QCsZgOmWJBCRabmDFLxRa7Rbm7icXR-nKnFjpLVPX_8WeuZ5WW8U
Message-ID: <CAO8a2Siubo8Dnj+RnQLf_AUxhJMuuE6d5JLu=OUjmnT0GJJcCg@mail.gmail.com>
Subject: Re: [PATCH] fscrypt: allow filesystems to disable symlink target caching
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I''ll resend a combined v4

On Mon, Oct 19, 2026 at 3:56=E2=80=AFPM Xiubo Li <xiubo.li@clyso.com> wrote=
:
>
> On Thu, Oct 15, 2026 at 05:46:24PM +0000, Alex Markuze wrote:
> > fscrypt stores decrypted symlink targets in inode->i_link. The VFS can
> > use this field without calling the filesystem's ->get_link() callback.
>
> Agree with Eric that this belongs in the quarantine series, with the
> ceph_fscrypt_ops hunk folded into the patch that adds the ->get_link()
> check.
>
> I tested it on top of quarantine v3 with a KASAN/lockdep kernel and a
> v2-policy encrypted directory.  With v3 alone, the only access to a
> cached encrypted symlink that still succeeds during quarantine is
> readlinkat() on an O_PATH fd opened before quarantine, with an empty
> path.  Path-based readlink/follow/lstat and readlinkat(dirfd, name) are
> already refused by the lookup checks.  With this patch the O_PATH case
> returns EACCES as well.  Please describe that case in the changelog,
> since it is what justifies disabling the cache.
>
> Only the two writers need gating (the kmemdup() in
> __fscrypt_encrypt_symlink() and the cmpxchg_release() in
> fscrypt_get_symlink()).  If i_link is never populated, the READ_ONCE()s
> in fscrypt_get_symlink() and fscrypt_symlink_getattr() already see
> NULL, and the VFS reads i_link without looking at the flag anyway.  A
> writer-only version behaved identically in the same tests.  Please also
> update the fscrypt_symlink_getattr() kernel-doc, which still says that
> targets are cached in ->i_link.
>
> The cost is one allocation plus one decryption on every readlink,
> follow and lstat of an encrypted symlink: a re-read link went from a
> single fscrypt_get_symlink() call to one per access.  That is probably
> acceptable, but the changelog should say so.
>
> Thanks,
> Xiubo
>
>
> On Thu, 15 Oct 2026 at 21:45, Alex Markuze <amarkuze@redhat.com> wrote:
> >
> > I didn't want to conflate fscrypt patches with Ceph features; arguably
> > two distinct patchsets.
> >
> > I will CC you folks when this is acked then.
> >
> > On Thu, Oct 15, 2026 at 10:38=E2=80=AFPM Eric Biggers <ebiggers@kernel.=
org> wrote:
> > >
> > > On Thu, Oct 15, 2026 at 09:52:11PM +0300, Alex Markuze wrote:
> > > > Hi Eric,
> > > >
> > > > This supports the concurrent CephFS subvolume quarantine series.
> > > > There=E2=80=99s no Fixes: tag since this isn't addressing an existi=
ng upstream
> > > > regression.
> > > >
> > > > The quarantine series adds checks to Ceph's ->get_link(). However, =
if
> > > > an encrypted symlink target was cached prior to quarantine, the VFS
> > > > bypasses that callback entirely when following or reading it. While
> > > > the target data is still valid, access now needs to be denied.
> > > >
> > > > This patch adds an opt-out for symlink caching and enables it for
> > > > Ceph, handling the encrypted-symlink case for the concurrent series
> > > > without affecting other filesystems.
> > > >
> > >
> > > That series wasn't sent to me.  Is it
> > > https://lore.kernel.org/r/cover.1792074165.git.amarkuze@redhat.com/ ?
> > > It would make more sense to add this patch to that series so that the=
y
> > > can be reviewed together.  I can potentially apply a prerequisite pat=
ch
> > > by itself, but we'd first need to know that the rest has been reviewe=
d
> > > and will be accepted too, otherwise it will be unused code.
> > >
> > > - Eric
> > >
> >
>


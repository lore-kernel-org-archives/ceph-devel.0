Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA232264B0
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419557; cv=pass; b=lIDHOa1kfKORDfiM6MTsKWUfP18kQ7gKcwSVFnOQhsd/ImD6loJ+ri7Bn2oVyuDHT/UJa9pgYs7Jk5sSAxjS7uQIwEmQDCFQKpzG49c5KMl6xp2f4b+q05fw2cGI9W/BCJo98GwYOjEI1VncqquUW1EnMFPkD+s6nFXKCNe2TFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419557; c=relaxed/simple;
	bh=//KbL8BSwpGtNpA7Wk2hApobKAsz+Z1PhTLAGco2vBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVaEf7kpa4MidMgFTQ+ITZLVnhhySExMR1GLIQTmfANDATcQz/bsHlY7h6lJgAxOQKPL660A2BaJ9hPRJzEstGiFwJ3uuYmPNzLGVEZZYPyDBYXVy6ZQyKLH6i6ibAkNRczTk1SCNvFmJB6SsKxjrzjVfvhZt1j7ZWzc0PtvZ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBYf2qY/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULBtcjym; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBYf2qY/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULBtcjym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783419555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQy7A81fZce04GjZTsxZNhuVO07LGWg+ePmQQ4hJDAI=;
	b=KBYf2qY/fuhI6P/fSlGG5s3ml3Vqb3Z23/WepanYkeiHOPXeM4EMLDIAw0dcvSEIMIdtCa
	+nPdxsiOQhjbsMNb3mts+G6hUSive+TPlUmCV5cwaQKVMrYocA36YFEw/YOndDDlkU6sVc
	rVuC9bYz3b2DqlU77uSYYlJL8OiVbjo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-BTtbubqjOFusWk5gU2epCg-1; Tue, 07 Jul 2026 06:19:14 -0400
X-MC-Unique: BTtbubqjOFusWk5gU2epCg-1
X-Mimecast-MFC-AGG-ID: BTtbubqjOFusWk5gU2epCg_1783419553
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5bde4e69013so1771005e0c.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 03:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783419553; cv=none;
        d=google.com; s=arc-20260327;
        b=E99hUK+Lqb8slWk/se4qjlWQetrdUvVXjBeGKi66tFnWhUDkf85cpb41CZBuCgT8Yt
         X5H2gwU/hpb6yHCCs6GvX9JtshEOxs6cIFCvStNyC79tWN0/xXQ6P1rvSoqHZ5h0zYaj
         oy/vxlcvXyUQPrV39ug82Bnz5udfl695tEwdF8KpInRY+Yw2RgAu3I8Y7bipT0ai/UC8
         ZQQGkugpHTstobq916YBbKrhye8lJ+REhKpl8pdr0gc28fx85QhcRXrOBasm3dJvQbm0
         hFJNsjNrbYumxLnekAbexNp5MT97B8/aEvpeX79788yAjcVT40WbC3nnUGMEXHLHHJOO
         A3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQy7A81fZce04GjZTsxZNhuVO07LGWg+ePmQQ4hJDAI=;
        fh=SSzta9I+i6Arnhq3v7CjSr65Jr5vHT80uHg3z3ptul0=;
        b=KCU4AAlPDpBDkGk2T4U+2cZC87YulHtYIs61A364XQr6SC9Hv/5FgnhF1BlrAZaHob
         PqUOswU4AI2Vd1JGN0BrzpGxzXV/kV/KK8PAUrXzSrR0vTRWtPtXmXMsiHoQ03ZtAuaM
         S4cjs4hrqr+F25dEyFVOg/FpLkAbik+dbmNjgL8kqRXKIvmaj9lYTUoE9llOCS+Pl23r
         nVGsl38iQKV6/z9op8+IqpqseJoysSE8vFde8WTGZYZgk7g4pfE0MunTIm6Phlat0ofF
         uUWargmkrRsy0ZXY9t0762wMO+5c75JgJLM5apYN/ss729RhQBRB6gUZuydy6yJJHgxU
         xw4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783419553; x=1784024353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQy7A81fZce04GjZTsxZNhuVO07LGWg+ePmQQ4hJDAI=;
        b=ULBtcjymc3szGytluzadMYl+uqAXv/bxvUu1LqDLnKFicdcJfZaFL6IY1gAKZc4rlT
         boALXZ/VmeGBl+poszw9ibYXlTiE4+gwYqRWulHBT3sDPhry/Ck5Jn9+Xnkf3M1XNeBN
         NQKnTcdYY2nX/D+OmB50F1aDPLF1x/aLfJ3CXRXZMrQMCAVNzC8qabuB5l6O0r/87iP5
         qTIdI6M0Vv41n3ZtXpuwNz94568QSiFRE81bbx+UyObkey7SoVFhu9CXpesaAQL8dCC8
         +EFZqIv2vYbmwoDfPqOi3p+OLhts70X6ttUyTzAO1V8Klpz0lqGyVJAq9XbYfUlR5Rt6
         F2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419553; x=1784024353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQy7A81fZce04GjZTsxZNhuVO07LGWg+ePmQQ4hJDAI=;
        b=BU53EaJ15vMD/msuhKuStdRtC53ezFzmqiCCJ6/CPp6b3qxVilbSdX8SoSGcGedXrK
         CD9oxDU77hOZ51RUOOyfsCgkW4NVBa8utSUBEaVVcTnB2zjbU/YXHnlDYF7BGfVEx8ST
         2BoA+UqOZWN+a6fNo1kuA0IUMrZN6WN7O1TsTFCEFIkXTsNbu0Dw6GnyKddshXGGfNZ5
         fgGEg35g7bRQx/k+DOJCDYSSXexjAIRbeiNtuoLDy7zKyigsSfemCPyjKYcNHHMdVIrf
         OxN+byldt66wjdqSJoj+KUFlnUvGsgQuqXg/I89K42a3r2ZlT1pNBnZnkoEmvxPz+SM4
         Q8KA==
X-Gm-Message-State: AOJu0YykFncReRy9HMkf7lZZsjCpI9I9pGboBbTOUT0adONo31d9njlb
	cPE2jz/ScOzs1eQcUSlwZOteUWizJldY47rB2En1FspRqoTTAgKVZrFgJz5oH9kYc72neE1+obo
	e3/NxoTofXakML49652p7Ux5KCAY3AUZazFSA+uMlKQXmoFoUtmqeY5GTrGQr9Q329sgASA8G+U
	VvWNl381bkk17MkUgA514vDWWs4yxmup8a2MEvGA==
X-Gm-Gg: AfdE7clsQ19xzWP2wEfOiHHIaYN77WiaSeu01OQkFnG7sdOVUHr5khC+ahSEEANU4n+
	XapUIQdEUHgo+zjddEvVW+PGNwvbTlPAfNfvp0JMlok0taSM5HlutGWSvC/P4xPYfO3vNTwwbO7
	lhgz8JdV6SjjJPpwu15rwSuhR5MavVVJyp1HxXbO0WwOFJeBgOgeLCN6bc2D7tt8Hq
X-Received: by 2002:a05:6102:148e:b0:736:7e78:cf7f with SMTP id ada2fe7eead31-744b7ddbdb1mr2158411137.25.1783419553352;
        Tue, 07 Jul 2026 03:19:13 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:736:7e78:cf7f with SMTP id
 ada2fe7eead31-744b7ddbdb1mr2158399137.25.1783419552947; Tue, 07 Jul 2026
 03:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415034020.11530-1-CFSworks@gmail.com> <20260702114034.917507-5-amarkuze@redhat.com>
 <CAH5Ym4j6GUT2L7tFy63BzsqXV-okfW5GyVYBS+MOxMJsEP49+w@mail.gmail.com>
In-Reply-To: <CAH5Ym4j6GUT2L7tFy63BzsqXV-okfW5GyVYBS+MOxMJsEP49+w@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 7 Jul 2026 13:19:01 +0300
X-Gm-Features: AVVi8CcNeDXiI7dgKpsmH0vTgl4zlzvgMzVZAgvMbyAp7kGHIMhkN9uF6jAztzk
Message-ID: <CAO8a2SiSA6OUa2Yy_q-ikvnot-D18gHuK6+19p-hgAGPfBOvnQ@mail.gmail.com>
Subject: Re: [RFC/BUG] Use a bounce buffer for mds client decryption
To: Sam Edwards <cfsworks@gmail.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The mailing list has been a firehose lately, apologies.
Feel free to ping me directly in case you feel something might have been mi=
ssed.

On Thu, Jul 2, 2026 at 7:42=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wro=
te:
>
> On Thu, Jul 2, 2026 at 4:40=E2=80=AFAM Alex Markuze <amarkuze@redhat.com>=
 wrote:
> >
> > Hi Sam,
> >
> > NACK for now. Thanks for the patch, but I have some concerns
> > that need a v2:
>
> Hi Alex,
>
> This RFC was only to get feedback on my (ultimately improper) approach
> of fixing the issue inside parse_reply_info_readdir(), not intended to
> be a kernel-worthy patch.
>
> I see you've already found/reviewed the superseding v2 [1], so I
> suspect you later stumbled on this one while working on the backlog in
> Patchwork and didn't notice that it can be closed. :)
>
> Cheers,
> Sam
>
> [1] https://lore.kernel.org/ceph-devel/20260530030646.85589-1-CFSworks@gm=
ail.com/T/
>
> >
> >   1. [major] fs/ceph/mds_client.c:578: BUG_ON on wire-controlled length=
 panics the client
> >   2. [major] fs/ceph/mds_client.c:580: Patch may not build against curr=
ent tree
> >   3. [major] fs/ceph/inode.c: Trace/LOOKUPNAME path has the same vmallo=
c/fscrypt bug
> >   4. [minor] fs/ceph/mds_client.c:497: Assignment-in-if and missing bra=
ces
> >   5. [nit] fs/ceph/mds_client.c:494: Typo: fscript_str =E2=86=92 fscryp=
t_str
> >   6. [nit] fs/ceph/mds_client.c:574: Missing unlikely() on inner-loop b=
ounce check
> >
> >
> > --
> > Alex Markuze
> >
>


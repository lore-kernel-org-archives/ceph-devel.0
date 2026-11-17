Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945467;
	b=AekE/56j76YLsA6pA5ISfzOTAxdgYMnSnHG9rGDJr+Bd/4vFIlwQa4L475RcPZ2mD1+D
	 pZjNbV8vx4DnsqYioUXMszaPHoETNm1SLfbg0acL2nf8tkg+A/eQ9keuAsQYaKfkL38Pm
	 SdZHYPdlW/nqz+zVuTNyAWEKUOzrMKfC6lK2pO5MwLtQI0j9tlPtPsnT0BlCfw7XkqYzt
	 D0kGIbvqdKjOXHE5u1ilDmnXOKSkYNInhkT1Dbd719EgEuFrwccrtC/QdugG3zKYzl5mE
	 sDCFEAvjMXC+JWwCCp2+SL1xCC+orzeln4zRq4dAcJV9Qq8998CRbKT5jCLV5WIYlDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945467;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=8FM6zV2jcG/nODchlaxjXPlgpgpsE6ltpToIZCja9Pw=;
	b=SzizVApFI91qPs9AouLiAKb4ZDKx23j7X1Y+8j85pjIt6n9qZWMSXEuUcNQXGfdkOA0o
	 dbZvHyvRqGFL4Q+RIAQdhDiCWoT3wkYYQRqrvkXU7UHiX9Prn5W22LP9HWLxwW4TWAaVU
	 f8O2lMign34e93OQdb5h7312tX/QFj1jtxn0q1QCWN/yfnb56ICmXiLHZr37eEDuvIUlZ
	 9e5TBv7YOSZfgcbkiC7PO2N/mB87EoWlLGGwOI2Yjc5QyxRXzxHr0NdKfgk1K3yhEDq78
	 aL1rGWePJzLd09i3dWKIBhM7s6eLfJdtKsZwV3wagHQNYz2EgR4rsIQh8kGhV3l3rOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=ImTKhk4d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zXB+Z4HG;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C8606A32F
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2026 19:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491C8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=ImTKhk4d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zXB+Z4HG
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CD98A1D00284
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2026 14:57:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 14:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1794945466; x=1795031866; bh=8FM6zV2jcG/nODchlaxjXPlgpgpsE6ltpTo
	IZCja9Pw=; b=ImTKhk4dSSHZqUVebBBZQVqF7ML7SQqYIGcOb/9mFA5PmmJG0iC
	UC98oUoXzdTQoiK6LTEFeQPzWOwvQGbIqKQNEn64cWgpHnj5eJ5u/XuS98R1kw8F
	a2wUozob043kW0z9VeKSnyQSWiMX03Whp9kc9XPONMyHPeqmjzq9vAMyPPIO7WAT
	/+Y62VZKS2VlcNcYw5VH8Rtv+8FMZfcqLSgwVynAlr7sNj1pzu+LpqSfPo7XJQdm
	YVccgyq9B2xrxe643TVf9K6OkcVq9qxW8uK+kkOpA+gWR2ohB6GmscWvUc+RskLg
	mUA1O1IF8QXEA0uylMuoyxchQFQ99wxi87w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794945466; x=
	1795031866; bh=8FM6zV2jcG/nODchlaxjXPlgpgpsE6ltpToIZCja9Pw=; b=z
	XB+Z4HGJTZFaTA3stJ9s1eE+RgdYvjHOLIHqFy4I/df9XCC6qLSGTyudFR7rw0jq
	RC7gzof2XVINqMpCDxIkzKllACCH/I2nKlxvOSvCBojPtJ+9g42UdYzgYXNE5PKk
	DPGvT9YG3Ju5UuG+UkZyNRjOIsse9s+WzLQoc80p4w0qS6FZ27zyqyYbq4ZjdkkH
	ciuGrB08XCqw2rwle/70NqGdiQ9k8jfEARkCTN1fM9KpN/19UJ3YsSLySJk7SFF7
	ZwMkzTIguj+00zI7hzAcTC7bA5qKgMFqVwC4gZg4jzgp4klh5cQE1u5F4iMEDrHg
	TanE+bjfSx0ZrjBOKQQPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794945466; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:gYWm6curlkwZXhrcRKDfEqcjCuCzKoJi9gSkAjDlbngDFAr
	/2e5cPvRhAa8Ph/fh361RVcte4IyuMAXfmWHdCGanUCGftJwZapr51D+E5vrYJLJ
	1QAjR9pn6boEL+hgokQiFrQ/9OXiP1qSCu+kojVhs0FDHsila68OvAnAAGkvoLii
	PIzv3G2t9FT2Ru+6PM1a3gM8pAvZQRpFm/NCpmukYOqshJtp2fF4+pQeEBmYn42E
	5i/AcUfIPz4AyGucCCo3HVKFQD8ZcNfxssrSlwf4kc2vyUq0fyXyEJOKt61zAV3l
	ngrwsEd23pubsc09n8Tu3O+mnDOzS+XeN6LeUhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:llVildKPAcODEVh9NY6eyVP73Aj3h94g0wIzgQ+onlI=:Is/waql9zhclRn95l3RXd2eFbNWAsv/RG06E+Px8hvA=;
X-ME-Sender: <xms:uLH8ajpqtCAj8Xai1CW_vbZQMrjLF3Caq7kNDOF2hsXBhnKkRP3kSw>
    <xme:uLH8avOTZ3AwEYoZjvivJWAI0nLNBh2zOrgD1ap75JIzrfkJkn596g32QeRzO0WaE
    1xz0QOD6Pva3tjTDFxRSNojmqqyNAm94PK_KX_mciEKP7rIn0U>
X-ME-Received: <xmr:uLH8avfmlE9rZ5lo6AFhVQq8vqjdPAc51eABxi9j8_HYndWobOlvMC8PH_qUSyb0li5BjKd8Cc10W2s9M3F0mAPw01CGfVo>
X-ME-Proxy-Cause: dmFkZTEA1d/neZFqRb6e2cyZEut2KcqiYo2pL+wPjidRd/YMAjSsR4HZtJxmOtFhJbjPS5
    YtplEZNpoPys0VHwAO3xDpYuDMR13nwdU9u2gH2CC2I0m6TP9AsKnB/rSvhMORZUP/Rspi
    +4u8XREyoVeS/CAvmaboLdhNJw323ED1m3wbYHChkKYwN5TSx38LqrZ9Yi7P//oZogIocj
    sea3ZD4CvaNUrRxstKTAtSetUrKZw2p6UdyKdb1j0sMJsHBB+gtCUci+6PKuvVORz/f51e
    cYDS5liNxuASxgwvWOf6UGFk0Q/hGWmJwySGP9LX+oi/M2wZI3HaLguomp09E66HVg+KdV
    jyKS2bKHvdwcE5+TeVVv4/S5URrOgiVUi40d992v6IokBOx1hpfGWk87DPhUN0DEVLlK+n
    +ZqIeTmwVVicI95ov+oTMCh8wDLBIrKPP8DwQit6W/+ngGFLurALi2pVv60A0vyyGuYAmN
    gyvHYpSCYWr9bq34/caI2jkcVvuTM2VF8ksM2NyzzvRsI1ighVEyvKP/EGR0kzvcsP7Tku
    5oUMDB6bg26hSGsJqx6Y6V7HbqVBAknfy7OOaXi5uDCH6GiK11b8/Awaym9RlQ1h6IFmGL
    PaN77CNS4QeW7WBs2FqYuL1tdCKI3DXt9DgY3qQ5NOYFZQvmAP8ruCHkcANQ
X-ME-Proxy: <xmx:uLH8atUSm_KlpEO5vL1jHSvwsq5mg504m9K6PhC4uc3S8B5DRfzwug>
    <xmx:ubH8aoBw53ptZTqM5kA8LfjLCZDD6CKCYtreAzyJSWnj0JIK3vSmBw>
    <xmx:ubH8ag5lCEyBbFsN9qWnhmw08pBM1teFZ1JvOCY6mt4ovGm36fLyUg>
    <xmx:ubH8an28NbRNe3jn8u2QvjTfIvsR-AFWpbbTMppAys6gRFIB4UA2nw>
    <xmx:urH8atfj23_7_x5zK9Cc5D31klRw4g4v9qL2pJAvVZQp-V9KryTFmtkc>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 14:57:41 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Xiubo Li" <xiubli@kernel.org>
Cc: "Ilya Dryomov" <idryomov@gmail.com>, "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cephfs: prepare for changes to VFS locking
In-reply-to:
 <CAOuZWzxQEsqSS84ERExczbLBeyoh8RR=8L6sYMUw-nPj=sS9cw@mail.gmail.com>
References: <20261109202339.1380828-1-neilb@ownmail.net>
  <CAOuZWzxQEsqSS84ERExczbLBeyoh8RR=8L6sYMUw-nPj=sS9cw@mail.gmail.com>
Date: Wed, 18 Nov 2026 06:57:39 +1100
Message-id: <179494545935.1728055.18315721225187340860@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 10 Nov 2026, Xiubo Li wrote:
> On Tue, Nov 10, 2026 at 07:20:23AM +1100, NeilBrown wrote:
> > @@ -2230,7 +2226,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_reques=
t *req,
> >               if (inode_state_read_once(in) & I_NEW)
> >                       unlock_new_inode(in);
> >
> > -             if (d_really_is_negative(dn)) {
> > +             if (d_in_lookup(dn) || d_really_is_negative(dn)) {
>=20
> Nit: An in-lookup dentry is always negative: __d_instantiate() warns on one,
> and __d_add() ends the lookup before it sets the inode.  Here dn can only
> be in-lookup if d_alloc_trylock() has just allocated it for us, so
> d_really_is_negative(dn) already covers that case and the old test could
> stay as it was.  Feel free to keep it if you prefer it spelled out.

I think I would prefer to keep the d_in_lookup() test but it isn't a
strong preference.  In my mind an in-lookup dentry is neither positive or
negtive yet, though the d_inode is certainly NULL.

>=20
> Otherwise this looks good to me.
>=20
> Today ceph_readdir() runs with i_rwsem held exclusive (WRAP_DIR_ITER),
> so the -EWOULDBLOCK branch cannot be reached yet.  To exercise it, I ran
> a test-only build that drops the parent's shared lock in ceph_lookup()
> and sleeps 300ms while the dentry is in-lookup, which is what the lookup
> side will look like once d_alloc_parallel() moves above i_rwsem.  In
> that build, readdir replies met the in-lookup dentries
> (d_alloc_trylock() returned -EWOULDBLOCK 64 times over 4 rounds), and
> afterwards:
>  - the first and the second (cached) listing both showed every name,
>  - every lookup returned the inode the other client sees,
>  - there were no duplicate hashed dentries in the directory (checked
>    with drgn),
>  - the MDS cap count matched,
>  - KASAN and lockdep stayed quiet.

Thanks for this testing - I really appreciate it.

Thanks,
NeilBrown


>=20
> Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
> Tested-by: Xiubo Li <xiubo.li@clyso.com>
>=20
> Thanks
> Xiubo
>=20
> NeilBrown <neilb@ownmail.net> =E4=BA=8E2026=E5=B9=B411=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 21:25=E5=86=99=E9=81=93=EF=BC=9A
> >
> > This v2 drops 3/3 which was deprecating d_add() - there is no rush for
> > that so I'm not going to push it at present.
> > It also fixes the first patch to increment "skipped" when d_alloc_trylock=
()
> > returns -EWOULDBLOCK.
> >
> > The VFS patches that this series depends on are upstream, so this can
> > land in any tree.
> >
> > Thanks,
> > NeilBrown
> >
> > original intro:
> > I am working on changes to directory locking.  The medium term goal is
> > to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
> > can be run unlocked, and consequently cannot be called when ->i_rwsem is
> > held.
> >
> > The requires:
> >  1/ that d_alloc_parallel() not be called while i_rwsem is held and also
> >     that d_alloc()/d_splice_alias() not be used (unless the filesystems
> >     doesn't support creating objects).
> >     cephfs uses d_alloc()/d_splice_alias() when priming the dcache from
> >     the results of readdir.  A new interface d_alloc_trylock()
> >     is now available and can be used instead.
> >
> >  2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
> >     unlocked d_alloc_parallel() would then be able to create a new
> >     dentry with the same name.  cephfs calls d_drop() in couple of places
> >     before d_splice_alias() but this is no longer needed as d_splice_alia=
s()
> >     handles spliced aliases now.
> >
> >
> >  [PATCH v2 1/2] cephfs: Use d_alloc_trylock() in
> >  [PATCH v2 2/2] cephfs: Don't d_drop() before d_splice_alias()
> >
>=20


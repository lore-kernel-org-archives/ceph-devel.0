Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293415;
	b=bdLlBVa1JThN3ErkAMWyUVF4EcBgxhEWaAuT7870SuduBvEkdfPOmpJhP+AW3fMKsdLq
	 pF+JBRezijDEP3eN6e3lII7CyRkC0+sX31nEvc1LMNnaYUpup9nLu4UMx/RZr3RQ7pz4G
	 0maXPfYaxKoGN12xbSyzSWepS2dwHc0PT16Qy6TD69P7hvYGx5UV3lwfXJfId0RLsZs1d
	 Dxf6XUFS77l8m5b2F7O9CKUHbeQd7I+q6UWUjSIAGE5ItglnQcqv7B1CGdZoD7oAJsCrC
	 Hhnnee6p8Gmiae45mUpmeWOtUW50pDpoHOYfzGIrVaHK3w7AScm0Dg3qTj5sM9I3WVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293415;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7l7admDhKHWRr+9KKiexEyCEJJRCMQKRjoREwqhnmEA=;
	b=s92Fh5syHbMnWoWEGap0vlZBPyAQm5bHvV+BSKWWiUnsNXIYxg2EgfpxRfcjI+6PbQfc
	 RcK+Z1sJ7/lh8g83Ofdp6k5zq2/law3gBDYTrg3IpgnxIOWu1jr6o/cbxfEslFFjfddxE
	 TFk+RUSjXCbWvgZHQnUMOtdg1Tk99U3eCvEyT0XbHpR8NSBzlHvV0CuB5OSAcagoLYuJ9
	 RfX2DBmu+QrI09xpS0K+dFDYrrYK/+bj9657WtNRy/JTVLm2g9hVdZCcGW24fMKXwMj+j
	 DfUKqpvMcYk8T8RrSOhPHAQ36jFFLVZ6Sj7T0aBb9H57xfdJsFVv3u5XQnm+72/jeVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5lIyDTs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9DA606A31C
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5lIyDTs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544AD1F008A2
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794293414;
	bh=7l7admDhKHWRr+9KKiexEyCEJJRCMQKRjoREwqhnmEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z5lIyDTso0dF3UTryjxNYWMRH9OmA/ZuLb84XvtfphPqhUsQr+y0qxJI/Cq9jc/hA
	 gP80q6F4jpRCWYMqgx03e2FXUDFDFxGezx56SfTIRHGcR7T6hohamHjK5GBVgJxHBY
	 L7eHEIKkkwNeKbuT+LmNGBT8iOKN9bwe6Zb5i+eASIrYDF+H8xTgEdGy/Zn2WLgtAy
	 HlcbCwLTLwiDqhjjbQoG/d+J1GNgK0XUzaoASCW9NV3q+y0hdFaFZn+ytSXlPTZQNG
	 Zi5YhcrR5eDmZVhg/pwNdIk2TmZtjESPz4qPNmSHooh6nTS2UyL13fbmynZMRYYTKE
	 u0e1t3wFgxMOw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso1255918e87.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2026 22:50:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEV1nMk3QzEGEAVW2na6mNSD86wka1cIm0zwchBV2AZRSAdM7rBwRJFAZT6VeVuGoKvU/yIrHBrJWfD@vger.kernel.org
X-Gm-Message-State: APuU4Z/4p5NCFpG0/HJ5Be/AATEa6C5pKmYBKIHM2/BZpAzhxmfv8KmS
	5IQDdLdoyKvYuDbu+iHRLyjSjrSE/r+Cz+Lfr5efMeHhdPRNS2H1Gb0i6qxV5WRq7BM14LNVYTE
	1J8wmE0+wPnPWuqjjFKBPYnGwaX2xbU0=
X-Received: by 2002:a05:6512:39c7:b0:5bf:e31f:2f63 with SMTP id
 2adb3069b0e04-5c156e9ee81mr556739e87.24.1794293413101; Mon, 09 Nov 2026
 22:50:13 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109202339.1380828-1-neilb@ownmail.net>
In-Reply-To: <20261109202339.1380828-1-neilb@ownmail.net>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 10 Nov 2026 07:50:01 +0100
X-Gmail-Original-Message-ID: <CAOuZWzxQEsqSS84ERExczbLBeyoh8RR=8L6sYMUw-nPj=sS9cw@mail.gmail.com>
X-Gm-Features: AclHuK-LP0O68yT8RI-LwSnATqskCGt2zIjV7x8_J3ygMTkIzQUs4KmXHF1ZVvc
Message-ID: <CAOuZWzxQEsqSS84ERExczbLBeyoh8RR=8L6sYMUw-nPj=sS9cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cephfs: prepare for changes to VFS locking
To: NeilBrown <neil@brown.name>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 07:20:23AM +1100, NeilBrown wrote:
> @@ -2230,7 +2226,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_reques=
t *req,
>               if (inode_state_read_once(in) & I_NEW)
>                       unlock_new_inode(in);
>
> -             if (d_really_is_negative(dn)) {
> +             if (d_in_lookup(dn) || d_really_is_negative(dn)) {

Nit: An in-lookup dentry is always negative: __d_instantiate() warns on one=
,
and __d_add() ends the lookup before it sets the inode.  Here dn can only
be in-lookup if d_alloc_trylock() has just allocated it for us, so
d_really_is_negative(dn) already covers that case and the old test could
stay as it was.  Feel free to keep it if you prefer it spelled out.

Otherwise this looks good to me.

Today ceph_readdir() runs with i_rwsem held exclusive (WRAP_DIR_ITER),
so the -EWOULDBLOCK branch cannot be reached yet.  To exercise it, I ran
a test-only build that drops the parent's shared lock in ceph_lookup()
and sleeps 300ms while the dentry is in-lookup, which is what the lookup
side will look like once d_alloc_parallel() moves above i_rwsem.  In
that build, readdir replies met the in-lookup dentries
(d_alloc_trylock() returned -EWOULDBLOCK 64 times over 4 rounds), and
afterwards:
 - the first and the second (cached) listing both showed every name,
 - every lookup returned the inode the other client sees,
 - there were no duplicate hashed dentries in the directory (checked
   with drgn),
 - the MDS cap count matched,
 - KASAN and lockdep stayed quiet.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
Xiubo

NeilBrown <neilb@ownmail.net> =E4=BA=8E2026=E5=B9=B411=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 21:25=E5=86=99=E9=81=93=EF=BC=9A
>
> This v2 drops 3/3 which was deprecating d_add() - there is no rush for
> that so I'm not going to push it at present.
> It also fixes the first patch to increment "skipped" when d_alloc_trylock=
()
> returns -EWOULDBLOCK.
>
> The VFS patches that this series depends on are upstream, so this can
> land in any tree.
>
> Thanks,
> NeilBrown
>
> original intro:
> I am working on changes to directory locking.  The medium term goal is
> to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
> can be run unlocked, and consequently cannot be called when ->i_rwsem is
> held.
>
> The requires:
>  1/ that d_alloc_parallel() not be called while i_rwsem is held and also
>     that d_alloc()/d_splice_alias() not be used (unless the filesystems
>     doesn't support creating objects).
>     cephfs uses d_alloc()/d_splice_alias() when priming the dcache from
>     the results of readdir.  A new interface d_alloc_trylock()
>     is now available and can be used instead.
>
>  2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
>     unlocked d_alloc_parallel() would then be able to create a new
>     dentry with the same name.  cephfs calls d_drop() in couple of places
>     before d_splice_alias() but this is no longer needed as d_splice_alia=
s()
>     handles spliced aliases now.
>
>
>  [PATCH v2 1/2] cephfs: Use d_alloc_trylock() in
>  [PATCH v2 2/2] cephfs: Don't d_drop() before d_splice_alias()
>

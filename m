Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1340DFBB
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835564; cv=none; b=hG8dQCbWymtT4de+jDom7ubtNhEyOgmFoz67q9M9zjfO9YxFdVDlzm6EYfkxRCu4SuYtovlKuuPR4lrRdcLaxQRpnwFZfkX/bByZ0BWKJl2cpomJgMpr37ppdfwYDkUdMawdqI4e7C5qBB+estnbVt7SgjCm4hLety1wSn7ZcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835564; c=relaxed/simple;
	bh=QGjn0h8NSRZca48XCmcAPPi02MNk6xdPgE9XLeAOl0Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7aL/EeJpGywcfyxU1nRgR9QmITZC2yi7UaYsnHinmrbBbWAeY/ta6g63ItqxpDdAr2VrfdJqqkLlJVmrxMzo9DZadeRhQjntxUzuBmeumk91msglwd4Rpzp+Xq9MvzmPLLKlX5YvHsRhKd2pPJi+eBxqnM+UhDEPLC4y/VKGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=lGAAMvHw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="lGAAMvHw"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-804239c418bso46353607b3.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782835561; x=1783440361; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV6OxKDuDsCOOfUhUwx5E9h0wYjJ8BBeRhGIjauKZlw=;
        b=lGAAMvHwy1mpjccUQM1qAIo311rh3S/9zWtvGZA7NeDdkf5ao82Sl/qZoPJq2Pox1l
         MWDRZcEmjx8NeCA07ApouYeZ8YGLUpTRN8Zg0WPXyIaeNLo+muHN9hREk/tRbsn/yWRC
         lAjwkcRkpaQ7aprRefGXsQ+Qp3NWYo1j8XHChhSNOWEb9IcbEbZ49KQsE/mQw28sPt35
         xPcHgJIAA2Q/dwp7l/cR6eYEAn8mqpQ1e3haxFvMHo6TQQRzfu8DQgq0/ekKszgcypyx
         0L0pZiAe+491sfYKGqGnciBDqYl+cu6J6FraUj9jZNVRh2lQPnNg0RsLkN9e7pOVrCvd
         8jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835561; x=1783440361;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sV6OxKDuDsCOOfUhUwx5E9h0wYjJ8BBeRhGIjauKZlw=;
        b=k6FHBfndi7zG9Grqx3Tddpds2fizEa43DAlMyeJk6VrX8va0RAzWNW4YnxctwiEcN4
         6R/3Zqww7+z0x7uPXGkSZLy22MA4/vHmZC4f6hWDoNKSSV0v6gvhKWUJRnE8vgH+ovEn
         OaQIeq2YsfRWyK6w6QZ/oaBzGVoJyUlXRvKELJtXfPGY9/IhT8tBg2iPWJjr/sCB7mxw
         MXfbleurakTFuMN4z9OsX60X3j+wfCGfOmzGw4Tu7/X7PhjFWDTE9fb+gln/fOcOShTf
         cqn/jxkSWfJISNIRq7TE9Ok7VlozJDyfgr87lRSzmYfTZlUPgRBPP1FPxUatCcErYfS/
         WarA==
X-Forwarded-Encrypted: i=1; AHgh+RrvrfcZSwcGxUG2qsYXttbmi9VNh8/1K+e9ZVE7rED2wCZXXvbo/MCXU9ilpA39xSvIWGwWTD8m6Hx9@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAL3U5/mwaVQJzCoOX04BU2fxTy7ELbgbQYH57giUAPaDTwmA
	bHPy7mBJsWWrA5fOtyExIPiNJSoRKvLHoGL33sLtKmxmIrS5y4GAhpNcYL8kqzYnawM=
X-Gm-Gg: AfdE7ckEQ+IqOgIRCi2lFwNRvvIwV+JkCc3R9U6qKkolXz1TPZ/JjrY6Dz5tPYGCmPo
	FqOEWUQ3bliXT+xTCZLRAEAp42wjuRfHYo6KA8ZvTXo/+FzJ6b6/VJx57hyWhCl2HkJGCt5Ob4Y
	H3dp+gVtta3ox1JrXDUpBntHU4hEKtwCeh652BNSOMoJAbOEA0mgRuZfKdAIQs0uekNmewsspPD
	yZPC9XyB+q52WrNLdcl3PZ63ynyHok0fNpTRXCGXcR16NzyU08Mc6h/nR9Yokw0Q/2/rBPO4egc
	G+CxV0jklP+Pl344E22JnguhaBHvY5hz4HZCdZokLQ0NshyfdIi4Um8yRzSI5VWzkFqSl1kPY9j
	xUYi/6ePh/gwb0Uc4gqZT7GG9mVXcDO/ParPpwQujciN5AYk5OSywBERCvtJQF+uHWcW8js1KLo
	8GemUm1hDXHRgjlIXGxc8/B/kamvpWIs1W0oDd7NjjuI3nxOLg5s1I+TbHWcMb1u9w1zYIoaliC
	I6frmL3Ls4yUA7s85Huh5i/a3uIEYAkWztNVCoVujCX5u+tOsNPbmygJ7vtvfSObaSIZaMCQdE5
	x95KZDY=
X-Received: by 2002:a05:690c:c4ce:b0:80c:85e5:872c with SMTP id 00721157ae682-81203f4f6damr11490137b3.58.1782835560829;
        Tue, 30 Jun 2026 09:06:00 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e797364bsm12554747b3.17.2026.06.30.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:00 -0700 (PDT)
Message-ID: <4b9e77c1d8a3bc69a2b91fbba248bbe6939f406f.camel@dubeyko.com>
Subject: Re: [PATCH 03/12] include/ceph/ceph_fs.h: convert `pool_id` to u32
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 09:05:57 -0700
In-Reply-To: <20260612165204.86137-4-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
	 <20260612165204.86137-4-max.kellermann@ionos.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-12 at 18:51 +0200, Max Kellermann wrote:
> While the Ceph OSD protocol transmits OSD pool ids as 64 bit
> integers,
> the MDS protocol is limited to 32 bits.=C2=A0 This is a protocol
> limitation
> we cannot fix, but it gives us the chance to reduce the struct sizes
> by only using the integer size we really need.

We have tendency of growing capacity of file system volumes. I would
prefer to increase this value to u64 instead of decreasing to u32.

>=20
> There is one caveat: previously, -1 was used to indicate "invalid
> pool
> id".=C2=A0 This patch changes this magic value to 0 (i.e. removes the
> special-case code from ceph_file_layout_{from,to}_legacy()).=C2=A0 This i=
s
> fine because on the wire, this magic value is 0, too.

Potentially, we can use U64_MAX as invalid pool id.

Thanks,
Slava.

>=20
> This reduces the size of `struct ceph_inode_info` by 16 bytes
> (because
> it contains `struct ceph_file_layout` twice, and that struct shrinks
> by 8 bytes; the small pool_id now fits in the existing padding hole).
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/addr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++--------
> =C2=A0fs/ceph/caps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/ceph/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/ceph/mds_client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0fs/ceph/util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +-------
> =C2=A0fs/ceph/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++-----
> =C2=A0include/linux/ceph/ceph_fs.h |=C2=A0 2 +-
> =C2=A07 files changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 0a86f672cc09..a11b5c633358 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -2381,7 +2381,7 @@ enum {
> =C2=A0};
> =C2=A0
> =C2=A0static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
> -				s64 pool, struct ceph_string
> *pool_ns)
> +				u32 pool, struct ceph_string
> *pool_ns)
> =C2=A0{
> =C2=A0	struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(&ci-
> >netfs.inode);
> =C2=A0	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> @@ -2420,10 +2420,10 @@ static int __ceph_pool_perm_get(struct
> ceph_inode_info *ci,
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	if (pool_ns)
> -		doutc(cl, "pool %lld ns %.*s no perm cached\n",
> pool,
> +		doutc(cl, "pool %u ns %.*s no perm cached\n", pool,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (int)pool_ns->len, pool_ns->str);
> =C2=A0	else
> -		doutc(cl, "pool %lld no perm cached\n", pool);
> +		doutc(cl, "pool %u no perm cached\n", pool);
> =C2=A0
> =C2=A0	down_write(&mdsc->pool_perm_rwsem);
> =C2=A0	p =3D &mdsc->pool_perm_tree.rb_node;
> @@ -2548,10 +2548,10 @@ static int __ceph_pool_perm_get(struct
> ceph_inode_info *ci,
> =C2=A0	if (!err)
> =C2=A0		err =3D have;
> =C2=A0	if (pool_ns)
> -		doutc(cl, "pool %lld ns %.*s result =3D %d\n", pool,
> +		doutc(cl, "pool %u ns %.*s result =3D %d\n", pool,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (int)pool_ns->len, pool_ns->str, e=
rr);
> =C2=A0	else
> -		doutc(cl, "pool %lld result =3D %d\n", pool, err);
> +		doutc(cl, "pool %u result =3D %d\n", pool, err);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -2560,7 +2560,7 @@ int ceph_pool_perm_check(struct inode *inode,
> int need)
> =C2=A0	struct ceph_client *cl =3D ceph_inode_to_client(inode);
> =C2=A0	struct ceph_inode_info *ci =3D ceph_inode(inode);
> =C2=A0	struct ceph_string *pool_ns;
> -	s64 pool;
> +	u32 pool;
> =C2=A0	int ret, flags;
> =C2=A0
> =C2=A0	/* Only need to do this for regular files */
> @@ -2587,11 +2587,11 @@ int ceph_pool_perm_check(struct inode *inode,
> int need)
> =C2=A0check:
> =C2=A0	if (flags & CEPH_I_POOL_PERM) {
> =C2=A0		if ((need & CEPH_CAP_FILE_RD) && !(flags &
> CEPH_I_POOL_RD)) {
> -			doutc(cl, "pool %lld no read perm\n", pool);
> +			doutc(cl, "pool %u no read perm\n", pool);
> =C2=A0			return -EPERM;
> =C2=A0		}
> =C2=A0		if ((need & CEPH_CAP_FILE_WR) && !(flags &
> CEPH_I_POOL_WR)) {
> -			doutc(cl, "pool %lld no write perm\n",
> pool);
> +			doutc(cl, "pool %u no write perm\n", pool);
> =C2=A0			return -EPERM;
> =C2=A0		}
> =C2=A0		return 0;
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index d51454e995a8..cf9916608dc2 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3638,7 +3638,7 @@ static void handle_cap_grant(struct inode
> *inode,
> =C2=A0
> =C2=A0	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))
> {
> =C2=A0		/* file layout may have changed */
> -		s64 old_pool =3D ci->i_layout.pool_id;
> +		u32 old_pool =3D ci->i_layout.pool_id;
> =C2=A0		struct ceph_string *old_ns;
> =C2=A0
> =C2=A0		ceph_file_layout_from_legacy(&ci->i_layout, &grant-
> >layout);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 1504b889622c..c26217ed2034 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1175,7 +1175,7 @@ int ceph_fill_inode(struct inode *inode, struct
> page *locked_page,
> =C2=A0	if (new_version ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 (new_issued & (CEPH_CAP_ANY_FILE_RD |
> CEPH_CAP_ANY_FILE_WR))) {
> =C2=A0		u64 size =3D le64_to_cpu(info->size);
> -		s64 old_pool =3D ci->i_layout.pool_id;
> +		u32 old_pool =3D ci->i_layout.pool_id;
> =C2=A0		struct ceph_string *old_ns;
> =C2=A0
> =C2=A0		ceph_file_layout_from_legacy(&ci->i_layout, &info-
> >layout);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 4e6c87f8414c..7b848fdd6f70 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -396,7 +396,7 @@ struct ceph_mds_request {
> =C2=A0struct ceph_pool_perm {
> =C2=A0	struct rb_node node;
> =C2=A0	int perm;
> -	s64 pool;
> +	u32 pool;
> =C2=A0	size_t pool_ns_len;
> =C2=A0	char pool_ns[];
> =C2=A0};
> diff --git a/fs/ceph/util.c b/fs/ceph/util.c
> index 2c34875675bf..5bb40af08b1c 100644
> --- a/fs/ceph/util.c
> +++ b/fs/ceph/util.c
> @@ -35,9 +35,6 @@ void ceph_file_layout_from_legacy(struct
> ceph_file_layout *fl,
> =C2=A0	fl->stripe_count =3D le32_to_cpu(legacy->fl_stripe_count);
> =C2=A0	fl->object_size =3D le32_to_cpu(legacy->fl_object_size);
> =C2=A0	fl->pool_id =3D le32_to_cpu(legacy->fl_pg_pool);
> -	if (fl->pool_id =3D=3D 0 && fl->stripe_unit =3D=3D 0 &&
> -	=C2=A0=C2=A0=C2=A0 fl->stripe_count =3D=3D 0 && fl->object_size =3D=3D =
0)
> -		fl->pool_id =3D -1;
> =C2=A0}
> =C2=A0
> =C2=A0void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
> @@ -46,10 +43,7 @@ void ceph_file_layout_to_legacy(struct
> ceph_file_layout *fl,
> =C2=A0	legacy->fl_stripe_unit =3D cpu_to_le32(fl->stripe_unit);
> =C2=A0	legacy->fl_stripe_count =3D cpu_to_le32(fl->stripe_count);
> =C2=A0	legacy->fl_object_size =3D cpu_to_le32(fl->object_size);
> -	if (fl->pool_id >=3D 0)
> -		legacy->fl_pg_pool =3D cpu_to_le32(fl->pool_id);
> -	else
> -		legacy->fl_pg_pool =3D 0;
> +	legacy->fl_pg_pool =3D cpu_to_le32(fl->pool_id);
> =C2=A0}
> =C2=A0
> =C2=A0int ceph_flags_to_mode(int flags)
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index e773be07f767..9808eb10625d 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -50,7 +50,7 @@ static bool ceph_vxattrcb_layout_exists(struct
> ceph_inode_info *ci)
> =C2=A0{
> =C2=A0	struct ceph_file_layout *fl =3D &ci->i_layout;
> =C2=A0	return (fl->stripe_unit > 0 || fl->stripe_count > 0 ||
> -		fl->object_size > 0 || fl->pool_id >=3D 0 ||
> +		fl->object_size > 0 || fl->pool_id > 0 ||
> =C2=A0		rcu_dereference_raw(fl->pool_ns) !=3D NULL);
> =C2=A0}
> =C2=A0
> @@ -61,7 +61,7 @@ static ssize_t ceph_vxattrcb_layout(struct
> ceph_inode_info *ci, char *val,
> =C2=A0	struct ceph_client *cl =3D fsc->client;
> =C2=A0	struct ceph_osd_client *osdc =3D &fsc->client->osdc;
> =C2=A0	struct ceph_string *pool_ns;
> -	s64 pool =3D ci->i_layout.pool_id;
> +	u32 pool =3D ci->i_layout.pool_id;
> =C2=A0	const char *pool_name;
> =C2=A0	const char *ns_field =3D " pool_namespace=3D";
> =C2=A0	char buf[128];
> @@ -81,7 +81,7 @@ static ssize_t ceph_vxattrcb_layout(struct
> ceph_inode_info *ci, char *val,
> =C2=A0		total_len =3D len + strlen(pool_name);
> =C2=A0	} else {
> =C2=A0		len =3D snprintf(buf, sizeof(buf),
> -		"stripe_unit=3D%u stripe_count=3D%u object_size=3D%u
> pool=3D%lld",
> +		"stripe_unit=3D%u stripe_count=3D%u object_size=3D%u
> pool=3D%u",
> =C2=A0		ci->i_layout.stripe_unit, ci->i_layout.stripe_count,
> =C2=A0		ci->i_layout.object_size, pool);
> =C2=A0		total_len =3D len;
> @@ -164,7 +164,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct
> ceph_inode_info *ci,
> =C2=A0	ssize_t ret;
> =C2=A0	struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(ci-
> >netfs.inode.i_sb);
> =C2=A0	struct ceph_osd_client *osdc =3D &fsc->client->osdc;
> -	s64 pool =3D ci->i_layout.pool_id;
> +	u32 pool =3D ci->i_layout.pool_id;
> =C2=A0	const char *pool_name;
> =C2=A0
> =C2=A0	down_read(&osdc->lock);
> @@ -174,7 +174,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct
> ceph_inode_info *ci,
> =C2=A0		if (ret <=3D size)
> =C2=A0			memcpy(val, pool_name, ret);
> =C2=A0	} else {
> -		ret =3D ceph_fmt_xattr(val, size, "%lld", pool);
> +		ret =3D ceph_fmt_xattr(val, size, "%u", pool);
> =C2=A0	}
> =C2=A0	up_read(&osdc->lock);
> =C2=A0	return ret;
> diff --git a/include/linux/ceph/ceph_fs.h
> b/include/linux/ceph/ceph_fs.h
> index 69ac3e55a3fe..7faa18493a07 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -69,7 +69,7 @@ struct ceph_file_layout {
> =C2=A0	u32 stripe_unit;=C2=A0=C2=A0 /* stripe unit, in bytes */
> =C2=A0	u32 stripe_count;=C2=A0 /* over this many objects */
> =C2=A0	u32 object_size;=C2=A0=C2=A0 /* until objects are this big */
> -	s64 pool_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* rados pool id=
 */
> +	u32 pool_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* rados pool id=
 */
> =C2=A0	struct ceph_string __rcu *pool_ns; /* rados pool namespace
> */
> =C2=A0};
> =C2=A0

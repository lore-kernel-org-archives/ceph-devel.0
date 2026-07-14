Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFF417BF8
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054157; cv=none; b=jZ6+rQ2jE4JL+2yzcpALrkYg7O9jD/YrGELIInx27EVGPwB1A8S9gbtC0HQWCDGd49Iwvf7m0+u3zAkujWV86WaFrQrwWxOsAEvknIeEnDpNjWdgaB9k5iokJlQ+feeTbQRq81WL8l4NS5pe8n4y6gEMCQ9pz7Ct/wUb+8u94nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054157; c=relaxed/simple;
	bh=9T8bxQRx7suZaYWRf3PeL7rjO64RgxGEecJR3WPMBWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXTeNj2m9qJ0P9Z0YF2fNMTTy2W4zV1squJA/Ev3smo69tlduv+Q3Si7+Izb93WLaFcOuZEF//SvnAko+1y5/xvjkZwk26VmnK5URjNJPxJxfqLtdnoCqeTRctmyIrbFkpe7msym3LLSOY2UWr1CmpaiymFLV+/vCeXZoP/j8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ehnggEo9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ehnggEo9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80bb41f7f3cso13874597b3.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784054153; x=1784658953; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VIBkeErESQDFkfoajwguWG1RXxbwcQdbF+QJ3u0Fh4=;
        b=ehnggEo9cUft0XcX8pEPjEQ4bEkuQpbL8LtOgbqVVsFCNnfjCjwVueiGKM4WOxHRzB
         Yx2/uGzWMN0i1zJovOR7v4bvlaijBodV+yrwMXzEJHyw2os1iHJDH4FgUL/oH/PUYebU
         bXxurecILupkbWbC6ar8KswdPrGN44H60qQIxRm9S96GYAQbdcJm2DzVQz5d5RmOtiM4
         2gFz87CboFtRCGrVkELprYhnBM6PQCePA9eV1uje1tE5lY5jEzeqYAU6VXt2NUufn3kE
         f7n/0Tt4ZfOxmtlg+JbIKWTpnmAfs1xN46TYdW8M4DImnzLBKPtHZApqujCWa8RxJYtA
         IiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054153; x=1784658953;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7VIBkeErESQDFkfoajwguWG1RXxbwcQdbF+QJ3u0Fh4=;
        b=jOWl/Q1oyxUg2gZUAaEm/iDYW5VO9zfbgCdu6MFIFAfO0XLaNE90FdGybx5CEbHUr8
         s7Yn1DGT4YD1GQUHkMiD9vT3avlhnPrb8oXPj54SUFirj230Vk6zvHvATsyvMqtXCdzZ
         LRDGUJnNCVGkZ0ltneMexFOib45GZr6PysEOsW7sxc7Bxxosx8HlhhrwVdPD1PYlwhWR
         U2DMT951JgTvMw1pKi+LG6pCEjLaXoaP9/j3OOIz/PlPFv1Sz+xwyjGlX2InJCW3gmQE
         xyFEC67dNa06y4+Bs5dS0w6T/tEJLN+BpsU6cA0JwJhZJaki3igby6pEijzMfn4u2a2P
         J/YA==
X-Gm-Message-State: AOJu0YyG2u24Huuz9EVd7bepCtXvs+lQ/34FVNeGpGZu17likDar4rnm
	fiVNWQduYK9r4R3d9n3OKmbkDjLvpggmvQNHjlk0QtPEumyhFL0lYTCzKiaD1C3n49w=
X-Gm-Gg: AfdE7cldraABwhPv9Bz0A8BdXoRNxQEeZHoN3DxhAX80aCfRbI7b2iRXjvU4xZd42c1
	KIVAaFaNBLs+EpDOi7Ea6nj6DVS9KJHwl9o4fCgxmSRn1rV9+RYTMT//I9S1OxZracHxxyEwgZO
	vN5NogDy3V4PjZAaWhJ0PeUPb+m46FKFy6LX4GDS0SYB31owAspzGUFS/ZWxFcWB+O84h96Cjcv
	Cqi7nYNjDsjBprkYBAuOaLYriz6MrGBDFBEzSHFScS1b5t/J4V/EfBmv0uWHtUaIc0543zyj+T+
	DLnS0JII7GDy7e7OB0Psg4d3PEIypkLcdsDJfzJyfkTIyU/ggoOz/65bR7PBBXUlPDVevADRm43
	ZUZNcQL1b0Hxtw+sOi11TpCzgu1tbatbKhwl8omtjz4kAE/aAkxy94zhdM7KULAcdctVO8VTEKG
	lC6ianBOE7safL+D7nl57J8FQBFIsVjtX4JR8TDLAj80CGVC9NWlt7yeHjkQjgGE/D0RNWXIU64
	aabOsFPEbtPkFDnTN20ILs/MXbpgVt4qnpBBG/aQ9V6otI/RDCWMO4C5hVjxZZzBp18hBv7ZEme
	kP93eA==
X-Received: by 2002:a05:690c:7346:b0:80c:85e5:8741 with SMTP id 00721157ae682-81e902bd287mr102723307b3.63.1784054152874;
        Tue, 14 Jul 2026 11:35:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b87:2209:14fb:1802? ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bf37397sm148929687b3.16.2026.07.14.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:35:52 -0700 (PDT)
Message-ID: <4e8172e54217e10625a81e40ec0f6c253a568f04.camel@dubeyko.com>
Subject: Re: [PATCH 2/5] ceph: replace the request_tree rbtree with an
 xarray keyed by r_tid.
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 11:35:50 -0700
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-2-9ae5ac135c34@clyso.com>
References: 
	<20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	 <20260713-ceph-mdsc-mutex-optimization-v1-2-9ae5ac135c34@clyso.com>
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

On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> The xarray gives O(1) lookups by tid (vs O(log N) rbtree) and
> uses internal RCU-based locking, eliminating mdsc->mutex as a
> precondition for tree access and paving the way for lockless
> xa_load() in the future. Iteration is also cleaner: xa_for_each()
> and xa_find() replace the open-coded rb_first()/rb_next() walks.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/debugfs.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +--
> =C2=A0fs/ceph/mds_client.c | 109 ++++++++++++++++++++++------------------=
-
> ----------
> =C2=A0fs/ceph/mds_client.h |=C2=A0=C2=A0 3 +-
> =C2=A03 files changed, 50 insertions(+), 68 deletions(-)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 18eb5da03411..491ead3fe1c6 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -87,12 +87,12 @@ static int mdsc_show(struct seq_file *s, void *p)
> =C2=A0	struct ceph_fs_client *fsc =3D s->private;
> =C2=A0	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> =C2=A0	struct ceph_mds_request *req;
> -	struct rb_node *rp;
> +	unsigned long idx;
> =C2=A0	char *path;
> =C2=A0
> =C2=A0	mutex_lock(&mdsc->mutex);
> -	for (rp =3D rb_first(&mdsc->request_tree); rp; rp =3D
> rb_next(rp)) {
> -		req =3D rb_entry(rp, struct ceph_mds_request, r_node);
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> =C2=A0
> =C2=A0		if (req->r_request && req->r_session)
> =C2=A0			seq_printf(s, "%lld\tmds%d\t", req->r_tid,
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 98d0a5baff70..909f909b64ed 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1183,7 +1183,6 @@ void ceph_mdsc_release_request(struct kref
> *kref)
> =C2=A0	kmem_cache_free(ceph_mds_request_cachep, req);
> =C2=A0}
> =C2=A0
> -DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
> =C2=A0
> =C2=A0/*
> =C2=A0 * lookup session, bump ref if found.
> @@ -1195,7 +1194,7 @@ lookup_get_request(struct ceph_mds_client
> *mdsc, u64 tid)
> =C2=A0{
> =C2=A0	struct ceph_mds_request *req;
> =C2=A0
> -	req =3D lookup_request(&mdsc->request_tree, tid);
> +	req =3D xa_load(&mdsc->request_tree, tid);
> =C2=A0	if (req)
> =C2=A0		ceph_mdsc_get_request(req);
> =C2=A0
> @@ -1229,7 +1228,7 @@ static void __register_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	}
> =C2=A0	doutc(cl, "%p tid %lld\n", req, req->r_tid);
> =C2=A0	ceph_mdsc_get_request(req);
> -	insert_request(&mdsc->request_tree, req);
> +	xa_store(&mdsc->request_tree, req->r_tid, req, GFP_NOFS);

Should we check the return value of xa_store()? What about this?

        err =3D xa_err(xa_store(&mdsc->request_tree, req->r_tid, req,
GFP_NOFS));
        if (err) {
                ceph_mdsc_put_request(req);
                return err;
        }=20

> =C2=A0
> =C2=A0	req->r_cred =3D get_current_cred();
> =C2=A0	if (!req->r_mnt_idmap)
> @@ -1259,20 +1258,20 @@ static void __unregister_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	list_del_init(&req->r_unsafe_item);
> =C2=A0
> =C2=A0	if (req->r_tid =3D=3D atomic64_read(&mdsc->oldest_tid)) {
> -		struct rb_node *p =3D rb_next(&req->r_node);
> +		unsigned long tidx =3D req->r_tid + 1;
> +		struct ceph_mds_request *next_req;
> +
> =C2=A0		atomic64_set(&mdsc->oldest_tid, 0);
> -		while (p) {
> -			struct ceph_mds_request *next_req =3D
> -				rb_entry(p, struct ceph_mds_request,
> r_node);
> +		xa_for_each_start(&mdsc->request_tree, tidx,
> next_req, tidx) {
> =C2=A0			if (next_req->r_op !=3D
> CEPH_MDS_OP_SETFILELOCK) {
> -				atomic64_set(&mdsc->oldest_tid,
> next_req->r_tid);
> +				atomic64_set(&mdsc->oldest_tid,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 next_req->r_tid);
> =C2=A0				break;
> =C2=A0			}
> -			p =3D rb_next(p);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	erase_request(&mdsc->request_tree, req);
> +	xa_erase(&mdsc->request_tree, req->r_tid);
> =C2=A0
> =C2=A0	if (req->r_unsafe_dir) {
> =C2=A0		struct ceph_inode_info *ci =3D ceph_inode(req-
> >r_unsafe_dir);
> @@ -1829,7 +1828,7 @@ static void cleanup_session_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D mdsc->fsc->client;
> =C2=A0	struct ceph_mds_request *req;
> -	struct rb_node *p;
> +	unsigned long idx;
> =C2=A0
> =C2=A0	doutc(cl, "mds%d\n", session->s_mds);
> =C2=A0	mutex_lock(&mdsc->mutex);
> @@ -1845,10 +1844,8 @@ static void cleanup_session_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0		__unregister_request(mdsc, req);
> =C2=A0	}
> =C2=A0	/* zero r_attempts, so kick_requests() will re-send requests
> */
> -	p =3D rb_first(&mdsc->request_tree);
> -	while (p) {
> -		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> -		p =3D rb_next(p);
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> =C2=A0		if (req->r_session &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 req->r_session->s_mds =3D=3D session->s_mds)
> =C2=A0			req->r_attempts =3D 0;
> @@ -2732,7 +2729,6 @@ ceph_mdsc_create_request(struct ceph_mds_client
> *mdsc, int op, int mode)
> =C2=A0	req->r_fmode =3D -1;
> =C2=A0	req->r_feature_needed =3D -1;
> =C2=A0	kref_init(&req->r_kref);
> -	RB_CLEAR_NODE(&req->r_node);
> =C2=A0	INIT_LIST_HEAD(&req->r_wait);
> =C2=A0	init_completion(&req->r_completion);
> =C2=A0	init_completion(&req->r_safe_completion);
> @@ -2752,10 +2748,9 @@ ceph_mdsc_create_request(struct
> ceph_mds_client *mdsc, int op, int mode)
> =C2=A0 */
> =C2=A0static struct ceph_mds_request *__get_oldest_req(struct
> ceph_mds_client *mdsc)
> =C2=A0{
> -	if (RB_EMPTY_ROOT(&mdsc->request_tree))
> -		return NULL;
> -	return rb_entry(rb_first(&mdsc->request_tree),
> -			struct ceph_mds_request, r_node);
> +	unsigned long idx =3D 0;
> +
> +	return xa_find(&mdsc->request_tree, &idx, ULONG_MAX,
> XA_PRESENT);
> =C2=A0}
> =C2=A0
> =C2=A0static inline=C2=A0 u64 __get_oldest_tid(struct ceph_mds_client *md=
sc)
> @@ -3816,12 +3811,11 @@ static void kick_requests(struct
> ceph_mds_client *mdsc, int mds)
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D mdsc->fsc->client;
> =C2=A0	struct ceph_mds_request *req;
> -	struct rb_node *p =3D rb_first(&mdsc->request_tree);
> +	unsigned long idx;
> =C2=A0
> =C2=A0	doutc(cl, "kick_requests mds%d\n", mds);
> -	while (p) {
> -		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> -		p =3D rb_next(p);
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> =C2=A0		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> >r_req_flags))
> =C2=A0			continue;
> =C2=A0		if (req->r_attempts > 0)
> @@ -4654,7 +4648,7 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0				=C2=A0=C2=A0 struct ceph_mds_session *session)
> =C2=A0{
> =C2=A0	struct ceph_mds_request *req, *nreq;
> -	struct rb_node *p;
> +	unsigned long idx;
> =C2=A0
> =C2=A0	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
> =C2=A0
> @@ -4666,10 +4660,8 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0	 * also re-send old requests when MDS enters reconnect
> stage. So that MDS
> =C2=A0	 * can process completed request in clientreplay stage.
> =C2=A0	 */
> -	p =3D rb_first(&mdsc->request_tree);
> -	while (p) {
> -		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> -		p =3D rb_next(p);
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> =C2=A0		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> >r_req_flags))
> =C2=A0			continue;
> =C2=A0		if (req->r_attempts =3D=3D 0)
> @@ -5514,7 +5506,7 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0	 */
> =C2=A0	{
> =C2=A0		struct ceph_mds_request *req;
> -		struct rb_node *rn;
> +		unsigned long idx;
> =C2=A0		u64 last_tid;
> =C2=A0
> =C2=A0		mutex_lock(&mdsc->mutex);
> @@ -5522,14 +5514,12 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0		mutex_unlock(&mdsc->mutex);
> =C2=A0
> =C2=A0		mutex_lock(&mdsc->mutex);
> -		rn =3D rb_first(&mdsc->request_tree);
> -		while (rn) {
> -			req =3D rb_entry(rn, struct ceph_mds_request,
> r_node);
> -			if (req->r_tid > last_tid)
> -				break;
> +		idx =3D 0;
> +		while ((req =3D xa_find(&mdsc->request_tree, &idx,
> last_tid,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XA_PRESENT))) {
> =C2=A0			if (req->r_op =3D=3D CEPH_MDS_OP_SETFILELOCK ||
> =C2=A0			=C2=A0=C2=A0=C2=A0 !(req->r_op & CEPH_MDS_OP_WRITE)) {
> -				rn =3D rb_next(rn);
> +				idx++;
> =C2=A0				continue;
> =C2=A0			}
> =C2=A0			ceph_mdsc_get_request(req);
> @@ -5542,7 +5532,7 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0			ceph_mdsc_put_request(req);
> =C2=A0			if (time_after(jiffies, drain_deadline))
> =C2=A0				break;
> -			rn =3D rb_first(&mdsc->request_tree);
> +			idx =3D 0;=C2=A0 /* restart: tree may have changed
> */
> =C2=A0		}
> =C2=A0		mutex_unlock(&mdsc->mutex);
> =C2=A0
> @@ -6268,7 +6258,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> =C2=A0	mdsc->snap_realms =3D RB_ROOT;
> =C2=A0	INIT_LIST_HEAD(&mdsc->snap_empty);
> =C2=A0	spin_lock_init(&mdsc->snap_empty_lock);
> -	mdsc->request_tree =3D RB_ROOT;
> +	xa_init(&mdsc->request_tree);
> =C2=A0	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
> =C2=A0	mdsc->last_renew_caps =3D jiffies;
> =C2=A0	INIT_LIST_HEAD(&mdsc->cap_delay_list);
> @@ -6590,34 +6580,33 @@ static void
> flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
> =C2=A0						 u64 want_tid)
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D mdsc->fsc->client;
> -	struct ceph_mds_request *req =3D NULL, *nextreq;
> +	struct ceph_mds_request *req;
> =C2=A0	struct ceph_mds_session *last_session =3D NULL;
> -	struct rb_node *n;
> +	unsigned long idx;
> =C2=A0
> =C2=A0	mutex_lock(&mdsc->mutex);
> =C2=A0	doutc(cl, "want %lld\n", want_tid);
> -restart:
> -	req =3D __get_oldest_req(mdsc);
> -	while (req && req->r_tid <=3D want_tid) {
> -		/* find next request */
> -		n =3D rb_next(&req->r_node);
> -		if (n)
> -			nextreq =3D rb_entry(n, struct
> ceph_mds_request, r_node);
> -		else
> -			nextreq =3D NULL;
> -		if (req->r_op !=3D CEPH_MDS_OP_SETFILELOCK &&
> -		=C2=A0=C2=A0=C2=A0 (req->r_op & CEPH_MDS_OP_WRITE)) {
> +	idx =3D 0;
> +	while ((req =3D xa_find(&mdsc->request_tree, &idx, want_tid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XA_PRESENT))) {
> +		u64 next_tid =3D req->r_tid + 1;
> +
> +		if (req->r_op =3D=3D CEPH_MDS_OP_SETFILELOCK ||
> +		=C2=A0=C2=A0=C2=A0 !(req->r_op & CEPH_MDS_OP_WRITE)) {
> +			idx =3D next_tid;
> +			continue;
> +		}
> +
> +		{
> =C2=A0			struct ceph_mds_session *s =3D req->r_session;
> =C2=A0
> =C2=A0			if (!s) {
> -				req =3D nextreq;
> +				idx =3D next_tid;
> =C2=A0				continue;
> =C2=A0			}
> =C2=A0
> =C2=A0			/* write op */
> =C2=A0			ceph_mdsc_get_request(req);
> -			if (nextreq)
> -				ceph_mdsc_get_request(nextreq);
> =C2=A0			s =3D ceph_get_mds_session(s);
> =C2=A0			mutex_unlock(&mdsc->mutex);
> =C2=A0
> @@ -6635,16 +6624,9 @@ static void
> flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
> =C2=A0
> =C2=A0			mutex_lock(&mdsc->mutex);
> =C2=A0			ceph_mdsc_put_request(req);
> -			if (!nextreq)
> -				break;=C2=A0 /* next dne before, so we're
> done! */
> -			if (RB_EMPTY_NODE(&nextreq->r_node)) {
> -				/* next request was removed from
> tree */
> -				ceph_mdsc_put_request(nextreq);
> -				goto restart;
> -			}
> -			ceph_mdsc_put_request(nextreq);=C2=A0 /* won't go
> away */
> +			/* restart from the next tid; tree may have
> changed */
> +			idx =3D next_tid;
> =C2=A0		}
> -		req =3D nextreq;
> =C2=A0	}
> =C2=A0	mutex_unlock(&mdsc->mutex);
> =C2=A0	ceph_put_mds_session(last_session);
> @@ -6803,6 +6785,7 @@ static void ceph_mdsc_stop(struct
> ceph_mds_client *mdsc)
> =C2=A0	if (mdsc->mdsmap)
> =C2=A0		ceph_mdsmap_destroy(mdsc->mdsmap);
> =C2=A0	kfree(mdsc->sessions);
> +	xa_destroy(&mdsc->request_tree);
> =C2=A0	ceph_caps_finalize(mdsc);
> =C2=A0
> =C2=A0	if (mdsc->s_cap_auths) {
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 3b614b5df18c..00ca993ed583 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -329,7 +329,6 @@ typedef int (*ceph_mds_request_wait_callback_t)
> (struct ceph_mds_client *mdsc,
> =C2=A0 */
> =C2=A0struct ceph_mds_request {
> =C2=A0	u64 r_tid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* transaction id */
> -	struct rb_node r_node;
> =C2=A0	struct ceph_mds_client *r_mdsc;
> =C2=A0
> =C2=A0	struct kref=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r_kref;
> @@ -534,7 +533,7 @@ struct ceph_mds_client {
> =C2=A0	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_tid;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* most recent mds
> request */
> =C2=A0	atomic64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 oldest_tid;=C2=A0=C2=A0=C2=A0 /* oldest incomplete
> mds request,
> =C2=A0						 excluding
> setfilelock requests */
> -	struct rb_root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request_=
tree;=C2=A0 /* pending mds
> requests */
> +	struct xarray=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 request_tree;=C2=A0 /* pending mds
> requests */

Transaction IDs are u64; xarray indices are unsigned long. req->r_tid,
mdsc->last_tid, and want_tid/last_tid in the drain paths are all u64,
but xa_store(), xa_load(), xa_erase(), and xa_find()'s max parameter
all take unsigned long. CEPH_FS in fs/ceph/Kconfig only depends on INET
=E2=80=94 it's not gated on 64BIT =E2=80=94 so this driver still builds for=
 32-bit
targets, where unsigned long truncates r_tid to 32 bits. Are we safe
here?

Thanks,
Slava.

> =C2=A0	struct delayed_work=C2=A0=C2=A0=C2=A0 delayed_work;=C2=A0 /* delay=
ed work */
> =C2=A0	unsigned long=C2=A0=C2=A0=C2=A0 last_renew_caps;=C2=A0 /* last tim=
e we renewed
> our caps */
> =C2=A0	struct list_head cap_delay_list;=C2=A0=C2=A0 /* caps with delayed
> release */

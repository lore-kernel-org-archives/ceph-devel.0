Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FE4CA28E
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139938; cv=none; b=jsQdMlmn8NDnNCqhDmR8joqnhyZjeGysO1JnbuzekAgAiShsvZNSBKPVIFo5sxiJjNKgJ2gGxuZ6rBxwzss5VM8JuAy13HzuZ9M6VYUJW1Ak3mBznkPxS/ZxKDM/GbIuQl4GdXLDGZRM1ciwzH7+BAulNlFPBDJljLrzYUZUtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139938; c=relaxed/simple;
	bh=MJekRq2UNTY0zUz5ecf4+a7kncmyDRDUfsSDF7/0XNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9tXS87FAWk04nCH5Par6HC+0boGd3xAVBdTR/TFmqy+q3yqxloZBuhI4zV/MXnDp0wbTKnV8elBbuXn015ZKtqVtm14uEITFrJLV2nSYwOIVDArPd3mgItftmOQ4HWUjq15Qw6snY+1HLWIZrSfC7FRNP7KPl5hmgTxf1jU5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qZ/gJBKd; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qZ/gJBKd"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6682259cae6so468645d50.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784139928; x=1784744728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRyh0LFXPFEKMLuZC0MlFV4X101ZYoTfPLdAR5YQQUI=;
        b=qZ/gJBKd15v3vEHyqzq5JESk7X8S7Tp6V3sGN9IzZJ+axg5neIDGp7AUUTx/84H7pM
         P+Lezey6owSplb13FjPnnn2/JmW0UqMv2GUIVApiVWX5Q8N0LuHAWp65JAaQA0jgnFg1
         LPxoHqLaRPsgVxcy9RH+FCrH5JlFdFdiPfOfj6dtz6XBJW4bd3PetTAGNjeuunmWLaPh
         S9wWRA61xF/BlJv6JFGof0fw+eSiX00xjW7CVaRSF5y+f4ariV8/mcs5tJH5VMQbpya0
         fj2WrgNGHmMUyPVb3arhqaK22GTQFInbiFVQsHfsfyhzPk492FarlU4QbbWNcvoL+Hwl
         hpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139928; x=1784744728;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iRyh0LFXPFEKMLuZC0MlFV4X101ZYoTfPLdAR5YQQUI=;
        b=bt9+gVumIr1oZ0QKgXczFvZsfFEn8tmzeiCsXcRYNI39ZWmP/TzqhT6AJfzg1xTAxk
         rpj7ly6d6/JuiE4ZBbZgDbVA61Oh7YVmoeae5xyJWgElJApkLUblLw3tNSt4Tmw9m668
         NeF3cwbEnVqtLfLhN/ML9FALqUY6aqQECcjrSvtPt2DzoWtM1XvEFdyIUboW5omxMnns
         +F36k38xUrzz/7PL1SE4ECqh2lp1rBV+4/zeejnbVKuc4jiQSvc/2tbN0Q+mL4UZp0u/
         IgCCLnUH0tZ5SB8Z9FlGj3lVKgpCDjhrQhkv1cp6XLz6tXSieQ5F6WMp8c68i3EVNR1+
         0AOA==
X-Gm-Message-State: AOJu0Yx/tSyJqRVIDNVveiT0hrf+lTEnXmv/I3NxGZ3J+33y7I+T+Wwp
	YERVZZvv1/ivng0JxV/iGJxnabenqgkfuPN3rwghUuoMYKXbc8MgmRs7WDcDza+0mYTIhHDMLQT
	/bCGkFBhF+A==
X-Gm-Gg: AfdE7cmDzhDrCKgrhvnfr1OAOnTQkSUEbwJ82/uGj//+I9xJi0K+bD3+3c1mGpEo8Y3
	Vdck0U9OS/h75iM3Xbx32zUosx8puYwjtxNFQomsvd7KRAjC/deChBFM1z9nSwsJmew0NR60Zyn
	pwpWbNz/lWRLdPVk7251FT+kMFLgRS+4m6AnLQxttjIvoyT5MDhvnLWdmY53WPYJ3e7sTn2lbnz
	K1tW/vEVAiSiieLSFvJdlxmB/7yL8CwYNADjgHE+4cxXcUg+gOP3goTAZjIGOliOe+BRIXzgqVa
	DtG110B7MWpHYOIzE9CBYbs8XMQSvzPO7X9BLfhQ6c5hq8JcAe0Z5tYAsfw17SSdkGWqlW8VEHO
	XkNBIR+2toH38T9aqBm8eL7VMzJsJQdBz1EJB6ZCMzW0aAFq6vybyJWWGl0e1iLXXZiEA69FBrP
	Mb66+ErUc/9ALJ7VV0okec/xZwUfZOrrC4Wb2GUBfmba7Juh3ZNO/PdwI1HGqYsGZ/WRMZmw8Bo
	OrmhSjVdTQd6vpXJuJOgqDiztr+ZnmQ2IUffSkwnvmQBJBPf2G1e2AbRyAHVFQFklbKD8le46hg
	xkQ=
X-Received: by 2002:a53:b6cb:0:b0:667:aec2:a8ff with SMTP id 956f58d0204a3-6681339aa85mr2256932d50.52.1784139928096;
        Wed, 15 Jul 2026 11:25:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:393f:38b4:2407:391? ([2600:1700:6476:1430:393f:38b4:2407:391])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6681fdeb112sm1218239d50.13.2026.07.15.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:25:27 -0700 (PDT)
Message-ID: <4bbb0109d2d37a17c9a9bfcadf52923609115c35.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/5] ceph: replace the request_tree rbtree with an
 xarray keyed by r_tid.
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 11:25:26 -0700
In-Reply-To: <20260715-ceph-mdsc-mutex-optimization-v2-2-90e81b726724@clyso.com>
References: 
	<20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
	 <20260715-ceph-mdsc-mutex-optimization-v2-2-90e81b726724@clyso.com>
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

On Wed, 2026-07-15 at 11:58 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> The xarray gives O(1) lookups by tid (vs O(log N) rbtree) and
> uses internal RCU-based locking, eliminating mdsc->mutex as a
> precondition for tree access and paving the way for lockless
> xa_load() in the future. In practise this yields a 13x reduction
> of handle_reply mutex hold time, from 51-416us down to 10-32us,
> due to parse_reply_info() no longer being protected by the global
> mutex.
>=20
> Check xa_store() for allocation failure, which would otherwise be
> silent, and skip __do_request() in the submit path if registration
> failed.
>=20
> On 32-bit architectures xarray silently truncates u64 keys because
> its index type is unsigned long.=C2=A0 Guard the entire conversion by
> BITS_PER_LONG=3D=3D64 and fall back to the original rbtree on 32-bit
> so there is no regression from the current code.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/debugfs.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +++
> =C2=A0fs/ceph/mds_client.c | 160
> +++++++++++++++++++++++++++++++++++++++++++++++++--
> =C2=A0fs/ceph/mds_client.h |=C2=A0 10 +++-
> =C2=A03 files changed, 173 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 18eb5da03411..f0d0b9b04b79 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -87,12 +87,21 @@ static int mdsc_show(struct seq_file *s, void *p)
> =C2=A0	struct ceph_fs_client *fsc =3D s->private;
> =C2=A0	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> =C2=A0	struct ceph_mds_request *req;
> +#if BITS_PER_LONG =3D=3D 64
> +	unsigned long idx;
> +#else
> =C2=A0	struct rb_node *rp;
> +#endif
> =C2=A0	char *path;
> =C2=A0
> =C2=A0	mutex_lock(&mdsc->mutex);
> +#if BITS_PER_LONG =3D=3D 64
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> +#else
> =C2=A0	for (rp =3D rb_first(&mdsc->request_tree); rp; rp =3D
> rb_next(rp)) {
> =C2=A0		req =3D rb_entry(rp, struct ceph_mds_request, r_node);
> +#endif
> =C2=A0
> =C2=A0		if (req->r_request && req->r_session)
> =C2=A0			seq_printf(s, "%lld\tmds%d\t", req->r_tid,
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 98d0a5baff70..239ed34886f9 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1183,7 +1183,9 @@ void ceph_mdsc_release_request(struct kref
> *kref)
> =C2=A0	kmem_cache_free(ceph_mds_request_cachep, req);
> =C2=A0}
> =C2=A0
> +#if BITS_PER_LONG !=3D 64
> =C2=A0DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
> +#endif
> =C2=A0
> =C2=A0/*
> =C2=A0 * lookup session, bump ref if found.
> @@ -1195,7 +1197,11 @@ lookup_get_request(struct ceph_mds_client
> *mdsc, u64 tid)
> =C2=A0{
> =C2=A0	struct ceph_mds_request *req;
> =C2=A0
> +#if BITS_PER_LONG =3D=3D 64
> +	req =3D xa_load(&mdsc->request_tree, tid);
> +#else
> =C2=A0	req =3D lookup_request(&mdsc->request_tree, tid);
> +#endif
> =C2=A0	if (req)
> =C2=A0		ceph_mdsc_get_request(req);
> =C2=A0
> @@ -1229,7 +1235,17 @@ static void __register_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	}
> =C2=A0	doutc(cl, "%p tid %lld\n", req, req->r_tid);
> =C2=A0	ceph_mdsc_get_request(req);

It looks like we get request before failure check. And the failure path
returns without undoing it. I believe we have issue here.

Thanks,
Slava.

> +#if BITS_PER_LONG =3D=3D 64
> +	if (xa_is_err(xa_store(&mdsc->request_tree, req->r_tid, req,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOFS))) {
> +		pr_err_client(cl, "%p tid %lld: xa_store failed\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req, req->r_tid);
> +		req->r_err =3D -ENOMEM;
> +		return;
> +	}
> +#else
> =C2=A0	insert_request(&mdsc->request_tree, req);
> +#endif
> =C2=A0
> =C2=A0	req->r_cred =3D get_current_cred();
> =C2=A0	if (!req->r_mnt_idmap)
> @@ -1259,6 +1275,19 @@ static void __unregister_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	list_del_init(&req->r_unsafe_item);
> =C2=A0
> =C2=A0	if (req->r_tid =3D=3D atomic64_read(&mdsc->oldest_tid)) {
> +#if BITS_PER_LONG =3D=3D 64
> +		unsigned long tidx =3D req->r_tid + 1;
> +		struct ceph_mds_request *next_req;
> +
> +		atomic64_set(&mdsc->oldest_tid, 0);
> +		xa_for_each_start(&mdsc->request_tree, tidx,
> next_req, tidx) {
> +			if (next_req->r_op !=3D
> CEPH_MDS_OP_SETFILELOCK) {
> +				atomic64_set(&mdsc->oldest_tid,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 next_req->r_tid);
> +				break;
> +			}
> +		}
> +#else
> =C2=A0		struct rb_node *p =3D rb_next(&req->r_node);
> =C2=A0		atomic64_set(&mdsc->oldest_tid, 0);
> =C2=A0		while (p) {
> @@ -1270,9 +1299,14 @@ static void __unregister_request(struct
> ceph_mds_client *mdsc,
> =C2=A0			}
> =C2=A0			p =3D rb_next(p);
> =C2=A0		}
> +#endif
> =C2=A0	}
> =C2=A0
> +#if BITS_PER_LONG =3D=3D 64
> +	xa_erase(&mdsc->request_tree, req->r_tid);
> +#else
> =C2=A0	erase_request(&mdsc->request_tree, req);
> +#endif
> =C2=A0
> =C2=A0	if (req->r_unsafe_dir) {
> =C2=A0		struct ceph_inode_info *ci =3D ceph_inode(req-
> >r_unsafe_dir);
> @@ -1829,7 +1863,11 @@ static void cleanup_session_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D mdsc->fsc->client;
> =C2=A0	struct ceph_mds_request *req;
> +#if BITS_PER_LONG =3D=3D 64
> +	unsigned long idx;
> +#else
> =C2=A0	struct rb_node *p;
> +#endif
> =C2=A0
> =C2=A0	doutc(cl, "mds%d\n", session->s_mds);
> =C2=A0	mutex_lock(&mdsc->mutex);
> @@ -1845,6 +1883,14 @@ static void cleanup_session_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0		__unregister_request(mdsc, req);
> =C2=A0	}
> =C2=A0	/* zero r_attempts, so kick_requests() will re-send requests
> */
> +#if BITS_PER_LONG =3D=3D 64
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> +		if (req->r_session &&
> +		=C2=A0=C2=A0=C2=A0 req->r_session->s_mds =3D=3D session->s_mds)
> +			req->r_attempts =3D 0;
> +	}
> +#else
> =C2=A0	p =3D rb_first(&mdsc->request_tree);
> =C2=A0	while (p) {
> =C2=A0		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> @@ -1853,6 +1899,7 @@ static void cleanup_session_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0		=C2=A0=C2=A0=C2=A0 req->r_session->s_mds =3D=3D session->s_mds)
> =C2=A0			req->r_attempts =3D 0;
> =C2=A0	}
> +#endif
> =C2=A0	mutex_unlock(&mdsc->mutex);
> =C2=A0}
> =C2=A0
> @@ -2732,7 +2779,9 @@ ceph_mdsc_create_request(struct ceph_mds_client
> *mdsc, int op, int mode)
> =C2=A0	req->r_fmode =3D -1;
> =C2=A0	req->r_feature_needed =3D -1;
> =C2=A0	kref_init(&req->r_kref);
> +#if BITS_PER_LONG !=3D 64
> =C2=A0	RB_CLEAR_NODE(&req->r_node);
> +#endif
> =C2=A0	INIT_LIST_HEAD(&req->r_wait);
> =C2=A0	init_completion(&req->r_completion);
> =C2=A0	init_completion(&req->r_safe_completion);
> @@ -2752,10 +2801,16 @@ ceph_mdsc_create_request(struct
> ceph_mds_client *mdsc, int op, int mode)
> =C2=A0 */
> =C2=A0static struct ceph_mds_request *__get_oldest_req(struct
> ceph_mds_client *mdsc)
> =C2=A0{
> +#if BITS_PER_LONG =3D=3D 64
> +	unsigned long idx =3D 0;
> +
> +	return xa_find(&mdsc->request_tree, &idx, ULONG_MAX,
> XA_PRESENT);
> +#else
> =C2=A0	if (RB_EMPTY_ROOT(&mdsc->request_tree))
> =C2=A0		return NULL;
> =C2=A0	return rb_entry(rb_first(&mdsc->request_tree),
> =C2=A0			struct ceph_mds_request, r_node);
> +#endif
> =C2=A0}
> =C2=A0
> =C2=A0static inline=C2=A0 u64 __get_oldest_tid(struct ceph_mds_client *md=
sc)
> @@ -3816,12 +3871,20 @@ static void kick_requests(struct
> ceph_mds_client *mdsc, int mds)
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D mdsc->fsc->client;
> =C2=A0	struct ceph_mds_request *req;
> -	struct rb_node *p =3D rb_first(&mdsc->request_tree);
> +#if BITS_PER_LONG =3D=3D 64
> +	unsigned long idx;
> +#else
> +	struct rb_node *p;
> +#endif
> =C2=A0
> =C2=A0	doutc(cl, "kick_requests mds%d\n", mds);
> -	while (p) {
> +#if BITS_PER_LONG =3D=3D 64
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> +#else
> +	for (p =3D rb_first(&mdsc->request_tree); p; p =3D rb_next(p)) {
> =C2=A0		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> -		p =3D rb_next(p);
> +#endif
> =C2=A0		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> >r_req_flags))
> =C2=A0			continue;
> =C2=A0		if (req->r_attempts > 0)
> @@ -3894,7 +3957,8 @@ int ceph_mdsc_submit_request(struct
> ceph_mds_client *mdsc, struct inode *dir,
> =C2=A0	mutex_lock(&mdsc->mutex);
> =C2=A0	__register_request(mdsc, req, dir);
> =C2=A0	trace_ceph_mdsc_submit_request(mdsc, req);
> -	__do_request(mdsc, req);
> +	if (!req->r_err)
> +		__do_request(mdsc, req);
> =C2=A0	err =3D req->r_err;
> =C2=A0	mutex_unlock(&mdsc->mutex);
> =C2=A0	return err;
> @@ -4654,7 +4718,11 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0				=C2=A0=C2=A0 struct ceph_mds_session *session)
> =C2=A0{
> =C2=A0	struct ceph_mds_request *req, *nreq;
> +#if BITS_PER_LONG =3D=3D 64
> +	unsigned long idx;
> +#else
> =C2=A0	struct rb_node *p;
> +#endif
> =C2=A0
> =C2=A0	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
> =C2=A0
> @@ -4666,10 +4734,15 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0	 * also re-send old requests when MDS enters reconnect
> stage. So that MDS
> =C2=A0	 * can process completed request in clientreplay stage.
> =C2=A0	 */
> +#if BITS_PER_LONG =3D=3D 64
> +	idx =3D 0;
> +	xa_for_each(&mdsc->request_tree, idx, req) {
> +#else
> =C2=A0	p =3D rb_first(&mdsc->request_tree);
> =C2=A0	while (p) {
> =C2=A0		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> =C2=A0		p =3D rb_next(p);
> +#endif
> =C2=A0		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> >r_req_flags))
> =C2=A0			continue;
> =C2=A0		if (req->r_attempts =3D=3D 0)
> @@ -5514,7 +5587,11 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0	 */
> =C2=A0	{
> =C2=A0		struct ceph_mds_request *req;
> +#if BITS_PER_LONG =3D=3D 64
> +		unsigned long idx;
> +#else
> =C2=A0		struct rb_node *rn;
> +#endif
> =C2=A0		u64 last_tid;
> =C2=A0
> =C2=A0		mutex_lock(&mdsc->mutex);
> @@ -5522,14 +5599,24 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0		mutex_unlock(&mdsc->mutex);
> =C2=A0
> =C2=A0		mutex_lock(&mdsc->mutex);
> +#if BITS_PER_LONG =3D=3D 64
> +		idx =3D 0;
> +		while ((req =3D xa_find(&mdsc->request_tree, &idx,
> last_tid,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XA_PRESENT))) {
> +#else
> =C2=A0		rn =3D rb_first(&mdsc->request_tree);
> =C2=A0		while (rn) {
> =C2=A0			req =3D rb_entry(rn, struct ceph_mds_request,
> r_node);
> =C2=A0			if (req->r_tid > last_tid)
> =C2=A0				break;
> +#endif
> =C2=A0			if (req->r_op =3D=3D CEPH_MDS_OP_SETFILELOCK ||
> =C2=A0			=C2=A0=C2=A0=C2=A0 !(req->r_op & CEPH_MDS_OP_WRITE)) {
> +#if BITS_PER_LONG =3D=3D 64
> +				idx++;
> +#else
> =C2=A0				rn =3D rb_next(rn);
> +#endif
> =C2=A0				continue;
> =C2=A0			}
> =C2=A0			ceph_mdsc_get_request(req);
> @@ -5542,7 +5629,11 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0			ceph_mdsc_put_request(req);
> =C2=A0			if (time_after(jiffies, drain_deadline))
> =C2=A0				break;
> +#if BITS_PER_LONG =3D=3D 64
> +			idx =3D 0;=C2=A0 /* restart: tree may have changed
> */
> +#else
> =C2=A0			rn =3D rb_first(&mdsc->request_tree);
> +#endif
> =C2=A0		}
> =C2=A0		mutex_unlock(&mdsc->mutex);
> =C2=A0
> @@ -6268,7 +6359,11 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> =C2=A0	mdsc->snap_realms =3D RB_ROOT;
> =C2=A0	INIT_LIST_HEAD(&mdsc->snap_empty);
> =C2=A0	spin_lock_init(&mdsc->snap_empty_lock);
> +#if BITS_PER_LONG =3D=3D 64
> +	xa_init(&mdsc->request_tree);
> +#else
> =C2=A0	mdsc->request_tree =3D RB_ROOT;
> +#endif
> =C2=A0	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
> =C2=A0	mdsc->last_renew_caps =3D jiffies;
> =C2=A0	INIT_LIST_HEAD(&mdsc->cap_delay_list);
> @@ -6590,8 +6685,59 @@ static void
> flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
> =C2=A0						 u64 want_tid)
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D mdsc->fsc->client;
> -	struct ceph_mds_request *req =3D NULL, *nextreq;
> =C2=A0	struct ceph_mds_session *last_session =3D NULL;
> +#if BITS_PER_LONG =3D=3D 64
> +	struct ceph_mds_request *req;
> +	unsigned long idx;
> +
> +	mutex_lock(&mdsc->mutex);
> +	doutc(cl, "want %lld\n", want_tid);
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
> +			struct ceph_mds_session *s =3D req->r_session;
> +
> +			if (!s) {
> +				idx =3D next_tid;
> +				continue;
> +			}
> +
> +			/* write op */
> +			ceph_mdsc_get_request(req);
> +			s =3D ceph_get_mds_session(s);
> +			mutex_unlock(&mdsc->mutex);
> +
> +			/* send flush mdlog request to MDS */
> +			if (last_session !=3D s) {
> +				send_flush_mdlog(s);
> +				ceph_put_mds_session(last_session);
> +				last_session =3D s;
> +			} else {
> +				ceph_put_mds_session(s);
> +			}
> +			doutc(cl, "wait on %llu (want %llu)\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->r_tid, want_tid);
> +			wait_for_completion(&req-
> >r_safe_completion);
> +
> +			mutex_lock(&mdsc->mutex);
> +			ceph_mdsc_put_request(req);
> +			idx =3D next_tid;
> +		}
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +	ceph_put_mds_session(last_session);
> +	doutc(cl, "done\n");
> +#else /* BITS_PER_LONG !=3D 64 =E2=80=94 rbtree fallback */
> +	struct ceph_mds_request *req =3D NULL, *nextreq;
> =C2=A0	struct rb_node *n;
> =C2=A0
> =C2=A0	mutex_lock(&mdsc->mutex);
> @@ -6649,6 +6795,7 @@ static void
> flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
> =C2=A0	mutex_unlock(&mdsc->mutex);
> =C2=A0	ceph_put_mds_session(last_session);
> =C2=A0	doutc(cl, "done\n");
> +#endif
> =C2=A0}
> =C2=A0
> =C2=A0void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
> @@ -6803,6 +6950,9 @@ static void ceph_mdsc_stop(struct
> ceph_mds_client *mdsc)
> =C2=A0	if (mdsc->mdsmap)
> =C2=A0		ceph_mdsmap_destroy(mdsc->mdsmap);
> =C2=A0	kfree(mdsc->sessions);
> +#if BITS_PER_LONG =3D=3D 64
> +	xa_destroy(&mdsc->request_tree);
> +#endif
> =C2=A0	ceph_caps_finalize(mdsc);
> =C2=A0
> =C2=A0	if (mdsc->s_cap_auths) {
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 3b614b5df18c..c2de551607e3 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -329,7 +329,11 @@ typedef int (*ceph_mds_request_wait_callback_t)
> (struct ceph_mds_client *mdsc,
> =C2=A0 */
> =C2=A0struct ceph_mds_request {
> =C2=A0	u64 r_tid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* transaction id */
> +#if BITS_PER_LONG =3D=3D 64
> +	/* embedded in mdsc->request_tree xarray */
> +#else
> =C2=A0	struct rb_node r_node;
> +#endif
> =C2=A0	struct ceph_mds_client *r_mdsc;
> =C2=A0
> =C2=A0	struct kref=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r_kref;
> @@ -534,7 +538,11 @@ struct ceph_mds_client {
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
> +#if BITS_PER_LONG =3D=3D 64
> +	struct xarray=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 request_tree;=C2=A0 /* pending mds
> requests */
> +#else
> +	struct rb_root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
quest_tree;=C2=A0 /* pending mds
> requests */
> +#endif
> =C2=A0	struct delayed_work=C2=A0=C2=A0=C2=A0 delayed_work;=C2=A0 /* delay=
ed work */
> =C2=A0	unsigned long=C2=A0=C2=A0=C2=A0 last_renew_caps;=C2=A0 /* last tim=
e we renewed
> our caps */
> =C2=A0	struct list_head cap_delay_list;=C2=A0=C2=A0 /* caps with delayed
> release */

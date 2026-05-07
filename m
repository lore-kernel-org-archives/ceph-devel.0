Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D3199931
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180483; cv=none; b=N2BvNX7PuopVfKrkJuGmm5xUeu/27ULBLE+qsDraY7dT+cCt6fKFvEowzga+Uv4n9/Q7NCoqURN/BGDblxdLDLUC4FMAkM27BWu7xyu5TfFD5kkBtX0XG3ikH/7Zy1TvElnR+yKvoAZ4HvGnNfab5aEA64w99L/MyHEAvicBix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180483; c=relaxed/simple;
	bh=lFTZ/jFD5sqxmIIDESQgZMhYwz1XrhpC3zn+Yo/2khw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goYtTGnwUSZqyXBxSCZHQYEBQ7TJ7e0cs9wA2idbO5adrd/r9R8j7Bd23xyWz44r1qiWawk6inV2Yz+F3wfMi8O9lzxej0xh9BA/gX56THCDmMMnN5ZAK/CF7XAoo6jDDuqC867PWDdfAyM1iZgMVoCM/GPL2E6Fkvpp79jNj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8OrjxG8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUHxvmbq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8OrjxG8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUHxvmbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778180480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSNjWxyHawtQvbQl2o4WeIV83oSSkzsu+iVTyFGdvTI=;
	b=P8OrjxG8nQJK5qQSp8JUtQIRPW0z40Td3cLM/TOtHxIxyfJQ1godQVeVuLmKYTJ/czVXS8
	m8QsJ/MP5C1DYgAAIEoPY7aGbCOaaCIsn2I9mehjSZtUveWDMTsVv3OkxPQ9F/44+ojSj9
	JLKG0HTeGyE2wfqlSH4vwErA/jwNo1Q=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-eNlYDPCbPYSX8yDWSFOELA-1; Thu, 07 May 2026 15:01:13 -0400
X-MC-Unique: eNlYDPCbPYSX8yDWSFOELA-1
X-Mimecast-MFC-AGG-ID: eNlYDPCbPYSX8yDWSFOELA_1778180473
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c223da702so2512450d50.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778180472; x=1778785272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dSNjWxyHawtQvbQl2o4WeIV83oSSkzsu+iVTyFGdvTI=;
        b=EUHxvmbqZxmt/FWwpNUpqtegQF056b3jcVWsieZRzgm82UVJ6VK/4G48Z+LPWoLDiv
         wut005bA905oQdcIIs1UBRSYHwtrzoORuihimkX4lLhclt3YNqaoe8YYNJ6ftWYOHRGa
         h7JUsUMeqL2t9QBNAbfnyImBoZrbtmwzr8UQDGhBIfrFdrYffKvH5udJLR9uF6wJT+Fh
         +qYzmZ1ruTlVG0A1+jWgm1U8ZOhLLflaIw+gDIJhVTt1Iy1ChDt8psrlNsSTQWLYlgBf
         wRVdKv29gwDXRjFXLv+3lXzz/5TZQyy2Bq2fTPwUVQej0LxfffNwAluliBJp9A004Fnu
         JPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180472; x=1778785272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSNjWxyHawtQvbQl2o4WeIV83oSSkzsu+iVTyFGdvTI=;
        b=sZVZwC9dHJda00gfEG4zzX8G3brS9SWpi8y19K4dIhKXm1YTryRaCy1Y5mNWDKmu2r
         J2K42GZERhCQkn/x2iGVwtbQa3h9AE3r69p00Bv6ZXvNaSt4imFzxD7dAR98iVMuGrgk
         zdzRjp9UgIHA/1djbNcxEoC7RVEDw61sqbg1tWkOULy3jtXFC+Q0OwQQ925lehMuqKTz
         w7WoUuvKZN124Ie9pPPE31pii0FocHyJEG4suVm1IoGwbHPHzhRV+xEHNj3yvRBnZdLR
         lUSNKcONWlI28gWSxlp+XXwX/sperrVQGM0F1yh9fOHywQc6zdQ//BXm1vdKd9CG5Jr5
         Cn1A==
X-Forwarded-Encrypted: i=1; AFNElJ9aO/41zfS3hPNn7JTSbi26cQGjhL3XzzRBhr0jGscp+OWP4VPiytYzAUv6RMvgQWn6wwRQxmhTl4EA@vger.kernel.org
X-Gm-Message-State: AOJu0YztuLikzK+Gs/cYsSYONPF+qYbmet8J2uNwBUxPx5A4IJ6cEuCs
	rqiGDQZbVoSkx0fjsjVYDyu1d2RWV2CgYzQeL9kDPFwpzN1oX8sSCZe1aoMykkNWgzgIF903fXc
	0+3UXPEvuQ65pSrZm09RdN0XGexbbMfCjQHaHcnS8QryH96ZEw2p9S3LNRo6U3u7ZCxp7MfY=
X-Gm-Gg: Acq92OGJmp/loafJ44B5uiDugCW6zwr9LyiiE6PzEMG3rIzydZp66VyfoJJ/3NCehtK
	aBuojo8w9wXHG96RDxSPFq2+7xku5Urorh30NrlenKPEJ+FfxIyNiFUKoT879oN4CZBumso2DfL
	NcqM9IbMhImEszuKbHmdU8yb5fZeTLy75ancmrYBngADuXZNpsV274cEB2GwEtwKdaos4MBti2p
	RapkzUtyiW3ZEpvbQjcaRt9eZGrxmyAhBSuJV33FaT0CxzINIc8gC1Mx+QLyPeuYndtGEjx9q4/
	8LVRzlVmRTQKL8zu12rE7LtWwW2L0KFo1dfC59T/3lmgXsLBYvDCSdb8+FdsE02PR55TDhaeX0v
	hoXfGNsLVGMNd9ykxGccEsxLjlyscFAdGdLWBFCrikr1ZPw/uTnYN
X-Received: by 2002:a05:690c:d94:b0:7b0:4bc1:d700 with SMTP id 00721157ae682-7bdf5ec8733mr101971097b3.36.1778180470573;
        Thu, 07 May 2026 12:01:10 -0700 (PDT)
X-Received: by 2002:a05:690c:d94:b0:7b0:4bc1:d700 with SMTP id 00721157ae682-7bdf5ec8733mr101969627b3.36.1778180469509;
        Thu, 07 May 2026 12:01:09 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd7d849afesm78481267b3.49.2026.05.07.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:01:09 -0700 (PDT)
Message-ID: <2ec3b7c8d69c7a5daae26918075247593009accf.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 04/11] ceph: add diagnostic timeout loop
 to wait_caps_flush()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:01:07 -0700
In-Reply-To: <20260507122737.2804094-5-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-5-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 12:27 +0000, Alex Markuze wrote:
> Convert wait_caps_flush() from a silent indefinite wait into a diagnostic
> wait loop that periodically dumps pending cap flush state.
>=20
> The underlying wait semantics remain intact: callers still wait until the
> requested cap flushes complete. The difference is that long stalls now
> produce actionable diagnostics instead of looking like a silent hang.
>=20
> CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES limits the number of entries
> emitted per diagnostic dump, and CEPH_CAP_FLUSH_MAX_DUMP_ITERS
> limits the number of timed diagnostic dumps before the wait
> continues silently.  When more entries exist than the per-dump
> limit, a truncation count is reported.  When the dump iteration
> limit is reached, a final suppression message is emitted so the
> transition to silence is explicit.
>=20
> The diagnostic dump collects flush entry data under cap_dirty_lock into
> a bounded on-stack array, then prints after releasing the lock.  This
> avoids holding the spinlock across printk calls.
>=20
> A null cf->ci on the global flush list indicates a bug since all
> cap_flush entries are initialized with a valid ci before being added.
> Signal this with WARN_ON_ONCE while still printing enough context for
> debugging.
>=20
> READ_ONCE is used for the i_last_cap_flush_ack field, which is read
> outside the inode lock domain. Flush tids are monotonically increasing
> and acks are processed in order under i_ceph_lock, so the latest ack
> tid is always the most recently written value.
>=20
> Add a ci pointer to struct ceph_cap_flush so that the diagnostic
> dump can identify which inode each pending flush belongs to.  The
> new i_last_cap_flush_ack field tracks the latest acknowledged flush
> tid per inode for diagnostic correlation.
>=20
> This improves reset-drain observability and is also useful for
> existing sync and writeback troubleshooting paths.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/caps.c       |  10 +++++
>  fs/ceph/inode.c      |   1 +
>  fs/ceph/mds_client.c | 100 +++++++++++++++++++++++++++++++++++++++++--
>  fs/ceph/mds_client.h |   3 ++
>  fs/ceph/super.h      |   6 +++
>  5 files changed, 116 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index cb9e78b713d9..4b37d9ffdf7f 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_in=
fo *ci,
> =20
>  		spin_lock(&mdsc->cap_dirty_lock);
>  		capsnap->cap_flush.tid =3D ++mdsc->last_cap_flush_tid;
> +		capsnap->cap_flush.ci =3D ci;
>  		list_add_tail(&capsnap->cap_flush.g_list,
>  			      &mdsc->cap_flush_list);
>  		if (oldest_flush_tid =3D=3D 0)
> @@ -1846,6 +1847,7 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
>  		return NULL;
> =20
>  	cf->is_capsnap =3D false;
> +	cf->ci =3D NULL;
>  	return cf;
>  }
> =20
> @@ -1931,6 +1933,7 @@ static u64 __mark_caps_flushing(struct inode *inode=
,
>  	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
> =20
>  	swap(cf, ci->i_prealloc_cap_flush);
> +	cf->ci =3D ci;
>  	cf->caps =3D flushing;
>  	cf->wake =3D wake;
> =20
> @@ -3826,6 +3829,13 @@ static void handle_cap_flush_ack(struct inode *ino=
de, u64 flush_tid,
>  	bool wake_ci =3D false;
>  	bool wake_mdsc =3D false;
> =20
> +	/*
> +	 * Flush tids are monotonically increasing and acks arrive in
> +	 * order under i_ceph_lock, so this is always the latest tid.
> +	 * Diagnostic readers use READ_ONCE() without holding the lock.
> +	 */
> +	WRITE_ONCE(ci->i_last_cap_flush_ack, flush_tid);
> +
>  	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
>  		/* Is this the one that was flushed? */
>  		if (cf->tid =3D=3D flush_tid)
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 4871d7ab2730..61d7c0b8161f 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -671,6 +671,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
>  	INIT_LIST_HEAD(&ci->i_cap_snaps);
>  	ci->i_head_snapc =3D NULL;
>  	ci->i_snap_caps =3D 0;
> +	ci->i_last_cap_flush_ack =3D 0;
> =20
>  	ci->i_last_rd =3D ci->i_last_wr =3D jiffies - 3600 * HZ;
>  	for (i =3D 0; i < CEPH_FILE_MODE_BITS; i++)
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 249419c17d3c..6ab5031e697a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2330,19 +2330,111 @@ static int check_caps_flush(struct ceph_mds_clie=
nt *mdsc,
>  }
> =20
>  /*
> - * flush all dirty inode data to disk.
> + * Snapshot of a single cap_flush entry for diagnostic dump.
> + * Collected under cap_dirty_lock, printed after releasing it.
> + */
> +struct flush_dump_entry {
> +	u64 ino;		/* inode number */
> +	u64 snap;		/* snap id */
> +	int caps;		/* dirty cap bits */
> +	u64 tid;		/* flush transaction id */
> +	u64 last_ack;		/* most recent ack tid for this inode */
> +	bool wake;		/* whether completion was requested */
> +	bool is_capsnap;	/* true if this is a cap snap flush */
> +	bool ci_null;		/* true if cf->ci was unexpectedly NULL */
> +};
> +
> +/*
> + * Dump pending cap flushes for diagnostic purposes.
>   *
> - * returns true if we've flushed through want_flush_tid
> + * cf->ci is safe to dereference here: cap_flush entries hold a
> + * reference on the inode (via the cap), and entries are removed from
> + * cap_flush_list under cap_dirty_lock before the cap (and thus the
> + * inode reference) is released.  Holding cap_dirty_lock therefore
> + * guarantees the inode remains valid for the lifetime of the scan.
> + */
> +
> +static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
> +{
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES];
> +	struct ceph_cap_flush *cf;
> +	int n =3D 0, remaining =3D 0;
> +
> +	spin_lock(&mdsc->cap_dirty_lock);
> +	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
> +		if (cf->tid > want_tid)
> +			break;
> +		if (n < CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES) {
> +			struct flush_dump_entry *e =3D &entries[n++];
> +
> +			e->ci_null =3D WARN_ON_ONCE(!cf->ci);
> +			if (!e->ci_null) {
> +				e->ino =3D ceph_ino(&cf->ci->netfs.inode);
> +				e->snap =3D ceph_snap(&cf->ci->netfs.inode);
> +				e->last_ack =3D READ_ONCE(cf->ci->i_last_cap_flush_ack);
> +			}
> +			e->caps =3D cf->caps;
> +			e->tid =3D cf->tid;
> +			e->wake =3D cf->wake;
> +			e->is_capsnap =3D cf->is_capsnap;
> +		} else {
> +			remaining++;
> +		}

We don't need brackets here. :)

> +	}
> +	spin_unlock(&mdsc->cap_dirty_lock);
> +
> +	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
> +		       want_tid);
> +	for (int i =3D 0; i < n; i++) {

I am slightly worried that we could have warnings because of this declarati=
on.

> +		struct flush_dump_entry *e =3D &entries[i];
> +
> +		if (e->ci_null)
> +			pr_info_client(cl,
> +				       "  (null ci) %s tid=3D%llu wake=3D%d%s\n",
> +				       ceph_cap_string(e->caps), e->tid,
> +				       e->wake,
> +				       e->is_capsnap ? " is_capsnap" : "");
> +		else
> +			pr_info_client(cl,
> +				       "  %llx.%llx %s tid=3D%llu last_ack=3D%llu wake=3D%d%s\n",
> +				       e->ino, e->snap,
> +				       ceph_cap_string(e->caps), e->tid,
> +				       e->last_ack, e->wake,
> +				       e->is_capsnap ? " is_capsnap" : "");
> +	}
> +	if (remaining)
> +		pr_info_client(cl, "  ... and %d more pending flushes\n",
> +			       remaining);
> +}
> +
> +/*
> + * Wait for all cap flushes through @want_flush_tid to complete.
> + * Periodically dumps pending cap flush state for diagnostics.
>   */
>  static void wait_caps_flush(struct ceph_mds_client *mdsc,
>  			    u64 want_flush_tid)
>  {
>  	struct ceph_client *cl =3D mdsc->fsc->client;
> +	int i =3D 0;
> +	long ret;
> =20
>  	doutc(cl, "want %llu\n", want_flush_tid);
> =20
> -	wait_event(mdsc->cap_flushing_wq,
> -		   check_caps_flush(mdsc, want_flush_tid));
> +	do {
> +		/* 60 * HZ fits in a long on all supported architectures. */
> +		ret =3D wait_event_timeout(mdsc->cap_flushing_wq,
> +			   check_caps_flush(mdsc, want_flush_tid),
> +			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
> +		if (ret =3D=3D 0) {
> +			if (i < CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
> +				dump_cap_flushes(mdsc, want_flush_tid);
> +			else if (i =3D=3D CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
> +				pr_info_client(cl,
> +					       "still waiting for cap flushes; suppressing further dumps\n"=
);
> +			i++;
> +		}
> +	} while (ret =3D=3D 0);
> =20
>  	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
>  }
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index d873e784b025..8208fdf02efe 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -77,6 +77,9 @@ struct ceph_fs_client;
>  struct ceph_cap;
> =20
>  #define MDS_AUTH_UID_ANY -1
> +#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
> +#define CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES 5
> +#define CEPH_CAP_FLUSH_MAX_DUMP_ITERS 5
> =20
>  struct ceph_mds_cap_match {
>  	s64 uid;  /* default to MDS_AUTH_UID_ANY */
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 8afc6f3a10da..a4993644d543 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -239,6 +239,7 @@ struct ceph_cap_flush {
>  	bool is_capsnap; /* true means capsnap */
>  	struct list_head g_list; // global
>  	struct list_head i_list; // per inode
> +	struct ceph_inode_info *ci;
>  };
> =20
>  /*
> @@ -453,6 +454,11 @@ struct ceph_inode_info {
>  	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 o=
r
>  						    dirty|flushing caps */
>  	unsigned i_snap_caps;           /* cap bits for snapped files */
> +	/*
> +	 * Written under i_ceph_lock, read via READ_ONCE()
> +	 * from diagnostic paths.
> +	 */
> +	u64 i_last_cap_flush_ack;
> =20
>  	unsigned long i_last_rd;
>  	unsigned long i_last_wr;

I have two minor remarks. The rest looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


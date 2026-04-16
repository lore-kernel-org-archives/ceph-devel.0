Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD83ED5D6
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369371; cv=none; b=DG13aeZAeN/hTdJ+DIkKPSdBjx7ALwK7f0F14arh1xDDk46DLtj5UnuREk5QVFBV3MNncYsNM4oRi1EmH5GQjE2828gl+Ckl2IZE31Kg9Y976csnOKdsufVgCmwLz1dMMYsarMpplefukSv6CQTcL2b+4lkfAdgPFQ2dVgVBO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369371; c=relaxed/simple;
	bh=2irto3+zmkfBJcbk5mMEo01hqsM25MOffsgIG4dQnHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BarK0cEAVuEgXCj81t8gTyyAgpqWQJ95Zkte3zk8QHy7PR6qmJXrLWyckFnxfQdecIVk7eKZ+9C7BjchI0a7zSWnyn3zi5u2PG5poKpVCOivhIvOoZDhC/HYu9Q1OyQR+7+Afv50DyRX9dOOpMkA5ZYyJPymKit/4uGCD97foRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBWglcSh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/dbTBK7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBWglcSh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/dbTBK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776369363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4vEcnA6sfg/gK8PDsvUK5TVbDPDBw6vHof22O/JKcw=;
	b=aBWglcShs8osverkbp63JWxjVbsNWhSt+ZUE1LXpgs3VFQAQOBEcSh9EUv0k0Js3GhVz4t
	IonrJQhPmhr5H44zdBDevWbBEFCyCaYLAR0zL4vR+y0kwjkHW7LaFdz1WTRaAVUr1fejrM
	pJmykUlSt/i5D8Jxap4rcmy/KjSU8Sw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-YLf2wvCIOUiudCBKaT01Yw-1; Thu, 16 Apr 2026 15:56:02 -0400
X-MC-Unique: YLf2wvCIOUiudCBKaT01Yw-1
X-Mimecast-MFC-AGG-ID: YLf2wvCIOUiudCBKaT01Yw_1776369361
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7987861595eso248565427b3.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776369361; x=1776974161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X4vEcnA6sfg/gK8PDsvUK5TVbDPDBw6vHof22O/JKcw=;
        b=D/dbTBK7OlTUr8F1pEIwpJP0jr2KTywHkw/50aayeeEh/nSTbLWaIH1lRTDv0s7fBA
         WP3kN1YttS7Sn9eIbJU4D5CE2fXaWhakpU0CToyah7dZTZUn6u6IN3z1ycFYswyPNbHW
         BkfVwbrnh9zHG266FFpvpb0o90zXyyASNiQuWMDspldCH4ZU4OMQGasI2MWRKTrmTA5K
         BOIZgGSEV6yHoHA82cslwFr/76kaNlnOLxf+X71KQFflbLv6llNMH/neI4YWL4s/6d0J
         IIAgPEliFn9noxjaS8NBnF1tDABFpoyI6Do9GNVmwxUMGsomyxJileH8n778XcU772dG
         U7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369361; x=1776974161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4vEcnA6sfg/gK8PDsvUK5TVbDPDBw6vHof22O/JKcw=;
        b=sr3TrOCKLttK1RD+9N6TlWZUjL3H0acwYKeM+uHtgT1d3+3GeiLcYUzMG1eaHJrq6c
         1DJ7X8nLx2HtsjCpqS0x6LghyLS+dX+MZS540sipb1kPGNMUmqWBBFUHu79NUOeqABUU
         hAjb/GisY9kEjhLXMpQpKvhY9aTrmndZRr/Z4cEVYOoQBX0OCEBso5wcqyL2siEXI0co
         Vw84hC/SwKF5VKjAZEQp51ELsXMxpRvsIS4gKNT2AbG6/a6whvreB8fwfrJ4Bnlw40xa
         JHoWXKkcPOBu5aIfZAkBMa+LuwtxxsyBVzUQDp402OL5HRV2/7oho9hlTbe/0ET9TPDW
         i/Sw==
X-Forwarded-Encrypted: i=1; AFNElJ+sDIWcZ6FGWbkpAcU2ppGgG5QBbwWs/sH3TpDUsJCHoWFHdafJVX5/nzxQ1c4uwRgmzSv2obx1vjDX@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqIPPN18SnQi3aod2M1JvDhqlzRJQcYgvdqqZgRuJb3i8Wq8o
	Xyw9P+o3EEjlm9O0coBr93hGCB3zJKZmhbOqRoNz7VBmxufMKJDYQkhgef+kBmvClBqFmQpiBzi
	TbZL6i+Adxuhv5nIezpwCCCfnSRfBf8F433YmXno8qe1w1/LTUVeB2zg4wCL0v7RmtQjGj7s=
X-Gm-Gg: AeBDiesb67gkQ/lWYxA9keh0XDMp2npYX+jQG48UyER5NwI1p8kJRaaZpykvu6/3WRw
	ot0x5FOYlvktVIAKUiuj0zNKjt8fh4UoOPQIKZxX5qtu5akyLdtcWNiKUW4uLn2zTE1IFdh5Q37
	ibUnXoKmgCfs14e3poKES212781e2NKAtGcMI8pg2Fgjtzp1xj3GcrzoNWk2WWuMUVtZWg9yl6F
	i+eYwtjDq5eyUF9Bn0+4KIDsONZfSf4QOVmiwDtWIjnnBzcJxHw2uZRRksFRf4/mReb5qIeX6fA
	DUF8t9on0HmHuXS+Ml8iV2ubBhafGWNQ6W8OP7W2Uyi2985EatFTXFwUKoY39V5Grtt1RdzBupX
	pIhLt9xEGEEZPq3h3OwX1CpbfQ9cW+2H6RN0lwMxiz+AGLEk1i9mjO7Ndsq0k93s=
X-Received: by 2002:a05:690c:a00d:b0:7a3:7ad3:3ecf with SMTP id 00721157ae682-7b9e453b093mr4571047b3.26.1776369360597;
        Thu, 16 Apr 2026 12:56:00 -0700 (PDT)
X-Received: by 2002:a05:690c:a00d:b0:7a3:7ad3:3ecf with SMTP id 00721157ae682-7b9e453b093mr4570827b3.26.1776369360133;
        Thu, 16 Apr 2026 12:56:00 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b768d387fasm28840937b3.30.2026.04.16.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:55:58 -0700 (PDT)
Message-ID: <d8cdfbc04a0a7ef3a2272a112c66a3bd2b3564b6.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 4/7] ceph: add diagnostic timeout loop to
 wait_caps_flush()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 16 Apr 2026 12:55:57 -0700
In-Reply-To: <20260415170043.3882912-5-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-5-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 17:00 +0000, Alex Markuze wrote:
> Convert wait_caps_flush() from a silent indefinite wait into a diagnostic
> wait loop that periodically dumps pending cap flush state.
>=20
> The underlying wait semantics remain intact: callers still wait until the
> requested cap flushes complete. The difference is that long stalls now
> produce actionable diagnostics instead of looking like a silent hang.
>=20
> CEPH_CAP_FLUSH_MAX_DUMP_COUNT bounds the diagnostics in two ways:
> it limits the number of entries emitted per diagnostic dump, and it
> limits the number of timed diagnostic dumps before the wait continues
> silently.
>=20
> READ_ONCE is used for the i_last_cap_flush_ack field, which is read
> outside the inode lock domain.
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
>  fs/ceph/caps.c       |  5 ++++
>  fs/ceph/inode.c      |  1 +
>  fs/ceph/mds_client.c | 56 ++++++++++++++++++++++++++++++++++++++++----
>  fs/ceph/super.h      |  6 +++++
>  4 files changed, 64 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index cb9e78b713d9..c40175dd77ae 100644
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
> @@ -3826,6 +3829,8 @@ static void handle_cap_flush_ack(struct inode *inod=
e, u64 flush_tid,
>  	bool wake_ci =3D false;
>  	bool wake_mdsc =3D false;
> =20
> +	WRITE_ONCE(ci->i_last_cap_flush_ack, flush_tid);

Could acks ever arrived out of order? If so, then i_last_cap_flush_ack coul=
d
contain not the maximum value. Do we need to use max() here?

> +
>  	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
>  		/* Is this the one that was flushed? */
>  		if (cf->tid =3D=3D flush_tid)
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index f75d66760d54..de465c7e96e8 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -670,6 +670,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
>  	INIT_LIST_HEAD(&ci->i_cap_snaps);
>  	ci->i_head_snapc =3D NULL;
>  	ci->i_snap_caps =3D 0;
> +	ci->i_last_cap_flush_ack =3D 0;
> =20
>  	ci->i_last_rd =3D ci->i_last_wr =3D jiffies - 3600 * HZ;
>  	for (i =3D 0; i < CEPH_FILE_MODE_BITS; i++)
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b14ede808436..7d17332d72d7 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -27,6 +27,8 @@
>  #include <trace/events/ceph.h>
> =20
>  #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
> +#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
> +#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
> =20
>  /*
>   * A cluster of MDS (metadata server) daemons is responsible for
> @@ -2286,19 +2288,65 @@ static int check_caps_flush(struct ceph_mds_clien=
t *mdsc,
>  }
> =20
>  /*
> - * flush all dirty inode data to disk.
> + * Dump pending cap flushes for diagnostic purposes.
>   *
> - * returns true if we've flushed through want_flush_tid
> + * cf->ci is safe to dereference here because the cap_dirty_lock is
> + * held, and cap_flush entries are removed from the global
> + * cap_flush_list under the same lock in the purge path.
> + */
> +static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
> +{
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	struct ceph_cap_flush *cf;
> +	int dumped =3D 0;
> +
> +	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
> +		       want_tid);
> +	spin_lock(&mdsc->cap_dirty_lock);
> +	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
> +		if (cf->tid > want_tid)
> +			break;
> +		if (++dumped > CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> +			break;

We break silently if dumped is bigger than CEPH_CAP_FLUSH_MAX_DUMP_COUNT. B=
ut we
could have more items in the list. Should we inform that the dump is trunca=
ted?

> +		if (!cf->ci) {

Is it normal situation? Could we expect such condition as regular workflow?
Maybe, we need to have WARN_ON_ONCE(!cf->ci) instead?

> +			pr_info_client(cl,
> +				       "(null ci) %s tid=3D%llu wake=3D%d%s\n",
> +				       ceph_cap_string(cf->caps), cf->tid,
> +				       cf->wake,
> +				       cf->is_capsnap ? " is_capsnap" : "");
> +			continue;
> +		}
> +		pr_info_client(cl,
> +			       "%llx:%llx %s tid=3D%llu last_ack=3D%llu wake=3D%d%s\n",
> +			       ceph_vinop(&cf->ci->netfs.inode),
> +			       ceph_cap_string(cf->caps), cf->tid,
> +			       READ_ONCE(cf->ci->i_last_cap_flush_ack),
> +			       cf->wake,
> +			       cf->is_capsnap ? " is_capsnap" : "");

Multiple pr_info_client() calls happen while cap_dirty_lock is held. I thin=
k
it's not good at all. Could we rework it somehow?

> +	}
> +	spin_unlock(&mdsc->cap_dirty_lock);
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
> +		ret =3D wait_event_timeout(mdsc->cap_flushing_wq,
> +			   check_caps_flush(mdsc, want_flush_tid),
> +			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);

Are we safe here? Could we have overflow for CEPH_CAP_FLUSH_WAIT_TIMEOUT_SE=
C *
HZ calculation?

Thanks,
Slava.=20

> +		if (ret =3D=3D 0 && i++ < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> +			dump_cap_flushes(mdsc, want_flush_tid);
> +	} while (ret =3D=3D 0);
> =20
>  	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
>  }
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index c89ad8dcc969..1f901b1647e6 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -238,6 +238,7 @@ struct ceph_cap_flush {
>  	bool is_capsnap; /* true means capsnap */
>  	struct list_head g_list; // global
>  	struct list_head i_list; // per inode
> +	struct ceph_inode_info *ci;
>  };
> =20
>  /*
> @@ -443,6 +444,11 @@ struct ceph_inode_info {
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


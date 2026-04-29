Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3F335081
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498882; cv=none; b=DUr2loS8NdmmQ/CcfpWKsvfFI9SC/JcHFvSGVu5fRqhcTR1Qfx5lyoquEhL2z8+oYk9FUWYivA1/bk5kcZo5JL0ij97DNgDTI4KRd4HSkAHCHj4i8QueIu22myNnJKSmEkdkHGU0m2zHb4xfJRYVKCwNaq9ccbBiYXE3s/JYrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498882; c=relaxed/simple;
	bh=4gUaXrl3UskpCY1b73BcQ4+kOBSY0Bzr3MSGnd1pJyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UG/uwEBv6Um2wi4y6CwAsLd0k0ReRoYiaGQpZtMBSJPuvZwzTfC5+KV01V7c/9NHLZQP44rf6bgMxFxSmUk2nEllfJXY6n+i0b9gU4wDdw1WLERESJbMtFeyM9SbhvGUF1LY6VKQ93MV2K5UbT+x7bWi1unQqXjxq3APAtxuOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5YSFEjf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kp/T2NjR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5YSFEjf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp/T2NjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777498879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sl0xewYyqSp8d6vH3PwbkZbfKrRKC9g4HXpzaFf4dVg=;
	b=T5YSFEjfe+H06EJople0TkLgEiis/BdFfEUnbHXfP2guXzbVCm5XBWu/6PQFRTVngs2c96
	oZpZ9dYBuiKh5d6ad72eMetFUWfH8sU787l4DDMwD2NY80O8u4B9HTp9GQ/oQpfNq9PMpw
	p/AbiScmDAFWGWjxOV+D9CtTDhoXqLU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-jx6xKEKkOw-ByJ6LKT482g-1; Wed, 29 Apr 2026 17:41:18 -0400
X-MC-Unique: jx6xKEKkOw-ByJ6LKT482g-1
X-Mimecast-MFC-AGG-ID: jx6xKEKkOw-ByJ6LKT482g_1777498877
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79a670a6032so6215427b3.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777498877; x=1778103677; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sl0xewYyqSp8d6vH3PwbkZbfKrRKC9g4HXpzaFf4dVg=;
        b=Kp/T2NjRS169WMW6k6xG940SGcQAfdcgeDwgbTQOkkJGp4PzL4sNq5KgeVFJTSZs/6
         FEMYLy+46ADb8O+8BgPCe82axwFjEDH5KsvOsKuITMoSe9YStf113k3yHLLR6M0vXQYn
         fUbcOn5xkoexaJYXdSmPycxE0kKYuRhSg/XpV3wvJDnIx5MmoeU+uLuljDWwZzhbAhhM
         nTdg7yqaGTJCUfxXEbfJrdLxnP0Dz6CStD0CeNSfu9HuTxAyuLMpLSgiYErTvgLrdixa
         QJIO8GTUaoDUtIyDDukfXTJvDnodknarIocbGJuKpWmjSKSN7oqioEcKXFyaSXNO8Nen
         GZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777498877; x=1778103677;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl0xewYyqSp8d6vH3PwbkZbfKrRKC9g4HXpzaFf4dVg=;
        b=nmkp5wh7V/R1VNsOnVm9IjbyBmchFhz+bejBDG89LGHvRRbEuwBIBzI6ITeEdLU3/Y
         a8qK65X28jKLtzFzcXiasw6CcBCS8609JpGQheVmqwfEkXsVDJ/v+q/BMnXrufB2Zlhs
         W2freN/33GBF/pLWIShGsrjwT2yJdAEzRG/Fm25pRv9hLb4FDS9z7n5LKEVUf1h6XyNt
         7V33GBVC3wMkNU9u3jGRrqZQpk161N135mEiD0j6Y8DexZ7Eg9v48Ixzmitzu8/oxq2N
         WAKQ1zt5bOm4ON6UszdzcALeCzS6ZXcE5LxzcDko8A+RSUpkMlHm7CPhDrwNzaevmC6l
         3wrA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZMBwjTqEvzKLjTv/PFZliAP9ETUwjYhrtm5/HCOIkU9mukuc68nBl8GGKeRbx88aauFqKC1NRt9RP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd146pAceEwAlD5T88RxKXZLZmbYY3NEIAASS1luFWZClzWg1/
	YwZBqUlx2UpZEskojtbEWFesZn66QbvPAKM7gyjNLT2yy4S+YptahOZcVauQHOHWrsHkOT1dupf
	8r2NnE5xdSu7xw9jONyDVado5X2cT4xxsGCPm53EVPbvROZKwzEJR7LGvdPE9dwg=
X-Gm-Gg: AeBDievMaJeqLUxz4vH57PytOF8efy7O3iV5k7vUC8Z57rTq7OFII63SbdsuontPn3R
	gcuggqB2m00ntzkR3L7QixmhG3C0EiZyRCJBpDDluw6zsy/pt6Ai1RYkPYrQHQNUg/gjXzhoQB+
	dfo45TvJBSwvnyfe1QNww/z1SydMgNd+Vl0Kwh+esCJ3hSEveZMZPqMAwIyjRGsEdc4+dKOpiw4
	67gEoNvXrTMvt2pQNy4Xw+0RaphlGxbzdcCFiIVapdcjiWKeJhKFVc3D4Rl8ubBzWNadmz5DWsU
	GkvCrBccZg3lhDxcr2axXuZC4OMFdGloTdKu7lDsaNtiKZ1hA/bwWpHrwWg1/PW/vot+TlLsSNs
	Rv5/au4ibmCEDqlNBLYRmWK+zMsTWIgiC8C+ptoieqEobP1hIP8q4xGBl+uVsoyU=
X-Received: by 2002:a05:690c:6e87:b0:7b2:dad2:5def with SMTP id 00721157ae682-7bd52ac34e8mr5523467b3.48.1777498877230;
        Wed, 29 Apr 2026 14:41:17 -0700 (PDT)
X-Received: by 2002:a05:690c:6e87:b0:7b2:dad2:5def with SMTP id 00721157ae682-7bd52ac34e8mr5523197b3.48.1777498876727;
        Wed, 29 Apr 2026 14:41:16 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b00f3csm330847b3.7.2026.04.29.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:41:16 -0700 (PDT)
Message-ID: <fbab16663ba7c8b0a1970de7301ae85ea8cb0ca4.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 04/11] ceph: add diagnostic timeout loop
 to wait_caps_flush()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Wed, 29 Apr 2026 14:41:15 -0700
In-Reply-To: <20260429125206.1512203-5-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-5-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-29 at 12:51 +0000, Alex Markuze wrote:
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
> silently. When more entries exist than the per-dump limit, a truncation
> count is reported. When the dump iteration limit is reached, a final
> suppression message is emitted so the transition to silence is explicit.
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
>  fs/ceph/caps.c       | 10 +++++
>  fs/ceph/inode.c      |  1 +
>  fs/ceph/mds_client.c | 97 ++++++++++++++++++++++++++++++++++++++++++--
>  fs/ceph/super.h      |  6 +++
>  4 files changed, 110 insertions(+), 4 deletions(-)
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
> index b62abae72c4c..d83003acfb06 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -27,6 +27,8 @@
>  #include <trace/events/ceph.h>
> =20
>  #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
> +#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
> +#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5

I see the point to collect all timeout declarations in one place. What abou=
t to
place this declarations here [1]?

The CEPH_CAP_FLUSH_MAX_DUMP_COUNT controls two unrelated limits: the number=
 of
entries printed per dump, and the number of timed diagnostic dumps before
suppression. I think we need to have two separate constants with distinct n=
ames.

> =20
>  /*
>   * A cluster of MDS (metadata server) daemons is responsible for
> @@ -2286,19 +2288,106 @@ static int check_caps_flush(struct ceph_mds_clie=
nt *mdsc,
>  }
> =20
>  /*
> - * flush all dirty inode data to disk.
> + * Dump pending cap flushes for diagnostic purposes.
>   *
> - * returns true if we've flushed through want_flush_tid
> + * cf->ci is safe to dereference here: cap_flush entries hold a
> + * reference on the inode (via the cap), and entries are removed from
> + * cap_flush_list under cap_dirty_lock before the cap (and thus the
> + * inode reference) is released.  Holding cap_dirty_lock therefore
> + * guarantees the inode remains valid for the lifetime of the scan.
> + */

This commenting looks very strange and confusing. I think we need to have
comment for the function and comment for the structure. Especially, it's re=
ally
important to have comment for all fields of the structure.

> +struct flush_dump_entry {
> +	u64 ino;
> +	u64 snap;
> +	int caps;
> +	u64 tid;
> +	u64 last_ack;
> +	bool wake;
> +	bool is_capsnap;
> +	bool ci_null;
> +};
> +
> +static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
> +{
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_COUNT];
> +	struct ceph_cap_flush *cf;
> +	int n =3D 0, remaining =3D 0;
> +
> +	spin_lock(&mdsc->cap_dirty_lock);
> +	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
> +		if (cf->tid > want_tid)
> +			break;
> +		if (n < CEPH_CAP_FLUSH_MAX_DUMP_COUNT) {
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
> +	}
> +	spin_unlock(&mdsc->cap_dirty_lock);
> +
> +	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
> +		       want_tid);
> +	for (int i =3D 0; i < n; i++) {
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

Is integer type could be enough here? Could we overflow the i value?

Thanks,
Slava.

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
> +			if (i < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> +				dump_cap_flushes(mdsc, want_flush_tid);
> +			else if (i =3D=3D CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> +				pr_info_client(cl,
> +					       "still waiting for cap flushes; suppressing further dumps\n"=
);
> +			i++;
> +		}
> +	} while (ret =3D=3D 0);
> =20
>  	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
>  }
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 30911ccf961e..9aca42c89ea0 100644
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

[1]
https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/ceph/libceph.h=
#L72


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774F3859D2
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282877; cv=none; b=KaTz7Sg67oN4XwLWFmpFSF0crEtW5bNLxwXo1sDKJvzEWWr5dGxpURyDbjO7L4MsGFSsMMBQVp+zCUfqHu57xNpj/HNOeXI9Pj/RD1aP+JXudXo1ZJnXaNVUw4E3SpdKH337xd+VOmtLn5UGFrnJx1j4k2sZHx7VhkpHr0W7se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282877; c=relaxed/simple;
	bh=jFcryUTojklwCu/QQcPSVNssKMZuseGMvE2aB3KvKJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SR+TJSLP3n7MLZdzluIv2LIv6WU9I6fUbV/q/PTF5pMtdKvOmZQRixKPhMiMEGZ0AB/ciSqHWj5Wxvsm0Wjo7FBX1ke1lm//l+LjdcNbkboWeTFTfCqqQ7qKAtf6rXtQutCElps/E+6096E+AO4yzlPnFwruwTAB/ufLYP94+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA/qJgYj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIjkxW8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA/qJgYj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIjkxW8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776282874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGDPC/seN79By45edPfb2mXU7vgF94gklws+M1d9JYU=;
	b=OA/qJgYj7HmbL6XalOtV3gUpkFvcIm/8r8irb9B47gYI69HG1Qtd7QJ4c6lN8cgYPg6szS
	3Nf/KoQ99on3+8n3qRcEBcF5FGjD77fIHhceNuIhM0RDuMW9IzsLU/lIYFoIMPu229sl69
	nGw1gT8wXAGFQRoeZqd+Mh/91KZM30M=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-cesrPRTsM2e9HRMLGvljJQ-1; Wed, 15 Apr 2026 15:54:33 -0400
X-MC-Unique: cesrPRTsM2e9HRMLGvljJQ-1
X-Mimecast-MFC-AGG-ID: cesrPRTsM2e9HRMLGvljJQ_1776282873
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-649f0d26e5eso11359233d50.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776282873; x=1776887673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGDPC/seN79By45edPfb2mXU7vgF94gklws+M1d9JYU=;
        b=LIjkxW8pHVopxam4tsZ+Ipigix9EHcq1UUoehy7yMSreivtCi3Ae7bI4NzBzfKndSi
         SjM4/fYO+5NN+neCyVdqeP7Z+e9AKLDTOz4UIOK7tUZjP9aGsIPB67NcIcWJCdzDmzei
         T9l+MsQ2ZBzROU3AquQCAUe6SRe5bjLKfcBIEO/S95QVPDzCD324aiLSw9HQDmHjsDDP
         DN7lGLS4Yfa3yBS9CwPmTC8ltsjgPY5V5/ZUCdmIcP0Y2dPBCrmC6/S2sbxBYUb6gHTp
         GD0EJ2E3PT4qiZbHTZB5BidvD2HxJcbt+fSiQ0X3T2JMiu2xPsfomn+2/aiwnIMu/CsW
         jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282873; x=1776887673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGDPC/seN79By45edPfb2mXU7vgF94gklws+M1d9JYU=;
        b=eOHdC7PW/YKupM//616rTx/Qge8LHNsHvwB1JFgbapKO0L0H8kuvXBH3sLE/WFfgRd
         Q403apAlS406kH8gLAUtAtKqKGaSDadd1ST0sOVmz1vj6xsmbPZVpsld+J3z6XvFybB9
         wwRdKs+MkGpgkiIixBpVa/QYu8KeiwATn7jVrx2ZHWfsq79JTHabB450z29vbSNHXmGV
         0j8u7rPHVh950BBGz0jIPPe+rn8wrOgspqtomlENfMWqfUmi9TwWkQIVqJRSWEmEXAoB
         W2QwKONh0txw+qxwPpAPip7zrg4sfHGct2YUzpxATFZ6pu6n06Mtu3wIbVIiZdo9wmbD
         6fvA==
X-Forwarded-Encrypted: i=1; AFNElJ/2+fWVdNzj4BnP8M+hvybjqXuO2rLRWh0L41PxnfMdODE7q3H1Iesp1mNIzdlpUe+UoXg0BQTSTdMA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+m+WQlAjRh6yCZ8OGcFOCjBTssvR66N8CH6tp6UApbfzJPq96
	QPAJaFCM+0/dhVB+xMsdNwbJ9cVmTsDeAD/FzyFBGk2pBOZZ4jrY/vk/icOcZ9He296tNa9d0Qz
	hTMDqQev1d+ZGx0LXSv12gCSjRiLfDNG8gElFbSNbQF3voND7RSKCjncEePc8Wvk=
X-Gm-Gg: AeBDiesZ6Yb1Sbl3+KezfHLgSPnTqi2dCzljb3jXDQlIloGVvJjkeFFmo3YwFhd+dCQ
	VidQv1Bdtx/oj06eb+0QZw3bTnHNQQhV3DRZBXyhrp/7rgI2jSbtAZP3C/zcFUmmRU+Uj1U0tED
	AYK3SqDZlKGm4jvpEC+bTSj7j7B0VEl2ovofW65+sKq3qdb1cR8iP8hhB3jE8TcO5lNVLjNT2mF
	co2HXcAfq3nXJ1CmimX6Uv6d9vFThnOEpaG/lJRfgpe47oAKkmBJ2KT0hDXW6kPIiMmuioWXYj/
	as1zadDMv23IaZFHKVexub/P6pARfKqGrK5fyHblO7QJH0MznWMt3VfAAM+8ZESidlVBrbGwa8F
	8UmLVzDU4d8DLF27VAmw/D181GIRguFFI7nsH3q6OjyTOYZqpWWFSzPGQbEnptBI=
X-Received: by 2002:a05:690e:4362:b0:650:2770:804c with SMTP id 956f58d0204a3-65198aae2acmr17095965d50.10.1776282872677;
        Wed, 15 Apr 2026 12:54:32 -0700 (PDT)
X-Received: by 2002:a05:690e:4362:b0:650:2770:804c with SMTP id 956f58d0204a3-65198aae2acmr17095926d50.10.1776282871938;
        Wed, 15 Apr 2026 12:54:31 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e47884f8sm1145723d50.15.2026.04.15.12.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:54:30 -0700 (PDT)
Message-ID: <d2d748b9cb329c5cc066e8343570f0ca77e81884.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 1/7] ceph: convert inode flags to named
 bit positions and atomic bitops
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Wed, 15 Apr 2026 12:54:29 -0700
In-Reply-To: <20260415170043.3882912-2-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-2-amarkuze@redhat.com>
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
> Define named bit-position constants for all CEPH_I_* inode flags and
> derive the bitmask values from them.  This gives every flag a named
> _BIT constant usable with the test_bit/set_bit/clear_bit family.
> The intentionally unused bit position 1 is documented inline.
>=20
> Convert all flag modifications to use atomic bitops (set_bit,
> clear_bit, test_and_clear_bit).  The previous code mixed lockless
> atomic ops on some flags (ERROR_WRITE, ODIRECT) with non-atomic
> read-modify-write (|=3D / &=3D ~) on other flags sharing the same
> unsigned long.  A concurrent non-atomic RMW can clobber an
> adjacent lockless atomic update -- for example, a lockless
> clear_bit(ERROR_WRITE) could be silently resurrected by a
> concurrent ci->i_ceph_flags |=3D CEPH_I_FLUSH under the spinlock.
> Using atomic bitops for all modifications eliminates this class
> of race entirely.
>=20
> Flags whose only users are now the _BIT form (ERROR_WRITE,
> ERROR_FILELOCK, SHUTDOWN, ASYNC_CHECK_CAPS) have their old mask
> defines removed to document that callers must use the _BIT
> constant with the set_bit/test_bit family.
>=20
> Flag reads under i_ceph_lock continue to use bitmask tests where
> the tested flag is only modified under the same lock; this is safe
> because the lock serialises both the read and the write.  The
> remaining flags continue to use non-atomic bitmask operations under
> i_ceph_lock, which is correct and unchanged.
>=20
> The lockless reader ceph_inode_is_shutdown() retains the READ_ONCE()
> snapshot plus bitmask test pattern -- the single atomic load into a
> local variable is correct and avoids a second memory access that
> test_bit() would require.
>=20
> The direct assignment in ceph_finish_async_create() is converted
> from i_ceph_flags =3D CEPH_I_ASYNC_CREATE to set_bit().  This
> inode is I_NEW at this point -- still invisible to other threads
> and guaranteed to have zero flags from alloc_inode -- so either
> form is safe, but set_bit() keeps the conversion uniform.
>=20
> The only remaining direct assignment (alloc_inode zeroing) operates
> on an inode that is not yet visible to other threads, so it is safe
> without atomic ops.
>=20
> The dead precomputed flags variable in ceph_pool_perm_check() is
> removed; the check: loop re-reads flags from i_ceph_flags after
> the set_bit() calls, keeping a single source of truth.
>=20
> Co-developed-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/addr.c       | 16 +++++------
>  fs/ceph/caps.c       | 24 ++++++++---------
>  fs/ceph/file.c       | 12 ++++-----
>  fs/ceph/inode.c      |  4 +--
>  fs/ceph/locks.c      | 22 ++++-----------
>  fs/ceph/mds_client.c |  3 ++-
>  fs/ceph/mds_client.h |  2 +-
>  fs/ceph/snap.c       |  2 +-
>  fs/ceph/super.h      | 64 ++++++++++++++++++++++----------------------
>  fs/ceph/xattr.c      |  2 +-
>  10 files changed, 69 insertions(+), 82 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 2090fc78529c..bde9efffa228 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -2583,20 +2583,18 @@ int ceph_pool_perm_check(struct inode *inode, int=
 need)
>  	if (ret < 0)
>  		return ret;
> =20
> -	flags =3D CEPH_I_POOL_PERM;
> -	if (ret & POOL_READ)
> -		flags |=3D CEPH_I_POOL_RD;
> -	if (ret & POOL_WRITE)
> -		flags |=3D CEPH_I_POOL_WR;
> -

Is it correct removal? It looks like a bug to me. Should we do this inside =
of
spin_lock section but before any operations with flags? It looks like that
ceph_pool_perm_check() can read stale POOL_RD/POOL_WR bits.

>  	spin_lock(&ci->i_ceph_lock);
>  	if (pool =3D=3D ci->i_layout.pool_id &&
>  	    pool_ns =3D=3D rcu_dereference_raw(ci->i_layout.pool_ns)) {
> -		ci->i_ceph_flags |=3D flags;
> -        } else {
> +		set_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
> +		if (ret & POOL_READ)
> +			set_bit(CEPH_I_POOL_RD_BIT, &ci->i_ceph_flags);
> +		if (ret & POOL_WRITE)
> +			set_bit(CEPH_I_POOL_WR_BIT, &ci->i_ceph_flags);
> +	} else {
>  		pool =3D ci->i_layout.pool_id;
> -		flags =3D ci->i_ceph_flags;
>  	}
> +	flags =3D ci->i_ceph_flags;
>  	spin_unlock(&ci->i_ceph_lock);
>  	goto check;
>  }
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index d51454e995a8..cb9e78b713d9 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -549,7 +549,7 @@ static void __cap_delay_requeue_front(struct ceph_mds=
_client *mdsc,
> =20
>  	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
>  	spin_lock(&mdsc->cap_delay_lock);
> -	ci->i_ceph_flags |=3D CEPH_I_FLUSH;
> +	set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
>  	if (!list_empty(&ci->i_cap_delay_list))
>  		list_del_init(&ci->i_cap_delay_list);
>  	list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_list);
> @@ -1409,7 +1409,7 @@ static void __prep_cap(struct cap_msg_args *arg, st=
ruct ceph_cap *cap,
>  	      ceph_cap_string(revoking));
>  	BUG_ON((retain & CEPH_CAP_PIN) =3D=3D 0);
> =20
> -	ci->i_ceph_flags &=3D ~CEPH_I_FLUSH;
> +	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> =20
>  	cap->issued &=3D retain;  /* drop bits we don't want */
>  	/*
> @@ -1666,7 +1666,7 @@ static void __ceph_flush_snaps(struct ceph_inode_in=
fo *ci,
>  		last_tid =3D capsnap->cap_flush.tid;
>  	}
> =20
> -	ci->i_ceph_flags &=3D ~CEPH_I_FLUSH_SNAPS;
> +	clear_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
> =20
>  	while (first_tid <=3D last_tid) {
>  		struct ceph_cap *cap =3D ci->i_auth_cap;
> @@ -2026,7 +2026,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, in=
t flags)
> =20
>  	spin_lock(&ci->i_ceph_lock);
>  	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> -		ci->i_ceph_flags |=3D CEPH_I_ASYNC_CHECK_CAPS;
> +		set_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT, &ci->i_ceph_flags);
> =20
>  		/* Don't send messages until we get async create reply */
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -2577,7 +2577,7 @@ static void __kick_flushing_caps(struct ceph_mds_cl=
ient *mdsc,
>  	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE)
>  		return;
> =20
> -	ci->i_ceph_flags &=3D ~CEPH_I_KICK_FLUSH;
> +	clear_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
> =20
>  	list_for_each_entry_reverse(cf, &ci->i_cap_flush_list, i_list) {
>  		if (cf->is_capsnap) {
> @@ -2686,7 +2686,7 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_=
client *mdsc,
>  			__kick_flushing_caps(mdsc, session, ci,
>  					     oldest_flush_tid);
>  		} else {
> -			ci->i_ceph_flags |=3D CEPH_I_KICK_FLUSH;
> +			set_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
>  		}
> =20
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -2829,7 +2829,7 @@ static int try_get_cap_refs(struct inode *inode, in=
t need, int want,
>  	spin_lock(&ci->i_ceph_lock);
> =20
>  	if ((flags & CHECK_FILELOCK) &&
> -	    (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
> +	    test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
>  		doutc(cl, "%p %llx.%llx error filelock\n", inode,
>  		      ceph_vinop(inode));
>  		ret =3D -EIO;
> @@ -3207,7 +3207,7 @@ static int ceph_try_drop_cap_snap(struct ceph_inode=
_info *ci,
>  		BUG_ON(capsnap->cap_flush.tid > 0);
>  		ceph_put_snap_context(capsnap->context);
>  		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
> -			ci->i_ceph_flags |=3D CEPH_I_FLUSH_SNAPS;
> +			set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
> =20
>  		list_del(&capsnap->ci_item);
>  		ceph_put_cap_snap(capsnap);
> @@ -3396,7 +3396,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_i=
nfo *ci, int nr,
>  				if (ceph_try_drop_cap_snap(ci, capsnap)) {
>  					put++;
>  				} else {
> -					ci->i_ceph_flags |=3D CEPH_I_FLUSH_SNAPS;
> +					set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
>  					flush_snaps =3D true;
>  				}
>  			}
> @@ -3648,7 +3648,7 @@ static void handle_cap_grant(struct inode *inode,
> =20
>  		if (ci->i_layout.pool_id !=3D old_pool ||
>  		    extra_info->pool_ns !=3D old_ns)
> -			ci->i_ceph_flags &=3D ~CEPH_I_POOL_PERM;
> +			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
> =20
>  		extra_info->pool_ns =3D old_ns;
> =20
> @@ -4815,7 +4815,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
>  			doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
>  			      ceph_vinop(inode));
>  			spin_lock(&mdsc->cap_delay_lock);
> -			ci->i_ceph_flags |=3D CEPH_I_FLUSH;
> +			set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
>  			if (!list_empty(&ci->i_cap_delay_list))
>  				list_del_init(&ci->i_cap_delay_list);
>  			list_add_tail(&ci->i_cap_delay_list,
> @@ -5080,7 +5080,7 @@ int ceph_purge_inode_cap(struct inode *inode, struc=
t ceph_cap *cap, bool *invali
> =20
>  		if (atomic_read(&ci->i_filelock_ref) > 0) {
>  			/* make further file lock syscall return -EIO */
> -			ci->i_ceph_flags |=3D CEPH_I_ERROR_FILELOCK;
> +			set_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
>  			pr_warn_ratelimited_client(cl,
>  				" dropping file locks for %p %llx.%llx\n",
>  				inode, ceph_vinop(inode));
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5e7c73a29aa3..2b457dab0837 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -579,12 +579,11 @@ static void wake_async_create_waiters(struct inode =
*inode,
> =20
>  	spin_lock(&ci->i_ceph_lock);
>  	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> -		clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
> +		clear_and_wake_up_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
> =20
> -		if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
> -			ci->i_ceph_flags &=3D ~CEPH_I_ASYNC_CHECK_CAPS;
> +		if (test_and_clear_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT,
> +				      &ci->i_ceph_flags))

I am not sure that it could be a problem but we call clear_and_wake_up_bit(=
) and
only then call test_and_clear_bit(). I think spin_lock() should protect fro=
m
potential races.

>  			check_cap =3D true;
> -		}
>  	}
>  	ceph_kick_flushing_inode_caps(session, ci);
>  	spin_unlock(&ci->i_ceph_lock);
> @@ -747,7 +746,8 @@ static int ceph_finish_async_create(struct inode *dir=
, struct inode *inode,
>  			 * that point and don't worry about setting
>  			 * CEPH_I_ASYNC_CREATE.
>  			 */
> -			ceph_inode(inode)->i_ceph_flags =3D CEPH_I_ASYNC_CREATE;
> +			set_bit(CEPH_I_ASYNC_CREATE_BIT,
> +				&ceph_inode(inode)->i_ceph_flags);
>  			unlock_new_inode(inode);
>  		}
>  		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
> @@ -2422,7 +2422,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
> =20
>  	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) =3D=3D 0 ||
>  	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
> -	    (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
> +	    test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
>  		struct ceph_snap_context *snapc;
>  		struct iov_iter data;
> =20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index d99e12d1100b..f75d66760d54 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1142,7 +1142,7 @@ int ceph_fill_inode(struct inode *inode, struct pag=
e *locked_page,
>  		rcu_assign_pointer(ci->i_layout.pool_ns, pool_ns);
> =20
>  		if (ci->i_layout.pool_id !=3D old_pool || pool_ns !=3D old_ns)
> -			ci->i_ceph_flags &=3D ~CEPH_I_POOL_PERM;
> +			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
> =20
>  		pool_ns =3D old_ns;
> =20
> @@ -3199,7 +3199,7 @@ void ceph_inode_shutdown(struct inode *inode)
>  	bool invalidate =3D false;
> =20
>  	spin_lock(&ci->i_ceph_lock);
> -	ci->i_ceph_flags |=3D CEPH_I_SHUTDOWN;
> +	set_bit(CEPH_I_SHUTDOWN_BIT, &ci->i_ceph_flags);
>  	p =3D rb_first(&ci->i_caps);
>  	while (p) {
>  		struct ceph_cap *cap =3D rb_entry(p, struct ceph_cap, ci_node);
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index dd764f9c64b9..c4ff2266bb94 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -57,9 +57,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
>  	ci =3D ceph_inode(inode);
>  	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
>  		/* clear error when all locks are released */
> -		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags &=3D ~CEPH_I_ERROR_FILELOCK;
> -		spin_unlock(&ci->i_ceph_lock);
> +		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
>  	}
>  	fl->fl_u.ceph.inode =3D NULL;
>  	iput(inode);
> @@ -271,15 +269,10 @@ int ceph_lock(struct file *file, int cmd, struct fi=
le_lock *fl)
>  	else if (IS_SETLKW(cmd))
>  		wait =3D 1;
> =20
> -	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> -		err =3D -EIO;
> -	}
> -	spin_unlock(&ci->i_ceph_lock);
> -	if (err < 0) {
> +	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
>  		if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
>  			posix_lock_file(file, fl, NULL);
> -		return err;
> +		return -EIO;
>  	}
> =20
>  	if (lock_is_read(fl))
> @@ -331,15 +324,10 @@ int ceph_flock(struct file *file, int cmd, struct f=
ile_lock *fl)
> =20
>  	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
> =20
> -	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> -		err =3D -EIO;
> -	}
> -	spin_unlock(&ci->i_ceph_lock);
> -	if (err < 0) {
> +	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
>  		if (lock_is_unlock(fl))
>  			locks_lock_file_wait(file, fl);
> -		return err;
> +		return -EIO;
>  	}
> =20
>  	if (IS_SETLKW(cmd))
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b1746273f186..ccf0d53dde2b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3613,7 +3613,8 @@ static void __do_request(struct ceph_mds_client *md=
sc,
> =20
>  		spin_lock(&ci->i_ceph_lock);
>  		cap =3D ci->i_auth_cap;
> -		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds !=3D cap->mds) {
> +		if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
> +		    mds !=3D cap->mds) {
>  			doutc(cl, "session changed for auth cap %d -> %d\n",
>  			      cap->session->s_mds, session->s_mds);
> =20
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0428a5eaf28c..e91a199d56fd 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -658,7 +658,7 @@ static inline int ceph_wait_on_async_create(struct in=
ode *inode)
>  {
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
> =20
> -	return wait_on_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT,
> +	return wait_on_bit(&ci->i_ceph_flags, CEPH_I_ASYNC_CREATE_BIT,
>  			   TASK_KILLABLE);
>  }
> =20
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 52b4c2684f92..9b79a5eaca93 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -700,7 +700,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci=
,
>  		return 0;
>  	}
> =20
> -	ci->i_ceph_flags |=3D CEPH_I_FLUSH_SNAPS;
> +	set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
>  	doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=3D%llu\n",
>  	      inode, ceph_vinop(inode), capsnap, capsnap->context,
>  	      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 29a980e22dc2..c89ad8dcc969 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -655,23 +655,32 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
>  /*
>   * Ceph inode.
>   */
> -#define CEPH_I_DIR_ORDERED	(1 << 0)  /* dentries in dir are ordered */
> -#define CEPH_I_FLUSH		(1 << 2)  /* do not delay flush of dirty metadata =
*/
> -#define CEPH_I_POOL_PERM	(1 << 3)  /* pool rd/wr bits are valid */
> -#define CEPH_I_POOL_RD		(1 << 4)  /* can read from pool */
> -#define CEPH_I_POOL_WR		(1 << 5)  /* can write to pool */
> -#define CEPH_I_SEC_INITED	(1 << 6)  /* security initialized */
> -#define CEPH_I_KICK_FLUSH	(1 << 7)  /* kick flushing caps */
> -#define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
> -#define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
> -#define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
> -#define CEPH_I_ODIRECT_BIT	(11) /* inode in direct I/O mode */
> -#define CEPH_I_ODIRECT		(1 << CEPH_I_ODIRECT_BIT)
> -#define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this =
*/
> -#define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
> -#define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
> -#define CEPH_I_ASYNC_CHECK_CAPS	(1 << 14) /* check caps immediately afte=
r async
> -					     creating finishes */
> +#define CEPH_I_DIR_ORDERED_BIT		(0)  /* dentries in dir are ordered */
> +					     /* bit 1 historically unused */
> +#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata *=
/
> +#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
> +#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
> +#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
> +#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
> +#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
> +#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snaps */
> +#define CEPH_I_ERROR_WRITE_BIT		(9)  /* have seen write errors */
> +#define CEPH_I_ERROR_FILELOCK_BIT	(10) /* have seen file lock errors */
> +#define CEPH_I_ODIRECT_BIT		(11) /* inode in direct I/O mode */
> +#define CEPH_I_ASYNC_CREATE_BIT		(12) /* async create in flight for this=
 */
> +#define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
> +#define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creat=
ing finishes */
> +
> +#define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
> +#define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
> +#define CEPH_I_POOL_PERM		(1 << CEPH_I_POOL_PERM_BIT)
> +#define CEPH_I_POOL_RD			(1 << CEPH_I_POOL_RD_BIT)
> +#define CEPH_I_POOL_WR			(1 << CEPH_I_POOL_WR_BIT)
> +#define CEPH_I_SEC_INITED		(1 << CEPH_I_SEC_INITED_BIT)
> +#define CEPH_I_KICK_FLUSH		(1 << CEPH_I_KICK_FLUSH_BIT)
> +#define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
> +#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
> +#define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
> =20
>  /*
>   * Masks of ceph inode work.
> @@ -684,27 +693,18 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
> =20
>  /*
>   * We set the ERROR_WRITE bit when we start seeing write errors on an in=
ode
> - * and then clear it when they start succeeding. Note that we do a lockl=
ess
> - * check first, and only take the lock if it looks like it needs to be c=
hanged.
> - * The write submission code just takes this as a hint, so we're not too
> - * worried if a few slip through in either direction.
> + * and then clear it when they start succeeding. The write submission co=
de
> + * just takes this as a hint, so we're not too worried if a few slip thr=
ough
> + * in either direction.
>   */
>  static inline void ceph_set_error_write(struct ceph_inode_info *ci)
>  {
> -	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
> -		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags |=3D CEPH_I_ERROR_WRITE;
> -		spin_unlock(&ci->i_ceph_lock);
> -	}
> +	set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>  }

Maybe, we need to consider something like this?

  static inline void ceph_set_error_write(struct ceph_inode_info *ci)      =
   =20
  {                              =20
      if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags))            =
   =20
          set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
  }

> =20
>  static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
>  {
> -	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
> -		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags &=3D ~CEPH_I_ERROR_WRITE;
> -		spin_unlock(&ci->i_ceph_lock);
> -	}
> +	clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>  }
> =20
>  static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
> @@ -1142,7 +1142,7 @@ static inline bool ceph_inode_is_shutdown(struct in=
ode *inode)
>  	struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode);
>  	int state =3D READ_ONCE(fsc->mount_state);
> =20
> -	return (flags & CEPH_I_SHUTDOWN) || state >=3D CEPH_MOUNT_SHUTDOWN;
> +	return (flags & BIT(CEPH_I_SHUTDOWN_BIT)) || state >=3D CEPH_MOUNT_SHUT=
DOWN;

Why not to use the CEPH_I_SHUTDOWN_BIT here?

Thanks,
Slava.

>  }
> =20
>  /* xattr.c */
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 5f87f62091a1..7cf9e908c2fe 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1054,7 +1054,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const =
char *name, void *value,
>  	if (current->journal_info &&
>  	    !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) &&
>  	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
> -		ci->i_ceph_flags |=3D CEPH_I_SEC_INITED;
> +		set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
>  out:
>  	spin_unlock(&ci->i_ceph_lock);
>  	return err;


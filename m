Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574453F0756
	for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952233; cv=none; b=dSfriIjRh4p1/qBtdc6fIS4gjzwHXW8WPmB5izV2AHcRJy2NP+WQBuvNWQ8EHby+dMn2mFicP5Ofgl+rVcbvnpu7+iak3kIuoK+HvUqyP2d0mH4XqqVvQtqJIyyb83MAX1IzYPeyuFAYH2yqp6+oGZ2xCKUT/E8LVLfMk7vw//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952233; c=relaxed/simple;
	bh=jFJ9lWNJUAJ+bnAgHDiJk2FuT88rkR33tlBVrouFvC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIYCg2+/I+kyK2BTy59Z3RWEEBU7NOanXNLV19jxB1QMh074i6sZQaUyAgkTaniJdRllGxNdOXKMWaWZzEdj6El5DfbqDTUi3P/8TRABbX4Q1rLxvOsAk2j6/GVwkbTg67/pshp3t0z690pBYqPANYiqeDLEeNvNCvNtiZG9mRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa1zryNH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyNlfv37; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa1zryNH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyNlfv37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768952230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZ+Byp7DNuQZdaomw9Iake4qmi38JQ1Iil1sM7dDxrM=;
	b=Xa1zryNH9SVnxika/9yXfowhxlXF5H/tNSSaigmwa2XNBYvY/7FWK87b7CY6OD/tDttmwS
	KyM4ehhKhJubfXcBlBi9gdO78tRB0UXpB7+aFmmOi/KrdxEtBcJZ6p7FyOajXEjnVsw1tx
	BCVk6V4XkQcBexdw6D0jrb3jhjGtn7Y=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-2eaJ6th_N6uGzdeEfYDzTA-1; Tue, 20 Jan 2026 18:37:08 -0500
X-MC-Unique: 2eaJ6th_N6uGzdeEfYDzTA-1
X-Mimecast-MFC-AGG-ID: 2eaJ6th_N6uGzdeEfYDzTA_1768952228
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78fb85eddf1so65013397b3.3
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 15:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768952228; x=1769557028; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZ+Byp7DNuQZdaomw9Iake4qmi38JQ1Iil1sM7dDxrM=;
        b=WyNlfv37MqrB5GgMzMnZ0V6FSdRP1gqFa9j6dmcAoDj9MD2tp2I5KoVjldSqg+5zbA
         TF6swVXY23YuchgbQFJ1BJQBSKlR8opqu29bDbLr8hHkCjJNiI70Euhtjdk1x3h7XYFC
         h+mkaniSfAXFz7I3dw+XsCjkUtT0tPBZsKHLWBzXumNgB0wIoZ0RZ6LO+dgnsDMLLtew
         ieE6Y2TQWSN8empR8HzPsN8JMt37eml79/T64finRYpa6iFp6JjA9vZVd3XtR0S5B9/N
         Zec6HVtmuBTRFxbHsqqL52I7qGfvcnQGQm4GPliFzeWtvHCNrOPnfn/nM1JsuzhvVO23
         ccmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768952228; x=1769557028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ+Byp7DNuQZdaomw9Iake4qmi38JQ1Iil1sM7dDxrM=;
        b=S+lD8XMZ+HC+2kcQPGI7CDZG7HWfNOjTja+02XsA1Dnvlqq0kohMy699/XObM8zfgS
         eoyQbl7C1Lku3a7yqA7LcwHbTx8fPp7pOmDkHcpdA78yTsWe7dzpaW908GWe9/3Nj6mP
         00caVduQfR3QpgOsS3bklSDYXya0p08Yvncdmd9bNbXQi80FNC6IyTzugFeMGPxNS0+X
         LE5YJSEmubs1h4X5ySguQJWHxhcIxR/FPp7LSXn6K7xub0oYbQsYlveJLIwpWQxWPp+7
         jXElMpURWOf6bb6KAdt77uA1NbAGGfFINoVD0g9H4ltr+UIhUF0VHaLX3hmBw8oV3UQu
         exxA==
X-Forwarded-Encrypted: i=1; AJvYcCV/4k1JKknHa1WyeYYE2k8sIAZm/EgdLasKgs2klMC9tZvhGNclJObErBLdLATKrdeYD5Qd0AyquLpU@vger.kernel.org
X-Gm-Message-State: AOJu0YywKMkeBA7gzjlbRKzWS4vhsDx6HudTdJ+1OXMdAPV7cHxOLcwP
	BGJcNUXDvc1SIzNa0Y6QIXYTLOSHtlaSpUUJGSmnthZ6o5eA0e80IqBKN9QRSYKefTcI1P/VpSn
	aoSb0DU3vv4q0DvkzOWb69tBkCgOzkKzxNvJd4XURHryw8iPqb3cATMCMkd6dURo=
X-Gm-Gg: AZuq6aJCm5I0igBFNfGhkN1hrxj/zpqsQDnoEazT+VRLhxEBXBUw5AyHQeMYlbMiX7Z
	VVbDZ784nONXCSLFSyBPkpV0uqXv0frcSsWJWWH/XtPd17ZPCaFKrsZb+zzCxrKXKrdNpy7mXzW
	KY5XSBnUXWRbhalmoI5DCnqnvYALAfrdD8HcPAsddVtKcfub+u1Gvzpxe3583WIHLD4MxdETLDa
	n+3KDPdcmGarjp6KsO28EhSDspx6mn/Y8qeZCZNi9mlsO+qmMIcmve/2xyUZqzUKJDytThrTjUv
	UaKksAxhu42AJ31uGZ9Y7fOznMShUUgkLWOkxMCuBuFF8YZb4NT2OrwAad4uvH14frffMHcZzFx
	uNBbpzB3c5IerF1xGtXvxVPfWXM4Zu/UYst2eDDN0
X-Received: by 2002:a05:690c:c50e:b0:78d:7307:76a4 with SMTP id 00721157ae682-7940a0e4c83mr67699877b3.11.1768952228079;
        Tue, 20 Jan 2026 15:37:08 -0800 (PST)
X-Received: by 2002:a05:690c:c50e:b0:78d:7307:76a4 with SMTP id 00721157ae682-7940a0e4c83mr67699407b3.11.1768952227612;
        Tue, 20 Jan 2026 15:37:07 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68307b5sm57919137b3.32.2026.01.20.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 15:37:07 -0800 (PST)
Message-ID: <1c56927f3eb7cb2ab49288d161bf5276b17ff8f4.camel@redhat.com>
Subject: Re: [PATCH v5 2/3] ceph: parse subvolume_id from InodeStat v9 and
 store in inode
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 15:37:06 -0800
In-Reply-To: <20260118182446.3514417-3-amarkuze@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
	 <20260118182446.3514417-3-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
> Add support for parsing the subvolume_id field from InodeStat v9 and
> storing it in the inode for later use by subvolume metrics tracking.
>=20
> The subvolume_id identifies which CephFS subvolume an inode belongs to,
> enabling per-subvolume I/O metrics collection and reporting.
>=20
> This patch:
> - Adds subvolume_id field to struct ceph_mds_reply_info_in
> - Adds i_subvolume_id field to struct ceph_inode_info
> - Parses subvolume_id from v9 InodeStat in parse_reply_info_in()
> - Adds ceph_inode_set_subvolume() helper to propagate the ID to inodes
> - Initializes i_subvolume_id in inode allocation and clears on destroy
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/inode.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.c | 38 ++++++++++++++++++++++++--------------
>  fs/ceph/mds_client.h |  1 +
>  fs/ceph/super.h      | 10 ++++++++++
>  4 files changed, 76 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index a6e260d9e420..257b3e27b741 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -638,6 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
> =20
>  	ci->i_max_bytes =3D 0;
>  	ci->i_max_files =3D 0;
> +	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> =20
>  	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
>  	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> @@ -742,6 +743,8 @@ void ceph_evict_inode(struct inode *inode)
> =20
>  	percpu_counter_dec(&mdsc->metric.total_inodes);
> =20
> +	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> +
>  	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
>  	if (inode->i_state & I_PINNING_NETFS_WB)
> @@ -873,6 +876,40 @@ int ceph_fill_file_size(struct inode *inode, int iss=
ued,
>  	return queue_trunc;
>  }
> =20
> +/*
> + * Set the subvolume ID for an inode.
> + *
> + * The subvolume_id identifies which CephFS subvolume this inode belongs=
 to.
> + * CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset - the MDS only sends
> + * non-zero IDs for inodes within subvolumes.
> + *
> + * An inode's subvolume membership is immutable - once an inode is creat=
ed
> + * in a subvolume, it stays there. Therefore, if we already have a valid
> + * (non-zero) subvolume_id and receive a different one, that indicates a=
 bug.
> + */
> +void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
> +{
> +	struct ceph_inode_info *ci;
> +	u64 old;
> +
> +	if (!inode || subvolume_id =3D=3D CEPH_SUBVOLUME_ID_NONE)
> +		return;
> +
> +	ci =3D ceph_inode(inode);
> +	old =3D READ_ONCE(ci->i_subvolume_id);
> +
> +	if (old =3D=3D subvolume_id)
> +		return;
> +
> +	if (old !=3D CEPH_SUBVOLUME_ID_NONE) {
> +		/* subvolume_id should not change once set */
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
> +}
> +
>  void ceph_fill_file_time(struct inode *inode, int issued,
>  			 u64 time_warp_seq, struct timespec64 *ctime,
>  			 struct timespec64 *mtime, struct timespec64 *atime)
> @@ -1087,6 +1124,7 @@ int ceph_fill_inode(struct inode *inode, struct pag=
e *locked_page,
>  	new_issued =3D ~issued & info_caps;
> =20
>  	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
> +	ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
> =20
>  #ifdef CONFIG_FS_ENCRYPTION
>  	if (iinfo->fscrypt_auth_len &&
> @@ -1594,6 +1632,8 @@ int ceph_fill_trace(struct super_block *sb, struct =
ceph_mds_request *req)
>  			goto done;
>  		}
>  		if (parent_dir) {
> +			ceph_inode_set_subvolume(parent_dir,
> +						 rinfo->diri.subvolume_id);
>  			err =3D ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
>  					      rinfo->dirfrag, session, -1,
>  					      &req->r_caps_reservation);
> @@ -1682,6 +1722,7 @@ int ceph_fill_trace(struct super_block *sb, struct =
ceph_mds_request *req)
>  		BUG_ON(!req->r_target_inode);
> =20
>  		in =3D req->r_target_inode;
> +		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
>  		err =3D ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
>  				NULL, session,
>  				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d7d8178e1f9a..c765367ac947 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -95,19 +95,19 @@ static int parse_reply_info_quota(void **p, void *end=
,
>  	return -EIO;
>  }
> =20
> -/*
> - * parse individual inode info
> - */
>  static int parse_reply_info_in(void **p, void *end,
>  			       struct ceph_mds_reply_info_in *info,
> -			       u64 features)
> +			       u64 features,
> +			       struct ceph_mds_client *mdsc)
>  {
>  	int err =3D 0;
>  	u8 struct_v =3D 0;
> +	u8 struct_compat =3D 0;
> +	u32 struct_len =3D 0;
> +
> +	info->subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> =20
>  	if (features =3D=3D (u64)-1) {
> -		u32 struct_len;
> -		u8 struct_compat;
>  		ceph_decode_8_safe(p, end, struct_v, bad);
>  		ceph_decode_8_safe(p, end, struct_compat, bad);
>  		/* struct_v is expected to be >=3D 1. we only understand
> @@ -251,6 +251,10 @@ static int parse_reply_info_in(void **p, void *end,
>  			ceph_decode_skip_n(p, end, v8_struct_len, bad);
>  		}
> =20
> +		/* struct_v 9 added subvolume_id */
> +		if (struct_v >=3D 9)
> +			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
> +
>  		*p =3D end;
>  	} else {
>  		/* legacy (unversioned) struct */
> @@ -383,12 +387,13 @@ static int parse_reply_info_lease(void **p, void *e=
nd,
>   */
>  static int parse_reply_info_trace(void **p, void *end,
>  				  struct ceph_mds_reply_info_parsed *info,
> -				  u64 features)
> +				  u64 features,
> +				  struct ceph_mds_client *mdsc)
>  {
>  	int err;
> =20
>  	if (info->head->is_dentry) {
> -		err =3D parse_reply_info_in(p, end, &info->diri, features);
> +		err =3D parse_reply_info_in(p, end, &info->diri, features, mdsc);
>  		if (err < 0)
>  			goto out_bad;
> =20
> @@ -408,7 +413,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>  	}
> =20
>  	if (info->head->is_target) {
> -		err =3D parse_reply_info_in(p, end, &info->targeti, features);
> +		err =3D parse_reply_info_in(p, end, &info->targeti, features,
> +					  mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -429,7 +435,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>   */
>  static int parse_reply_info_readdir(void **p, void *end,
>  				    struct ceph_mds_request *req,
> -				    u64 features)
> +				    u64 features,
> +				    struct ceph_mds_client *mdsc)
>  {
>  	struct ceph_mds_reply_info_parsed *info =3D &req->r_reply_info;
>  	struct ceph_client *cl =3D req->r_mdsc->fsc->client;
> @@ -544,7 +551,7 @@ static int parse_reply_info_readdir(void **p, void *e=
nd,
>  		rde->name_len =3D oname.len;
> =20
>  		/* inode */
> -		err =3D parse_reply_info_in(p, end, &rde->inode, features);
> +		err =3D parse_reply_info_in(p, end, &rde->inode, features, mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  		/* ceph_readdir_prepopulate() will update it */
> @@ -752,7 +759,8 @@ static int parse_reply_info_extra(void **p, void *end=
,
>  	if (op =3D=3D CEPH_MDS_OP_GETFILELOCK)
>  		return parse_reply_info_filelock(p, end, info, features);
>  	else if (op =3D=3D CEPH_MDS_OP_READDIR || op =3D=3D CEPH_MDS_OP_LSSNAP)
> -		return parse_reply_info_readdir(p, end, req, features);
> +		return parse_reply_info_readdir(p, end, req, features,
> +						req->r_mdsc);
>  	else if (op =3D=3D CEPH_MDS_OP_CREATE)
>  		return parse_reply_info_create(p, end, info, features, s);
>  	else if (op =3D=3D CEPH_MDS_OP_GETVXATTR)
> @@ -781,7 +789,8 @@ static int parse_reply_info(struct ceph_mds_session *=
s, struct ceph_msg *msg,
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
>  		ceph_decode_need(&p, end, len, bad);
> -		err =3D parse_reply_info_trace(&p, p+len, info, features);
> +		err =3D parse_reply_info_trace(&p, p + len, info, features,
> +					     s->s_mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -790,7 +799,7 @@ static int parse_reply_info(struct ceph_mds_session *=
s, struct ceph_msg *msg,
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
>  		ceph_decode_need(&p, end, len, bad);
> -		err =3D parse_reply_info_extra(&p, p+len, req, features, s);
> +		err =3D parse_reply_info_extra(&p, p + len, req, features, s);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -3970,6 +3979,7 @@ static void handle_reply(struct ceph_mds_session *s=
ession, struct ceph_msg *msg)
>  			goto out_err;
>  		}
>  		req->r_target_inode =3D in;
> +		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
>  	}
> =20
>  	mutex_lock(&session->s_mutex);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0428a5eaf28c..bd3690baa65c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -118,6 +118,7 @@ struct ceph_mds_reply_info_in {
>  	u32 fscrypt_file_len;
>  	u64 rsnaps;
>  	u64 change_attr;
> +	u64 subvolume_id;
>  };
> =20
>  struct ceph_mds_reply_dir_entry {
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a1f781c46b41..74fe2dd914e0 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -386,6 +386,15 @@ struct ceph_inode_info {
>  	/* quotas */
>  	u64 i_max_bytes, i_max_files;
> =20
> +	/*
> +	 * Subvolume ID this inode belongs to. CEPH_SUBVOLUME_ID_NONE (0)
> +	 * means unknown/unset, matching the FUSE client convention.
> +	 * Once set to a valid (non-zero) value, it should not change
> +	 * during the inode's lifetime.
> +	 */
> +#define CEPH_SUBVOLUME_ID_NONE 0
> +	u64 i_subvolume_id;
> +
>  	s32 i_dir_pin;
> =20
>  	struct rb_root i_fragtree;
> @@ -1057,6 +1066,7 @@ extern struct inode *ceph_get_inode(struct super_bl=
ock *sb,
>  extern struct inode *ceph_get_snapdir(struct inode *parent);
>  extern int ceph_fill_file_size(struct inode *inode, int issued,
>  			       u32 truncate_seq, u64 truncate_size, u64 size);
> +extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_=
id);
>  extern void ceph_fill_file_time(struct inode *inode, int issued,
>  				u64 time_warp_seq, struct timespec64 *ctime,
>  				struct timespec64 *mtime,

Looks good!

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


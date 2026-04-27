Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52462421884
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319835; cv=none; b=lk15lRkwinxrjVc6h4PjPliNs4gNTaKw8Nfvz/Pwm1vNOlhUl3KeVmEUQ5Vt6o6DBFHp3MEItqkFyBrHKlPvsn5ckgcpTaYDpzVVc+8hLLZ5DLl1APprDxT9p3zUdW4NfYRI1+X7toPP5Y6qsaraex8U3ZwKMfvnyfzZkz3GMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319835; c=relaxed/simple;
	bh=h09aoUcZcPEq+HcK/yYLwdypVvQtuCa44dXzoaWUMKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWuUDXF5v85rDKbbSayfVgrZSptrO7LUrs1VIUXoKHg/d0BVLfA4OG1CqgobKEEl5tiZUAIO/zarTbWCm7t2dBGeYuXMlteDdvH42of+i1wxOV4q3EuQCkViEErIaicPoQe4d9qzC5YEMx2dVIBinguL4UffXhuPLxGjW5pgOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxkXlJR4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+8aEpcD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxkXlJR4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+8aEpcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICw+B9EQ3je422zYrSrt2k64CSETxiqpDeaciqWbX6s=;
	b=WxkXlJR4cSS1CW7CeHIPn0aVOZXqi49+DgSrKez0DAeKovh9vR3SVK3OH5e+l6ehj4boX1
	NJiLyiCjHAhsavZxb05qEReuAYouODRUuM/LQhrqPBlcso/sXYa7pcuifX6+i1M5YbpeRG
	SF3PM/syzS7H9DQSQKg1MQJlWOcGqvo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-05arSmaoNTeGyLO6vxzCTQ-1; Mon, 27 Apr 2026 15:57:12 -0400
X-MC-Unique: 05arSmaoNTeGyLO6vxzCTQ-1
X-Mimecast-MFC-AGG-ID: 05arSmaoNTeGyLO6vxzCTQ_1777319831
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794d80fea59so205662117b3.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777319831; x=1777924631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ICw+B9EQ3je422zYrSrt2k64CSETxiqpDeaciqWbX6s=;
        b=Z+8aEpcDodHl8QdJwCjcW6WpP51VaT4YstUgKyAqHUQJTFWm3/Tt3gcSBj9K5QURAz
         jLQS4YEfKz+cJ1TU/pHV/gVvQvziKs+X0Cb9Qh18hH0rm/FlovBImAVPLsZL4PIp9gzs
         PM5uZq1w5BZp9OqqLaK9Jpcj7sH3TjHnmn6Qh56qmLMm/xcnXqW9SGhs/YQKC3LX42Vr
         x2UvdcfeLUGjq25d4R5qMp9Zq9yqtdaySzvEalqK2j2aKL8itJpaGnKDXnbSq/1qn5GY
         zjtkZTy3Z7s6LYWpelGnTHbMJbTrzLWEJ37HNYXMrmetS19K2bRXOxUvRRC6QTpeEQQO
         +o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777319831; x=1777924631;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICw+B9EQ3je422zYrSrt2k64CSETxiqpDeaciqWbX6s=;
        b=dImSej8CB65i8XyOL14HaPG/ZS1j1dl9q/Sj2oI1gqw+yc1SFA1kwBl+tRx7/bQ3SB
         cy8PryepbB3S8DgSW1aOc6bRyRvfrxeerIs/GH5IiNFYE0oxCAlr0mTzsqsUoO71EgH2
         6mNWwIVQj29lGd/8drzoafBMqy7GAnTDXARDMAnlWnQCFVHlDmfZKe+Pbtkr3e/63DjB
         3Uq85HbUruGZm8CYn7K3DZ0E5hTI4Irc/cmIvVD9qWsCTBsxIHeIkBD4su3jv6wTUt0P
         ZBweXl1tmPF9vhhYodNwOI16MciIawQPtsSOI2nrfEDITC2BOriEtVpMLLd/dW5qUJMG
         QQaQ==
X-Gm-Message-State: AOJu0YxR0OxGck+aL70wjFnNvuqjmHuGdAdjYcyP2eO3ZlckOI/YTyxJ
	PMBKrs0TgVON1hPaUdPEq5EjHQVR6mCC1BRZK3mQhstQv9I5GDJK16bMx1SJCjkd0kOtpuR1i90
	tOWq9oHq1FXj5itJv3l7IXHgq+uA5RqL3sNyr/RZg7T87auY1gjs+3xGT05TRBdI=
X-Gm-Gg: AeBDieuEm04/td/7gAS8KWbZwzRY65HTvKsKOxLjbHaZVGbM18ZpXr8bBCB8n9bxFLy
	BSlmePwL8pqXP/H9uiZoRxOuarGUHziM4N8rjvUPCdYd2uoUKpXTBYbpDYWrsyLNUGYLtPkffok
	PVL2BL8eYjIKJ3T+v4vYemAN1bLs6BoUY9NMrekL+pTF9ysgMEqI6KasSu4sWoX0CxFiQ4VPb97
	BErKKSN8oL1mtN5nNrW/EJX5iHsQlVS3OIdmSzdp6vby68PG9n4wSVJ9FeV9R90OCoP+6g8irSx
	iIHiprsSAnjEwyIde7KTjhB9L9YX1fD+p99Moqyy2gcdsvptFJyKjSsDp56zI6MX93glKWXdz+e
	2DO2/0dp36bo4TA0GF+hnkrMZVzvD5BxpQcUhIe/Pg5YCSX0YJ8rkg5dCn0wYNU8=
X-Received: by 2002:a05:690c:9a8a:b0:7bb:712:a768 with SMTP id 00721157ae682-7bced8c499emr8488187b3.7.1777319831266;
        Mon, 27 Apr 2026 12:57:11 -0700 (PDT)
X-Received: by 2002:a05:690c:9a8a:b0:7bb:712:a768 with SMTP id 00721157ae682-7bced8c499emr8487877b3.7.1777319830658;
        Mon, 27 Apr 2026 12:57:10 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf04c18e5sm1620477b3.10.2026.04.27.12.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:57:10 -0700 (PDT)
Message-ID: <8ac6712e0584e51acbbeb025dea4c6c3fa7c9769.camel@redhat.com>
Subject: Re: [PATCH] Revert "ceph: when filling trace, call ceph_get_inode
 outside of mutexes"
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Li Lei <lilei24@kuaishou.com>, slava@dubeyko.com, idryomov@gmail.com, 
	amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	noctis.akm@gmail.com, Zhao Sun <sunzhao03@kuaishou.com>
Date: Mon, 27 Apr 2026 12:57:09 -0700
In-Reply-To: <20260418041241.17892-1-lilei24@kuaishou.com>
References: <20260418041241.17892-1-lilei24@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-18 at 12:12 +0800, Li Lei wrote:
> This reverts commit bca9fc14c70fcbbebc84954cc39994e463fb9468.
>=20
> Deadlock detected between mdsc->snap_rwsem and the I_NEW bit in
> handle_reply().
>=20
> - kworker/u113:1 (stat inode)
>   1) Hold a inode with I_NEW set
>   2) Request for mdsc->snap_rwsem
> - kworker/u113:2 (readdir)
>   1) Hold mdsc->snap_rwsem
>   2) Wait for inode I_NEW flag to be cleared
>=20
> task:kworker/u113:1  state:D stack:    0 pid:34454 ppid:     2
> flags:0x00004000
> Workqueue: ceph-msgr ceph_con_workfn [libceph]
> Call Trace:
> __schedule+0x3a9/0x8d0
> schedule+0x49/0xb0
> rwsem_down_write_slowpath+0x30a/0x5e0
> handle_reply+0x4d7/0x7f0 [ceph]
> ? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
> mds_dispatch+0x10a/0x690 [ceph]
> ? calc_signature+0xdf/0x110 [libceph]
> ? ceph_x_check_message_signature+0x58/0xc0 [libceph]
> ceph_con_process_message+0x73/0x140 [libceph]
> ceph_con_v1_try_read+0x2f2/0x860 [libceph]
> ceph_con_workfn+0x31e/0x660 [libceph]
> process_one_work+0x1cb/0x370
> worker_thread+0x30/0x390
> ? process_one_work+0x370/0x370
> kthread+0x13e/0x160
> ? set_kthread_struct+0x50/0x50
> ret_from_fork+0x1f/0x30
>=20
> task:kworker/u113:2  state:D stack:    0 pid:54267 ppid:     2
> flags:0x00004000
> Workqueue: ceph-msgr ceph_con_workfn [libceph]
> Call Trace:
> __schedule+0x3a9/0x8d0
> ? bit_wait_io+0x60/0x60
> ? bit_wait_io+0x60/0x60
> schedule+0x49/0xb0
> bit_wait+0xd/0x60
> __wait_on_bit+0x2a/0x90
> ? ceph_force_reconnect+0x90/0x90 [ceph]
> out_of_line_wait_on_bit+0x91/0xb0
> ? bitmap_empty+0x20/0x20
> ilookup5.part.29+0x69/0x90
> ? ceph_force_reconnect+0x90/0x90 [ceph]
> ? ceph_ino_compare+0x30/0x30 [ceph]
> iget5_locked+0x26/0x90
> ceph_get_inode+0x45/0x130 [ceph]
> ceph_readdir_prepopulate+0x59f/0xca0 [ceph]
> handle_reply+0x78d/0x7f0 [ceph]
> ? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
> mds_dispatch+0x10a/0x690 [ceph]
> ? calc_signature+0xdf/0x110 [libceph]
> ? ceph_x_check_message_signature+0x58/0xc0 [libceph]
> ceph_con_process_message+0x73/0x140 [libceph]
> ceph_con_v1_try_read+0x2f2/0x860 [libceph]
> ceph_con_workfn+0x31e/0x660 [libceph]
> process_one_work+0x1cb/0x370
> worker_thread+0x30/0x390
> ? process_one_work+0x370/0x370
> kthread+0x13e/0x160
> ? set_kthread_struct+0x50/0x50
> ret_from_fork+0x1f/0x30
>=20
> It's rather rear to be caught, but here's Fast Reproduce Steps
> (multiple mds is needed):
> 1. Try to find 2 different directories (DIR_a DIR_b) in a cephfs cluster
>     and make sure they have different auth mds nodes. In this way, a clie=
nt
>     may have chances to run handle_reply on different CPU for our test
>     (see step 5 and step 6).
> 2. In DIR_b, create a hard link of DIR_a/FILE_a, namely FILE_b.
>     DIR_a/FILE_a and DIR_b/FILE_b have the same ino (123456 e.g)
> 3. Save ino in code below, make it sleep for stat command.
>     ```
>     static void handle_reply(struct ceph_mds_session
>     *session, struct ceph_msg *msg)
> 			   goto out_err;
> 		   }
> 		   req->r_target_inode =3D in;
>     +               if (in->i_ino =3D=3D 123456) {
>     +                       pr_err("inode %lu found, ready to wait 10 sec=
onds.\n",
>     +				in->i_ino);
>     +                       msleep(10000);
>     +               }
>     ```
> 4. Execute echo 3 > /proc/sys/vm/drop_caches
> 5. In a shell, do `cd DIR_a;stat DIR_a/FILE_a`, we suppose to be stuck on=
 this shell
>     because of msleep() in handle_reply().
> 6. In the other shell, do `cd DIR_b;ls DIR_b/` to trigger ceph_readdir_pr=
epopulate()
>=20
> Repeat step 4-6, less than 10 times is enough to see the problem.
>=20
> It turns out that commit bca9fc14c70f ("ceph: when filling trace, call ce=
ph_get_inode outside of mutexes")
> moved ceph_inode_get outside snap_rmsem and made a chance for the deadloc=
k of ceph_inode_get()
> and snap_rwsem.
>=20
> After the following commit, original commit(bca9fc14c70f) can be reverted=
 safely.
> commit 6a92b08fdad2 ("ceph: don't take s_mutex or snap_rwsem in ceph_chec=
k_caps")
>=20
> Signed-off-by: Zhao Sun <sunzhao03@kuaishou.com>
> Signed-off-by: Li Lei <lilei24@kuaishou.com>
> ---
>  fs/ceph/inode.c      | 26 ++++++++++++++++++++++----
>  fs/ceph/mds_client.c | 29 -----------------------------
>  2 files changed, 22 insertions(+), 33 deletions(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index d99e12d..0c241a4 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1667,10 +1667,28 @@ int ceph_fill_trace(struct super_block *sb, struc=
t ceph_mds_request *req)
>  	}
> =20
>  	if (rinfo->head->is_target) {
> -		/* Should be filled in by handle_reply */
> -		BUG_ON(!req->r_target_inode);
> +		in =3D xchg(&req->r_new_inode, NULL);
> +		tvino.ino  =3D le64_to_cpu(rinfo->targeti.in->ino);
> +		tvino.snap =3D le64_to_cpu(rinfo->targeti.in->snapid);
> +
> +		/*
> +		 * If we ended up opening an existing inode, discard
> +		 * r_new_inode
> +		 */
> +		if (req->r_op =3D=3D CEPH_MDS_OP_CREATE &&
> +			!req->r_reply_info.has_create_ino) {
> +			/* This should never happen on an async create */
> +			WARN_ON_ONCE(req->r_deleg_ino);
> +			iput(in);
> +			in =3D NULL;
> +		}
> +
> +		in =3D ceph_get_inode(fsc->sb, tvino, in);
> +		if (IS_ERR(in)) {
> +			err =3D PTR_ERR(in);
> +			goto done;
> +		}
> =20
> -		in =3D req->r_target_inode;
>  		err =3D ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
>  				NULL, session,
>  				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
> @@ -1680,13 +1698,13 @@ int ceph_fill_trace(struct super_block *sb, struc=
t ceph_mds_request *req)
>  		if (err < 0) {
>  			pr_err_client(cl, "badness %p %llx.%llx\n", in,
>  				      ceph_vinop(in));
> -			req->r_target_inode =3D NULL;
>  			if (inode_state_read_once(in) & I_NEW)
>  				discard_new_inode(in);
>  			else
>  				iput(in);
>  			goto done;
>  		}
> +		req->r_target_inode =3D in;
>  		if (inode_state_read_once(in) & I_NEW)
>  			unlock_new_inode(in);
>  	}
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b174627..8a27775 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3941,36 +3941,7 @@ static void handle_reply(struct ceph_mds_session *=
session, struct ceph_msg *msg)
>  				       session->s_con.peer_features);
>  	mutex_unlock(&mdsc->mutex);
> =20
> -	/* Must find target inode outside of mutexes to avoid deadlocks */
>  	rinfo =3D &req->r_reply_info;
> -	if ((err >=3D 0) && rinfo->head->is_target) {
> -		struct inode *in =3D xchg(&req->r_new_inode, NULL);
> -		struct ceph_vino tvino =3D {
> -			.ino  =3D le64_to_cpu(rinfo->targeti.in->ino),
> -			.snap =3D le64_to_cpu(rinfo->targeti.in->snapid)
> -		};
> -
> -		/*
> -		 * If we ended up opening an existing inode, discard
> -		 * r_new_inode
> -		 */
> -		if (req->r_op =3D=3D CEPH_MDS_OP_CREATE &&
> -		    !req->r_reply_info.has_create_ino) {
> -			/* This should never happen on an async create */
> -			WARN_ON_ONCE(req->r_deleg_ino);
> -			iput(in);
> -			in =3D NULL;
> -		}
> -
> -		in =3D ceph_get_inode(mdsc->fsc->sb, tvino, in);
> -		if (IS_ERR(in)) {
> -			err =3D PTR_ERR(in);
> -			mutex_lock(&session->s_mutex);
> -			goto out_err;
> -		}
> -		req->r_target_inode =3D in;
> -	}
> -
>  	mutex_lock(&session->s_mutex);
>  	if (err < 0) {
>  		pr_err_client(cl, "got corrupt reply mds%d(tid:%lld)\n",

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


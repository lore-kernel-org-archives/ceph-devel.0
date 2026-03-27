Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074237FF42
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639919; cv=none; b=DUdsZOmSurgkeP/z3/i/2EH5JWEE1BSWbGXxF3Lx7c3QUh8rpNVoF2owpz6ShktHcQ0hrdYUX6nijqTdggqwH9hvQQyHrb7GyaFuBhtWZQmfukOPod7xlKaqJ2ht9qPP9Ox34FmMiKTABp1GYEpoN6BLdnq/TNkY2ODuXtAs/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639919; c=relaxed/simple;
	bh=x4+BqjXP11AfUUwh3LWO+/WyCVx0H7CmB4sF6qI9dko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oME20pXC+yQ8VwovGKUwxg2Ciq96m1Wt2vKwoh387hzYRBC2mcvhlJw+ODvFRGpiPXqcpdXS7sYW8iH3NIch9NXh8++DvsbJSuK01jQwaSfosIxSY8mPlH/BecTcA1DFo6ECd5ECTP2f6Mu3XpCWE8rw2DxptNqvWA2gouZclfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpmd4vq7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyqsXAEs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpmd4vq7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyqsXAEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774639913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmebsfF1GIj0IbrIcp0Kqgqyk2tYg+hHzhcW6Lvc0bI=;
	b=Jpmd4vq7bMIk4D4cH3a/BGk93lMsBRYqUA3Mhj7Q3sOj7IqWsFc6r0ouDAGKj1zkWuUEKf
	vUbDxQoRwFdr2GbLH15UHAkOCFrbzHYzFS2d23fEykWMbTeAMNZ3EGhiBt9xKWWuSOSR/J
	YVL0/wMl1gWN23sjHOkl0xYjTmmGHvg=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-_g2pGoKoNDmYYGzCfQZm5A-1; Fri, 27 Mar 2026 15:31:49 -0400
X-MC-Unique: _g2pGoKoNDmYYGzCfQZm5A-1
X-Mimecast-MFC-AGG-ID: _g2pGoKoNDmYYGzCfQZm5A_1774639909
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64ef16112f4so5846054d50.2
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774639909; x=1775244709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmebsfF1GIj0IbrIcp0Kqgqyk2tYg+hHzhcW6Lvc0bI=;
        b=RyqsXAEszlU6xR2A+M0Y9A+M1lEvjkbS4LrP9/6C50VrCsWIdlIIA6ibv6dxqCeTqg
         7Bbik+Jn5udpku1GZIo42hB8HhChURfY7qpxgPflOFSLvX4py8WVgEEWtDMfo7F+Mv01
         bu/CcJrJOoWRiFNmU5CTEBzAxxVdaGsfpPI42cZ1inAry4ReuXWYsuF5zF/5s0uS7QRu
         IbNoO8Fx1o3lfme1bHekMqgyYtQg6geGaak4Cj4CA6cJYon07uhh5y5DZnArXYC0J9Ag
         wZPNTmvzrDt1AjNSJyNNKIky1gR5qFQYz2LKOugVn3B7UNGutyAovIWQ3x47KENGYoJm
         8d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639909; x=1775244709;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmebsfF1GIj0IbrIcp0Kqgqyk2tYg+hHzhcW6Lvc0bI=;
        b=SQWAzprZ4gilPM/iPpFEHpV4TSP7/Y2G0P4AAPsOqVxFPPJyLt7WFYnsO+Hr1o0a3s
         jWLde9vooTa0Rq1IWiMWNR6Bq3YWnXXrEx/UKVoiFVmgrstqme+OKDW/lGJ9x6zSgQww
         B8b4pBIPBZ7p5X1sc1NU0pWJsaX47ceVZuMVQVUKTt7n+F88qb9xw5Q3s/ohrfsWHbT3
         FJlkZb2FAFGUj80egqHrfc2989JDNa8xWD6O65eD5tUAbd/RXHll1cvANyNWRbAxzMKh
         SWdgYU5XR3JV+cj7SfgFrfibj91yNoWd0yq/W/cBglUthno2862NseheC2QcOgEwx1Nf
         e9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXwQw0Lduo0YWIuANWsELFEBXqJTYnafGnxRRaJnAwHC2diS5LGP6cSXUpB01Ubxoo3F+aVgKuV4Dk9@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt7UyK8AUsBALG63bF1Pi52MJm9wcy+KwZHWJu1VfNzpRqAYW
	obz3QOE8+yuHO0/sygmhSPecJKxa2pS9cJEEoTrvGPA5d4kG6HFyl+68A+i9g/+knvcU9taENqD
	UpC2ew55WbxnyxKV5i9UjwUUK70Xmfdl17BqxA+QDwN8RNey3aomvc6gTeEYoYpM=
X-Gm-Gg: ATEYQzyd9YcVITuvXnnIikE1l8F+xXuaEkBkon8lLI+/zMS8DGKMYO2vMzobZ702Mc2
	VlWAmVyUoJgm73RGNekcPdFwiTg12JDlArupIZD2hKwg90RJ+mkZJlz7GiClBAX7rXYb9O3cSV/
	z7UcfJePTTWvBTywCMnOzb/VGtrRpB+367AycQODLSYJQOG37ontgEzRm/NJIs0nuOLyLmBkPXi
	hWRgTV39kw+nMu+xg8irYR1MVdJ1vlYKV1N+o7Ujz5K7wocQpmgV1uQ8QRQfr+slUXPcjgfpBgf
	EIRYd0p2X/uVKE0Io52SeD3IFPg0th9H1y0i9uhVZ0nJyJm7oZRca7VnlOQCt9ZlWSWJ8S5Bm4C
	S+4LYbCb8gjhEEfJ3x1IOmmE4qsANvEXj69xMVdbfLLyMGeoCyDgB
X-Received: by 2002:a53:ef05:0:b0:64e:b33b:c6bb with SMTP id 956f58d0204a3-64ff71c1d26mr3111558d50.5.1774639909191;
        Fri, 27 Mar 2026 12:31:49 -0700 (PDT)
X-Received: by 2002:a53:ef05:0:b0:64e:b33b:c6bb with SMTP id 956f58d0204a3-64ff71c1d26mr3111513d50.5.1774639908556;
        Fri, 27 Mar 2026 12:31:48 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ef58b8707sm3254860d50.4.2026.03.27.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:31:48 -0700 (PDT)
Message-ID: <110e26d0e6d0f594fc294a9ffda2b17e143b3566.camel@redhat.com>
Subject: Re: [PATCH 01/10] ceph: convert inode flags to named bit positions
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Fri, 27 Mar 2026 12:31:46 -0700
In-Reply-To: <20260327143045.1393612-2-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
	 <20260327143045.1393612-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> Define all CEPH_I_* flags as named bit positions with derived bitmask
> values so the Ceph client can use test_bit(), set_bit(), and clear_bit()
> consistently on inode error and state flags. This prepares the later
> reset path to use atomic bit operations on the file-lock error state.
>=20
> Co-authored-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/file.c       |  2 +-
>  fs/ceph/locks.c      |  8 +++----
>  fs/ceph/mds_client.c |  3 ++-
>  fs/ceph/mds_client.h |  2 +-
>  fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
>  5 files changed, 40 insertions(+), 29 deletions(-)
>=20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 66bbf6d517a9..aa9ee283dfda 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -579,7 +579,7 @@ static void wake_async_create_waiters(struct inode *i=
node,
> =20
>  	spin_lock(&ci->i_ceph_lock);
>  	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> -		clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
> +		clear_and_wake_up_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
> =20
>  		if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
>  			ci->i_ceph_flags &=3D ~CEPH_I_ASYNC_CHECK_CAPS;
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index dd764f9c64b9..2f21574dfb99 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
>  	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
>  		/* clear error when all locks are released */
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags &=3D ~CEPH_I_ERROR_FILELOCK;
> +		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  	fl->fl_u.ceph.inode =3D NULL;
> @@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct file=
_lock *fl)
>  		wait =3D 1;
> =20
>  	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> +	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
>  		err =3D -EIO;
> -	}
>  	spin_unlock(&ci->i_ceph_lock);
>  	if (err < 0) {
>  		if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
> @@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct fil=
e_lock *fl)
>  	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
> =20
>  	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> +	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))

There are several other places of using CEPH_I_ERROR_FILELOCK. I believe we=
 need
to convert that cases too:

[1] https://elixir.bootlin.com/linux/v7.0-rc5/source/fs/ceph/caps.c#L2832
[2] https://elixir.bootlin.com/linux/v7.0-rc5/source/fs/ceph/caps.c#L5083
[3] https://elixir.bootlin.com/linux/v7.0-rc5/source/fs/ceph/mds_client.c#L=
4696

>  		err =3D -EIO;
> -	}
>  	spin_unlock(&ci->i_ceph_lock);
>  	if (err < 0) {
>  		if (lock_is_unlock(fl))
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 23b6d00643c9..12f1b57d4b1c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *md=
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
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 29a980e22dc2..272c287836c1 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struct =
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

Somehow, we skip the bit 1. I assume we need to have some comment here why =
it
was skipped.

As far as I can see, bit 1 was CEPH_I_NODELAY, which was removed by commit:

a0d93e327fc4 ("ceph: remove delay check logic from ceph_check_caps()")

  -#define CEPH_I_NODELAY  (1 << 1)  /* do not delay cap release */        =
   =20
                                                                           =
                                                   =20
  The layout just before removal was:                                      =
   =20
  #define CEPH_I_DIR_ORDERED  (1 << 0)
  #define CEPH_I_NODELAY      (1 << 1)  /* removed */                      =
   =20
  #define CEPH_I_FLUSH        (1 << 2)                                     =
   =20
  #define CEPH_I_POOL_PERM    (1 << 3)
  ...

When CEPH_I_NODELAY was deleted, the remaining flags were not renumbered,
leaving bit 1 permanently vacant.

So, what could we do here? Simply add comment?

Thanks,
Slava.

> +#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata *=
/
> +#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
> +#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
> +#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
> +#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
> +#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
> +#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snapss */
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
> +#define CEPH_I_ERROR_WRITE		(1 << CEPH_I_ERROR_WRITE_BIT)
> +#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
> +#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
> +#define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
> +#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
> +#define CEPH_I_ASYNC_CHECK_CAPS		(1 << CEPH_I_ASYNC_CHECK_CAPS_BIT)
> =20
>  /*
>   * Masks of ceph inode work.
> @@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
>   */
>  static inline void ceph_set_error_write(struct ceph_inode_info *ci)
>  {
> -	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
> +	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags |=3D CEPH_I_ERROR_WRITE;
> +		set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  }
> =20
>  static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
>  {
> -	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
> +	if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags &=3D ~CEPH_I_ERROR_WRITE;
> +		clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  }


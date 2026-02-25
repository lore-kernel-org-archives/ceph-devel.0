Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FA26C3BE
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053002; cv=none; b=ZPeaV1ysiTFWan9dLB2Os3lhT0bEkQwC/drN1q4O6EUI+3kIUiMXQql6BuBkLtw/ZR5vKmKrqvh3yP9GnsE4bU7U/JorqgPTVcrOnaFAgaViDB38nFdQmcdeguEHTMPtGvAOPrvzbHdAd3xcGYArQo0BAxFLTHzlwJjMDNmmof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053002; c=relaxed/simple;
	bh=rhCq4+9Wz3PUOBm64nh1Ke6+bQXt5cAvl09cJd4qqw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBnLstwKTBLlMAk8V3f8wcE1sw+CNn2DFlDA0P85IoJzSS1o/7FLwQFOd/kmSL1/djcgkxRCrPqpQNvHPr4egJrL7AQRzR4xNUEy5NzU/ikbqjUGKDkz5gnsvQrc+LxHKIbmrRU8GgX7JvQtGFBXy1CHmfQRrVJpfAV9fhtXZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSDOWlEW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMUkClaw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSDOWlEW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMUkClaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772053000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2YEZi7KcbD8SQA6LwyRyL7mxfRFNp+QIg8lXjiTFBU=;
	b=NSDOWlEWyYwv24N/jW9J1KMSIBTP93g/ozAkUbPsUg9JUwNgpUa6amtjRRS32C2UGVlCR5
	OHBlOu/fg2/gTsdUGMUR2sLGhb/jJ9wjcuqdjPLVhBnx70CalisKueJCXMlyPnMfvMmhGE
	7FKBA6y35Qk5ZM5OXBpWe0WLiQHnq0w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-rhSgEk-JMD2mwNfYNaZ-Lg-1; Wed, 25 Feb 2026 15:56:36 -0500
X-MC-Unique: rhSgEk-JMD2mwNfYNaZ-Lg-1
X-Mimecast-MFC-AGG-ID: rhSgEk-JMD2mwNfYNaZ-Lg_1772052996
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-46393ffb94eso2237030b6e.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772052995; x=1772657795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m2YEZi7KcbD8SQA6LwyRyL7mxfRFNp+QIg8lXjiTFBU=;
        b=ZMUkClawT7WZnZ9iFOV8bAaEeIDnHiI1Yd+vD3j1V/elOLbZ6Uq+9c13NHSEyc5ZXB
         g3eTSxiThp7q4O+Z3g8LUXEWnpyd7iisUyb1c/dSpaTuF3vXWcMK6TzeNSuTFUDti9IQ
         8avqMvQ0Dv3QtY+KP/E0lL9be7xm/UjcTY2dnOMzJfphV5FbwYSY9p5+h+cDZbbf+itO
         qqIUSMwGbeE9uuvX/bR4IMGfWSSfT3T6bhsDuC9QJkO0eZxQPK+BiWp61iDWO+rqJIkK
         RDIsC3LCAC+BJpVjNgkqig2dvbFXaoPUgm+rQdiXD1NVYsYmxWcdYefqNGlPQzG8KzoF
         ZEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052995; x=1772657795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2YEZi7KcbD8SQA6LwyRyL7mxfRFNp+QIg8lXjiTFBU=;
        b=N9xJE3eeqiuz68KFbgZrHBKRHKO3yOShvoO2NM4rvK961wPNctW/WfLMYPKtwvFtg6
         5PdqwIrCK1tLI43xKytVHwweNljf4vyyF0f4SDhPtlqVDYjNLrcbu4dVOb+rM6kwG1Wx
         NX40pedUOERPgNhrUzeBmhs86nmacUG19iyFGsErMn4qS68Q+0ojadwSWqhBINKyd800
         BeQXh273wow5O2BfkI/s/9i2G63z4HqDVv4uh3euTzORSMRl35c1OisEE84wq504Awbs
         OzhT0CcNNI6Zsehv8SVq2BDhzd5PkVY3+/zzGLI50XYzzqRvWS1H6hdbpo/LKKoZah4+
         c4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyijUVG2aFzsvyQV3KEE4Prd6o20aoM3XDCC7cNRl/j3NdtiIQiq/zGQUPFFZ54nk4TjwdNmp2lR/s@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2LRbp51wJlLw5sz8/mr7Fq7WdtbkDcifAKGm2+ePYzNJwj2a
	ty+cggarhMor+mgU9yelxHqZwe9Vn3RpeSwSJQcyMVJr1709TWAd7pPloDZmAsfG/pPGQtNZc85
	D4P+5cr0WDRQlDV72hqbJr1t+jmD34vHXqT4Ck4n3eJVS283Fyk5xfEVic1bEkmaEikcjnyI=
X-Gm-Gg: ATEYQzxLcjIgCClcnDKp98VBbBNn7k9rRcgNiw7jdUjZB3FHzBCi7+5gZWWFvuAVZYX
	lB1tWpoRGkWb9N6HEPFgTRkPg+OkE95tqXtbfpCmv+C+oFkFXkG7XF+y5osFKdH+JF1kI1G83AZ
	NX8JO0+mdnRURKP3afLS8VFAUDYVncODfgn92ZBPOWQCMUO3UoxclNydAfaJ24EeRRZJE6GbEB6
	YxZJHuibkVJmnmULfI8PNeWoaTa5y5DYVgvrsINp4db7IQk31PlTlSpe2HrE+/XnE22oa639NO9
	rafijhW3isDxW50sMwmLndDTQWzemEbnQk443NiFM7kSJ/rwBPkKqNyHz0E6e6qJ7HNk7znEllZ
	Qug+9e0tJdyv7AJeneTQ5TMzQyBfkMyEuNsjkFBtjBexY1hHAAJ4L
X-Received: by 2002:a05:6808:14c8:b0:441:c8a2:ba26 with SMTP id 5614622812f47-464a5d9a776mr262122b6e.7.1772052995509;
        Wed, 25 Feb 2026 12:56:35 -0800 (PST)
X-Received: by 2002:a05:6808:14c8:b0:441:c8a2:ba26 with SMTP id 5614622812f47-464a5d9a776mr262114b6e.7.1772052995116;
        Wed, 25 Feb 2026 12:56:35 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46449fd7a0asm9721165b6e.1.2026.02.25.12.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:56:34 -0800 (PST)
Message-ID: <9687495100c02050c09c503fad1b840ddbfa313c.camel@redhat.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 1/4] ceph: convert inode flags to
 named bit positions
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Wed, 25 Feb 2026 12:56:33 -0800
In-Reply-To: <20260225125907.53851-2-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
	 <20260225125907.53851-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-25 at 12:59 +0000, Alex Markuze wrote:
> Define all CEPH_I_* flags as named bit positions with derived
> bitmask values, making them usable with test_bit/set_bit/clear_bit.
> Previously only CEPH_I_ODIRECT_BIT and CEPH_ASYNC_CREATE_BIT had
> named bit positions; the rest were bare bitmask constants.
>=20

As I remember, I've reworked all constants for having name for every bit.
Probably, this patch has ignored and it has never been sent to upstream. An=
d I
converted pretty everything for using test_bit/set_bit/clear_bit. :) You di=
d
this work again. :)

Thanks,
Slava.

> Convert CEPH_I_ERROR_WRITE and CEPH_I_ERROR_FILELOCK usage sites
> to use atomic bit operations (test_bit, set_bit, clear_bit) via
> the new _BIT constants.
>=20
> This is preparation for the client reset feature which needs
> test_bit() on CEPH_I_ERROR_FILELOCK_BIT in reconnect paths.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/locks.c      |  8 +++----
>  fs/ceph/mds_client.c |  3 ++-
>  fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
>  3 files changed, 38 insertions(+), 27 deletions(-)
>=20
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
>  		err =3D -EIO;
> -	}
>  	spin_unlock(&ci->i_ceph_lock);
>  	if (err < 0) {
>  		if (lock_is_unlock(fl))
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 23b6d00643c9..28bb27b09b40 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *md=
sc,
> =20
>  		spin_lock(&ci->i_ceph_lock);
>  		cap =3D ci->i_auth_cap;
> -		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds !=3D cap->mds) {
> +		if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
> +		    mds !=3D cap->mds) {
>  			doutc(cl, "session changed for auth cap %d -> %d\n",
>  			      cap->session->s_mds, session->s_mds);
> =20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 29a980e22dc2..69a71848240f 100644
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
> +#define CEPH_ASYNC_CREATE_BIT		(12) /* async create in flight for this *=
/
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
> +#define CEPH_I_ASYNC_CREATE		(1 << CEPH_ASYNC_CREATE_BIT)
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


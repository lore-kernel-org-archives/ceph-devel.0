Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8D1991CB
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883218; cv=none; b=WubIMOvPTlZS4VszlRzIwavrPsxAgWeAeO0wGqTMA6aRDlF3eZ1cor5UDcxZd8UVfwpGkiYgDJhcA8e0May9dCEq8P9X6wFMzUDP8nag4GGHNUpJzQSUn4ORX1ELOyeWTq203A14AQBBm2wmtLjYk/sHLBcgC13kWqApPT8natc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883218; c=relaxed/simple;
	bh=uh5Z6xxP2ViIZSZAYz1zobcE0sSpa6X6JN88q87OluI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUwe3MHlF1jHXBbKTYlDiEB7v9Rh2zk2yHnRXYtb6cFNoj0X++u2mRX5Zq7HdbfzFzGyZYLh4JfCAfS61bWleyZ/mv3SScODJWWGGkMWzBI9CBvGMNoSkiL9sUgmRhEg4suaW3YTQ3f7rPw+B3L8a/vHlk0lDQOkLlgEPF92GZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO/G0JaY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO/G0JaY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso6855633f8f.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779883214; x=1780488014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI1XrbB08fJnj/+Jt7BQ2bALSl2qU1edDmRWW1UIbPs=;
        b=EO/G0JaYwu9bfZlEqyqQ7HHQBkb/UsVtIUKbJYaQ2I1HtKJdv7X2Z2lXgePJLo19fo
         aJ7u54kZnZgAIk08a8XdZwd92j9Rpm13tUYMABegx72D9cJhNJJKIpTwQBHtlmyaTEQO
         Ssixadq+VzR0eWK9Ff2DUn31i/MuUoQjyWRIgAwV+qJ81SOMk8PgM+p8hQUFaGlmv3q4
         JVdRJ502QZUmv8AFcX7eRUdlTXTqlitgy/Vy3Hf1c0smaZZopKksXQYNZ02+RYyIPR71
         410jvevdr1DCfctDu5QKzB7fmIxF0pQxiusdNF51m745vlsrcW5IVEH3rxipmQoEEomK
         0EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779883214; x=1780488014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CI1XrbB08fJnj/+Jt7BQ2bALSl2qU1edDmRWW1UIbPs=;
        b=ZfFTLrxVgIQsBY3jl4fY567iH8dX8J/I2yDGz77cUMq3CF1/xzA3AxunzGaelUpMtA
         w6gckZyxl2HO1Yym8o7NhXQwCAvW/w109d6IhA32/UTaCufrDXhcS6cKcfI4zyglgZh5
         H/BTxSf250ICIG/Ct9SntybQtlEyCQdS/NsvNtYN0QJB4CYIeTj6PlXfYcACrVy5z2qI
         oUQOvjw0g0NQwU0bEzUm8TXUD+OblLotQ/x1ZOkOPgkFyGtQsbKmN27ZhJkNQ7ZiyHFU
         QjhQsDGzVHx92IaEhtKC2w/xE3BCeq2GB3KsEAMzs0uymCG64/37GtCQXyWPV4sEPGph
         /zGg==
X-Forwarded-Encrypted: i=1; AFNElJ8dbRm2T3kM/ghngL68DCIq2RrP5/fO7YzAUVFDXdC3raBmtiOUJCgN2Vcc1HqEDmZ51WFsXXOH3Mfn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QrtKkHKNlHIpw4+Ep0qHrVldGCIPkzWdRCZH9MCUEYk7m7sT
	TcUzL9db8S+ClTmDley1/6B/q216HZQJvzEOcC2xpdeRqKU8ckpo0Hws
X-Gm-Gg: Acq92OGgUNaxyld03omRGsPbWSP8Ws6jFQD5dfWclmZhNnB7mrnkP0t+8fOVf/SLICK
	wegNIfPRR4h0wD5XDAImmxN6JnPP3uFqhY88vQrhFbHZ1E5f/d/WQB4J/q2hLYeejM5zIIH3TsB
	R8J3QzlWs7djw28XEr1c3YmmgUrjlHSYerbeM22A4iJ16h0sfAECFJgZiQvDAaS6P42xOb/6dJI
	qRhyRInjviqt80MRrs/3XGKP4Q2V6W4U/QKUOPROCEIMIBcElbiwIYzYvt9nnKGLLjTawu7G+kx
	7Ouf61l7/wVeUUDlfHmTJvC84khtb+ce1MeyVtLDQP7Pm9/egSoGNyAA4qp6E9OWhPnziLLycXK
	B6KShErSJi9VPp2mg/pfbJEdqvwPWI6YrCr3auUHz92antaeT0UboQytVFjlBgP5+VmCz3sBQRo
	7qgOKJ64Xj3VK99T/jL+umfTO3QQ6cll3RGZwKOMkFI6zhRACtHaKA67kHXbAQpMes
X-Received: by 2002:a05:6000:430b:b0:45e:8526:7dd1 with SMTP id ffacd0b85a97d-45eb39e1f12mr36501519f8f.22.1779883212294;
        Wed, 27 May 2026 05:00:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549addsm5519489f8f.5.2026.05.27.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:00:11 -0700 (PDT)
Date: Wed, 27 May 2026 13:00:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Jeff Layton <jlayton@kernel.org>,
 Xiubo Li <xiubli@redhat.com>, Milind Changire <mchangir@redhat.com>,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ceph: pass fscrypt `tname` buffers directly
Message-ID: <20260527130008.0261fd62@pumpkin>
In-Reply-To: <20260527025828.5966-2-CFSworks@gmail.com>
References: <20260527025828.5966-1-CFSworks@gmail.com>
	<20260527025828.5966-2-CFSworks@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 19:58:27 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

> ceph_fname_to_usr() needs a temporary buffer for some operations
> (currently only base64-decoding ciphertext) and it is convenient to
> allow the caller to specify this buffer to avoid a heap allocation, so
> it has a (nullable) `tname` argument. Until now, this argument was a
> `struct fscrypt_str`; however, this is unnecessary for two reasons:
> 
> 1. `tname->len` isn't used anywhere: ceph_fname_to_usr() assumes a
>    buffer large enough to hold the ciphertext, and
>    parse_reply_info_readdir() -- the only caller to use tname -- doesn't
>    set it.
> 2. While the `tname` parameter is documented "may be NULL,"
>    parse_reply_info_readdir() always passes it but with `tname->name`
>    sometimes NULL in violation of the contract, indicating that the
>    unnecessary container creates actual confusion.
> 
> Therefore, change the type to `unsigned char *` and pass the buffer
> directly.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  fs/ceph/crypto.c     | 10 +++++-----
>  fs/ceph/crypto.h     |  4 ++--
>  fs/ceph/mds_client.c |  6 +++---
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 64d240759277..7515cb251226 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -300,7 +300,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
>   *
>   * Returns 0 on success or negative error code on error.
>   */
> -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,

I can't help feeling that the buffer length should also be passed.
Either explicitly or, if constant, implicitly by embedding the array
in a structure.

-- David


>  		      struct fscrypt_str *oname, bool *is_nokey)
>  {
>  	struct inode *dir = fname->dir;
> @@ -357,16 +357,16 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>  			if (ret)
>  				goto out_inode;
> -			tname = &_tname;
> +			tname = _tname.name;
>  		}
>  
> -		declen = base64_decode(name, name_len,
> -				       tname->name, false, BASE64_IMAP);
> +		declen = base64_decode(name, name_len, tname, false,
> +				       BASE64_IMAP);
>  		if (declen <= 0) {
>  			ret = -EIO;
>  			goto out;
>  		}
> -		iname.name = tname->name;
> +		iname.name = tname;
>  		iname.len = declen;
>  	} else {
>  		iname.name = fname->ctext;
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index b748e2060bc9..79cb563fd887 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -115,7 +115,7 @@ static inline void ceph_fname_free_buffer(struct inode *parent,
>  		fscrypt_fname_free_buffer(fname);
>  }
>  
> -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
>  		      struct fscrypt_str *oname, bool *is_nokey);
>  int ceph_fscrypt_prepare_readdir(struct inode *dir);
>  
> @@ -204,7 +204,7 @@ static inline void ceph_fname_free_buffer(struct inode *parent,
>  }
>  
>  static inline int ceph_fname_to_usr(const struct ceph_fname *fname,
> -				    struct fscrypt_str *tname,
> +				    unsigned char *tname,
>  				    struct fscrypt_str *oname, bool *is_nokey)
>  {
>  	oname->name = fname->name;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ed17e0023705..aa6730b48e97 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -488,11 +488,11 @@ static int parse_reply_info_readdir(void **p, void *end,
>  		struct inode *inode = d_inode(req->r_dentry);
>  		struct ceph_inode_info *ci = ceph_inode(inode);
>  		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
> -		struct fscrypt_str tname = FSTR_INIT(NULL, 0);
>  		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
>  		struct ceph_fname fname;
>  		u32 altname_len, _name_len;
>  		u8 *altname, *_name;
> +		u8 *tname = NULL;
>  
>  		/* dentry */
>  		ceph_decode_32_safe(p, end, _name_len, bad);
> @@ -540,7 +540,7 @@ static int parse_reply_info_readdir(void **p, void *end,
>  			 * always be shorter, which is 3/4 of origin
>  			 * string.
>  			 */
> -			tname.name = _name;
> +			tname = _name;
>  
>  			/*
>  			 * Set oname to _name too, and this will be
> @@ -557,7 +557,7 @@ static int parse_reply_info_readdir(void **p, void *end,
>  			oname.len = altname_len;
>  		}
>  		rde->is_nokey = false;
> -		err = ceph_fname_to_usr(&fname, &tname, &oname, &rde->is_nokey);
> +		err = ceph_fname_to_usr(&fname, tname, &oname, &rde->is_nokey);
>  		if (err) {
>  			pr_err_client(cl, "unable to decode %.*s, got %d\n",
>  				      _name_len, _name, err);


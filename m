Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776F3BCD01
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316923; cv=none; b=CjGZUaistVvbzF0aTziEYzkh09dcceByxe1QXbLe3juGS+vd/ue14OLfipZ9qxQ4/25Z68zsfea5Uhz/HYfBSQAvGh2q72KP1bTW4ipbtWekEepF5q0omHebfdCXV2DXFBQukOMSVdhLU0IslaeGZJObfkHhdxnPL+OXJ/cJVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316923; c=relaxed/simple;
	bh=Ib1G1HvJbNyRcWO81HjPhfTyiddnCm9YVoxujVd1HP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPIuQy4GExXJ/a1kPj0qe5EZ1bmmEqG2oLIRpV92Ks5TzGEILDO5XrVn4OgHT6x99eMehHx1+P79JIYlEb2AN4VH+KKJnEcLPxa+uf2rg+PP8zLXguM8uU+Wae1LfW/0w8C4rjm7uiApIcgNd35pzepZ6+k2942ObqhciHrkq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeDchu2p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeDchu2p"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7e23defbso3045434f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316915; x=1779921715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGD0/pwTecIM3ffPJGuJWN0Obb0PAJ/eWot9laPpF0c=;
        b=TeDchu2pzTkH6hWiKJKZQi6Iqxz+oD3Vx5Ay6LA7gBc9ybziLNGzVN5Gr/+depeJqQ
         GM9UcqoQoRhP+9IHuXkBNbwnryrjxJ1BmPlcN/PskN08BSfqIrRzvg9w6+b412CpOz0U
         IpBKKTvjnDc2HrK+ykUCuPlNJezOtUaZ/TNongBb+uvs1GtIBxuOrveo7+slyIH5JX0l
         42ACQqC1fEWFoNZyfWZwMv7uZrZ78kKYGHXOe3LVEDwBf6/JfTvelTvRnqTAxCavmJvl
         41h7nEvDOAkgacwAwEW07GlqwA4x5f5b5sfezqq869n7IOs2DHfruehRMCudtXnH7dgB
         bhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316915; x=1779921715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGD0/pwTecIM3ffPJGuJWN0Obb0PAJ/eWot9laPpF0c=;
        b=Mm4fLf2cdll+Kw+2Wdt10rsQ8UkfY0a9K2xjbxuzlMYNKsPwnUYQCYzEtIdH5wFtRr
         jDvL2r1Jdl5LRCPIgGgSVwhsF+P7LbVW8cCNsFm2oBQ0AEZfPXyb8U1gdnOTpz6Rn7/m
         f9zrk0JiROA4e8CyboHOzYUNBi2QRIl5qa/mI7sej3+4nyBNNMduY2nA+cTzARcLaXNY
         4+kdymZLWjyATlKdBnkmLNY683zoQL2qoc4As8ZZdoxFJMnT9D5Fe5i513MUg5ixz8zE
         ckxE6ati19/+Y1isb4L36NgaNZAQZfZcZaJXsgczVUOYibQl33t3SBSIUW7ha/gHMpIB
         KmXA==
X-Forwarded-Encrypted: i=1; AFNElJ+/GxyHRGwDrtoeMUppiUzb9K6Eog3ZPXm0EloTnrrE7T24+rkiSZqCRnSRqYIPkH/bJWiWOTt6ypM+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GNEUiFEFtqH6oqfLS049WarTBfcqQTFQSJizeWjetMjuMDWg
	L4g2FzGyIh4CldaO1Re/7A/q3R/naVh08GX8CRB9LYJVp1FakGxpgkmi
X-Gm-Gg: Acq92OEKqXCQM07g7onjylo0+S/R29uEPLSlg91Qh9zDgULbN8agnXsexsiEq+3rs9E
	iX3XA3WeFqq1o9BnwuxyOmfPmhIIiQQiFgDpuRQ9rGqAntmOlNv0L3M4RmM8lEV+Cdoes6KvFq4
	5ofAgjjCkzVQyIUF0aNJbRonhazzbBuMk2rpMOOgDjec2cXavd/BUBjFfC72U1vUke3XI8JIKLR
	sP2bMX4zMQHHHfNJ6Lwgz6CVqfvd9Egd6fcCJJw+JwaaxTwV4Vob+iN8IwrRVbXh7jAZgCZoa8I
	jSvqQhmmA/TEUO2WonYM5tCq+d7IsSJsNxkTjd+/ZfGHYe4nm90SYeaHiWxJJ6rXlyX3iqfa4Zf
	3V1fL9YTDBfyf2Py4luGXy87NrN7GZtRfRisslnfjoI2O+CimkNPI/d1MfAHwQ29PxI14gxQ4w8
	xAHecp7KSPrS0tXONC7a0UBldPDlpLpvchYdYfWgdWQXTt4LCtr5CUKfO9f+3QG2dA
X-Received: by 2002:a05:6000:2481:b0:45e:73eb:1ff7 with SMTP id ffacd0b85a97d-45ea37b46b1mr404588f8f.3.1779316914988;
        Wed, 20 May 2026 15:41:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm53978549f8f.24.2026.05.20.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:41:54 -0700 (PDT)
Date: Wed, 20 May 2026 23:41:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org"
 <brauner@kernel.org>, "neil@brown.name" <neil@brown.name>,
 "slava@dubeyko.com" <slava@dubeyko.com>, Alex Markuze
 <amarkuze@redhat.com>, "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>,
 "idryomov@gmail.com" <idryomov@gmail.com>, "jlayton@kernel.org"
 <jlayton@kernel.org>, "ceph-devel@vger.kernel.org"
 <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "zhongling0719@126.com"
 <zhongling0719@126.com>
Subject: Re:  [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
Message-ID: <20260520234153.7a89f0b1@pumpkin>
In-Reply-To: <d2cd070ded01305414815248032bbfc331c392ee.camel@ibm.com>
References: <20260520095428.69422-1-zenghongling@kylinos.cn>
	<d2cd070ded01305414815248032bbfc331c392ee.camel@ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 18:49:18 +0000
Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> On Wed, 2026-05-20 at 17:54 +0800, Hongling Zeng wrote:
> > When mkdir succeeds, ceph_mkdir() sets ret to ERR_PTR(0) which is
> > incorrect. It should return NULL instead for success.
> > 
> > Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
> > Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> > ---
> >  fs/ceph/dir.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index bac9cfb6b982..ab7f7b7016c6 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1167,7 +1167,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >  	    !req->r_reply_info.head->is_target &&
> >  	    !req->r_reply_info.head->is_dentry)
> >  		err = ceph_handle_notrace_create(dir, dentry);
> > -	ret = ERR_PTR(err);
> > +	ret = err ? ERR_PTR(err) : NULL;
> >  out_req:
> >  	if (!IS_ERR(ret) && req->r_dentry != dentry)
> >  		/* Some other dentry was spliced in */  
> 
> I think that this modification doesn't make sense. The ERR_PTR(0) returns NULL,
> as far as I can understand.
> 
>   static inline void * __must_check ERR_PTR(long error)
>   {
>       return (void *) error;
>   }
> 
> ERR_PTR(0) evaluates to (void *)0, which is exactly NULL.

In practise yes, technically no.
NULL is an 'integer constant expression with value 0' cast to 'void *'.
ERR_PTR(0) will be the 'all zero' bit pattern, NULL is an implementation
defined bit pattern.
So '(void *)(1 - 1)' is NULL but '(void *)(x = 0)' isn't.

But I think sparse() is trying to stop you converting a NULL
pointer into 'success' when failure to 'allocate/find' something
would normally be an error.

-- David

> 
> Thanks,
> Slava.


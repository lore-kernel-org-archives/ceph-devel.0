Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A054779A8
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377705; cv=none; b=aBfk6FhXMZ//o0BNkoMxqnS6dSeRIeRbXZPKQEWpJBeZ2i25MuOqLICcBDBzDrj4VZuaZ/qY31bZHekPS2/eyNKbM8jAqykOyG/MMU/f9Yq3QhYSiEtn4+LdnV76w+GoMoLR7cOofGuBr/TAAXo0JyF3VoaAEjlWjN6NKSqMMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377705; c=relaxed/simple;
	bh=eh+it0zb54ufEP/JnblEMEpySL7Prj/F5s/H28111ro=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=msbtgX15kiHniCe3s7fLkxb+i8VyzWZJvNZjLaqxUg1n6zsSqMx0gtP9sbWNci6IgH0xHkyuvvnu9adpnLkXj/tGitVIENZJgCCWrIaWydA6YXlGALcES4cbi2S+qGqj7vdVU1dkZs4fs1U1IvjSTQBW7J8I+uLQG5yi9GIVOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BApmi94N; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BApmi94N"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90cd0e6fd80so14514156d6.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377687; x=1788982487; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=BApmi94N0haia63+fWtF0lO8gtf7CPbnhyiBUjO2IH+nYwAJb4uJXYRK7Cr6JJKpFk
         YxGptCgPyiA1YZmnPhS3FOGlqVAlbkwTb/eVF5NtLCuLuSICFUx37nq/Nns4yNA2zgH0
         CFYc13B4d2J1cC4nKVeZUp+yNmFJrn0DoYd6ScYOlVDpCIQWM8wV9IJ51HJQi6KW+GVF
         nI2FzCFnKFMfXHpWkki8P6hmZ4q8a2BhC/Xez0+PIPWLa+R4Uc0B91tXHiwfcP+6AsP1
         FRMH/M4HjtVOxsSROaRN5mJYZjmLY8FnTjlOzEo1VRpzChFgoAHEReRUhVrJL43U/Yma
         Kkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377687; x=1788982487;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=tZGKxinuWh4KCpJJXhXOkYu2rGjoHzvPmPCxAD+gWUwnstEA6vL7AdalW8+96rMbHA
         3XO5PVORNupYqpSuz132DA1eOkC/pMx2ff+ebuUq5cR/IY7qZ18ZGp2kJ24D2QkbUbf8
         von2hUPjyWgoX4qbuajD6d1zHB6iqgrMS/xG78fDZc06cTcXGRs1ZEaBVD5A/axbHJXR
         xNpJJRW3VqgPJ8SsT1DFh3Ckc097LJUuDJLUzt2P8urB8PiKS4B3+9PEcoxLUdnpys9t
         QUOAG+N07Nf9bdekfzBwnL8Q5Jiq5xhwA4LXUqMTaTfqmNT16O7qQJAWVQk4560S+qp8
         kdsg==
X-Forwarded-Encrypted: i=1; AKwUvByvD6JzsiTMHraJ3pMa5pRX/0tizufrch2ksqjt3B83z0JpTHdjISMjcEdEA+v7kPKsSNgJyP+QdjgR@vger.kernel.org
X-Gm-Message-State: AFuF++kCfDYjl8k5MVKdkPXIPWshJvnXosFur9KSu4O9pXTGoIrNv0pd
	6PJito+HrYMxOA70Pszd+HZPYIwF4lZzg9fdoTARJ0BqdDKO+Ma5z150uFhy8pq5EA==
X-Gm-Gg: AYBFou2+IccXmGGfUY0czSgbyWiCY0pr6U6FGE9H9Dg8v7jjcO1p0tmBcrRcpt7IAXP
	uStIYz6hpRxZAQ03207Qe/GqPz462rD3hvXbGOTEYQWgMxOcuWZg1PuTPuhJP1e0q+x2vcrskY7
	aPy6imV6+sWY5qy3AHWAAzv5i+UxjWnnhNkyyHBGM0rNLrBHQrKgTrof0E0qEeGe64YN6v8cIYW
	ksYguFIuLy2h5LFHB3KPn5IjMzWbjDYlCNSZ8dIRhs5ZQRQm29RuTLGsjBY2BxWnQCAY1CNpGFD
	DgpQD3z5sVgeRaj6/FUjajeIzCiBjR8RT7hR2NgNKwvxtel/JOp/NPWgK6n1NSHIq5tIEa22faP
	f6JfamsCcwIi8P+lv1lFnqq9M1FkMyDNY+f8fxN8BWAmkGOxj3Y856I2OuXlM3EBcHkCWdGynsX
	zpXWlDfsaLhP+am/I5iebqhe4S5Zyxd02DoPJMAxKNjOeo/6t1InEw9axXeqe8zzWYrWp7RY/5P
	yhxkY98SR6ZgO2sGtqxksyNRMjkulIV7w==
X-Received: by 2002:a05:6214:e85:b0:90e:7de2:d81f with SMTP id 6a1803df08f44-90ebabbac8emr90744936d6.20.1788377687526;
        Wed, 02 Sep 2026 12:34:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm25176366d6.2.2026.09.02.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:46 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:46 -0400
Message-ID: <e266759fa7a20e9620b16c1b5a717744@paul-moore.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260901_1604/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Seth Forshee <sforshee@kernel.org>, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 11/27] fs: port acl to const mnt_idmap
References: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>

On Sep  1, 2026 Christian Brauner <brauner@kernel.org> wrote:
> 
> Convert to const struct mnt_idmap.
> 
> A mount's idmapping is immutable. The only thing that is allowed to be
> modified afterwards is the reference count and that is hidden behind
> mnt_idmap_get() and mnt_idmap_put(). Everything else only ever reads
> from the idmapping. This is the same model that struct cred uses and the
> idmapping is also rather sensitive.
> 
> So make the idmap argument const wherever we can. The conversion is done
> from the bottom up so callers can continue to pass a non-const pointer
> to a const parameter until the conversion is finished.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ntfs/ea.c                          |  4 ++--
>  fs/ntfs/ea.h                          |  2 +-
>  fs/ntfs/namei.c                       |  2 +-
>  fs/ntfs3/inode.c                      |  2 +-
>  fs/ntfs3/ntfs_fs.h                    |  4 ++--
>  fs/ntfs3/xattr.c                      |  4 ++--
>  fs/posix_acl.c                        |  6 +++---
>  include/linux/lsm_hook_defs.h         |  8 ++++----
>  include/linux/posix_acl.h             |  4 ++--
>  include/linux/security.h              | 16 ++++++++--------
>  security/integrity/evm/evm_main.c     | 10 +++++-----
>  security/integrity/ima/ima_appraise.c |  4 ++--
>  security/security.c                   |  8 ++++----
>  security/selinux/hooks.c              |  6 +++---
>  security/smack/smack_lsm.c            |  6 +++---
>  15 files changed, 43 insertions(+), 43 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM, SELinux)

--
paul-moore.com

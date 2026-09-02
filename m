Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E894ACC9C
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377706; cv=none; b=mi0Z1elEd9dUxDCkVTPjkcr6s2ccpIEf93NMQ332L+uUMs/xN+fHgNnk/haroQJ9ts3KMv42xJSm+VUWqxAb3Cx0VanEp93F3bEhtUzl3NFlFJQnvKItfEzmsX83Cehp62nn7BEUu1q53sqcQYvMsJKRaaHapdotRaTpXe3JnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377706; c=relaxed/simple;
	bh=3WGPUky1hmwDKOIR30PGoglOqPg/CfPHhhz1D/WGWTI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=XhSYBwyPjxcaZN1M6uKyu4krEk4oKveDzCKi0mGozS4lGB8nrB5OyT62yCi+m3DvLb23oTCF2QprF1txOSuqiYhQ8jkXi7e2HjJ0cqC7Gj6N8CF2BoXjZQfLVAtiWbhpomtJwu5IGnF159YHtnVvWyn8yMAnMT5xiLLZNcoPBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dA1yL4xF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dA1yL4xF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5302b692c8eso13742801cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377689; x=1788982489; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTllqewIXAY5+sR//IBZWAZfUENL/NuhQCFU0zl+dm8=;
        b=dA1yL4xFmI/xLm4gRSWgFben1ST4myVImRVF3JDQcxKkV0fYD1Ntg9aKbmMS+Z+l78
         1/PWPbsjSZySmLHZideqKf+2aZzOLMAX9z2/84wXgSVlWbAm5hXDMv9KcEjc/puDweL3
         S6hUENsBnMQqsWYW9wDYNaFFFD1w8xhepjmDHisqycyUmz76aqSpxZvHM4OwoAAiQvlw
         62c4LWA0DWUYE6qqfOJzANDT6279+eDBPO0QC5/KDtprAIrbEoN2zG0aTCWDkC8nh72q
         TxsRBcE/AJeHtQGYCav2Fm3C30T4flhV5XQnCvzHynsxo+HzPMRVXjx9/tNF0MFsGTZa
         6OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377689; x=1788982489;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTllqewIXAY5+sR//IBZWAZfUENL/NuhQCFU0zl+dm8=;
        b=RiA28+ZP+mPVJBSQrlTIH1iBk1GR8vFCRnu3pyhpbItDmvcKBUGwXaf9cnsU/eUZrW
         4Ya3TQruZrUwwGzi4vehm5R6euRsewcRYdeuOrVBObQCamjJcj91AhMTfIqU8kIITe2G
         wHqqrhgvjtGwRvg5bckqK+1wizH1SA+3SyxLXO78513ZOmIAVGzNMcsAUUFQOm93SPvx
         Qa78iUhg1agPxazLsWJbfn3CUYkJbDrWIYe5GqXNpG/whIKuIc7wkzfYi9ejXzavO6Ge
         yxmhxXf2GvtE6UFzf3Wyrf7nTG8wpfBxaAtJ1NQi1IwwbyY4JbTduL3ozYndcRU8zzjX
         qEPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0K6pYd7KA9GwTUmNA0GtFwssMHEXWaljAPKkWbb+VbeD90N325KPM4Hl5tKR+nZhRsP/olk8JgImZ@vger.kernel.org
X-Gm-Message-State: AFuF++lNgmRkJPsQiPFthJJguq2QtJz6tPMm2JPZCOrFhh6f+EqgTeQ6
	au/WUrb3hRWpyVJBEGR+jbFFFF52pfltgfvkligKwNKtAxB/HMW37/8g/ddFZoi8DQ==
X-Gm-Gg: AYBFou2o+fVhqVo0VhIS0+YBVgaAyHvOu0ahhj6aDjThx5zQmscKUL+QliDLfj7VuKp
	Mtz2tlEu86zjjnkH4kGEAMvR0gvDFfD9DVzXRF/dI0IXffispYGXqLDSsC2HhSx901W3sWqtLeS
	Qy5aRQiUFoNJFauyClNNHZkC9iT6tNs4o8JKOjIwnyJ3mWredvSpE/XscOGoqixvehlXZzWtKSH
	/ddPDbArwQ71H4WW27xjak8y8zKp5t+0Yqh2/EPV6cguPw49UwbHluOpsSiZBPE20HyXS/nys1O
	jqI1zmfsXxuJDa78viie1CFH3J2i9fmEOuoAu0Y7+tFcS6HjLv0T5yjrjXwcwergrnCRhrnk9jd
	7QgPsDtQZHlW1ueTbdu6mDLkx9Xl6iH5kzlyRwOEp6v9UJlBTSUZ4d08zCjpyRd3csjqedEoFoa
	sWdtI6Q0JAV4Nm3XrEI0zbgIs/emTZBxZADgqJbF7AawitFJvCFouANCcmRxcHKeW+Q+JpPMyj6
	nWt6lX8Ye/uiucSuKC5uV79T1vMjn0/xA==
X-Received: by 2002:a05:622a:1f8d:b0:51b:f25c:2896 with SMTP id d75a77b69052e-53036bfdbebmr93564831cf.11.1788377688931;
        Wed, 02 Sep 2026 12:34:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53033252530sm25672391cf.28.2026.09.02.12.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:48 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:47 -0400
Message-ID: <4bcb6be827e73a667592e7110ba78682@paul-moore.com>
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
Subject: Re: [PATCH 12/27] fs: port ->permission() to pass const mnt_idmap
References: <20260901-work-idmap-const-v1-12-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-12-54ccd48e100b@kernel.org>

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
>  Documentation/filesystems/locking.rst |  2 +-
>  Documentation/filesystems/vfs.rst     |  2 +-
>  fs/afs/internal.h                     |  2 +-
>  fs/afs/security.c                     |  2 +-
>  fs/attr.c                             |  2 +-
>  fs/autofs/root.c                      |  4 ++--
>  fs/bad_inode.c                        |  2 +-
>  fs/btrfs/inode.c                      |  2 +-
>  fs/btrfs/ioctl.c                      |  2 +-
>  fs/ceph/inode.c                       |  2 +-
>  fs/ceph/super.h                       |  2 +-
>  fs/coda/coda_linux.h                  |  2 +-
>  fs/coda/dir.c                         |  2 +-
>  fs/coda/pioctl.c                      |  4 ++--
>  fs/ecryptfs/inode.c                   |  2 +-
>  fs/failfs.c                           |  2 +-
>  fs/fuse/dir.c                         |  2 +-
>  fs/gfs2/inode.c                       |  2 +-
>  fs/gfs2/inode.h                       |  2 +-
>  fs/hostfs/hostfs_kern.c               |  2 +-
>  fs/internal.h                         |  2 +-
>  fs/kernfs/inode.c                     |  2 +-
>  fs/kernfs/kernfs-internal.h           |  2 +-
>  fs/namei.c                            | 22 +++++++++++-----------
>  fs/nfs/dir.c                          |  2 +-
>  fs/nilfs2/inode.c                     |  2 +-
>  fs/nilfs2/nilfs.h                     |  2 +-
>  fs/ocfs2/file.c                       |  2 +-
>  fs/ocfs2/file.h                       |  2 +-
>  fs/orangefs/inode.c                   |  2 +-
>  fs/orangefs/orangefs-kernel.h         |  2 +-
>  fs/overlayfs/inode.c                  |  2 +-
>  fs/overlayfs/overlayfs.h              |  2 +-
>  fs/proc/base.c                        |  4 ++--
>  fs/proc/fd.c                          |  4 ++--
>  fs/proc/fd.h                          |  2 +-
>  fs/proc/proc_sysctl.c                 |  2 +-
>  fs/smb/client/cifsfs.c                |  2 +-
>  fs/smb/server/vfs.c                   |  2 +-
>  fs/smb/server/vfs.h                   |  2 +-
>  fs/tracefs/inode.c                    |  2 +-
>  include/linux/fs.h                    |  8 ++++----
>  include/linux/nfs_fs.h                |  2 +-
>  security/selinux/selinuxfs.c          |  2 +-
>  44 files changed, 61 insertions(+), 61 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

--
paul-moore.com

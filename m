Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0141352FBA
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022013; cv=pass; b=rCq5MfO0JK5N9gqOUCodG2Q//9hsbNVPopGVNuRiVbcWKeq3zA3tI2ii8itjNui1lvFOSoYfNZM2PFYvZvPsOlIn8ulvGw8aBEd0393J7QwMhBBRNliqtxqwBx8D7wiWOy/E/Pyxqu8Vx/i9dyvVHy8rSOWH/X+qrpaTnCatJ3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022013; c=relaxed/simple;
	bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzON5uLaYJ4YHtAKDdKhZeymxwrCU/kQyhiIewdg0Yrk/ZH/6VGYxX7DCxlaluQj0M04WgxsACJj5UDrcUULM7mXiYe/7tvFszbHbKUvSD51ouXHRpVcmVbqNGdWqBwMj9XpnKb4MwpGVhiNk3oUWpFlXC91aGODE7P4ogCMHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke3b0iRs; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke3b0iRs"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658072a4e56so379733a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 11:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769022008; cv=none;
        d=google.com; s=arc-20240605;
        b=iu/tb4S+iHGvZ4H0Jv3PsH2vJFEdCxypR91CCNnSGo9jtXlvyFV8EUAIv15OBo+4yv
         0NrxBrILc2lFRbqGjI1VBDVLMFLFXVo4+h1hEqKXVDyf90xafkZnxXQlTjsCJLUpw/hi
         hPEQ33F83Hg3uZ8YQfNmYVWDcViziKlDzJFnzz/2cKXjJyxQUv0YP2UajFNK/AR0KNam
         pWvc4nZO1E4MgVqGPJfRUYlbsVK/R5pEOsmfZYaZAwf6M7qDRFJACYz8Z72qtDWAkh57
         hCfolU+r7T/g3DryLQBtyCfhnihj7Gip/q/JD0x7/MXDbPZ3SijyAg8sqVXvEbanAuU1
         3YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        fh=gXt5fvh2anpK6voeq5SD/dW9aX10Hlf/sexmxv+ajxc=;
        b=KQpOQKDntt919Xh1oq7Ehm0sXUz+FhmssHk0/WmWosCP2CUJ3Ed8vKBrRfYunB+Qsq
         VezHhZdq94pH6M3w8Y8emnnxZUWcbGePqGDc/Llt2b6bos1K8l1XWYYmb59KIpYumjTW
         27aCZZDuC3hWeZk/Euft8BvMqaKYCT7fvUWIRqfHV2YVPhyQjM+eSEQqv8PAoKY7rfMv
         W0+80mBta37R98b+Aepewbf8wIDDvmgf7kyg4RTCYoqenJm3BhGJo0TBEcEddofb84Wc
         zPIpM71HDK7c9WvzWWZDHqMZphiwM+H6brjK8DwIb9bGC1UpDvYlGG+xzwaWPaOZM60Z
         xW4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769022008; x=1769626808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=ke3b0iRsOPGdb9oGItiqf3p2ocGTfsItthso0F5B2fak03CUA0liWLn/Ve+kCx5qdQ
         JombE0ayrWVRZQXIZl23qp9IKs0OR39m8RilvLRQvVGHRFm30KkpG++OotWZ92AwuCGc
         mfAvUOj8NIFwo25zttpr2t9oiEAh7Td8L4n9JqF49lbt65BYqwZMpd8IuL+pjuR3w7Cx
         uwF7vQXLdVLV63Ny5cgNkQ66Jb7r0JOenkZbCMRNua5Ow/a8OGWNheD6DVKMa3a6U1VX
         hddDJM9Nq2Z5pHCrVaA1w4AG9WOs41axr0x1rUqjUrhki3bUl8DCRQXOnsnH+8mR9kKE
         KgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022008; x=1769626808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=WqIDaHuSVfURto33/saZ+9BM/sopyAMXBd33tuSP1NLTzn9LvXxDKjxkzLchErbgZd
         nQzOvhRzXbKOl5nftaNXg4fqvVyKWUOHuaBrOfy11OILf2zmrljj5ZPyy7YuskWik1Ui
         TZD45PnQ6no1H6WaTBC1nFgdIsC2dUMLhF9jA+6lfa2ebl9fSHTWjMLhRKNTICEu0RUq
         7myb0iaXXPIpjgwOXdyyBMx4UxsaI7P/XJBJQuwTb36Ln2OpdacEhUW0awVXxvj7aNbZ
         Cf6XAqQk499UsIY7mEY/Ep23znhP+ocMq2Yd4wjSDDDlci7JG7QDZRBI+Pi146X/FYRd
         5BLw==
X-Forwarded-Encrypted: i=1; AJvYcCWMwxdV1uhsA3aJ7diqK2ywqDv/LjOlizLg50g1Id29z8+yj1VnJhpX7vimRrVS9uY21TK6V5pjhCpK@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+cWu7QiAE1u0CAL0m4xJzbI8YhpKKRSZ7G0bQ97Pz9Nil8DE
	kBXCGyqfZAvRoTJUcJkY17KkgrABDhSvKkxfv2dgd63ZTHpWODCMekc0vouK7D+kz8poJrwd90S
	El9sYZgUjF7EaFxTV/WvGhJks8ebVnvg=
X-Gm-Gg: AZuq6aKvxIDKMqX7L/NyUi5WHJXfL62I+kJWlULozv37lEsHre3HUXgvyBRLCsynOQd
	2ZMLt6UgLb8OsmuYKJfCwYDI1P07NafFb77pI7+SVuJ4hzVLGXLpqf+96HVq+5GFdlIFS3sX+sN
	HocyB2+N3DAir3hXJlvIuAlfMddFU5ZPjF1ATnjmFK3pm8pSeGgnJwl47LP8zfKCdI+7cAelix/
	B2wJjUoAWNaH8FxiaF6z0qo0JQ1oeQZPtFiPBLKLB/bWVREcaLzXdegK6Fpy5RHeYkL3gKBzeg+
	35MAC75uA1I04znKEvotiozCCdo=
X-Received: by 2002:a17:906:6a13:b0:b87:206a:a23b with SMTP id
 a640c23a62f3a-b8792f79852mr1477117366b.34.1769022007470; Wed, 21 Jan 2026
 11:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org> <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner> <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner> <176890211061.16766.16354247063052030403@noble.neil.brown.name>
 <20260120-hacken-revision-88209121ac2c@brauner> <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
 <176896790525.16766.11792073987699294594@noble.neil.brown.name> <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
In-Reply-To: <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 19:59:56 +0100
X-Gm-Features: AZwV_Qh050IhjThhArfxNo-53HjJR0uLCcITEQOtntS-75Lw875opD6ONQssxps
Message-ID: <CAOQ4uxg+dC1o+6V7Nvxf8UW3H=0OvsGjEe76LNY6q8ZcpGDDJw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
...
> > But if you really really want to set this new flag on almost every
> > export_operations, can I ask that you please set it on EVERY export
> > operations, then allow maintainers to remove it as they see fit.
> > I think that approach would be much easier to review.
> >
>
> We could probably do that, but I think the main ones that excludes it
> are kernfs, pidfs and nsfs. ovl and fuse also have export ops in
> certain modes that exclude NFS access, so the flag was left off of
> those as well.
>

For the record, my comments regarding fuse_export_fid_operations
and ovl_export_fid_operations variants were purely semantic -
it did not make sense to mark them as _STABLE_HANDLE, but
it does not matter if you set a flag on those ops, because they do
not implement ->fh_to_dentry(), on purpose, they are not
exportfs_can_decode_fh() by design.

Thanks,
Amir.

Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A43E3166
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370713; cv=pass; b=AbiRHIzFQrjRDQOR6A8A59ZXyAD6uCyzPY5y2rXCv6JaY9gAJBVgQQsVi7FGZsdI/91I+Bqkvg2Mv4pjBfP4EYkU4IF1p7iCjTGXBc5UB4iL97Yu+IMCJzeOWizZl8YxU4Mn9TrEfUjY6n6nS95bn2Tt1BoigsUnk8P3pkHdrYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370713; c=relaxed/simple;
	bh=wQK4iC+iVboZVQ0TbBvuUd5c8pU8uXP8R69wO9Cbm1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q12wFt6TLku69jXxYpaTaqaZGGFd+V2ejZ8/DhRKtGH/lbr0WqZMnuT113fGjyR6ohLKD6tjRtv5pIk0PJK2SysC/WUlcH/jfOH6XoutRvxK7bf1C2WNJl+kBXNkg5+F4mELJ7mWp74cGP2654l7ocezK0w5cOytqCwxusJBk38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=myhmKgHT; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="myhmKgHT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c4436d02cso8917391cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370710; cv=none;
        d=google.com; s=arc-20260327;
        b=a8DaFerbDXnVDFvqkjNWffuk/r+cqySlVnw/WjYbmtR/gX4QPRbXCHD8zDqDUhCjln
         zQ+gIfQEES9plNB0Jt62czsH6TFD92mKzNSCm2fyuVPjZUzG4ObJ1sjocPY8qHzP1gIX
         oN6gtfpubDIRZdj5bygKpv8PSEPGQYGn5ehhz/HiRc/CTkDE9ur2B0akhES0cMx1MlrC
         c5CSxJlUvRJLqpV1AJoOfoxNo6ISccYXREijrP4rUf5bR4t7hd00yhmd30T0WUV+gLP7
         V8KgnVzAi3EtDkbJTQoIYk0IgIbzoBlQw+s70dwnFcsVSiY40oBgoqaCZj91K/H7M15L
         rhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        fh=gDSlJQCodLr/FJs40LFaKTLVaZWjs4dPYY3s3e59beE=;
        b=Cbl5UB2RseU2vY1YtXBhvaPYZoR8kD/JA5SG4qjC7FU6N5RUmYccivJPMDnhG2jWSu
         2hZ+zaZo+YxStopoqSTNk43o07h5cFocvdHViripWXl/kOmkh+AjyI57CLU4YytHQEkI
         5T8gUA8M+ZUnFmEDzmKhwBvbPlCh9nrU2dzplbrKJuHz3pVvqd73jm1c4J7W94G1Xlg9
         4bDkvxN3sw1DTpCasKN+OyzeJIHAcKmOZEeQxnlNihBNCt93SQDrWTDe4aIKtD0mgqKs
         qpd0w1nREKc3wHIJY8jABb40FJEFyynMCZnU4NHWi3CoDfiBrq4CE9vnS24YhDVNwOkH
         rsdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786370710; x=1786975510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        b=myhmKgHTG1hXWp+ZWdXS/rOTTX/n2t2qUF8gwZnkEQrZniSCmin6lDe/80YepezVa6
         121u1I/avdUEU9WLXbOvUTKTDZnRMENu9eDMm34cdrmTSuVA63UMoNjjk1PYE/pAvemd
         YBbtcfpvyQ4CvlD5YmCvZn51m6vllAzMISc9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370710; x=1786975510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        b=nBg65Yu0khGRmAU42ojpxO4Slnq4/3r4D9zU0pTHS7U2oSOJIZReOURQOWwsJlejW+
         otmAsBg01LENFvRxu+5tfOqMOCMGaoNc2PYsl4nP+OEC20Iz8RfusoC1I7AccaLQ8TqC
         RiGHie0tnt3oYxX+F9qbcaRbahJUq8T9afMhtl1clb2hpQBx7m1tlOG7TncAsWtUV62d
         0S/U5JPWOuP2KUCEd7rKREfUSmH5UO3bMGTJaSSzm3SrwzROt/xzx6Xtp50bCpyEYV+U
         vzE2/6rkUFfN/RkoVacrhgLBdKKp2/eg1NwIYjmdOuCm6vSjitMZ/PhAcImBI9q949UW
         FUZw==
X-Forwarded-Encrypted: i=1; AHgh+RqKCFeuaWTxZz647Ib5azZM+nbHs+Ku3dveG0Xvct+XN7DwXI3jn9AcLW7TG7ZUJbznKPkzg1qxPlJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8VH0T9fSsxmTbrZFYANUHk/roDyUQq+BDJ5n7PIpG2tAUUuK
	mHxxJBmpobLH8uDaEqUlAW/ONxeaj0dwRgMKk4FMmTfAJNXXWInluQy6fGKwwPvMTrRWAjBOtIn
	Vu4S/3IQ+4m7WMUVCQj3HHlvAnjxbaIe21YzVtaS96Q==
X-Gm-Gg: AR+sD11WOzogXCwukL/B4nsJ8P4be31htaCHqo5JlKyN6QyswKzjR4ngHuEh+drZhp5
	EJGQf3BJjgm0emnla1RJw9G92e2oNCPwg3FnDxdm785fuzETymp+hl2DkpRKOBKGzgqiglpF0Pi
	sHtOoPDOnVZKgFFXair3XVEVq6JxVT9bgyhNS+rGEKJ1IxoBl9QxpeR+bov4AI9lGJtg78T7riD
	iCzZs8Ac829BN4OqiwqLG2w6eS4ndvw83BcYgskbmJ/tGFQVu+omw90ctz0WkvsXpa0ywZQbXZP
	9OfPtY2CP1NeEuKUkAeGt3rITi9a1Z6iU3TrIaizLpXCIV6VoAuvGH02CDwRoXLdc+yQz5ilWlk
	=
X-Received: by 2002:ac8:5cc5:0:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d1919e59dmr254953691cf.37.1786370709751; Mon, 10 Aug 2026
 07:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-3-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-3-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:04:56 +0200
X-Gm-Features: AUfX_mwOr6H9OqGZCernhbLrr_tuorcVZn-K7EOk-lg62vULXKmdHLNqnvpAUNY
Message-ID: <CAJfpegvTXG_kJHyFB115zdQvbyvDNtfqA_Mv9UKiEf9BE5qXwQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/12] Add and use d_for_each_positive_child family of iterators
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:38, NeilBrown <neilb@ownmail.net> wrote:

> coda_flag_children() doesn't need rcu_read_lock() as holding any
> spinlock prevents an RCU critical section from finishing.

I think prep changes should go in separate patches.

The conversion should be an equivalent transformation.

> nfs_clear_verifier_directory() is changed slightly so the parent lock is
> dropped and retaken between clearing the verifier on the parent and on
> all the children.  I think this is safe.

This can also be a prep patch.

> get_next_postive_dentry() in autofs now holds the parent lock a bit
> less.  The only non-trivial code that is no locked any more is
>    parent = p->d_parent
> This cannot need the lock as autofs doesn't support rename and
> a ref is held on a descendent of parent, so ->d_parent cannot
> change.  And if it could, the lock wouldn't help.

And this too.

> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 5c2d459e1e48..7b0a22629415 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -70,12 +70,9 @@ static int autofs_mount_busy(struct vfsmount *mnt,
>         return status;
>  }
>
> -/* p->d_lock held */
>  static struct dentry *positive_after(struct dentry *p, struct dentry *child)

Move this primitive to libfs.c?

> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2182,14 +2182,10 @@ static bool drop_negative_children(struct dentry *dentry)
>         if (!d_is_dir(dentry))
>                 goto out;
>
> -       spin_lock(&dentry->d_lock);
> -       hlist_for_each_entry(child, &dentry->d_children, d_sib) {
> -               if (d_really_is_positive(child)) {
> -                       all_negative = false;
> -                       break;
> -               }
> +       d_for_each_positive_child(child, dentry) {
> +               all_negative = false;
> +               break;
>         }
> -       spin_unlock(&dentry->d_lock);

simple_empty()?

Thanks,
Miklos

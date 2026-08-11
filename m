Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E583442371
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450475; cv=pass; b=uGaeEUqi42c6Aqi+5qN8vXjUW+q5MTYow6wgSl+y7U3v/D9g+s2KKjJnqtyjdt0i0GiiD8MPNxUDd6VDu48425pdbYcfbNitt4Ldx4b7J7FNVgVh6MTWutcd0+fqiANwaG4JgHwBE3xz3wrbFIBudz240YBGDfu1VqlS+WxBG4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450475; c=relaxed/simple;
	bh=uKswzyf3oANr0x5zb0bJBPrPAkNK77rK/33VzGVtg1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brcUE5KViM4byGbx8j2H3phL225Xm/6v2CUExGUET5qzKSUbyaqK5wM/3VeC9YfY453lqBry+cmy72hxkLIsUVmUHcAzrf3v5S9Oi0k4xpMGnZa69aXDdzX/Q1LKF4AbthpTilNaxD6cO62L69lM8mQHcSdi98yevVORmmUh7fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LYhhybqo; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LYhhybqo"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d37b65926so3286681cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 05:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786450473; cv=none;
        d=google.com; s=arc-20260327;
        b=dWIn1TQ8Hg8fIk+3i7MBE0A1z5ja9u3Ljy8N4xFM2Gyvp+nZUR7aHI8LnHN8ffsmze
         SVUFPMDzDf5KtHZozFcgPtK1x+ST2sPEhEHMMEc0AtNDmMl+h/vjmSr8bLYBu7j7JDmF
         acqHFw/lWLnCrH0PIwvDrAuKI+WD0cT6/j7PcerWlQ/Z21pC4NTzdTG1u7P6a3SOOIa6
         SY31XqkNJqPezFqdtg5rfNM/bbepZ59Mrj7oQx0J4bWv1t2y6pj5UPkCVTrns/wQZn6T
         fFhGebvr1AeqdfDuBRXyq36U/HyFYZu+5/jvV/hb/AM09FFA0xReBXYus9eh3erYd+h8
         RcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        fh=aTuCE2sV4qcNPgQpXu+LnrEnfsNwN4QyPfnwKXVyQVY=;
        b=dAgMBVv1mjUo2txVZmeF+5O6O76EfxGxfN1MkpX4P8T2etJrIpOBNsKVm7NbfzYIPj
         gEoZ9lGZKw1QcfgRKTN5S6gsbJng88FXNO9wTSLdTRce805lm8NSf++XAEGZuhaKukGs
         Qwxel6VytzDSOVeXaWIY1SowjrOPrDYh4jJfkM0XXHN3ngyvs+lvhCM8rGMu/KhOPwGp
         i4oyjFTd6s64PB04fRkS4NZ3kOTKrViIu9u4MH/aFrzl1g5Tu7tRANnj7xyxn/snGKiL
         6lhmpVqB8gfOHJB+b5y8meUSLL+R4PEpPf/jDcMB9rnJKc/6GoL0KkS7Q+V7NDb3yPra
         mq5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786450473; x=1787055273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        b=LYhhybqowWX6ZR+Nf5Xxsft7xXDxdFX3reI2VxNHFPBCKIsh8yC66ANIAQgBMBikIZ
         99mOfXZFzwE+fla4yJjoCv1zBbfR1iPecQ7opVFYRx2aUa01sY/qYo/E7B2JCkdw3MWb
         feyvqbpjBXul4yjwwI3Ksk3aN7ddKGi7W+kCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450473; x=1787055273;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        b=ZWqW/kfUYbwu5//6TRm6GqH9uyxYveWXBop2huJLexzwok1p9GBAabhUKrlhHIvRgu
         Bg890Z1TJlGyGSMRbDSnsNes10C2kaPfXaYM3rCp+3DKYe+q0j/eBLWPNWIxgCkCodjr
         iTj+gjlBCqW0dVRLYHs4UW1DXKLZUv4b4wAVRkRTmNlYiT2eIM0yo64YCJrmp6S8Cvgr
         QmV7hmyJvhjTYZRFCKEpFNk/9mj31UNNRqyTYj9Ey7jKogSEdwDXgJi74pJAY1jZfo7Y
         NuE52MlapJitAIwIPsvxrjrrND93rknk52rNWSFSXItos1p16Iifj56Bf9Vj/a7XPrGE
         n/Hw==
X-Forwarded-Encrypted: i=1; AHgh+RoZ9esD5f+KXvOHBI2Hp5yqiXknxNRWjSQIt2TFDU1XgIo7kqQA51LTVYUAXEwkHh4eO4G7vqKY5VpI@vger.kernel.org
X-Gm-Message-State: AOJu0YzMChCsh1Gmp0Csfh2C/GtPzAZWZXcf+YE+eraRiL0Ey7ptv8sa
	eKqSPZ7lm5bYzmBPwGR75FropD/nsJ6FaXSjW1tKGkNtX5MDEXJcGPOgjvKVX+jJdFv5oivQ15I
	gQ51wheeHElOeHkljJLW7sR+VwlM+9Q5J/FYPtm1OTQ==
X-Gm-Gg: AR+sD13TkCcghXdprUr9bfqJbtKIF+xhIS5/geDP1mRoot5P0EeMMqxTcMGeqIm1Ohk
	FZ86cTdLHefT3O49un5zhz4s9clcEZpAoroPwgrW/9k4q4IkHBP1MDa6gUBDYjDxig2mLLVOU54
	hDoJ8aZNhxywXot4BwamCNxjLah6jlFNYccLqV96DiFHcdXCdGe1yVRzQqc2aS0fbyt38ncrzpa
	jwvosjrAWd70nfs/jMihEcQZeq24YTHDLpJy51uWmEfZJ2w97HSp4wEjeXS/Kz13W1mJdAnDLGZ
	zpJQxwrmhQ7Gz1F1+YLjtNdbUt5gwIJDF8OW68yW4+r34XDZPnpGSOHljiMSd+/MshcbpFZoHBO
	4hw==
X-Received: by 2002:a05:622a:1389:b0:517:906b:c043 with SMTP id
 d75a77b69052e-52d5869769dmr20988111cf.36.1786450473109; Tue, 11 Aug 2026
 05:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-2-neilb@ownmail.net>
 <CAJfpegt1wHngLs9uR943gT6zxV67D53k3n4GiFKowsAb3C6LJw@mail.gmail.com> <178641431036.2852630.14175693646176331672@noble.neil.brown.name>
In-Reply-To: <178641431036.2852630.14175693646176331672@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Aug 2026 14:14:13 +0200
X-Gm-Features: AUfX_mx5_QZpyNyj5Ni2I_IHkZVhUDCHgR5x1MospzmB8YaToZll8PeS64_iAm0
Message-ID: <CAJfpeguZh6Bo7hxVW5f-OvKJ3UazJTn26Wkba8+rXY-LC-QNWA@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] VFS: don't count references through ->d_parent
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

On Tue, 11 Aug 2026 at 04:12, NeilBrown <neilb@ownmail.net> wrote:

> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -169,6 +169,8 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
>                 hlist_del_init(&cursor->d_sib);
>                 if (to)
>                         hlist_add_behind(&cursor->d_sib, &to->d_sib);
> +               else if (hlist_empty(&dentry->d_children)
> +                       dput_dlock(dentry);

you mean dput_dlock(cursor)?

But that's no good, since the directory could be repopulated and the
cursor needed again.

Thanks,
Miklos

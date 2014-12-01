From: =?UTF-8?B?6ams5bu65pyL?= <majianpeng@gmail.com>
Subject: Re: file journal fadvise
Date: Mon, 1 Dec 2014 10:09:15 +0800
Message-ID: <CALurOm2tEV=RqN21eFJvfU1zTtJkbz2gHDCk_Ntsy4oz9iwHoA@mail.gmail.com>
References: <alpine.DEB.2.00.1411301013490.352@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57155 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbaLACJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Nov 2014 21:09:17 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so8671501lbj.13
        for <ceph-devel@vger.kernel.org>; Sun, 30 Nov 2014 18:09:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1411301013490.352@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: mnelson@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi sage:
 For fadvise_random it only change the file readahead. I think it make
no sense for xfs
Becasue xfs don't like btrfs, the journal write always on old place(at
first allocated). We only can make those place contiguous.

Thanks!
Jianpeng

2014-12-01 2:46 GMT+08:00 Sage Weil <sweil@redhat.com>:
> Currently, when an OSD journal is stored as a file, we preallocate it as a
> large contiguous extent.  That means that for every journal write we're
> seeking back to wherever the journal is.  That possibly not ideal for
> writes.  For reads it's great, but that's the last thing we care about
> optimizing (we only read the journal after a failure, which is very rare).
>
> I wonder if we would do better if we:
>
>  1- trim/discard the old journal contents,
>  2- posix_fadvise RANDOM
>
> I'm not sure what the XFS behavior is in this case, but ideally it seems
> what we want it to do is write the journal wherever on disk it is most
> convenient... ideally contiguous with some other write that it is already
> doing.  If fadvise random doesn't do that, perhaps there is another
> allocator hint we can give it that will get us that behavior...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

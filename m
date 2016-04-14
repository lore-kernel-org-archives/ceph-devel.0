From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: cap mask differences for `Client::stat` vs `Client::fstat`
Date: Thu, 14 Apr 2016 09:49:23 +0800
Message-ID: <CAAM7YA=+4wjN0TJFrrBovzkxLGJp1ngqC-Y-2fgV_mywaJx2Uw@mail.gmail.com>
References: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33397 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbcDNBtZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 21:49:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id y144so18621386wmd.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 18:49:24 -0700 (PDT)
In-Reply-To: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 14, 2016 at 1:26 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
> In the libcephfs client it looks like both `Client::stat` and
> `Client::lstat` use a default mask of CEPH_STAT_CAP_INODE_ALL and are
> able to return immediately from `Client::_getattr` without making an
> MDS request. However, `Client::fstat` uses hard-coded -1 as the cap
> mask and always issues a MDS request. Is this the intended behavior,
> and if so, what are different semantics of fstat that make this a
> requirement?

I think it's a bug, Client::fstat should use CEPH_STAT_CAP_INODE_ALL too.

Regards
Yan, Zheng

>
> Thanks,
> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

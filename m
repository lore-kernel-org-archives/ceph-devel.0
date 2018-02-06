From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: question about fuse_disable_pagecache
Date: Tue, 6 Feb 2018 13:15:18 +0800
Message-ID: <CAAM7YAnH3RBu3Dwfo5qScZ2cAJ0jDmpu=Kp6CCg4MiXS7JFONA@mail.gmail.com>
References: <112905846.2630949.1517892905113.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:45407 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeBFFPT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 00:15:19 -0500
Received: by mail-oi0-f42.google.com with SMTP id c189so469318oib.12
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 21:15:19 -0800 (PST)
In-Reply-To: <112905846.2630949.1517892905113.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

both keep_cache and direct_io options control kernel page cache.
'keep_cache = 1' means kernel does not invalidate inode's page cache
on open(2). option 'client_oc' controls if fuse cache is enabled

On Tue, Feb 6, 2018 at 12:55 PM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> Hi,
>
> I have a question about this commit
>
> https://github.com/ceph/ceph/pull/5521/commits/0f11ec237d4692d313a038ed61aa07a3f40555ba#diff-bf87beacb5e3b3ff3ade7ac4a8332d20
>
> which introduce "fuse_disable_pagecache" option
>
> commit description is
> "In ceph-fuse case,
> there are two caches, one is in ceph-fuse, another one is in kernel.
> We can't disable/enable the kernel cache dynamically. So adding an
> config option to completely disable kernel cache."
>
> and
>
> -    if (cfuse->client->cct->_conf->fuse_use_invalidate_cb)
> -    fi->keep_cache = 1;
>
> +#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
> +    if (cfuse->client->cct->_conf->fuse_disable_pagecache)
> +      fi->direct_io = 1;
> +    else if (cfuse->client->cct->_conf->fuse_use_invalidate_cb)
> +      fi->keep_cache = 1;
> +#endif
>
>
> So, does it disable both caches ? (fuse cache(keep_cache=0) and host cache (direct_io=1).
>
> Isn't it possible to have direct_io = 0 and keep_cache = 1 at the same time ?
>
> If I understand, fuse_use_invalidate_cb is to be able to invalidate fuse cache.
>
> Regards,
>
> Alexandre.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

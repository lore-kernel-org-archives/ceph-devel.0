From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: RadosGW cache ldap auth
Date: Wed, 7 Feb 2018 06:38:28 -0500
Message-ID: <CAKOnarnFzOWc5iJe2CJktFL-Uu9je0h2Y8RygFTBsGomyauPsw@mail.gmail.com>
References: <CA+9pRwQKvWT615YsfUoYE-iU+JPHjAt77+ZjCh7PaSH=FJyqoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:41240 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeBGLia (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Feb 2018 06:38:30 -0500
Received: by mail-io0-f172.google.com with SMTP id f4so1662611ioh.8
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 03:38:29 -0800 (PST)
In-Reply-To: <CA+9pRwQKvWT615YsfUoYE-iU+JPHjAt77+ZjCh7PaSH=FJyqoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theofilos Mouratidis <mtheofilos@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I have plans to implement an in-memory cache--if sized correctly, do
you see a problem with this (materializing cached authentications to
disk would remove a lot of the benefit of caching for most potential
users)?

regards,

Matt

On Wed, Feb 7, 2018 at 5:43 AM, Theofilos Mouratidis
<mtheofilos@gmail.com> wrote:
> Hello cephers,
>
> In CERN, we would like to use the ldap authentication of the S3/Swift
> radosgw api, for its.
> features. I did some tests and I found out that for every request by
> the same user,
> the radosgw redirects the authentication to the ldap server. In case
> this goes public,
> it might cause a DDOS to the ldap server. We would kindly ask for it
> to be implemented.
> If this is not feasible right now, can you point us the way to create
> a PR for this?
>
> (Some change around "/src/rgw/librgw.cc:528", use rocksdb?)
>
> Thanks,
> Theofilos Mouratidis
> Storage Group, CERN
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309

From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4 0/6] ceph: kernel client cephfs quota support
Date: Wed, 10 Jan 2018 14:08:38 +0800
Message-ID: <CAAM7YA=N8W9aOfq=Y7Jd1NgGY3TxbMfSNShNKccqe3Hyewt4Qw@mail.gmail.com>
References: <20180105104723.16202-1-lhenriques@suse.com> <CAAM7YAm7kON+OqrBMccyDSMi6Jkm3qSLN=O0KPCjOuO+jUQojg@mail.gmail.com>
 <87lgh7ndwb.fsf@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38195 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933327AbeAJGIj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 01:08:39 -0500
Received: by mail-ot0-f193.google.com with SMTP id h2so13408406oti.5
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jan 2018 22:08:39 -0800 (PST)
In-Reply-To: <87lgh7ndwb.fsf@hermes.olymp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

On Wed, Jan 10, 2018 at 1:24 AM, Luis Henriques <lhenriques@suse.com> wrote:
> "Yan, Zheng" <ukernel@gmail.com> writes:
>
>> I also wish to do some optimization (incremental patches) to the code
>>
>> 1. avoid quota check if there is no quota in the filesystem. we can
>> use a variable to tracker how many snaprealm have quota enabled.
>
> I was thinking this should probably be an atomic64_t in struct
> ceph_mds_client.  Does this make sense?
>
yes


> Also, it would probably make sense to have the following functions as
> inline, defined in super.h:
>
>  ceph_quota_is_max_files_exceeded
>  ceph_quota_is_max_bytes_exceeded
>  ceph_quota_is_max_bytes_approaching
>
> This way they could simply check the mdsc and return immediately if the
> counter is 0.
>
>> 2. save inode pointer  (not increase inode's reference count) in
>> ceph_snap_realm data structure. so we can avoid calling
>> ceph_find_inode() in check_quota_exceeded()
>
> Would you like me to work on v5 to include these changes, or would you
> rather keep v4 and simply have 2 extra patches on top implementing these
> optimisations?

I'd like to keep v2 and have extra patches

Regards
Yan, Zheng

>
> Cheers,
> --
> Luis

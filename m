From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH v4 0/6] ceph: kernel client cephfs quota support
Date: Tue, 09 Jan 2018 17:24:52 +0000
Message-ID: <87lgh7ndwb.fsf@hermes.olymp>
References: <20180105104723.16202-1-lhenriques@suse.com>
        <CAAM7YAm7kON+OqrBMccyDSMi6Jkm3qSLN=O0KPCjOuO+jUQojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48299 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752816AbeAIRY7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 Jan 2018 12:24:59 -0500
In-Reply-To: <CAAM7YAm7kON+OqrBMccyDSMi6Jkm3qSLN=O0KPCjOuO+jUQojg@mail.gmail.com>
        (Zheng Yan's message of "Mon, 8 Jan 2018 20:55:35 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

"Yan, Zheng" <ukernel@gmail.com> writes:

> I also wish to do some optimization (incremental patches) to the code
>
> 1. avoid quota check if there is no quota in the filesystem. we can
> use a variable to tracker how many snaprealm have quota enabled.

I was thinking this should probably be an atomic64_t in struct
ceph_mds_client.  Does this make sense?

Also, it would probably make sense to have the following functions as
inline, defined in super.h:

 ceph_quota_is_max_files_exceeded
 ceph_quota_is_max_bytes_exceeded
 ceph_quota_is_max_bytes_approaching

This way they could simply check the mdsc and return immediately if the
counter is 0.

> 2. save inode pointer  (not increase inode's reference count) in
> ceph_snap_realm data structure. so we can avoid calling
> ceph_find_inode() in check_quota_exceeded()

Would you like me to work on v5 to include these changes, or would you
rather keep v4 and simply have 2 extra patches on top implementing these
optimisations?

Cheers,
-- 
Luis

From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH v4 0/6] ceph: kernel client cephfs quota support
Date: Mon, 08 Jan 2018 15:00:59 +0000
Message-ID: <87wp0stmxg.fsf@hermes.olymp>
References: <20180105104723.16202-1-lhenriques@suse.com>
        <CAAM7YAm7kON+OqrBMccyDSMi6Jkm3qSLN=O0KPCjOuO+jUQojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45771 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932121AbeAHPBH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 8 Jan 2018 10:01:07 -0500
In-Reply-To: <CAAM7YAm7kON+OqrBMccyDSMi6Jkm3qSLN=O0KPCjOuO+jUQojg@mail.gmail.com>
        (Zheng Yan's message of "Mon, 8 Jan 2018 20:55:35 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Fri, Jan 5, 2018 at 6:47 PM, Luis Henriques <lhenriques@suse.com> wrote:
<snip>
> Hi Luis.
>
> This series looks good. I will add them to our testing branch if my
> local test goes well.

Awesome, thanks a lot for your review.  Please let me know if you find
any issues during testing.

>
> I also wish to do some optimization (incremental patches) to the code
>
> 1. avoid quota check if there is no quota in the filesystem. we can
> use a variable to tracker how many snaprealm have quota enabled.
> 2. save inode pointer  (not increase inode's reference count) in
> ceph_snap_realm data structure. so we can avoid calling
> ceph_find_inode() in check_quota_exceeded()

Yeah, these changes seem to make sense.  I'll have a look at them and
see what I can come up with.

Cheers,
-- 
Luis

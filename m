From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC v2 PATCH 1/4] ceph: add seqlock for snaprealm hierarchy change detection
Date: Tue, 19 Dec 2017 10:57:34 +0000
Message-ID: <87tvwn9e8x.fsf@suse.com>
References: <20171218153902.7455-1-lhenriques@suse.com>
        <20171218153902.7455-2-lhenriques@suse.com>
        <CAAM7YAmwdoEp+SHtnN7ubRaDRcO9U=XZMa5vCbZL+FtEsvBbrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762070AbdLSK5g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 19 Dec 2017 05:57:36 -0500
In-Reply-To: <CAAM7YAmwdoEp+SHtnN7ubRaDRcO9U=XZMa5vCbZL+FtEsvBbrQ@mail.gmail.com>
        (Zheng Yan's message of "Tue, 19 Dec 2017 17:22:43 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Mon, Dec 18, 2017 at 11:38 PM, Luis Henriques <lhenriques@suse.com> wrote:
<snip>
>>  /* snap.c */
>> +extern seqlock_t snaprealm_lock;
>> +
>>  struct ceph_snap_realm *ceph_lookup_snap_realm(struct ceph_mds_client *mdsc,
>>                                                u64 ino);
>>  extern void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
>> --
>
> For the above reason, I think we'd better not to introduce the new seq
> lock. Just read lock mdsc->snap_rwsem when walking the snaprealm
> hierarchy.

Thank you for the detailed review of this patch.  I guess my
understanding of the snaprealms handling wasn't quite correct.  Using
the snap_rwsem seems to make sense now after reading your comments and
re-reading the code.

I'll look at the code a bit more and eventually rework this patchset.
Dropping this patch will also allow simplifying patches 3 and 4.

Cheers,
-- 
Luis

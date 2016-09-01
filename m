From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 0/2]: CEPHFS: allow for races between direct and buffered writes
Date: Thu, 1 Sep 2016 22:30:23 +0800
Message-ID: <53A4AE18-147D-44BC-8F96-62E4B7C0A16C@redhat.com>
References: <874m61eje0.fsf@notabene.neil.brown.name> <CAAM7YA=p9EdH6Kd2t_b5ZzbEHm5PSvEVakcSTtCiH=5o5sNi1g@mail.gmail.com> <87mvjscthb.fsf@notabene.neil.brown.name>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754017AbcIAObB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Sep 2016 10:31:01 -0400
In-Reply-To: <87mvjscthb.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: NeilBrown <neilb@suse.com>
Cc: Zheng Yan <ukernel@gmail.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


> On Sep 1, 2016, at 09:13, NeilBrown <neilb@suse.com> wrote:
> 
> On Wed, Aug 31 2016, Yan, Zheng wrote:
> 
>> On Wed, Aug 31, 2016 at 10:56 AM, NeilBrown <neilb@suse.com> wrote:
>>> 
>>> Hi,
>>> it is quite possible for O_DIRECT and buffered writes to a file to
>>> race.
>>> The xfstests test suite has a test - generic/036 - which tests this
>>> case.
>>> 
>>> Unlike most filesystems, cephfs does not hold inode_lock() across
>>> direct writes.  This means that buffer pages can become dirty while
>>> direct writes are happening.  This confused ceph a little.
>> 
>> how about make ceph_write_iter() hold inode_lock() for direct/sync write?
> 
> You could probably do that.  You could even use inode_lock_shared() to
> allow multiple writers to perform O_DIRECT writes to the same file in
> parallel.
> 
> But I don't know why ceph did this differently from every other
> filesystem, and the git commit message doesn't shine any light on that
> question.  I didn't want to propose a change that I didn't understand
> the consequences of.
> 
> If you did extend the locking over ceph_direct_read_write(), it would
> probably make sense to remove the truncate_inode_pages_range() call as
> it should be redundant.

both patches applied

Regards
Yan, Zheng


> 
> Thanks,
> NeilBrown
> 
> 
>> 
>> Regards
>> Yan, Zheng
>>> 
>>> The following two patches allow ceph to handle this possibility a
>>> little more cleanly.  The more important patch removes a WARN_ON() for
>>> a circumstance which can easily be triggered.
>>> 
>>> Thanks,
>>> NeilBrown


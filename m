From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: don't set memalloc flags in loopback case
Date: Thu, 2 Apr 2015 02:40:19 +0300
Message-ID: <CAOi1vP-u_sWF0uZpbYCN9qUp80tXQvmnJdOjWM3kpSR1JqSDMg@mail.gmail.com>
References: <1427908760-7083-1-git-send-email-idryomov@gmail.com>
	<20150401230323.GD20397@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32973 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbDAXkU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 19:40:20 -0400
Received: by wixm2 with SMTP id m2so45333122wix.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Apr 2015 16:40:19 -0700 (PDT)
In-Reply-To: <20150401230323.GD20397@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mel Gorman <mgorman@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <michaelc@cs.wisc.edu>, Sage Weil <sage@redhat.com>

On Thu, Apr 2, 2015 at 2:03 AM, Mel Gorman <mgorman@suse.de> wrote:
> On Wed, Apr 01, 2015 at 08:19:20PM +0300, Ilya Dryomov wrote:
>> Following nbd and iscsi, commit 89baaa570ab0 ("libceph: use memalloc
>> flags for net IO") set SOCK_MEMALLOC and PF_MEMALLOC flags for rbd and
>> cephfs.  However it turned out to not play nice with loopback scenario,
>> leading to lockups with a full socket send-q and empty recv-q.
>>
>> While we always advised against colocating kernel client and ceph
>> servers on the same box, a few people are doing it and it's also useful
>> for light development testing, so rather than reverting make sure to
>> not set those flags in the loopback case.
>>
>
> This does not clarify why the non-loopback case needs access to pfmemalloc
> reserves. Granted, I've spent zero time on this but it's really unclear
> what problem was originally tried to be solved and why dirty page limiting
> was insufficient. Swap over NFS was always a very special case minimally
> because it's immune to dirty page throttling.

I don't think there was any particular problem tried to be solved,
certainly not one we hit and fixed with 89baaa570ab0.  Mike is out this
week, but I'm pretty sure he said he copied this for iscsi from nbd
because you nudged him to (and you yourself did this for nbd as part of
swap-over-NFS series).  And then one day when I tracked down a lockup
caused by the fact that ceph workqueues didn't have a WQ_MEM_RECLAIM
tag he remembered his SOCK_MEMALLOC/PF_MEMALLOC iscsi patch and copied
it for rbd/cephfs.  As I mentioned in the previous thread [1], because
rbd is very similar to nbd, it seemed like a step in the right
direction...

We didn't get a clear answer from you in [1].  If this is the wrong
thing to do for network block devices then we should yank it
universally (nbd, iscsi, libceph).  If not, this patch simply tries to
keep ceph loopback scenario alive, for toy setups and development
testing, if nothing else.

[1] http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/23708

Thanks,

                Ilya

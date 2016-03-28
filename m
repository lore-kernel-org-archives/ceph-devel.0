From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Mon, 28 Mar 2016 10:12:51 +0800
Message-ID: <CAAM7YA=B1_3qD+dDOzuS4-0uQd=qN0Gqh66802ei47pEFHZG+g@mail.gmail.com>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com>
	<87fuvfw6g9.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36846 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbcC1CMx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Mar 2016 22:12:53 -0400
In-Reply-To: <87fuvfw6g9.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: NeilBrown <neilb@suse.com>
Cc: Sage Weil <sweil@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Mar 25, 2016 at 12:02 PM, NeilBrown <neilb@suse.com> wrote:
> On Sun, Mar 06 2016, Sage Weil wrote:
>
>> Hi Linus,
>>
>> Please pull the following Ceph patch from
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>>
>> This is a final commit we missed to align the protocol compatibility with
>> the feature bits.  It decodes a few extra fields in two different messages
>> and reports EIO when they are used (not yet supported).
>>
>> Thanks!
>> sage
>>
>>
>> ----------------------------------------------------------------
>> Yan, Zheng (1):
>>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
>
> Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
> exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
> CEPH_FEATURE_CRUSH_TUNABLES5)??
> Because when I backported this patch (and many others) to some ancient
> enterprise kernel, it caused mounts to fail.  If it really is meant to
> be the same value, then I must have some other backported issue to find
> and fix.

Yes, it's mean to be some value. For the mount failure, please make
sure the MDS is compiled from the newest ceph code.

Regards
Yan, Zheng

>
> Thanks,
> NeilBrown
>
>
>>
>>  fs/ceph/addr.c                     |  4 ++++
>>  fs/ceph/caps.c                     | 27 ++++++++++++++++++++++++---
>>  fs/ceph/inode.c                    |  2 ++
>>  fs/ceph/mds_client.c               | 16 ++++++++++++++++
>>  fs/ceph/mds_client.h               |  1 +
>>  fs/ceph/super.h                    |  1 +
>>  include/linux/ceph/ceph_features.h |  1 +
>>  7 files changed, 49 insertions(+), 3 deletions(-)

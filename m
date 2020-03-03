From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v3 0/6] ceph: don't request caps for idle open files
Date: Wed, 4 Mar 2020 00:23:48 +0800
Message-ID: <a226d5b6-2371-5c94-97ee-6bc5b273b21d@redhat.com>
References: <20200228115550.6904-1-zyan@redhat.com>
 <186bfc2278dbdd4eac21f6ce03108c53e3f574b3.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55055 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729508AbgCCQX7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2020 11:23:59 -0500
In-Reply-To: <186bfc2278dbdd4eac21f6ce03108c53e3f574b3.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Patrick Donnelly <pdonnell@redhat.com>

On 3/3/20 3:53 AM, Jeff Layton wrote:
> On Fri, 2020-02-28 at 19:55 +0800, Yan, Zheng wrote:
>> This series make cephfs client not request caps for open files that
>> idle for a long time. For the case that one active client and multiple
>> standby clients open the same file, this increase the possibility that
>> mds issues exclusive caps to the active client.
>>
>> Yan, Zheng (4):
>>    ceph: always renew caps if mds_wanted is insufficient
>>    ceph: consider inode's last read/write when calculating wanted caps
>>    ceph: simplify calling of ceph_get_fmode()
>>    ceph: remove delay check logic from ceph_check_caps()
>>
>>   fs/ceph/caps.c               | 324 +++++++++++++++--------------------
>>   fs/ceph/file.c               |  39 ++---
>>   fs/ceph/inode.c              |  19 +-
>>   fs/ceph/ioctl.c              |   2 +
>>   fs/ceph/mds_client.c         |   5 -
>>   fs/ceph/super.h              |  35 ++--
>>   include/linux/ceph/ceph_fs.h |   1 +
>>   7 files changed, 188 insertions(+), 237 deletions(-)
>>
>> changes since v2
>>   - make __ceph_caps_file_wanted more readable
>>   - add patch 5 and 6, which fix hung write during testing patch 1~4
>>
> 
> This patch series causes some serious slowdown in the async dirops
> patches that I've not yet fully tracked down, and I suspect that they
> may also be the culprit in these bugs:
> 

slow down which tests?

>      https://tracker.ceph.com/issues/44381

this is because I forgot to check if inode is snap when queue delayed 
check. But it can't explain slow down.

>      https://tracker.ceph.com/issues/44382
> 
> I'm going to drop this series from the testing branch for now, until we
> can track down the issue.
> 
> Thanks,
> 

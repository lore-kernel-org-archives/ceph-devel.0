From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v7 2/5] ceph: add caps perf metric for each session
Date: Fri, 21 Feb 2020 12:16:42 +0800
Message-ID: <ebe5e479-0da4-093a-adee-2b432ef2e109@redhat.com>
References: <20200219033851.6548-1-xiubli@redhat.com>
 <20200219033851.6548-3-xiubli@redhat.com>
 <b3837ae640e8ec3fa631b4b2a4d61adf15440ec2.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729782AbgBUEQ7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Feb 2020 23:16:59 -0500
In-Reply-To: <b3837ae640e8ec3fa631b4b2a4d61adf15440ec2.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/20 2:29, Jeff Layton wrote:
> On Tue, 2020-02-18 at 22:38 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will fulfill the cap hit/mis metric stuff per-superblock,
>> it will count the hit/mis counters based each inode, and if one
>> inode's 'issued & ~revoking == mask' will mean a hit, or a miss.
>>
>> item          total           miss            hit
>> -------------------------------------------------
>> caps          295             107             4119
>>
>> URL: https://tracker.ceph.com/issues/43215
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/acl.c        |  2 ++
>>   fs/ceph/caps.c       | 31 +++++++++++++++++++++++++++++++
>>   fs/ceph/debugfs.c    | 16 ++++++++++++++++
>>   fs/ceph/dir.c        |  9 +++++++--
>>   fs/ceph/file.c       |  2 ++
>>   fs/ceph/mds_client.c | 26 ++++++++++++++++++++++----
>>   fs/ceph/metric.h     |  3 +++
>>   fs/ceph/quota.c      |  9 +++++++--
>>   fs/ceph/super.h      |  9 +++++++++
>>   fs/ceph/xattr.c      | 17 ++++++++++++++---
>>   10 files changed, 113 insertions(+), 11 deletions(-)
>>
> Summary:
>
> I think counting this stuff is useful, but I'm not sure you're doing it
> in the right places below. Also, you're calling __ceph_caps_metric from
> many places where you already know whether it's a hit or miss. You could
> just bump the counter and do less work in those cases.
>
> More notes below:

Will fix them all.

Thanks
BRs
Xiubo

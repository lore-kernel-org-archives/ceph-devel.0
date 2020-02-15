From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v6 0/9] ceph: add perf metrics support
Date: Sat, 15 Feb 2020 08:39:43 +0800
Message-ID: <5729f4f1-caeb-84fb-4df3-dc623ee15ba3@redhat.com>
References: <20200210053407.37237-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44465 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbgBOAkA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2020 19:40:00 -0500
In-Reply-To: <20200210053407.37237-1-xiubli@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/10 13:33, xiubli@redhat.com wrote:
>
> Xiubo Li (9):
>    ceph: add global dentry lease metric support
>    ceph: add caps perf metric for each session
>    ceph: add global read latency metric support
>    ceph: add global write latency metric support
>    ceph: add global metadata perf metric support

Hi Jeff, Ilya

Currently the corresponding PR in the ceph is still not merged, so the 
following 4 patches we could ignore for now. And I will address the new 
comments and post them after that PR get merged.

The above 5 ones are only kclient concerned, if the above is okay could 
we split this series and test/merge them ?

Thanks

BRs

Xiubo


>    ceph: periodically send perf metrics to ceph
>    ceph: add CEPH_DEFINE_RW_FUNC helper support
>    ceph: add reset metrics support
>    ceph: send client provided metric flags in client metadata
>
>   fs/ceph/acl.c                   |   2 +
>   fs/ceph/addr.c                  |  13 ++
>   fs/ceph/caps.c                  |  29 +++
>   fs/ceph/debugfs.c               | 107 ++++++++-
>   fs/ceph/dir.c                   |  25 ++-
>   fs/ceph/file.c                  |  22 ++
>   fs/ceph/mds_client.c            | 381 +++++++++++++++++++++++++++++---
>   fs/ceph/mds_client.h            |   6 +
>   fs/ceph/metric.h                | 155 +++++++++++++
>   fs/ceph/quota.c                 |   9 +-
>   fs/ceph/super.c                 |   4 +
>   fs/ceph/super.h                 |  11 +
>   fs/ceph/xattr.c                 |  17 +-
>   include/linux/ceph/ceph_fs.h    |   1 +
>   include/linux/ceph/debugfs.h    |  14 ++
>   include/linux/ceph/osd_client.h |   1 +
>   net/ceph/osd_client.c           |   2 +
>   17 files changed, 759 insertions(+), 40 deletions(-)
>   create mode 100644 fs/ceph/metric.h
>

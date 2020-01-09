From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 0/6] ceph: asynchronous unlink support
Date: Thu, 9 Jan 2020 21:58:03 +0800
Message-ID: <85503b6d-4340-744d-395a-5eefc3a2914c@redhat.com>
References: <20200106153520.307523-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49863 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbgAIN6N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2020 08:58:13 -0500
In-Reply-To: <20200106153520.307523-1-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com

On 1/6/20 11:35 PM, Jeff Layton wrote:
> I sent an initial RFC set for this around 10 months ago. Since then,
> the requisite patches for the MDS have been merged for the octopus
> release. This adds support to the kclient to take advantage of
> asynchronous unlinks.
> 
> In earlier testing (with a vstart cluster backed by a rotating HDD), I
> saw roughly a 2x speedup when doing an rmdir on a directory with 10000
> files in it. When testing with a cluster backed by an NVMe SSD though,
> I only saw about a 20% speedup.
> 
> I'd like to put this in the testing branch now, so that it's ready for
> merge in the upcoming v5.6 merge window. Once this is in, asynchronous
> create support will be the next step.
> 
> Jeff Layton (4):
>    ceph: close holes in struct ceph_mds_session
>    ceph: hold extra reference to r_parent over life of request
>    ceph: register MDS request with dir inode from the start
>    ceph: add refcounting for Fx caps
> 
> Yan, Zheng (2):
>    ceph: check inode type for CEPH_CAP_FILE_{CACHE,RD,REXTEND,LAZYIO}
>    ceph: perform asynchronous unlink if we have sufficient caps
> 
>   fs/ceph/caps.c               | 84 ++++++++++++++++++++++++++----------
>   fs/ceph/dir.c                | 70 ++++++++++++++++++++++++++++--
>   fs/ceph/inode.c              |  9 +++-
>   fs/ceph/mds_client.c         | 27 ++++++------
>   fs/ceph/mds_client.h         |  2 +-
>   fs/ceph/super.c              |  4 ++
>   fs/ceph/super.h              | 17 +++-----
>   include/linux/ceph/ceph_fs.h |  9 ++++
>   8 files changed, 169 insertions(+), 53 deletions(-)
> 

Series Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

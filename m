From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v6 00/13] ceph: async directory operations support
Date: Tue, 3 Mar 2020 00:22:51 +0800
Message-ID: <544d98ca-6dc9-bcda-3f99-ff87f646265c@redhat.com>
References: <20200302141434.59825-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40797 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726831AbgCBQXD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2020 11:23:03 -0500
In-Reply-To: <20200302141434.59825-1-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, sage@redhat.com, pdonnell@redhat.com

On 3/2/20 10:14 PM, Jeff Layton wrote:
> v6: move handling of CEPH_I_ASYNC_CREATE from __send_cap into callers
>      also issue ceph_mdsc_release_dir_caps() in complete_request
>      properly handle -EJUKEBOX return in async callbacks
>      
> I previously pulled the async unlink patch from ceph-client/testing, so
> this set includes a revised version of that as well, and orders it
> some other changes.
> 
> The main change from v5 is to rework the callers of __send_cap to either
> skip sending or wait if the create reply hasn't come in yet.
> 
> We may not actually need patch #7 here. Zheng had that delta in one
> of the earlier patches, but I'm not sure it's really needed now. It
> may make sense to just take it on its own merits though.
> 
> Jeff Layton (12):
>    ceph: make kick_flushing_inode_caps non-static
>    ceph: add flag to designate that a request is asynchronous
>    ceph: track primary dentry link
>    ceph: add infrastructure for waiting for async create to complete
>    ceph: make __take_cap_refs non-static
>    ceph: cap tracking for async directory operations
>    ceph: perform asynchronous unlink if we have sufficient caps
>    ceph: make ceph_fill_inode non-static
>    ceph: decode interval_sets for delegated inos
>    ceph: add new MDS req field to hold delegated inode number
>    ceph: cache layout in parent dir on first sync create
>    ceph: attempt to do async create when possible
> 
> Yan, Zheng (1):
>    ceph: don't take refs to want mask unless we have all bits
> 
>   fs/ceph/caps.c               |  91 ++++++++----
>   fs/ceph/dir.c                | 111 ++++++++++++++-
>   fs/ceph/file.c               | 269 +++++++++++++++++++++++++++++++++--
>   fs/ceph/inode.c              |  58 ++++----
>   fs/ceph/mds_client.c         | 196 ++++++++++++++++++++++---
>   fs/ceph/mds_client.h         |  24 +++-
>   fs/ceph/super.c              |  20 +++
>   fs/ceph/super.h              |  23 ++-
>   include/linux/ceph/ceph_fs.h |  17 ++-
>   9 files changed, 724 insertions(+), 85 deletions(-)
> 


series

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

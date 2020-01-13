From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [RFC PATCH 0/9] ceph: add asynchronous create functionality
Date: Mon, 13 Jan 2020 19:07:19 +0800
Message-ID: <f3d6ac41-73d5-2990-feff-85365cd3700d@redhat.com>
References: <20200110205647.311023-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33794 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgAMLHc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:07:32 -0500
In-Reply-To: <20200110205647.311023-1-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com

On 1/11/20 4:56 AM, Jeff Layton wrote:
> I recently sent a patchset that allows the client to do an asynchronous
> UNLINK call to the MDS when it has the appropriate caps and dentry info.
> This set adds the corresponding functionality for creates.
> 
> When the client has the appropriate caps on the parent directory and
> dentry information, and a delegated inode number, it can satisfy a
> request locally without contacting the server. This allows the kernel
> client to return very quickly from an O_CREAT open, so it can get on
> with doing other things.
> 
> These numbers are based on my personal test rig, which is a KVM client
> vs a vstart cluster running on my workstation (nothing scientific here).
> 
> A simple benchmark (with the cephfs mounted at /mnt/cephfs):
> -------------------8<-------------------
> #!/bin/sh
> 
> TESTDIR=/mnt/cephfs/test-dirops.$$
> 
> mkdir $TESTDIR
> stat $TESTDIR
> echo "Creating files in $TESTDIR"
> time for i in `seq 1 10000`; do
>      echo "foobarbaz" > $TESTDIR/$i
> done
> -------------------8<-------------------
> 
> With async dirops disabled:
> 
> real	0m9.865s
> user	0m0.353s
> sys	0m0.888s
> 
> With async dirops enabled:
> 
> real	0m5.272s
> user	0m0.104s
> sys	0m0.454s
> 
> That workload is a bit synthetic though. One workload we're interested
> in improving is untar. Untarring a deep directory tree (random kernel
> tarball I had laying around):
> 
> Disabled:
> $ time tar xf ~/linux-4.18.0-153.el8.jlayton.006.tar
> 
> real	1m35.774s
> user	0m0.835s
> sys	0m7.410s
> 
> Enabled:
> $ time tar xf ~/linux-4.18.0-153.el8.jlayton.006.tar
> 
> real	1m32.182s
> user	0m0.783s
> sys	0m6.830s
> 
> Not a huge win there. I suspect at this point that synchronous mkdir
> may be serializing behind the async creates.
> 
> It needs a lot more performance tuning and analysis, but it's now at the
> point where it's basically usable. To enable it, turn on the
> ceph.enable_async_dirops module option.
> 
> There are some places that need further work:
> 
> 1) The MDS patchset to delegate inodes to the client is not yet merged:
> 
>      https://github.com/ceph/ceph/pull/31817
> 
> 2) this is 64-bit arch only for the moment. I'm using an xarray to track
> the delegated inode numbers, and those don't do 64-bit indexes on
> 32-bit machines. Is anyone using 32-bit ceph clients? We could probably
> build an xarray of xarrays if needed.
> 
> 3) The error handling is still pretty lame. If the create fails, it'll
> set a writeback error on the parent dir and the inode itself, but the
> client could end up writing a bunch before it notices, if it even
> bothers to check. We probably need to do better here. I'm open to
> suggestions on this bit especially.
> 
> Jeff Layton (9):
>    ceph: ensure we have a new cap before continuing in fill_inode
>    ceph: print name of xattr being set in set/getxattr dout message
>    ceph: close some holes in struct ceph_mds_request
>    ceph: make ceph_fill_inode non-static
>    libceph: export ceph_file_layout_is_valid
>    ceph: decode interval_sets for delegated inos
>    ceph: add flag to delegate an inode number for async create
>    ceph: copy layout, max_size and truncate_size on successful sync
>      create
>    ceph: attempt to do async create when possible
> 
>   fs/ceph/caps.c               |  31 +++++-
>   fs/ceph/file.c               | 202 +++++++++++++++++++++++++++++++++--
>   fs/ceph/inode.c              |  57 +++++-----
>   fs/ceph/mds_client.c         | 130 ++++++++++++++++++++--
>   fs/ceph/mds_client.h         |  12 ++-
>   fs/ceph/super.h              |  10 ++
>   fs/ceph/xattr.c              |   5 +-
>   include/linux/ceph/ceph_fs.h |   8 +-
>   net/ceph/ceph_fs.c           |   1 +
>   9 files changed, 396 insertions(+), 60 deletions(-)
> 

client should wait for reply of aysnc create, before sending cap message 
or request (which operates on the creating inode) to mds


see commit "client: wait for async creating before sending request or 
cap message" in https://github.com/ceph/ceph/pull/32576

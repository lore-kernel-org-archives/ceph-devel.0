From: Gregory Farnum <greg@inktank.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Wed, 9 Apr 2014 07:15:14 -0700
Message-ID: <CAPYLRzixgjpxnwjGh5x5sXNN=+1Q9zf_LEa3u9O2xBxkeFgWkw@mail.gmail.com>
References: <CACJqLyb+D5n74OyjP4sRG2=G083GQ3BzEUt4i8iAdw6nEBfRJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:46885 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbaDIOPP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Apr 2014 10:15:15 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2722317qcx.41
        for <ceph-devel@vger.kernel.org>; Wed, 09 Apr 2014 07:15:14 -0700 (PDT)
In-Reply-To: <CACJqLyb+D5n74OyjP4sRG2=G083GQ3BzEUt4i8iAdw6nEBfRJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Apr 9, 2014 at 3:05 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Hi all,
>
> I would like to share some ideas about how to improve performance on
> ceph with SSD. Not much preciseness.
>
> Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).
> ceph version is 0.67.5(Dumping)
>
> At first, we find three bottleneck on filestore:
> 1. fdcache_lock(changed in Firely release)
> 2. lfn_find in omap_* methods
> 3. DBObjectMap header
>
> According to my understanding and the docs in
> ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/ObjectStore.h),
> I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully
> sure the correctness of this change, but it works well still now.

"Simply remove"? I don't remember all the details, but I'm sure
there's more to it than that if you want things to behave.

> DBObjectMap header patch is on the pull request queue and may be
> merged in the next feature merge window.
>
> With things above done, we get much performance improvement in disk
> util and benchmark results(3x-4x).
>
> Next, we find fdcache size become the main bottleneck. For example, if
> hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If hot
> data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With
> increase "filestore_fd_cache_size", the cost of lookup(FDCache) and
> cache miss is expensive and can't be afford. The implementation of
> FDCache isn't O(1). So we only can get high performance on fdcache hit
> range(maybe 100GB with 10240 fdcache size) and more data exceed the
> size of fdcaceh will be disaster. If you want to cache more fd(102400
> fdcache size), the implementation of FDCache will bring on extra CPU
> cost(can't be ignore) for each op.

From explorations we and others have done, I think what we really want
to do here is make it cheaper to lookup and open files. The FileStore
is very much not optimized for this; a single lookup involves
constructing the path from its components multiple times and I think
even does the lookups more than once.
Also, 250k or even 25k file descriptors is an awful lot to demand. ;)

-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

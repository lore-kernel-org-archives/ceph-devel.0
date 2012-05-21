From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: v0.47 released
Date: Mon, 21 May 2012 00:37:10 -0700
Message-ID: <4FB9F0A6.7040808@inktank.com>
References: <Pine.LNX.4.64.1205202137430.843@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47231 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2EUHhN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 03:37:13 -0400
Received: by pbbrp8 with SMTP id rp8so6579042pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 00:37:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205202137430.843@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/20/2012 09:38 PM, Sage Weil wrote:
> It's been another three weeks and v0.47 is ready.  The highlights include:
>
>   * librbd: write-thru cache mode

Some more detail on rbd caching:

By default librbd does no caching - writes and reads go directly to the
storage cluster, and writes return only when the data is on disk on all
replicas.

With caching enabled, writes return immediately, unless there are more
than rbd_cache_max_dirty unflushed bytes. In this case, the write
triggers writeback and blocks until enough bytes are flushed.

To enable writethrough mode, set rbd_cache_max_dirty to 0. This means
writes return only when the data is on disk on all replicas, but reads
may come from the cache.

The cache is in memory on the client, and each rbd image has its own.
Since it's local to the client, and there's no coherency if there are
others accessing the image, running something like GFS or OCFS on top
of rbd would not work with caching enabled.

The options for controlling the cache are:

option                 | type      | default | description
-----------------------+-----------+---------+------------
rbd_cache              | bool      | false   | whether caching is enabled
rbd_cache_size         | long long | 32 MiB  | total cache size in bytes
rbd_cache_max_dirty    | long long | 24 MiB  | maximum number of dirty 
bytes before triggering writeback
rbd_cache_target_dirty | long long | 16 MiB  | writeback starts at this 
threshold, but does not block the write
rbd_cache_max_age      | float     | 1.0     | seconds in cache before 
writeback starts

The cache code was written for ceph-fuse a few years ago, so it's been
in use for a while now. It was just tweaked a bit to allow librbd
to use it. The rbd_cache_* options have the same meanings as the
client_oc_* options for ceph-fuse.

>   * librbd: improved error handling

To clarify, these were fixes for error handling in the caching module
used by ceph-fuse and librbd, and does not matter if you aren't using
ceph-fuse or rbd caching. It made write errors be returned to the
caller when the cache is flushed, and exposed read errors to the client
as well.

0.47 also includes a fix for a deadlock that was more likely to 
triggered with rbd caching enabled. I don't know of any outstanding 
issues with rbd caching since that was fixed.

Josh

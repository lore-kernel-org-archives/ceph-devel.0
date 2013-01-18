From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: tgt backend driver for Ceph block devices (rbd)
Date: Sat, 19 Jan 2013 01:29:42 +0900 (JST)
Message-ID: <20130119.012942.1305564732068186811.fujita.tomonori@lab.ntt.co.jp>
References: <50F76632.4040404@inktank.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:39282 "EHLO
	tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3ARQ3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 11:29:55 -0500
In-Reply-To: <50F76632.4040404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dan.mick@inktank.com
Cc: stgt@vger.kernel.org, ceph-devel@vger.kernel.org

On Wed, 16 Jan 2013 18:47:14 -0800
Dan Mick <dan.mick@inktank.com> wrote:

> Hi, all.  I recently hacked at bs_rdwr and made it work as a
> proof-of-concept driver allowing tgt to be backed by the Ceph[1]
> storage cluster's RADOS block device (rbd)[2].  I thought I'd share
> the results of my investigations, as it's useful even in its current
> form:

Sounds interesting. If you send a patch, I'm happy to review and merge
it.

> http://github.com/dmick/tgt, forked from http://github.com/fujita/tgt
> branch bs_rbd (https://github.com/dmick/tgt/tree/bs_rbd)
> 
> This is a simple transliteration of bs_rdwr to use librbd/librados
> calls instead of normal file I/O calls (so might be instructive to
> diff bs_rbd.c against bs_rdwr.c to see what was involved).  It
> currently uses only the synchronous librbd interfaces, so each tgtd
> worker thread will block for completion of each request.  See the

That's fine. I/O worker threads are supposed to handle such
synchronous API (bs_rwdr.c use read/write system calls with O_SYNC).

If rdb provides the async API and it's preferable, then you don't need
to use I/O worker threads like bs_aio.c


> I was quite impressed at how easy this was, and how well-organized the
> stgt source is.  Kudos to the developers and maintainers!

Thanks ;)

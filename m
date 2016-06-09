From: Sage Weil <sweil@redhat.com>
Subject: Re: Current Progress of librados rocksdb backend (06/06/2016)
Date: Thu, 9 Jun 2016 11:00:47 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606091026440.23732@cpach.fuggernut.com>
References: <CAGC6CocQHiK_-88=YDbRb=uSSqCaNpuRTcULRR8zL2T-EO3n+w@mail.gmail.com> <alpine.DEB.2.11.1606061613590.6221@cpach.fuggernut.com> <CAGC6Coe-DWjdQUcba1W4d1AdR7L7EkoamQLP496=u9S_F=517g@mail.gmail.com> <alpine.DEB.2.11.1606061631360.6221@cpach.fuggernut.com>
 <CAGC6Cod84CFTEtLuww7EYSPK4zkp912D+8iU8-xwxr492ZHM0Q@mail.gmail.com> <alpine.DEB.2.11.1606070834340.6221@cpach.fuggernut.com> <CAGC6Cod-XJ04K9j5CnsDAJ7PwWuGOVhw-W+WToEFkw5_bo2MNg@mail.gmail.com>
 <CAGC6Coe-RVBh7nq+f_AxDFBD6ECWM7=hkSN6+4F67WZ5gnEw3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-352937784-1465484450=:23732"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbcFIPAV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jun 2016 11:00:21 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB703155BA
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2016 15:00:20 +0000 (UTC)
In-Reply-To: <CAGC6Coe-RVBh7nq+f_AxDFBD6ECWM7=hkSN6+4F67WZ5gnEw3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryne Li <rli@redhat.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-352937784-1465484450=:23732
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Many comments on your PR.  It looks like it's in a pretty reasonble state 
for doing some testing.  Are you able to run rocksdb on top of it yet, or 
are you just running the unit tests?

Please rebase on current ceph/rocksdb master, e.g.

 git remote add cephrocksdb git@github.com:ceph/rocksdb
 git fetch cephrocksdb
 git rebase HEAD^^ --onto cephrocksdb/master

sage



On Wed, 8 Jun 2016, Ryne Li wrote:

> Hi Sage,
> Thank you so much for your advises, especially the IO_CTX pointer one. It is
> really helpful. I have revised my code according to your comments.
> Generally, I finished all your comments except distinguishing Flush() and
> Sync(). Main changes list as follow,
> 
>   - change copy of IO_CTX in file handler object to IO_CTX pointer
>   - remove xattr functions
>   - change split function to adapt RocksDB's 2-level structure (dir/file)
>   - add buffer to writable file handler
>   - correct Makefile
> 
> By the way, I accidentally forcibly push my modification. So the diff
> between current version and last version can't reflect my latest
> modification. Sorry for the inconvenience.
> 
> Following is the link to latest version of my code:
> 
>   https://github.com/ryneli/rocksdb/blob/master/utilities/env_librados.cc
> 
> Yours,
> 
> Ryne
> 
> On Tue, Jun 7, 2016 at 9:19 AM, Ryne Li <rli@redhat.com> wrote:
>       Hi Sage,
> Thank you for your comments and advises. It is really helpful. I will
> revise my code according to your comments.
> 
> I didn't find omap api at the beginning. So I used these xattr api
> instead. I will remove these functions later.
> 
> Useless Makefile changes may be caused my careless commit. Sorry about
> that.
> 
> Yours,
> 
> Ryne
> 
> On Tue, Jun 7, 2016 at 8:57 AM, Sage Weil <sweil@redhat.com> wrote:
>       [Copying ceph-devel so that interest parties can take a
>       look]
> 
>       On Tue, 7 Jun 2016, Ryne Li wrote:
>       > Hi Sage,
>       > Most code is in following file,
>       >
>       >  
>         https://github.com/ryneli/rocksdb/blob/master/utilities/env_librados.cc
>       >
>       > Test code is in file,
>       >
>       >   https://github.com/ryneli/rocksdb/blob/master/utilities/env_librados_tes
>       t
>       > .cc
> 
>       This is great!  I opened a PR against our rocksdb repo
>       just so I could
>       comment on the code:
> 
>               https://github.com/ceph/rocksdb/pull/8
> 
>       I made a bunch of comments.  This looks like a great
>       start!
> 
>       My main question is what the purpose of the xattr
>       functions is.  I don't
>       see any callers, and I think an omap object for the
>       directory mapping
>       should be sufficient.
> 
>       It looks like there are a bunch of Makefile changes in
>       that commit that
>       probably don't need to be included?
> 
>       sage
> 
> 
> 
> 
> 
--8323329-352937784-1465484450=:23732--

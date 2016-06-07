From: Sage Weil <sweil@redhat.com>
Subject: Re: Current Progress of librados rocksdb backend (06/06/2016)
Date: Tue, 7 Jun 2016 08:57:03 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606070834340.6221@cpach.fuggernut.com>
References: <CAGC6CocQHiK_-88=YDbRb=uSSqCaNpuRTcULRR8zL2T-EO3n+w@mail.gmail.com> <alpine.DEB.2.11.1606061613590.6221@cpach.fuggernut.com> <CAGC6Coe-DWjdQUcba1W4d1AdR7L7EkoamQLP496=u9S_F=517g@mail.gmail.com> <alpine.DEB.2.11.1606061631360.6221@cpach.fuggernut.com>
 <CAGC6Cod84CFTEtLuww7EYSPK4zkp912D+8iU8-xwxr492ZHM0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1969970302-1465304225=:6221"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60583 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983AbcFGM4h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jun 2016 08:56:37 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 535EC85541
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jun 2016 12:56:37 +0000 (UTC)
In-Reply-To: <CAGC6Cod84CFTEtLuww7EYSPK4zkp912D+8iU8-xwxr492ZHM0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryne Li <rli@redhat.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1969970302-1465304225=:6221
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

[Copying ceph-devel so that interest parties can take a look]

On Tue, 7 Jun 2016, Ryne Li wrote:
> Hi Sage,
> Most code is in following file,
> 
>     https://github.com/ryneli/rocksdb/blob/master/utilities/env_librados.cc
> 
> Test code is in file,
> 
>    https://github.com/ryneli/rocksdb/blob/master/utilities/env_librados_test
> .cc

This is great!  I opened a PR against our rocksdb repo just so I could 
comment on the code:

	https://github.com/ceph/rocksdb/pull/8

I made a bunch of comments.  This looks like a great start!

My main question is what the purpose of the xattr functions is.  I don't 
see any callers, and I think an omap object for the directory mapping 
should be sufficient.

It looks like there are a bunch of Makefile changes in that commit that 
probably don't need to be included?

sage
--8323329-1969970302-1465304225=:6221--

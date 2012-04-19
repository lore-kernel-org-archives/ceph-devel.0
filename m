From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Question about IoCtx::aio_exec semantics
Date: Thu, 19 Apr 2012 12:04:12 -0700
Message-ID: <1CD68FE4-74EB-4599-B7F8-309C0DD92D34@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44152 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab2DSTEM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 15:04:12 -0400
Received: from [192.168.50.124] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 641DC1009B90
	for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 12:04:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've had a lot of success using rados_exec(), but I need to graduate the implementation to use IoCtx::aio_exec for increased concurrency. I'm a little confused about how aio_exec should be used:

Here is aio_exec:

   int aio_exec(const std::string& oid, AioCompletion *c, const char *cls, const char *method, bufferlist& inbl, bufferlist *outbl);

I'd like to have many outstanding competitions, one for each call of aio_exec. Once @c has completed, I'd like to have access to the @outbl bufferlist. So, is the intended use here to allocate an empty bufferlist for each submitted completion?

In rgw/rgw_rados.cc a use is:

  AioCompletion *c = librados::Rados::aio_create_completion(NULL, NULL, NULL);                                                                                                                                                                                        
  r = io_ctx.aio_exec(oid, c, "rgw", "dir_suggest_changes", in, NULL);                                                                                                                                                                                                
  c->release();

To clarify, are the semantics here that an asynchronous aio_exec is made without checking for completion or return values.

Thanks,
Noah
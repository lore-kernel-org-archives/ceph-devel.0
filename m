From: Sage Weil <sweil@redhat.com>
Subject: client-facing feature bits and pending kernel changes
Date: Fri, 29 Jan 2016 11:09:04 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbcA2QIv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jan 2016 11:08:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 96D5149DB7
	for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 16:08:51 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, ceph-devel@vger.kernel.org

Hi Zheng,

We have one feature already merged to ceph.git, CRUSH_TUNABLES5, that's a 
pretty trivial change to crush/mapper.c that we can add to the kernel.

But there are two more coming:

OSDOPREPLY_ENCODING makes a small change to the OSDOpReply encoding for 
performance reasons.  Here is the PR

	https://github.com/ceph/ceph/pull/7386

The other is the file layout changes, which are much more invovled:

	https://github.com/ceph/ceph/pull/7098

Ideally we'd use the same feature bit for all of these, but it means they 
all need to upstream into Linux together.  Do you see a problem with that?
Assuming we get it all ready to go before the next merge window..

The tricky bit is we really need to know that we'll be able to do it 
together before we cut jewel too and commit to the overlapping feature 
bits.

sage

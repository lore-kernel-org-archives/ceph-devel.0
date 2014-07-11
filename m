From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: v0.80.2?
Date: Fri, 11 Jul 2014 20:39:19 +0200
Message-ID: <CAF6-1L6bYp9EUidFnKZDwh1Qsf6wRrRpyL4gm7nP7aHS+VHEng@mail.gmail.com>
References: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53310 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164AbaGKSjU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 14:39:20 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so1903664pac.19
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jul 2014 11:39:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> We built v0.80.2 yesterday and pushed it out to the repos, but quickly
> discovered a regression in radosgw that preventing reading objects written
> with earlier versions.  We pulled the packages, fixed the bug, and are
> rerunning tests to confirm the fix and ensure there aren't other
> upgrade-related issues.  We expect to have a v0.80.3 ready tomorrow or
> Monday.


I see that you reverted 5fd8b0d1639c67e355f0fc0d7e6d7036618d87a1. in
0.80.2. But without this patch, I can't initiate multipart upload ...
I reported this in http://tracker.ceph.com/issues/8517  My fix was a
bit different but should be equivalent to the one that was merged in.

Who reported the issue with this patch ?


Cheers,

   Sylvain

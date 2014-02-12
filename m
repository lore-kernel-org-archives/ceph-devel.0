From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: ACL tests
Date: Wed, 12 Feb 2014 12:03:52 +0800
Message-ID: <20140212040352.GA5659@x230>
References: <alpine.DEB.2.00.1401301616370.11959@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:59719 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbaBLEEA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 23:04:00 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so8454396pdj.39
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 20:04:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1401301616370.11959@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: li.wang@ubuntukylin.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org

On Thu, Jan 30, 2014 at 04:20:46PM -0800, Sage Weil wrote:

Hi Sage,

Sorry for the late reply, I just returned from a long vacation :-)

I have found some issues which maybe relate the bugs you mentioned, and
the patches are coming soon. 

> Hi Guangliang,
> 
> There were a few hiccups getting the ACL support into Linus's tree, but 
> it's in now, and it appears to work.  However, I tried out the tuxera 
> posix test suite at
> 
>  http://www.tuxera.com/community/posix-test-suite/
>  http://tuxera.com/sw/qa/pjd-fstest-20090130-RC.tgz
> 
> which has a set of acl tests, and several of them fail.  I would like to 
> get the tests to all pass and get them added to the night QA so that we 
> won't be chasing down (as many) strange user reports of permission errors 
> down the line.  Are you able to take a look?

OK, I would investigate it ASAP.

> 
> Thanks!
> sage

-- 
Best regards,
Guangliang

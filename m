From: Guang Yang <yguang11@outlook.com>
Subject: Re: v0.80.2?
Date: Fri, 11 Jul 2014 10:24:40 +0800
Message-ID: <BLU436-SMTP184DB798AACE357076BACE3DF090@phx.gbl>
References: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s17.hotmail.com ([65.55.111.156]:50419 "EHLO
	BLU004-OMC4S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689AbaGKCYt convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Jul 2014 22:24:49 -0400
In-Reply-To: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Is it possible to include a fix for this bug - http://tracker.ceph.com/issues/8733 considering the scope of the change and regression risk for the next release? We are finalizing our production launch version and this one is a blocker as we use EC pool.

Thanks,
Guang

On Jul 11, 2014, at 7:31 AM, Sage Weil <sweil@redhat.com> wrote:

> We built v0.80.2 yesterday and pushed it out to the repos, but quickly 
> discovered a regression in radosgw that preventing reading objects written 
> with earlier versions.  We pulled the packages, fixed the bug, and are 
> rerunning tests to confirm the fix and ensure there aren't other 
> upgrade-related issues.  We expect to have a v0.80.3 ready tomorrow or 
> Monday.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


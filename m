From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH 3/3 v3] rbd: add discard support for rbd
Date: Thu, 10 Apr 2014 11:32:20 +0800
Message-ID: <20140410033220.GA17486@work-station>
References: <1396362136-8722-1-git-send-email-lucienchao@gmail.com>
 <1396362136-8722-2-git-send-email-lucienchao@gmail.com>
 <53446EC3.8000509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64184 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222AbaDJDd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Apr 2014 23:33:59 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so3320136pde.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Apr 2014 20:33:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53446EC3.8000509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, elder@ieee.org

On Tue, Apr 08, 2014 at 02:48:51PM -0700, Josh Durgin wrote:
> On 04/01/2014 07:22 AM, Guangliang Zhao wrote:
> >This patch add the discard support for rbd driver.
> >
> >There are three types operation in the driver:
> >1. The objects would be removed if they completely contained
> >    within the discard range.
> >2. The objects would be truncated if they partly contained within
> >    the discard range, and align with their boundary.
> >3. Others would be zeroed.
> >
> >A discard request from blkdev_issue_discard() is defined which
> >REQ_WRITE and REQ_DISCARD both marked and no data, so we must
> >check the REQ_DISCARD first when getting the request type.
> >
> >This resolve:
> >	http://tracker.ceph.com/issues/190
> >
> >Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> >---
> 
> Thanks for fixing these up! I've added them to the wip-discard branch
> in ceph-client.git, which I'll post for review shortly.
> 
> Josh
> 

Thanks.

-- 
Best regards,
Guangliang

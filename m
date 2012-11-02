From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: ceph-fuse on os x
Date: Fri, 2 Nov 2012 16:35:31 +0000
Message-ID: <69920515-C310-44EB-8891-5AE452D2FA83@tchpc.tcd.ie>
References: <sfid-H20121030-161342-+023.00-1@marduk.tchpc.tcd.ie> <alpine.DEB.2.00.1210300912250.13553@cobra.newdream.net>  (sfid-H20121030-161342-+023.00-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:54858 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759725Ab2KBQfe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 12:35:34 -0400
In-Reply-To: <alpine.DEB.2.00.1210300912250.13553@cobra.newdream.net>  (sfid-H20121030-161342-+023.00-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


On 30 Oct 2012, at 16:13, Sage Weil wrote:

> It is probably a relatively straighforward porting job (fixing up 
> #includes, etc.) to get ceph-fuse working under OS X with macfuse or 
> osxfuse or whatever the latest and greatest is.
> 
> Any Mac users out there interested?
> 

I would be interested both the client and server side being ported, I started looking at the dependancies needed but I can't dedicate much time to it myself. Just from a workflow point of view for some use cases having a native OSX client or a fuse client on OSX would be nice.

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie


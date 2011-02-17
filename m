From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH] rgw: Lighttpd compatibity.
Date: Thu, 17 Feb 2011 11:38:39 -0800
Message-ID: <20110217193839.GB23974@dreamer>
References: <AANLkTikEd8UUyy3ncf2DiDqR1Aa0UNDy3AVVGnVSyCxK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47270 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab1BQTil (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 14:38:41 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikEd8UUyy3ncf2DiDqR1Aa0UNDy3AVVGnVSyCxK@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cclien <cclien@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 17, 2011 at 07:20:02PM +0800, cclien wrote:
> Hi all
> 
> I just tried to deploy a rados gateway with Lighttpd.
> But it have some trouble parsing object names.
> 
> Here's what I found in debug log on the non-working copy:
>     RADOS S3 Gateway: SCRIPT_NAME=/mybucket
>     RADOS S3 Gateway: REQUEST_URI=/mybucket/ceph.tgz
> 
> I think it will be better to retrive user's request from REQUEST_URI.

I haven't looked into rgw deeply, but if this is about the contents of
SCRIPT_NAME vs PATH_INFO, it might be related to lighttpd's behavior
differing from apache's. I stumbled on this when running fastcgis
under lighttpd 4 years ago:

http://redmine.lighttpd.net/issues/show/729

-- 
:(){ :|:&};:

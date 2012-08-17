From: Gregory Farnum <greg@inktank.com>
Subject: Re: How to write data to rados pool.
Date: Thu, 16 Aug 2012 23:12:47 -0700
Message-ID: <6F69B412D76D49808942F99B99B96ACB@inktank.com>
References: <loom.20120817T075847-947@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48279 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab2HQGMt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 02:12:49 -0400
Received: by pbbrr13 with SMTP id rr13so2815003pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 23:12:49 -0700 (PDT)
In-Reply-To: <loom.20120817T075847-947@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thursday, August 16, 2012 at 11:00 PM, ramu wrote:
> Hi all,
> 
> I want to write or insert text file to rados pool,please help me to how to 
> write or insert to rados pool.

Depending on what you're after, you'll want to explore using librados (for programmatic access) or the rados tool binary, which gives you command-line access to objects.
Of course, if you want a filesystem or a block device, you'll want to check out setting up the full distributed filesystem (http://ceph.com/docs/master/cephfs/) or using RBD (http://ceph.com/docs/master/rbd/rbd/).
-Greg


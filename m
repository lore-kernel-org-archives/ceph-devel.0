From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [ceph] locking fun with d_materialise_unique()
Date: Wed, 30 Jan 2013 14:42:14 +0000
Message-ID: <20130130144214.GJ4503@ZenIV.linux.org.uk>
References: <20130129045213.GH4503@ZenIV.linux.org.uk>
 <alpine.DEB.2.00.1301282115060.16431@cobra.newdream.net>
 <20130129080036.GI4503@ZenIV.linux.org.uk>
 <alpine.DEB.2.00.1301291301260.6657@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49244 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab3A3OmQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 09:42:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301291301260.6657@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org

On Tue, Jan 29, 2013 at 01:03:23PM -0800, Sage Weil wrote:

> We should drop teh mds_client.c hunk from your patch, and then do 
> something like the below.  I'll put it in the ceph tree so we can do some 
> basic testing.  Unfortunately, the abort case is a bit annoying to 
> trigger.. we'll need to write a new test for it.

hunk dropped, the rest folded into your patch, resulting branch pushed...

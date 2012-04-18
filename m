From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: ceph: move encode_fh to new API
Date: Thu, 19 Apr 2012 00:02:44 +0100
Message-ID: <20120418230244.GI6589@ZenIV.linux.org.uk>
References: <20120418094028.GA6866@elgon.mountain>
 <Pine.LNX.4.64.1204181035450.15730@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44065 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2DRXCs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 19:02:48 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1204181035450.15730@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 10:39:08AM -0700, Sage Weil wrote:
> On Wed, 18 Apr 2012, Dan Carpenter wrote:
> > Hello Sage Weil,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch f59919a07e03: "ceph: move encode_fh to new API" from Apr 5, 
> > 2012, leads to the following Smatch complaint:
> > 
> > fs/ceph/export.c:85 ceph_encode_fh()
> > 	 error: we previously assumed 'dentry' could be null (see line 67)
> 
> Thanks, Dan!  This caught a minor bug.
> 
> Al, can you update f59919a07e0335358d9470289cf46ffb83b7d2f9 in your 
> for-next with the following?

Folded and pushed...

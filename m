From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: use fscache as a local presisent cache
Date: Wed, 9 Mar 2016 11:54:52 +0300
Message-ID: <20160309085452.GA4085@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43932 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcCIIzI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 03:55:08 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: milosz@adfin.com
Cc: ceph-devel@vger.kernel.org

[ Hm...  I don't know why this has suddenly started warning now only.
  This check doesn't warn if it knows that the NULL check is not
  needed so potentially that was what prevented the warning before?
  -dan ]

Hello Milosz Tanski,

This is a semi-automatic email about new static checker warnings.

The patch 99ccbd229cf7: "ceph: use fscache as a local presisent
cache" from Aug 21, 2013, leads to the following Smatch complaint:

fs/ceph/addr.c:183 ceph_releasepage()
	 error: we previously assumed 'page->mapping' could be null (see line 178)

fs/ceph/addr.c
   177	{
   178		struct inode *inode = page->mapping ? page->mapping->host : NULL;
                                      ^^^^^^^^^^^^^
Check for NULL.

   179		dout("%p releasepage %p idx %lu\n", inode, page, page->index);
   180		WARN_ON(PageDirty(page));
   181	
   182		/* Can we release the page from the cache? */
   183		if (!ceph_release_fscache_page(page, g))
                                               ^^^^
The patch adds a dereference inside the function call.

   184			return 0;
   185	

regards,
dan carpenter

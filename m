From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/2] ceph: virtual xattr handling
Date: Thu, 21 Jul 2016 21:41:21 -0700
Message-ID: <20160722044121.GA7944@infradead.org>
References: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
 <1469103450-5255-1-git-send-email-vshankar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41084 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcGVElW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2016 00:41:22 -0400
Content-Disposition: inline
In-Reply-To: <1469103450-5255-1-git-send-email-vshankar@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Venky Shankar <vshankar@redhat.com>
Cc: ceph-devel@vger.kernel.org, zyan@redhat.com

On Thu, Jul 21, 2016 at 05:47:28PM +0530, Venky Shankar wrote:
> v2: vxattrs 'hidden' attribute defaults to false
> 
> Venky Shankar (2):
>   ceph: introduce 'ceph.all' virtual xattr
>   ceph: do not return virtual xattrs in listxattr()

NAK.  No new magic namespaces outside the documented systems ones,
please.  And especially no 'magic' attributes in 'magic' namespaces.


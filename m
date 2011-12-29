From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] ceph: take inode lock when finding an inode alias
Date: Thu, 29 Dec 2011 04:10:20 -0500
Message-ID: <20111229091020.GA5257@infradead.org>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
 <1325124315-3487-2-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:37312
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751829Ab1L2JKW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Dec 2011 04:10:22 -0500
Content-Disposition: inline
In-Reply-To: <1325124315-3487-2-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@dreamhost.com>

On Wed, Dec 28, 2011 at 06:05:13PM -0800, Sage Weil wrote:
> +/* The following code copied from "fs/dcache.c" */
> +static struct dentry * d_find_any_alias(struct inode *inode)
> +{
> +	struct dentry *de;
> +
> +	spin_lock(&inode->i_lock);
> +	de = __d_find_any_alias(inode);
> +	spin_unlock(&inode->i_lock);
> +	return de;
> +}
> +/* End of code copied from "fs/dcache.c" */

I would be much happier about just exporting d_find_any_alias.


From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] vfs: export symbol d_find_any_alias()
Date: Wed, 11 Jan 2012 13:55:57 -0500
Message-ID: <20120111185557.GA29582@infradead.org>
References: <1326307602-16284-1-git-send-email-sage@newdream.net>
 <1326307602-16284-2-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:40691
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932324Ab2AKSz7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Jan 2012 13:55:59 -0500
Content-Disposition: inline
In-Reply-To: <1326307602-16284-2-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: viro@ZenIV.linux.org.uk, hch@infradead.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2012 at 10:46:41AM -0800, Sage Weil wrote:
> Ceph needs this.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>

Can you add a kerneldoc comment now that it is exported?

> -static struct dentry * d_find_any_alias(struct inode *inode)
> +struct dentry * d_find_any_alias(struct inode *inode)

also if you touch the line anyway please remove the superflous
whitespace after the '*'.


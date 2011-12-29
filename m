From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] ceph: enable/disable dentry complete flags via mount
 option
Date: Thu, 29 Dec 2011 04:11:36 -0500
Message-ID: <20111229091136.GC5257@infradead.org>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
 <1325124315-3487-4-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:37319
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751829Ab1L2JLh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Dec 2011 04:11:37 -0500
Content-Disposition: inline
In-Reply-To: <1325124315-3487-4-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wed, Dec 28, 2011 at 06:05:15PM -0800, Sage Weil wrote:
> Enable/disable use of the dentry dir 'complete' flag via a mount option.

Please add documentation when a user would specify this option.


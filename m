From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] ceph: enable/disable dentry complete flags via mount
 option
Date: Wed, 11 Jan 2012 14:00:01 -0500
Message-ID: <20120111190001.GB29582@infradead.org>
References: <1326307602-16284-1-git-send-email-sage@newdream.net>
 <1326307602-16284-3-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:40718
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933244Ab2AKTAE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Jan 2012 14:00:04 -0500
Content-Disposition: inline
In-Reply-To: <1326307602-16284-3-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: viro@ZenIV.linux.org.uk, hch@infradead.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org

> +  dcache
> +        Use the dcache contents to perform negative lookups and
> +        readdir when the client has the entire directory contents in
> +        its cache.  (This does not change correctness; the client uses
> +        cached metadata only when a lease or capability ensures it is
> +        valid.)
> +
> +  nodcache
> +        Do not use the dcache as above.
>  
> +  noasyncreaddir
> +	Do not use the dcache as above for readdir.

None of thie explains why you'd ever want to turn the flag off.


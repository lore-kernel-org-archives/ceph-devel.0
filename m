From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] vfs: export symbol d_find_any_alias()
Date: Thu, 12 Jan 2012 14:04:29 -0500
Message-ID: <20120112190429.GA5022@infradead.org>
References: <1326307602-16284-1-git-send-email-sage@newdream.net>
 <1326307602-16284-2-git-send-email-sage@newdream.net>
 <20120111185557.GA29582@infradead.org>
 <Pine.LNX.4.64.1201111241270.13761@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1201111241270.13761@cobra.newdream.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>
Cc: Christoph Hellwig <hch@infradead.org>, viro@ZenIV.linux.org.uk, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

> >From d0207b0a2646a20e25ca8729a1d18ee74fdabfb9 Mon Sep 17 00:00:00 2001
> From: Sage Weil <sage@newdream.net>
> Date: Tue, 10 Jan 2012 09:04:37 -0800
> Subject: [PATCH 1/2] vfs: export symbol d_find_any_alias()
> 
> Ceph needs this.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>

Looks good,


Reviewed-by: Christoph Hellwig <hch@lst.de>


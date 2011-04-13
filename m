From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [qemu-iotests][PATCH] Update rbd support
Date: Wed, 13 Apr 2011 04:43:39 +0200
Message-ID: <20110413024339.GA16779@lst.de>
References: <cover.1302653035.git.josh.durgin@dreamhost.com> <1302655665-30101-1-git-send-email-josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39701 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab1DMCnk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2011 22:43:40 -0400
Content-Disposition: inline
In-Reply-To: <1302655665-30101-1-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

> @@ -43,6 +43,10 @@ _supported_fmt raw
>  _supported_proto generic
>  _supported_os Linux
>  
> +# rbd images are not growable
> +if [ "$IMGPROTO" = "rbd" ]; then
> +    _notrun "image protocol $IMGPROTO does not support growable images"
> +fi

I suspect we only support the weird writing past size for the
file protocol, so we should only run the test for it.

Or does sheepdog do anything special about it?


From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH][qemu-iotests] add support for rbd and sheepdog protocols
Date: Fri, 4 Feb 2011 19:07:32 +0100
Message-ID: <20110204180732.GB16264@lst.de>
References: <1295283677-31712-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:50206 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842Ab1BDSIA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Feb 2011 13:08:00 -0500
Content-Disposition: inline
In-Reply-To: <1295283677-31712-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
Cc: qemu-devel@nongnu.org, sheepdog@lists.wpkg.org, ceph-devel@vger.kernel.org

On Tue, Jan 18, 2011 at 02:01:17AM +0900, MORITA Kazutaka wrote:
> This patch introduces tests for protocols other than file, and
> initially supports rbd and sheepdog.

Thanks a lot!

This should also make adding nbd support trivial if anyone cares.


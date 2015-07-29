From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Ceph write path optimization
Date: Tue, 28 Jul 2015 23:57:55 -0700
Message-ID: <20150729065755.GB27890@infradead.org>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE784B@SACMBXIP01.sdcorp.global.sandisk.com>
 <CADkk3ivd=35oDHVTQihW7DnPsY9063LrJFQKvc1ayiyBri3Btw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60741 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbG2G55 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 02:57:57 -0400
Content-Disposition: inline
In-Reply-To: <CADkk3ivd=35oDHVTQihW7DnPsY9063LrJFQKvc1ayiyBri3Btw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ??ukasz Redynk <lukas.redynk@gmail.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 11:46:06PM +0200, ??ukasz Redynk wrote:
> Hi,
> 
> Have you tried to tune XFS mkfs options? From mkfs.xfs(8)
> a) (log section, -l)
> lazy-count=value // by default is 0

It's default.  And less AGs arent going to help you here.  Please don't
start micro tuning filesystem options before you understand the problem,
thanks.


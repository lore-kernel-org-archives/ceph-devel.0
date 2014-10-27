From: Christoph Hellwig <hch@infradead.org>
Subject: Re: krbd blk-mq support ?
Date: Mon, 27 Oct 2014 02:45:56 -0700
Message-ID: <20141027094556.GA31604@infradead.org>
References: <8dd75b6c-f026-466d-baa4-fa4d11f8800a@mailpro>
 <42753caf-adc1-48f7-bc34-83ed48845061@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60669 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbaJ0Jp5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 05:45:57 -0400
Content-Disposition: inline
In-Reply-To: <42753caf-adc1-48f7-bc34-83ed48845061@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

On Sun, Oct 26, 2014 at 02:46:03PM +0100, Alexandre DERUMIER wrote:
> Hi,
> 
> some news:
> 
> I have applied patches succefully on top of 3.18-rc1 kernel.
> 
> But don't seem to help is my case.
> (I think that blk-mq is working because I don't see any io schedulers on rbd devices, as blk-mq don't support them actually).
> 
> My main problem is that I can't reach more than around 50000iops on 1 machine,
> 
> and the problem seem to be the kworker process stuck at 100% of 1core.

Can you do a perf report -ag and then a perf report to see where these
cycles are spent?


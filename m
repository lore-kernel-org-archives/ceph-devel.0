From: Christoph Hellwig <hch@infradead.org>
Subject: Re: krbd blk-mq support ?
Date: Tue, 28 Oct 2014 11:07:25 -0700
Message-ID: <20141028180725.GA1138@infradead.org>
References: <20141027094556.GA31604@infradead.org>
 <fc083e2c-6a73-4ff8-934c-4e3ba1d64b50@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57400 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaJ1SH0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 14:07:26 -0400
Content-Disposition: inline
In-Reply-To: <fc083e2c-6a73-4ff8-934c-4e3ba1d64b50@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote:
> >>Can you do a perf report -ag and then a perf report to see where these
> >>cycles are spent?
> 
> Yes, sure.
> 
> I have attached the perf report to this mail.
> (This is with kernel 3.14, don't have access to my 3.18  host for now)

Oh, that's without the blk-mq patch?

Either way the profile doesn't really sum up to a fully used up
cpu.  Sage, Alex - are there any ordring constraints in the rbd client?
If not we could probably aim for per-cpu queues using blk-mq and a
socket per cpu or similar.

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: krbd blk-mq support ?
Date: Wed, 10 Dec 2014 06:05:18 -0800
Message-ID: <20141210140518.GA25470@infradead.org>
References: <20141113071815.GA27154@infradead.org>
 <473f435c-e053-47b9-9061-07b44c83d5d0@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57147 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbaLJOFT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 09:05:19 -0500
Content-Disposition: inline
In-Reply-To: <473f435c-e053-47b9-9061-07b44c83d5d0@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Thu, Nov 13, 2014 at 10:44:18AM +0100, Alexandre DERUMIER wrote:
> >>Did you manage to get those numbers?
> 
> Not yet, I'll try next week.

What's the result?  I'd really like to get rid of old request drivers
as much as possible.

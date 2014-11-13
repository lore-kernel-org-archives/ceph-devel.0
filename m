From: Christoph Hellwig <hch@infradead.org>
Subject: Re: krbd blk-mq support ?
Date: Wed, 12 Nov 2014 23:18:15 -0800
Message-ID: <20141113071815.GA27154@infradead.org>
References: <100ed8b3-2427-46d0-9a0c-e5e1a92031af@mailpro>
 <b31855d3-bde0-4e56-b50d-2a161ee095aa@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60237 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaKMHSQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 02:18:16 -0500
Content-Disposition: inline
In-Reply-To: <b31855d3-bde0-4e56-b50d-2a161ee095aa@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Tue, Nov 04, 2014 at 08:19:32AM +0100, Alexandre DERUMIER wrote:
> Now : 3.18 kernel + your patch : 120000 iops
>       3.10 kernel : 80000iops
> 
> 
> I'll try 3.18 kernel without your patch to compare.

Did you manage to get those numbers?

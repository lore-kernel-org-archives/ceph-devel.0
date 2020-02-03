From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] ceph: do not direct write executes in parallel if
 O_APPEND is set
Date: Mon, 3 Feb 2020 00:36:46 -0800
Message-ID: <20200203083646.GB5005@infradead.org>
References: <20200131133619.14209-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBCIgw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2020 03:36:52 -0500
Content-Disposition: inline
In-Reply-To: <20200131133619.14209-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com
Cc: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:36:19AM -0500, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> In O_APPEND & O_DIRECT mode, the data from different writers will
> be possiblly overlapping each other. Just use the exclusive clock
> instead in O_APPEND & O_DIRECT mode.

s/clock/lock/

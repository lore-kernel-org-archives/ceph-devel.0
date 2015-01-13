From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] rbd: convert to blk-mq
Date: Tue, 13 Jan 2015 17:19:02 +0100
Message-ID: <20150113161901.GA23547@lst.de>
References: <1420914688-27563-1-git-send-email-hch@lst.de> <54B1B864.4080008@ieee.org> <20150112124002.GA29490@lst.de> <CALFYKtBUONtvGDJtM92bna9utkvnpTHxbL--5P+N3oirgqU7Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44230 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbbAMQTF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Jan 2015 11:19:05 -0500
Content-Disposition: inline
In-Reply-To: <CALFYKtBUONtvGDJtM92bna9utkvnpTHxbL--5P+N3oirgqU7Bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 12, 2015 at 08:10:48PM +0300, Ilya Dryomov wrote:
> Why is this call here?  Why not above or below?  I doubt it makes much
> difference, but from a clarity standpoint at least, shouldn't it be
> placed after all the checks and allocations, say before the call to
> rbd_img_request_submit()?

The idea is to do it before doing real work, but after the request
is set up far enough that a cancallation works.  For rbd that doesn't do
timeouts or cancellations it really doesn't matter too much.  I've
moved it a little further down after the next trivial check now.

> Expanding on REQ_TYPE_FS comment, isn't blk_mq_end_request() enough?
> Swap blk_end_request_all() for blk_mq_end_request() and get rid of err
> label?

The blk_end_request_all should be gone and sneaked back in due to a sloppy
rebase.

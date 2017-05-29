From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] rbd: implement REQ_OP_WRITE_ZEROES
Date: Mon, 29 May 2017 10:43:48 +0200
Message-ID: <20170529084348.GA11801@lst.de>
References: <1495552107-1237-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54726 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbdE2Inu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 May 2017 04:43:50 -0400
Content-Disposition: inline
In-Reply-To: <1495552107-1237-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>

On Tue, May 23, 2017 at 05:08:27PM +0200, Ilya Dryomov wrote:
> Commit 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
> explicitly didn't implement REQ_OP_WRITE_ZEROES for rbd, while the
> following commit 48920ff2a5a9 ("block: remove the discard_zeroes_data
> flag") dropped ->discard_zeroes_data in favor of REQ_OP_WRITE_ZEROES.
> 
> rbd does support efficient zeroing via CEPH_OSD_OP_ZERO opcode and will
> release either some or all blocks depending on whether the zeroing
> request is rbd_obj_bytes() aligned.  This is how we currently implement
> discards, so REQ_OP_WRITE_ZEROES can be identical to REQ_OP_DISCARD for
> now.  Caveats:
> 
> - REQ_NOUNMAP is ignored, but AFAICT that's true of at least two other
>   current implementations - nvme and loop

That's no problem, it's just a hint in case the device differenciates
the cases.

> - there is no ->write_zeroes_alignment and blk_bio_write_zeroes_split()
>   is hence less helpful than blk_bio_discard_split(), but this can (and
>   should) be fixed on the rbd side

Yes.

> In the future we will split these into two code paths to respect
> REQ_NOUNMAP on zeroout and save on zeroing blocks that couldn't be
> released on discard.
> 
> Fixes: 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

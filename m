From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 2/2] rbd: get rid of rbd_mapping::read_only
Date: Wed, 8 Nov 2017 19:32:42 +0100
Message-ID: <20171108193242.7b3b16c5@suse.de>
References: <1509983370-1853-1-git-send-email-idryomov@gmail.com>
        <1509983370-1853-2-git-send-email-idryomov@gmail.com>
        <20171107142627.0d66f97b@suse.de>
        <CAOi1vP87GtgauS4OXGXDeBXD3ce_CM+N3p_j8+6XXDsG1TYgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbdKHScn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Nov 2017 13:32:43 -0500
In-Reply-To: <CAOi1vP87GtgauS4OXGXDeBXD3ce_CM+N3p_j8+6XXDsG1TYgwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 7 Nov 2017 17:56:51 +0100, Ilya Dryomov wrote:

> Heh, apparently I only tested writes and didn't do discards...  Writes
> go through blkdev_write_iter() but zeroout/discards seem to rely solely
> on FMODE_WRITE checks, which the block layer doesn't enforce.
> 
> I'd rather try to fix it in the block layer before working around it in
> krbd.  I'll work up a patch tomorrow.

FWIW I've pushed a blktests regression test for this to the
wip_ro_get_set_discard branch of my repo at:
https://github.com/ddiss/blktests.git

Cheers, David

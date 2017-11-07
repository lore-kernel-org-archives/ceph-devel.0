From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] rbd: use GFP_NOIO for parent stat and data requests
Date: Tue, 7 Nov 2017 16:00:55 +0100
Message-ID: <20171107160055.1b126519@suse.de>
References: <1509983480-2051-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933751AbdKGPA4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Nov 2017 10:00:56 -0500
In-Reply-To: <1509983480-2051-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon,  6 Nov 2017 16:51:20 +0100, Ilya Dryomov wrote:

> rbd_img_obj_exists_submit() and rbd_img_obj_parent_read_full() are on
> the writeback path for cloned images -- we attempt a stat on the parent
> object to see if it exists and potentially read it in to call copyup.
> GFP_NOIO should be used instead of GFP_KERNEL here.
> 
> Cc: stable@vger.kernel.org
> Link: http://tracker.ceph.com/issues/22014
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

Cheers, David

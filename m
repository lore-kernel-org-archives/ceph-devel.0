From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 5/8] rbd: don't crash or leak on errors in
 rbd_img_obj_parent_read_full_callback()
Date: Mon, 26 Sep 2016 14:58:59 +0200
Message-ID: <20160926145859.41755ab1@echidna.suse.de>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
        <1474304608-17958-6-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034437AbcIZM7B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 08:59:01 -0400
In-Reply-To: <1474304608-17958-6-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Mon, 19 Sep 2016 19:03:25 +0200, Ilya Dryomov wrote:

> - fix parent_length == img_request->xferred assert to not fire on
>   copyup read failures
> - don't leak pages if copyup read fails or we can't allocate a new osd
>   request
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>

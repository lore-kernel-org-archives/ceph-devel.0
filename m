From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 2/8] rbd: clean up asserts in
 rbd_img_obj_request_submit() helpers
Date: Mon, 26 Sep 2016 14:43:00 +0200
Message-ID: <20160926144300.069f3cd3@echidna.suse.de>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
        <1474304608-17958-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034322AbcIZMnB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 08:43:01 -0400
In-Reply-To: <1474304608-17958-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Mon, 19 Sep 2016 19:03:22 +0200, Ilya Dryomov wrote:

> Assert once in rbd_img_obj_request_submit().
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>

From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 6/8] rbd: rework rbd_img_obj_exists_submit() error paths
Date: Mon, 26 Sep 2016 14:05:39 +0200
Message-ID: <20160926140539.4b2b17fe@echidna.suse.de>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
        <1474304608-17958-7-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55507 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938997AbcIZMFl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 08:05:41 -0400
In-Reply-To: <1474304608-17958-7-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Mon, 19 Sep 2016 19:03:26 +0200, Ilya Dryomov wrote:

> - don't put obj_request if rbd_obj_request_create() fails
> - don't leak stat_request if rbd_osd_req_create() fails
> 
> Reported-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

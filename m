From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 7/8] rbd: don't call rbd_osd_req_format_read() for
 !img_data requests
Date: Mon, 26 Sep 2016 14:05:36 +0200
Message-ID: <20160926140536.0501ccce@echidna.suse.de>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
        <1474304608-17958-8-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934585AbcIZMFi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 08:05:38 -0400
In-Reply-To: <1474304608-17958-8-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Mon, 19 Sep 2016 19:03:27 +0200, Ilya Dryomov wrote:

> Accessing obj_request->img_request union field is only valid for object
> requests associated with an image (i.e. if obj_request_img_data_test()
> returns true).  rbd_osd_req_format_read() used to do more, but now it
> just sets osd_req->snap_id.  Standalone and stat object requests always
> go to the HEAD revision and are fine with CEPH_NOSNAP set by libceph,
> so get around the invalid union field use by simply not calling
> rbd_osd_req_format_read() in those places.
> 
> Reported-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>

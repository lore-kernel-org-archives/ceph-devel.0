From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 8/8] rbd: img_data requests don't own their page array
Date: Mon, 26 Sep 2016 17:33:22 +0200
Message-ID: <20160926173322.50fa05f8@echidna.suse.de>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
        <1474304608-17958-9-git-send-email-idryomov@gmail.com>
        <3fe273f8-7f12-26d4-885a-972e63c0b48e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030356AbcIZPdY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 11:33:24 -0400
In-Reply-To: <3fe273f8-7f12-26d4-885a-972e63c0b48e@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@linaro.org>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 25 Sep 2016 12:06:34 -0500, Alex Elder wrote:

> On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> > Move the check into rbd_obj_request_destroy(), to avoid use-after-free
> > on errors in rbd_img_request_fill().
> > 
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> 
> Is this because an error occurring in rbd_img_request_fill()
> causes rbd_img_obj_request_del() to be called, which leads to
> rbd_obj_request_destroy(), which (by this time) has not yet
> had its obj_request->pages pointer set to NULL because the
> object request is still outstanding?  (Your explanation was
> a little brief...)

I agree, the commit message could be improved...

I think the use after free is in the rbd_img_obj_parent_read_full()
call path - if rbd_img_request_fill() fails after adding an obj_request
to the img_request->obj_requests list, then the corresponding page(s)
will be freed in the rbd_img_request_fill() out_unwind error path *and*
the rbd_img_obj_parent_read_full() error path.

> The change in rbd_obj_request_destroy() looks good for that
> case.
> 
> The code deleted in rbd_img_obj_end_request() could still stay,
> however.  Almost everywhere, pointers are reassigned to NULL
> when it's known the thing referred to is no longer needed.
> It's useful in post-mortem understanding of what's occurred.

Agreed.

> I guess it's fine with me either way.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Looks fine to me too.
Reviewed-by: David Disseldorp <ddiss@suse.de>

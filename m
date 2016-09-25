From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 7/8] rbd: don't call rbd_osd_req_format_read() for
 !img_data requests
Date: Sun, 25 Sep 2016 11:44:19 -0500
Message-ID: <fc625423-0cf5-d836-176a-0337ab8cfddc@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-8-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36179 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938834AbcIYQoW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2016 12:44:22 -0400
Received: by mail-io0-f171.google.com with SMTP id m79so161939554ioo.3
        for <ceph-devel@vger.kernel.org>; Sun, 25 Sep 2016 09:44:21 -0700 (PDT)
In-Reply-To: <1474304608-17958-8-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> Accessing obj_request->img_request union field is only valid for object
> requests associated with an image (i.e. if obj_request_img_data_test()
> returns true).  rbd_osd_req_format_read() used to do more, but now it
> just sets osd_req->snap_id.  Standalone and stat object requests always
> go to the HEAD revision and are fine with CEPH_NOSNAP set by libceph,
> so get around the invalid union field use by simply not calling
> rbd_osd_req_format_read() in those places.

Since rbd_osd_req_format_{read,write} are now only called
from rbd_img_obj_request_fill(), and they're really simple,
maybe they could be eliminated entirely and open-coded
instead.  We already have the img_request and osd_req pointers
in the caller's context.

Stat requests go to the HEAD because they are only involved for
a layered write, which *cannot* be a snapshot.  I suppose that
is something that could have been (or be) asserted.

Is it guaranteed/required that method calls go to the HEAD?
I'm sure they all do now, but my question is whether there's
a good reason that it will *always* be true.  Maybe it is.

Similarly, rbd_obj_read_sync() is currently used only for
standalone object requests.  But it's conceivable it could
be useful for image objects.  (I'm not too concerned about
that though...)

Anwyay, this looks fine.  My reservations are all about
ensuring these assumptions are clear in the code.  Maybe
a comment or two is warranted.

In any case...

Reviewed-by: Alex Elder <elder@linaro.org>

> Reported-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 03f171067e08..8907ee6342ac 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1943,11 +1943,10 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req)
>  
>  static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request)
>  {
> -	struct rbd_img_request *img_request = obj_request->img_request;
>  	struct ceph_osd_request *osd_req = obj_request->osd_req;
>  
> -	if (img_request)
> -		osd_req->r_snapid = img_request->snap_id;
> +	rbd_assert(obj_request_img_data_test(obj_request));
> +	osd_req->r_snapid = obj_request->img_request->snap_id;
>  }
>  
>  static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
> @@ -2929,8 +2928,6 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  	stat_request->page_count = page_count;
>  	stat_request->callback = rbd_img_obj_exists_callback;
>  
> -	rbd_osd_req_format_read(stat_request);
> -
>  	rbd_obj_request_submit(stat_request);
>  	return 0;
>  
> @@ -4026,7 +4023,6 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
>  	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
>  					obj_request->pages, inbound_size,
>  					0, false, false);
> -	rbd_osd_req_format_read(obj_request);
>  
>  	rbd_obj_request_submit(obj_request);
>  	ret = rbd_obj_request_wait(obj_request);
> @@ -4265,7 +4261,6 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
>  					obj_request->length,
>  					obj_request->offset & ~PAGE_MASK,
>  					false, false);
> -	rbd_osd_req_format_read(obj_request);
>  
>  	rbd_obj_request_submit(obj_request);
>  	ret = rbd_obj_request_wait(obj_request);
> 


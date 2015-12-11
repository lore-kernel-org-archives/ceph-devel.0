From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: CEPH_MAX_OID_NAME_LEN in rbd kernel driver
Date: Fri, 11 Dec 2015 17:46:00 +0100
Message-ID: <CAOi1vP9znqun2LGbqSpvs6bs9U_YXH1Yqebu6dm4qPVfdFCR5g@mail.gmail.com>
References: <566AE24E.1050107@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37719 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbLKQqB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Dec 2015 11:46:01 -0500
Received: by wmnn186 with SMTP id n186so39559503wmn.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Dec 2015 08:46:00 -0800 (PST)
In-Reply-To: <566AE24E.1050107@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Tiare Le Bigot <jean-tiare.le-bigot@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Dec 11, 2015 at 3:48 PM, Jean-Tiare Le Bigot
<jean-tiare.le-bigot@corp.ovh.com> wrote:
> Hi,
>
> I hit a use case where rbd was failing to map an image because of the
> name length.
>
> dmesg output:
>
> WARNING: CPU: 0 PID: 20851 at include/linux/ceph/osdmap.h:97
> rbd_osd_req_create.isra.29+0xdd/0x140()
>
> ceph_oid_set_name
> 'rbd_id.docker:devel:ib8k2cxvci9sh7b4ly8wwvpyjf6kjoyuero1k25zal3ypc916i04x78tbmn60gjm6pyp38lmjq:latest'
> len 101 vs 100, truncating
>
>
> It turns out the maximum ceph object name length is controlled by the
> constant CEPH_MAX_OID_NAME_LEN. I naively tried to increase it to 500
> which appears to workaround (fix ?) the issue.
>
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 49ff69f..cf34bb0 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -50,7 +50,7 @@ struct ceph_object_locator {
>   *
>   * (probably outdated: must be >= RBD_MAX_MD_NAME_LEN -- currently 100)
>   */
> -#define CEPH_MAX_OID_NAME_LEN 100
> +#define CEPH_MAX_OID_NAME_LEN 500
>
>  struct ceph_object_id {
>         char name[CEPH_MAX_OID_NAME_LEN];
>
>
> What is the impact of such a change ? Should I submit a proper patch ?
> And, last but not least, shouldn't it return an error instead of trucate
> it and fail because, obviously the object does not exist ? Worse, It
> could exist with a different data. Which would be an interesting vector
> for injecting data in a third party image...

The impact is heavier allocations - each request has two of those and
the encoding buffer is also CEPH_MAX_OID_NAME_LEN, not the actual name
length.  I was actually considering lowering it, but I didn't consider
image names from hell like that.

librbd has #define RBD_MAX_OBJ_NAME_SIZE 96, but it's not enforced.

Is that ID between devel: and :latest fixed-size in docker world?  I.e.
would bumping it to something less than 500 do?

I don't think injecting data is a valid concern - if you can create an
image in a pool, you can write to it and if you can write to it...  It's
better to return an error, of course.

Thanks,

                Ilya

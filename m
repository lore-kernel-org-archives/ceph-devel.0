From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: fix error paths in rbd_img_request_fill()
Date: Tue, 4 Mar 2014 13:03:58 +0200
Message-ID: <CALFYKtBB6YU6La_iMqtJD+3bJ1jcjwV76N9XK4vjNX470vX57g@mail.gmail.com>
References: <1393861102-5123-1-git-send-email-ilya.dryomov@inktank.com>
	<5314FB58.7030604@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:59316 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbaCDLD7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Mar 2014 06:03:59 -0500
Received: by mail-qg0-f47.google.com with SMTP id 63so15019502qgz.6
        for <ceph-devel@vger.kernel.org>; Tue, 04 Mar 2014 03:03:58 -0800 (PST)
In-Reply-To: <5314FB58.7030604@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Mar 3, 2014 at 11:59 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/03/2014 09:38 AM, Ilya Dryomov wrote:
>>
>> Doing rbd_obj_request_put() in rbd_img_request_fill() error paths is
>> not only insufficient, but also triggers an rbd_assert() in
>> rbd_obj_request_destroy():
>>
>> Assertion failure in rbd_obj_request_destroy() at line 1867:
>> rbd_assert(obj_request->img_request == NULL);
>
>
> Does this have a tracker entry separate from 7327?  (I
> didn't look, just curious.)

No, I don't think so.  There are though 3 entries for the opposite
assert, on which I unfortunately don't have anything yet:

http://tracker.ceph.com/issues/5454
http://tracker.ceph.com/issues/5662
http://tracker.ceph.com/issues/7327

>
>> rbd_img_obj_request_add() adds obj_requests to the img_request, the
>> opposite is rbd_img_obj_request_del().  Use it.h
>
>
> This is the main bug here, and this is the right fix.
>
>
>> While at it, commit 03507db631c94 ("rbd: fix buffer size for writes to
>> images with snapshots") moved the call to rbd_img_obj_request_add() up,
>> making the out_partial label bogus.  Remove it.
>
>
> Yes, this is also correct, and is a bug fix.  Since it's a distinct
> bug *maybe* you could commit it separately, but I don't really think
> it's that important.

Done.

>
> Very nice.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks,

                Ilya

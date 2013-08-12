From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Correct usage of rbd_aio_release
Date: Mon, 12 Aug 2013 14:58:56 -0700
Message-ID: <52095AA0.9000008@inktank.com>
References: <CAF6-1L5nrco6oLq8xwnpymP+jLh8gi4O1WgvcOZimmCw4gFHiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34157 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab3HLWAl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Aug 2013 18:00:41 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so3995312pdj.4
        for <ceph-devel@vger.kernel.org>; Mon, 12 Aug 2013 15:00:40 -0700 (PDT)
In-Reply-To: <CAF6-1L5nrco6oLq8xwnpymP+jLh8gi4O1WgvcOZimmCw4gFHiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On 08/12/2013 06:36 AM, Sylvain Munaut wrote:
> Hi,
>
>
> When should / can rbd_aio_release be called exactly ?

It should be called whenever you're certain you won't be using the
rbd_completion_t anymore (and an rbd_completion_t should not be reused
after rbd_aio_{read,write,discard,flush} is called on it).
rbd_aio_release() could be in the callback, after the callback is
called, or like you suggest below, when there's an error submitting the
I/O in the first place. If you don't supply a callback when creating the
rbd_completion_t, you can release it after scheduling I/O with
rbd_aio_xxx, but you won't be able to do any error handling.

> For example if I create a rbd_aio_create_completion then do a
> rbd_aio_XXX that fails, should I call rbd_aio_release ?
> I would think yes, but when looking at the qemu rbd code, it doesn't
> and I'm not sure if it's by design.

Yes, you should call rbd_aio_release() then. It's a bug in the qemu rbd
driver that it doesn't, but the rbd_aio_xxx functions only fail for
some kind of bad request (i.e. trying to write to a snapshot, or
starting past the end of the image), so it's not really a problem in
practice. Errors like ENOSPC will not be triggered until after the
request is submitted, and will need to be handled by the callback.

Josh

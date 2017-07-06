From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 09:03:38 -0400
Message-ID: <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36816 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdGFNDj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 09:03:39 -0400
Received: by mail-yw0-f178.google.com with SMTP id a12so632867ywh.3
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 06:03:39 -0700 (PDT)
In-Reply-To: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Pre-Luminous also copies the provided buffer when using the C API --
it just copies it at a later point and not immediately. The eventual
goal is to eliminate the copy completely, but that requires some
additional plumbing work deep down within the librados messenger
layer.

On Thu, Jul 6, 2017 at 8:26 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> Hi,
>
> If you're using "rbd_aio_write()" in your code, be aware of the fact that
> before Luminous release, this function expects buffer to remain unchanged
> until write op ends, and on Luminous and later this function internally
> copies the buffer, allocating memory where needed, freeing it once write is
> done.
>
> If you write an app that may need to work with Luminous *and* pre-Luminous
> versions of librbd, you may want to provide a version check (using
> rbd_version() for example) so either your buffers won't change before write
> is done or you don't incur a penalty for unnecessary memory allocation and
> copy on your side (though it's probably unavoidable with current state of
> Luminous).
>
> --
> Piotr Dałek
> piotr.dalek@corp.ovh.com
> https://www.ovh.com/us/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason

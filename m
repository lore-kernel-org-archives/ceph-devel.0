From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW: Multi part upload - Attributes not copied from the upload
 object to the final meta object
Date: Wed, 4 Jun 2014 08:22:30 -0700
Message-ID: <CABBk=J9AaxABAYR9VkY1GavfzMtYop8+0xxbfXcQRdPhAoJz2w@mail.gmail.com>
References: <CAF6-1L4rcN+P21sN2-ofrXdjqsLLbT4VYEMWzuu-1-evWBs9Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:45598 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbaFDPWb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 11:22:31 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so8895014veb.22
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 08:22:31 -0700 (PDT)
In-Reply-To: <CAF6-1L4rcN+P21sN2-ofrXdjqsLLbT4VYEMWzuu-1-evWBs9Yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a known issue (8452). We have a fix for that and we'll get it
to firefly.

Thanks,
Yehuda

On Wed, Jun 4, 2014 at 8:10 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
> When playing around with firefly, I noticed that the content-type I'm
> setting when doing multi-part upload is not taken into account.
>
> And looking at the rados object, I can see the xattr present on the
> .meta file (upload obj), but when doing a complete, that object is
> removed and the attributes are not copied over to the final object
> AFAICT.
>
>
> Cheers,
>
>     Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

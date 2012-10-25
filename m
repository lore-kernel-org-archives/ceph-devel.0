From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: libcephfs ceph_shutdown()
Date: Thu, 25 Oct 2012 09:03:51 -0700
Message-ID: <CAPrxi58LQUCWDjkyyTnFwN4hVD2isOijEVo=OcHb5K_JT_LjNQ@mail.gmail.com>
References: <alpine.DEB.2.00.1210241614190.13619@cobra.newdream.net>
	<CAPrxi5_Fa8U=z2cD4tRrYB34w0Y5crV7sSmo=aaCFLEg_oYGdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40168 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933303Ab2JYQDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 12:03:52 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so2035348vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 09:03:51 -0700 (PDT)
In-Reply-To: <CAPrxi5_Fa8U=z2cD4tRrYB34w0Y5crV7sSmo=aaCFLEg_oYGdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: noah.watkins@inktank.com, joe.buck@inktank.com, ceph-devel@vger.kernel.org

I was just take a look at this for libcephfs. Does it make sense to
have ceph_release free CephContext, and ceph_unmount with everything
else: client, messenger, and mon client?

- Noah

On Wed, Oct 24, 2012 at 4:32 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> On the Java, side being able to do an unmount to free resources, while
> still keeping the context, makes things more natural to both explain,
> and code. I'm sure this would be true for other language bindings as
> well.
>
> +1
>
>
> On Wed, Oct 24, 2012 at 4:17 PM, Sage Weil <sage@inktank.com> wrote:
>> I'm annoyed that ceph_shutdown() both unmounts and releases the resource,
>> but there is a separate _create() and _mount() method.  I wonder if it
>> makes sense to introduce ceph_umount() and ceph_release() and make
>> ceph_shutdown() call them (for compatibility).
>>
>> I thought librados was a bit cleaner, but it appears to be doing the same
>> thing.. meh.  (Also, the docs for _shutdown() incorrectly state that
>> shutdown isn't needed if rados_connect() fails.. but presumably the
>> resource still needs to be freed?)
>>
>> Is this worth fixing?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

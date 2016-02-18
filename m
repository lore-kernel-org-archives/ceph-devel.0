From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Wed, 17 Feb 2016 22:02:11 -0800
Message-ID: <CABeXuvq1=LTOYybAUkwA=07NkoVJTBvnaZH+K_fhhMGKfWSH+A@mail.gmail.com>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
	<6208883.1yJqoj6hbg@wuerfel>
	<CABeXuvoTX1Bq=3GEO7POgmgThOk8eCOOJPOKJFza5U3UrkGwog@mail.gmail.com>
	<6833154.QUCaxj5s9M@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36343 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbcBRGCM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 01:02:12 -0500
Received: by mail-io0-f177.google.com with SMTP id l127so62370169iof.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 22:02:12 -0800 (PST)
In-Reply-To: <6833154.QUCaxj5s9M@wuerfel>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>

> I think you are forgetting that this is a wire protocol.  Changing how
> values are interpreted on one side without looking at the other side is
> generally not what you want to do.
>
> There aren't any casts on the server side: __u32 is simply assigned to
> time_t, meaning no sign-extension is happening - see src/include/utime.h
> in ceph.git.  The current __kernel_time_t and long casts on the kernel
> side are meaningless - they don't change the bit pattern, so everything
> is interpreted the same way.  Your patch changes that.
>
> If there is anything to be done here, it is documenting the existing
> behavior.  This isn't to say that there aren't any quirks or bugs in
> our time handling, it's that any changes concerning the protocol or how
> the actual bits are interpreted should follow or align with the rest of
> ceph and have a note in the changelog on that.
>
> (As Greg and I mentioned before, we do have a semi-concrete plan on how
> to deal with y2038 in ceph, just no timetable yet.)

I checked the server side code.
So the server side also reads whatever is sent over wire as u32 and
then assigns it to a time_t.

Do you have any documentation about the wire protocol?

To me, the wire protocol seems to have been designed to support only
positive time values(u32).
This means ceph can represent times from 1970 - 2106 as long as both
server and client are 64 bit machines.
Or, client is 64 bit and server does not operate on time values.
And, on 32 bit machines implementation will be broken in 2038.

I will change back the above code to not use any casts(as they are a
no-op) as on the server side and note the above
things in the file and changelog:

 static inline void ceph_decode_timespec(struct timespec *ts,
                                         const struct ceph_timespec *tv)
 {
 -       ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
 -       ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
 +       ts->tv_sec = le32_to_cpu(tv->tv_sec);
 +       ts->tv_nsec = le32_to_cpu(tv->tv_nsec);
  }

-Deepa

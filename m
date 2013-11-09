From: asomers@gmail.com
Subject: Re: libuuid vs boost uuid
Date: Sat, 9 Nov 2013 10:25:28 -0700
Message-ID: <CAOtMX2j4+og64Z8OM4p2Rs3++sHnTsChJgXyozQh5QHfrkvPOg@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
	<alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
	<CA+Hcz5_FLNgR=XiHJYQwVUUr6w-JrDGjiH_GYsUw1WhhSuxbxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62853 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab3KIRZa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 12:25:30 -0500
Received: by mail-we0-f174.google.com with SMTP id p61so3143585wes.5
        for <ceph-devel@vger.kernel.org>; Sat, 09 Nov 2013 09:25:28 -0800 (PST)
In-Reply-To: <CA+Hcz5_FLNgR=XiHJYQwVUUr6w-JrDGjiH_GYsUw1WhhSuxbxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Sage Weil <sage@inktank.com>, James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It certainly would.  For those not in the loop, e2fsprogs-libuuid is
problematic on FreeBSD because it shadows a symbol defined in libc.
There's a workaround, but boost::uuid would be better.
-Alan

On Sat, Nov 9, 2013 at 9:41 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
> Alan, would this fix the problem on FreeBSD? IIRC llibuuid is a
> terrible terrible headache, with the recommended approach, being to
> upstream changes to e2fsprogs-libuuid.
>
> On Fri, Nov 8, 2013 at 10:43 PM, Sage Weil <sage@inktank.com> wrote:
>> On Sat, 9 Nov 2013, James Harper wrote:
>>> Just out of curiosity (recent thread about windows port) I just had a
>>> quick go at compiling librados under mingw (win32 cross compile), and
>>> one of the errors that popped up was the lack of libuuid under mingw.
>>> Ceph appears to use libuuid, but I notice boost appears to include a
>>> uuid class too, and it seems that ceph already uses some of boost (which
>>> already builds under mingw).
>>>
>>> Is there anything special about libuuid that would mean boost's uuid
>>> class couldn't replace it? And would it be better to still use ceph's
>>> uuid.h as a wrapper around the boost uuid class, or to modify ceph to
>>> use the boost uuid class directly?
>>
>> Nice!  Boost uuid looks like it would work just fine.  It is probably
>> easier and less disruptive to use it from within the existing class in
>> include/uuid.h.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

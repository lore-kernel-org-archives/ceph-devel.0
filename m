From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: libuuid vs boost uuid
Date: Sat, 9 Nov 2013 08:41:49 -0800
Message-ID: <CA+Hcz5_FLNgR=XiHJYQwVUUr6w-JrDGjiH_GYsUw1WhhSuxbxA@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
	<alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:35592 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab3KIQlu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 11:41:50 -0500
Received: by mail-qc0-f173.google.com with SMTP id l13so2822670qcy.4
        for <ceph-devel@vger.kernel.org>; Sat, 09 Nov 2013 08:41:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alan Somers <asomers@gmail.com>

Alan, would this fix the problem on FreeBSD? IIRC llibuuid is a
terrible terrible headache, with the recommended approach, being to
upstream changes to e2fsprogs-libuuid.

On Fri, Nov 8, 2013 at 10:43 PM, Sage Weil <sage@inktank.com> wrote:
> On Sat, 9 Nov 2013, James Harper wrote:
>> Just out of curiosity (recent thread about windows port) I just had a
>> quick go at compiling librados under mingw (win32 cross compile), and
>> one of the errors that popped up was the lack of libuuid under mingw.
>> Ceph appears to use libuuid, but I notice boost appears to include a
>> uuid class too, and it seems that ceph already uses some of boost (which
>> already builds under mingw).
>>
>> Is there anything special about libuuid that would mean boost's uuid
>> class couldn't replace it? And would it be better to still use ceph's
>> uuid.h as a wrapper around the boost uuid class, or to modify ceph to
>> use the boost uuid class directly?
>
> Nice!  Boost uuid looks like it would work just fine.  It is probably
> easier and less disruptive to use it from within the existing class in
> include/uuid.h.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

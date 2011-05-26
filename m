From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: libceph: get_reply unknown tid
Date: Thu, 26 May 2011 15:41:14 -0400
Message-ID: <BANLkTinZxJj4CsA6cpz+a18F3QLKE7Rrsw@mail.gmail.com>
References: <4DD681C8.1060003@ufm.su>
	<BANLkTimva3_LFr5q3T9UvpfOysS69VzrYA@mail.gmail.com>
	<4DDEAA61.5030201@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42909 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab1EZTlQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 15:41:16 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 50009C52C
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 12:41:16 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id C1C7DC479
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 12:41:15 -0700 (PDT)
Received: by eyx24 with SMTP id 24so409894eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 12:41:14 -0700 (PDT)
In-Reply-To: <4DDEAA61.5030201@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Thu, May 26, 2011 at 3:30 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 05/26/2011 08:37 PM, Gregory Farnum wrote:
>>
>> That means something in the messaging layers got a bit busted, and y=
ou
>> should generally respond by filing bug reports.:) =A0What version ar=
e
>> you on right now? I think we fixed some issues with this a couple
>> weeks ago.
>
> [72845.480649] libceph: get_reply unknown tid 475665 from osd0
> [72845.481518] libceph: get_reply unknown tid 475622 from osd0
> [72845.482140] libceph: get_reply unknown tid 475618 from osd0
> [72845.482725] libceph: get_reply unknown tid 475592 from osd0
> [72845.483164] libceph: get_reply unknown tid 475587 from osd0
> [72845.483753] libceph: get_reply unknown tid 475570 from osd0
> [72846.838239] libceph: get_reply unknown tid 475660 from osd4
> [72846.839034] libceph: get_reply unknown tid 475649 from osd4
> [72846.840702] libceph: get_reply unknown tid 475610 from osd4
> [72846.841548] libceph: get_reply unknown tid 475608 from osd4
> [72846.842243] libceph: get_reply unknown tid 475598 from osd4
>
>
> Ie it happens regularly.
>
> Messages on client (kernel) 2.6.29
> ceph - 0.28.1

Sage reminded me that this can also happen if the OSD configuration
changes and the kernel client has to resend ops to a different OSD. Is
your cluster changing while this happens?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

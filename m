From: huang jun <hjwsm1989@gmail.com>
Subject: Re: osd down
Date: Fri, 29 Jul 2011 08:46:23 +0800
Message-ID: <CABAwU-boqnN==GM70h_T18K4chRmxCJdSaSDr_xdjfRQneq-9A@mail.gmail.com>
References: <CABAwU-ZrsJjXSX+2VV_1qbOJ7+4jeNzvThd6PC_CSOLBoG70RA@mail.gmail.com>
	<CAORUGqBybLLSu7qg0hZwa69HrvVHJ9gPYfO12CR1pE3+zJezQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47941 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab1G2AqZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 20:46:25 -0400
Received: by wwe5 with SMTP id 5so3015894wwe.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 17:46:24 -0700 (PDT)
In-Reply-To: <CAORUGqBybLLSu7qg0hZwa69HrvVHJ9gPYfO12CR1pE3+zJezQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2011/7/28 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Thu, Jul 28, 2011 at 06:16, huang jun <hjwsm1989@gmail.com> wrote:
>> after reboot it manually, from the kern.log of the down OSD in below
>> =85=85=85=85
>> Jul 28 11:26:00 T02-OSD152 kernel: [ 4413.426215] r8169 0000:01:00.0=
:
>> eth0: link up
>> ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@
> ...
>> ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@6802/3615
>> took stat stat(2011-07-23 13:45:26.302800 oprate=3D0 qlen=3D0
>
> Zeroed bytes and content from unrelated files are classic examples of
> what happens when your filesystem gets corrupted. It really sounds
> like you encountered a kernel/hardware bug.
>
> What filesystem is your /var/log on? Are you using ceph's kclient on
> the OSD node (you shouldn't be, just checking)?
>
we use ext3 as /var/log, and ceph kernel client apart from OSD nodes.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

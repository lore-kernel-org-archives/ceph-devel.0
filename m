From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: osd down
Date: Thu, 28 Jul 2011 08:59:35 -0700
Message-ID: <CAORUGqBybLLSu7qg0hZwa69HrvVHJ9gPYfO12CR1pE3+zJezQA@mail.gmail.com>
References: <CABAwU-ZrsJjXSX+2VV_1qbOJ7+4jeNzvThd6PC_CSOLBoG70RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52939 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab1G1P75 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 11:59:57 -0400
Received: by yia27 with SMTP id 27so1908157yia.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 08:59:56 -0700 (PDT)
In-Reply-To: <CABAwU-ZrsJjXSX+2VV_1qbOJ7+4jeNzvThd6PC_CSOLBoG70RA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 28, 2011 at 06:16, huang jun <hjwsm1989@gmail.com> wrote:
> after reboot it manually, from the kern.log of the down OSD in below
> =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
> Jul 28 11:26:00 T02-OSD152 kernel: [ 4413.426215] r8169 0000:01:00.0:
> eth0: link up
> ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@
=2E..
> ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@6802/3615
> took stat stat(2011-07-23 13:45:26.302800 oprate=3D0 qlen=3D0

Zeroed bytes and content from unrelated files are classic examples of
what happens when your filesystem gets corrupted. It really sounds
like you encountered a kernel/hardware bug.

What filesystem is your /var/log on? Are you using ceph's kclient on
the OSD node (you shouldn't be, just checking)?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

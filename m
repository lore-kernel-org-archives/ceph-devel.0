From: Gregory Farnum <greg@inktank.com>
Subject: Re: kernel BUG at fs/ceph/caps.c:1969!
Date: Mon, 2 Jul 2012 11:01:57 -0700
Message-ID: <CAPYLRziC9exdjKdfxX=4EzepGf_bd6+OZPOp0o6PGZk1uZT-ow@mail.gmail.com>
References: <CANExM-OT7Ri0fXkq74DAf4hvPRUdfunNjPSV9cxg7nYsZwSJOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44671 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab2GBSB6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 14:01:58 -0400
Received: by lbbgm6 with SMTP id gm6so7967321lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 11:01:57 -0700 (PDT)
In-Reply-To: <CANExM-OT7Ri0fXkq74DAf4hvPRUdfunNjPSV9cxg7nYsZwSJOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This call trace doesn't look familiar to me, but 2.6.38 is pretty old
and I know there have been a number of kernel fixes for when servers
change lately. I'd recommend trying out a newer kernel and seeing if
you can reproduce the problem. :)
-Greg

On Sun, Jul 1, 2012 at 9:17 AM, Henry C Chang <henry.cy.chang@gmail.com> wrote:
> Hi list,
>
> I got this kernel BUG (see attached image file) when I stopped the
> active mds and the standby one took over. Since my client is on Ubuntu
> natty (2.6.38), I'd like to know if this bug has been fixed in the
> latest kernel or anyone has seen this before?
>
> Thanks,
> Henry

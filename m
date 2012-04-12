From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH] Statically binding ports for ceph-osd
Date: Thu, 12 Apr 2012 11:42:51 -0700
Message-ID: <CAORUGqB-onNKsFt7-ra9u4LmwEFXpZRdARv3-axaW=ZeKooVDQ@mail.gmail.com>
References: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
 <CAPud5_7B8DG4hnVTqBnw7aHuJf8CJnPUjo3ZUfOjDPo89rqvSQ@mail.gmail.com> <C1A5CCB0C744475E8F129F38DAE60867@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56379 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab2DLSnN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 14:43:13 -0400
Received: by vbbff1 with SMTP id ff1so1578975vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 11:43:11 -0700 (PDT)
In-Reply-To: <C1A5CCB0C744475E8F129F38DAE60867@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org

On Tue, Apr 10, 2012 at 16:16, Greg Farnum <gregory.farnum@dreamhost.co=
m> wrote:
> Yep, you're absolutely correct. Might as well let users specify the w=
hole address rather than just the port, though =E2=80=94 since your pat=
ch won't apply to current upstream due to some heartbeating changes I w=
hipped up another one which adds the "osd heartbeat addr" option. It's =
pushed it to master in commit 6fbac10dc68e67d1c700421f311cf5e26991d39c,=
 but you'll want to backport (easy) or carry your change until you upgr=
ade (and remember to change the config!). :)

We're trying to push the "public addr" and "cluster addr" to have a
"public network" and "cluster network" alternatives that don't require
per-node IP address changes.. Adding more "addr" variants without
"network" ones is probably not the most awesome idea.

Now, because this is about port allocation, it runs into problems
trying to run multiple OSDs per machine without per-osd [osd.42]
sections, so I guess that's not as relevant here. I don't have a good
suggestion as to what to do for port allocation, apart from ensuring
that the port range being used is configurable (or even easily
discoverable).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

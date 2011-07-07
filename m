From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: samba write performance
Date: Thu, 7 Jul 2011 09:28:11 -0700
Message-ID: <CAORUGqCe=C4h3=0CGMpfbOBiUWEJ0rB_ohG+aGaZZnk9vJ4ZkA@mail.gmail.com>
References: <CAMwsgzMq94tL-OwvB_=TefAxzsmAdAyxv02N46i3tyK2-8ok9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52570 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1GGQ2c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2011 12:28:32 -0400
Received: by ewy4 with SMTP id 4so377152ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2011 09:28:31 -0700 (PDT)
In-Reply-To: <CAMwsgzMq94tL-OwvB_=TefAxzsmAdAyxv02N46i3tyK2-8ok9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 7, 2011 at 04:06, mowang da <whooya.xxl@gmail.com> wrote:
> I am trying to use a Ceph kernel =C2=A0client to mount Ceph DFS(/) an=
d
> set up a samba server to share the mount point(/mnt/) to Windows 7.
> when l write a large file to the shared directory ., I found that:

[cpu time spent in kernelspace in the 50-90% range a lot]

It's hard to tell just from this information what's really going on.
Is this host an OSD, or the one mounting Ceph? Using kclient or cfuse?

The host those measurements were taking from is spending an awful lot
of time in the kernelspace, which in case of OSD might imply btrfs
issues; for kclient I guess either it's just doing a *lot* of work, or
you have something like ethernet cards device drivers misbehaving.

If this is on an OSD, I would recommend turning off samba and ceph,
and benchmarking just the local filesystem (that the osd would be
using), to see how it performs. If this is on a client machine, I
would recommend verifying that the ethernet driver is able to perform
at those rates with minimal CPU use. It's hard to help you much
without a lot more information about your setup.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: remove user function of radosgw
Date: Mon, 15 Aug 2011 09:30:02 -0700
Message-ID: <CAORUGqCVcxdunKVqycdDELatDOsnGbjA1hMADQ7x8-z+LPqk1w@mail.gmail.com>
References: <CAPE_nyKvv5SG1wE0iVT0crTMpUHr6RfwWxBnhQuwKN-XqbGkeQ@mail.gmail.com>
 <CAORUGqADXgzWi=bg3CcXNHsyUMpSQ7qc4CzM8k3uLkL5UWZ6_g@mail.gmail.com> <CAPE_ny+gYP8_0cce_OEgRxzrzLQFO5JRTZqThNDxKLhm=vpAsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:54593 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab1HOQaW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2011 12:30:22 -0400
Received: by iye16 with SMTP id 16so7772443iye.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2011 09:30:22 -0700 (PDT)
In-Reply-To: <CAPE_ny+gYP8_0cce_OEgRxzrzLQFO5JRTZqThNDxKLhm=vpAsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Aug 13, 2011 at 07:11, Sylar Shen <kimulaaa@gmail.com> wrote:
> Hi Tommi,
> Thanks for your reply.
> My environment is ceph v0.30 and installed on Ubuntu 10.10 by
> compiling source, not debian package.
> It showed nothing when I did "user rm".
> And I know the user still exists because I did "rados -p .users.uid
> ls" and saw the user's name still exists.
> Still, I can use Cyberduck to connect to radosgw by the user's key.
> "BUT" it worked well when I created another v0.30 radosgw environment
> installed on Fedora 15 .
> So I am confusing now why this is happening.......><

I'm afraid it's hard to help you without getting more concrete
information about how you got into that situation, or what you're
doing. A "radosgw_admin user rm --uid=bar" on my test cluster makes
the user bar disappear from "rados -p .users.uid ls" output.

Please show the exact commands and their output for how you create and
remove the users, maybe there's something going on there.

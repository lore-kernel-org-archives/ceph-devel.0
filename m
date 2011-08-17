From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Logging to syslog from clients
Date: Wed, 17 Aug 2011 08:35:15 -0700
Message-ID: <CAORUGqAU=PVTZDHpHwfbRE-6raC4nThLACyMXZmjNeKvFECWOQ@mail.gmail.com>
References: <201108160231.53287.szekelyi@niif.hu> <CA+qbEUNRwy6c7kDG4rY0mxB1pGKuHJOj5sLacXcWhCgJo+uYPw@mail.gmail.com>
 <1313516786.3059.1.camel@wido-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:40371 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1HQPfg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 11:35:36 -0400
Received: by iye16 with SMTP id 16so2093775iye.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2011 08:35:36 -0700 (PDT)
In-Reply-To: <1313516786.3059.1.camel@wido-laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, =?UTF-8?Q?Sz=C3=A9kelyi_Szabolcs?= <szekelyi@niif.hu>, ceph-devel@vger.kernel.org

On Tue, Aug 16, 2011 at 10:46, Wido den Hollander <wido@widodh.nl> wrote:
> I also had that issue, but when using rsyslogd and using TCP for
> transport instead of UDP I wasn't able to see any dropped packets.
>
> To my experience it's not syslog dropping the packets, but UDP packets
> which get lost due to buffers being full at the kernel.

A TCP syslog connection will drop messages if the kernel's outgoing
TCP buffer gets full. You can see this in "ss --tcp" (old school:
"netstat -nt") output column Send-Q.

UDP loses messages even faster because it effectively doesn't have an
outgoing buffer (it does, but it'll blast the contents on the wire
ASAP). That is, UDP syslog loses messages easily if the bottleneck is
anywhere else than in the outgoing network interface; TCP syslog gives
you a TCP window size of grace to handle peaks.

Even syslog over UNIX domain sockets can lose messages, if the
receiving process is too slow and the buffers fill up.


Basically, in logging, you have two choices when buffers get full:
pause the program/thread until buffer space is available (using e.g.
straight writes to file, or runit/daemontools-style logging to
stdout), or lose log messages (decision made by glibc/POSIX for you).

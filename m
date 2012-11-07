From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: Add monitor problems
Date: Tue, 6 Nov 2012 19:44:31 -0800
Message-ID: <CA+jddaPU7YzvhoeZAsZs4sXG4cGnXdY8UJ-OHjP0+Md0KoEXOA@mail.gmail.com>
References: <CA+jddaMSc-Oa-xHGnYGo0xgZmLBFuJ4y5uv6d4HYNBm-G+_-0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62854 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab2KGDoc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 22:44:32 -0500
Received: by mail-wi0-f172.google.com with SMTP id hq12so4890461wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 19:44:31 -0800 (PST)
In-Reply-To: <CA+jddaMSc-Oa-xHGnYGo0xgZmLBFuJ4y5uv6d4HYNBm-G+_-0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Engineering <eng@piston.cc>

Sorry, all.  It turns out the problems were entirely on our side (bad
ceph.conf files on the new servers).

On Tue, Nov 6, 2012 at 11:09 AM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> I'm seeing some weird errors when I add multiple monitors and I'm
> hoping the list can shed some light to let me know if I need to
> completely change the way I'm doing it or if I'm seeing a bug.
>
> What happens is this:  I start with a happy cluster with 3 monitors
> (mon.0, mon.1, and mon.2)  I expand my cluster and want to add mon.3
> and mon.4.  Because of the way I start up nodes, I end up adding mon.4
> before I add mon.3, which seems to result in some errors as can be
> seen in the attached log.  It gets worse when I add the next two
> monitors (mon.6 followed by mon.5).
>
> I suspect the issue is in starting the monitors out of order with just
> enough time between to cause problems.  In any event, please examine
> the log and let me know if it is a bug that can easily be fixed or if
> it is a "feature" I need to work around.
>
> ceph --version reports:
>
>  ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>
> The first "mon add" command can be found starting at 19:59:50 in the
> mon log. Subsequent monitor additions happened at 20:02:01, 20:08:35,
> and finally 20:13:42.
>
> Regards,
> Mandell Degerness

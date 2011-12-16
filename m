From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Return stale file handle (-ESTALE) like NFS instead of hanging forever?
Date: Fri, 16 Dec 2011 11:16:01 -0800
Message-ID: <CAORUGqBDwTOTMKEjiqM1Y705cMXAhr5cqDESC970WFB0GkiPiQ@mail.gmail.com>
References: <201112081455.56365.a.ott@m-privacy.de> <CAF3hT9CHwgkuXynhdM9bmG2g6n2pFYdxxwRH3mCw7Jxcp6QfzQ@mail.gmail.com>
 <201112160936.35587.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41278 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1LPTQX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 14:16:23 -0500
Received: by wgbdr13 with SMTP id dr13so6716735wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 11:16:22 -0800 (PST)
In-Reply-To: <201112160936.35587.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Fri, Dec 16, 2011 at 00:36, Amon Ott <a.ott@m-privacy.de> wrote:
> Our server clusters have quite a few cron jobs as well as Nagios health checks
> that also access the common data area on Ceph FS for configuration and status
> storage. If these jobs hang forever because of a blocked access, they cannot
> finish their other tasks - even if that access is not vital for these other
> tasks. Specially, they can never return a result. You cannot even shutdown
> the system cleanly, if umount blocks forever.

Especially for Nagios checks, you really want to be very defensive
about things that might hang. I've seen too many nagios checks hanging
e.g. due to TCP, so I'd recommend using a generic timeout mechanism to
make sure all your checks, everywhere, fail if they take too long..
There's no point in waiting for a health check that's run every 5
minutes for more than 5 minutes.

Something like /usr/bin/timeout from coreutils is your friend.

(Whether this applies to cron jobs is a different conversation.. I
tend to think "yes"; I've seen too many systems pile up a hundred
instances of the same hourly cronjob.)

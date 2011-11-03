From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Feature request: "max mon" setting
Date: Thu, 3 Nov 2011 09:50:41 -0700
Message-ID: <CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
References: <201111031302.51236.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58825 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933891Ab1KCQvD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 12:51:03 -0400
Received: by wyh15 with SMTP id 15so1405058wyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 09:51:02 -0700 (PDT)
In-Reply-To: <201111031302.51236.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 3, 2011 at 05:02, Amon Ott <a.ott@m-privacy.de> wrote:
> Documentation recommends three monitors. In our special cluster configuration,
> this would mean that if accidentially two nodes with monitors fail (e.g. one
> in maintenance and one crashes), the whole cluster dies. What I would really

If you feel two monitors going down is too likely, run a monitor
cluster of size 5. And if you feel 3 monitors going down is too
likely, run 7.

> like would be that I can define a monitor on each node and e.g. set "max mon
> = 3". Each monitor starting up can then check how many monitors are already
> up and go to standby, if the number has already been reached. Regular
> rechecking could allow another monitor to become active, if one of the
> previously active monitors has died. Just like "max mds" actually.

Unfortunately, that is fundamentally not wanted. That would let a so
called "split brain" situation occur, and the whole purpose of the
majority rule of monitors is to ensure that it does not happen. If we
didn't care about that, the monitors left standing would never need to
stop operating.

> A special case that gives me most headaches is the case of just two active
> nodes. According to documentation, the monitor problem means that one failing
> monitor kills the cluster whatever the number of defined monitors (1 or 2),
> even if we have all data safely placed on both nodes.

Yes, 1 or 2 total physical nodes in a Ceph cluster makes it hard to do
HA. You could run just one ceph-mon, then the other node failing
doesn't affect the cluster at all (but naturally the one running
ceph-mon must not fail).

Perhaps you can get a third machine to also be a monitor, even if it
doesn't participate in storage etc. ceph-mon is a very lightweight
process. Share a server that has other responsibilities, or buy the
cheapest atom netbook you can find -- it should do the job just fine.

Clusters of <=2 nodes are pretty far from what Ceph was designed for,
and while we use them all the time for testing, running a setup that
small for real is pretty rare. Sorry.

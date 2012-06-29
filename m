From: Brian Edmonds <mornir@gmail.com>
Subject: Re: ceph performance under xen?
Date: Fri, 29 Jun 2012 13:54:39 -0700
Message-ID: <CAMsVa3tJOf0JcY6Maq2SJaor_=e-iMyxsOihuLJNSzTZ23ydtg@mail.gmail.com>
References: <CAMsVa3t8foWYguozDeFCiHf0jrK6b2+L4pKtU__-G1mTVVHzWg@mail.gmail.com>
 <CAPYLRzgMAPuTKOeZC78J48V1wCuL_7v-5Aj6YQX2Q=0BgQ5Cuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35369 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab2F2UzB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 16:55:01 -0400
Received: by qcro28 with SMTP id o28so1977483qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 13:55:00 -0700 (PDT)
In-Reply-To: <CAPYLRzgMAPuTKOeZC78J48V1wCuL_7v-5Aj6YQX2Q=0BgQ5Cuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 11:55 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> So right now you're using the Ceph filesystem, rather than RBD, right=
?

Right, CephFS.  I'm actually not even very clear on what RBD is, and
how one might use it, but I'm sure I'll understand that in the
fullness of time.  I came to Ceph from a background of wanting to
replace my primary RAID array with a RAIM (redundant array of
inexpensive machines) cluster, and a co-worker suggested Ceph as a
possibility.

> What processes do you have running on which machines/VMs? What's the
> CPU usage on the ceph-mds process?

I have four VMs running Debian testing, with a dom0 on a recent 6-core
AMD cpu (I forget which one).  Each VM has two virtual cores, 1GB of
RAM, and a 500GB virtual disk partition formatted with btrfs, used for
both data and journal.  These are somewhat smaller than recommended,
but in the right ballpark, and the filesystem has so far not been used
to store any significant amount of data.  (Mostly just bonnie tests.)

All four VMs are running OSD, the first three are running MON, and the
first two MDS.  I mostly watch top on the first machine (if there's a
better tool for watching a cluster, please let me know), and it shows
the majority of the CPU time in wait, with the Ceph jobs popping up
from time to time with a fraction of a percent, sometimes up into
single digits.  It's also not uncommon to see a lot of idle time.
When I get some time I'm going to wrap some sort of collector around
the log files and feed the data into OpenTSDB.

> And a warning: the filesystem, while nifty, is not yet
> production-ready =97 it works great for some use cases but there are
> some serious known bugs that aren't very hard to trigger, as we've
> been doing a lot of QA on RADOS and its associated systems (which the
> filesystem depends on) at the expense of the filesystem itself.

Good to know.  For now I'm just playing, but I eventually want to have
a distributed filesystem that I can use.  I'm curious to see how Ceph
does when deployed on real hardware, which I expect to have in the
next couple weeks.  Very simple stuff compared to what I see others on
the list discussing: a few dual core Atom systems with 1TB of drive
and 4GB of RAM each, all on a 1Gb switch.

Brian.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

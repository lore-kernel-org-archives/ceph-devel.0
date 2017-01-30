From: Sage Weil <sweil@redhat.com>
Subject: Re: mds: Doing fewer backtrace reads during rejoin (was: MDS flapping:
 how to increase MDS timeouts?)
Date: Mon, 30 Jan 2017 14:40:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701301437160.3654@piezo.novalocal>
References: <CALe9h7dCeP7yxOSTOPYkWPZ8L0WsFWFcBXW=c+z8=TWs771icA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932218AbdA3OrR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 09:47:17 -0500
In-Reply-To: <CALe9h7dCeP7yxOSTOPYkWPZ8L0WsFWFcBXW=c+z8=TWs771icA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>, Zheng Yan <ukernel@gmail.com>, Burkhard Linke <Burkhard.Linke@computational.bio.uni-giessen.de>

On Mon, 30 Jan 2017, John Spray wrote:
> This case (see forwarded) is showing that our current rejoin code is
> handling situations with many capabilities quite badly -- I think we
> should try and improve this soon.
> 
> One thought I have is to just throttle the number of open_inos that we
> do, so that we allow the cache to get populated with the already hit
> dirfrags before trying to load more backtraces, created a ticket for
> that here: http://tracker.ceph.com/issues/18730 (should be pretty
> simple and doable for luminous).  That would help in cases where many
> of the affected inodes were in the same directory (which I expect is
> all real workloads).

This sounds like the way to go.  At the very least it will throttle.

> There are probably other bigger changes we could make for this case,
> such as using the path passed in cap_reconnect_t to be smarter, or
> even adding a metadata pool structure that would provide super-fast
> lookup of backtraces for the N most recently touched ones -- not
> saying we necessarily want to go that far!

If we had a hint on the parent directory, we could track in-flight 
open_inos and limit it per parent directory, since that is where the 
duplicated/wasted work is generally coming from...

sage



> 
> John
> 
> 
> ---------- Forwarded message ----------
> From: Burkhard Linke <Burkhard.Linke@computational.bio.uni-giessen.de>
> Date: Mon, Jan 30, 2017 at 7:09 AM
> Subject: Re: [ceph-users] MDS flapping: how to increase MDS timeouts?
> To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
> 
> 
> Hi,
> 
> 
> 
> On 01/26/2017 03:34 PM, John Spray wrote:
> >
> > On Thu, Jan 26, 2017 at 8:18 AM, Burkhard Linke
> > <Burkhard.Linke@computational.bio.uni-giessen.de> wrote:
> >>
> >> HI,
> >>
> >>
> >> we are running two MDS servers in active/standby-replay setup. Recently we
> >> had to disconnect active MDS server, and failover to standby works as
> >> expected.
> >>
> >>
> >> The filesystem currently contains over 5 million files, so reading all the
> >> metadata information from the data pool took too long, since the information
> >> was not available on the OSD page caches. The MDS was timed out by the mons,
> >> and a failover switch to the former active MDS (which was available as
> >> standby again) happened. This MDS in turn had to read the metadata, again
> >> running into a timeout, failover, etc. I resolved the situation by disabling
> >> one of the MDS, which kept the mons from failing the now solely available
> >> MDS.
> >
> > The MDS does not re-read every inode on startup -- rather, it replays
> > its journal (the overall number of files in your system does not
> > factor into this).
> >
> >> So given a large filesystem, how do I prevent failover flapping between MDS
> >> instances that are in the rejoin state and reading the inode information?
> >
> > The monitor's decision to fail an unresponsive MDS is based on the MDS
> > not sending a beacon to the mon -- there is no limit on how long an
> > MDS is allowed to stay in a given state (such as rejoin).
> >
> > So there are two things to investigate here:
> >   * Why is the MDS taking so long to start?
> >   * Why is the MDS failing to send beacons to the monitor while it is
> > in whatever process that is taking it so long?
> 
> 
> Under normal operation our system has about 4.5-4.9 million active
> caps. Most of them (~ 4 millions) are associated to the machine
> running the nightly backups.
> 
> I assume that during the rejoin phase, the MDS is renewing the
> clients' caps. We see massive amount of small I/O on the data pool (up
> to 30.000-40.000 IOPS) during the rejoin phase. Does the MDS need to
> access the inode information to renew a cap? This would explain the
> high number of IOPS and why the rejoin phase can take up to 20
> minutes.
> 
> Not sure about the second question, since the IOPS should not prevent
> beacons from reaching the monitors. We will have to move the MDS
> servers to different racks during this week. I'll try to bump up the
> debug level before.
> 
> 
> Regards,
> Burkhard
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

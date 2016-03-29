From: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Subject: RE: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Tue, 29 Mar 2016 06:21:33 +0000
Message-ID: <6be5638226ba40f89bf9bdfb35fefe8e@R01UKEXCASM222.r01.fujitsu.local>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
 <CAOi1vP89OgUmvozXRO9cvNS-KYaSkBGQRkPS3UeNa2+kgAHkmA@mail.gmail.com>
 <CAJ4mKGbDQEyRfeMskBwsTxK_qoJY_4GfGfFz1h1ht6h6E0xhSg@mail.gmail.com>
 <CANP1eJFto2wEGaWt_dgys-cMQn_6t3wFrWwcURwkX0Y+HY_PKQ@mail.gmail.com>
 <alpine.DEB.2.11.1603251109400.26068@cpach.fuggernut.com>
 <9939bca9f29e4dafadf5946cf4392a98@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.173]:6097 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525AbcC2GVk convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Mar 2016 02:21:40 -0400
In-Reply-To: <9939bca9f29e4dafadf5946cf4392a98@R01UKEXCASM222.r01.fujitsu.local>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, Sage Weil <sweil@redhat.com>, Milosz Tanski <milosz@adfin.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Igor.Podoski@ts.fujitsu.com
> Sent: Tuesday, March 29, 2016 8:07 AM
> To: Sage Weil; Milosz Tanski
> Cc: Gregory Farnum; Ilya Dryomov; ceph-devel
> Subject: RE: Ceph watchdog-like thing to reduce IO block during process goes
> down by abort()
> 
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, March 25, 2016 4:13 PM
> > To: Milosz Tanski
> > Cc: Gregory Farnum; Ilya Dryomov; Podoski, Igor; ceph-devel
> > Subject: Re: Ceph watchdog-like thing to reduce IO block during
> > process goes down by abort()
> >
> > On Fri, 25 Mar 2016, Milosz Tanski wrote:
> > > On Thu, Mar 24, 2016 at 4:25 PM, Gregory Farnum
> <gfarnum@redhat.com>
> > wrote:
> > > > On Thu, Mar 24, 2016 at 12:53 PM, Ilya Dryomov
> > > > <idryomov@gmail.com>
> > wrote:
> > > >> On Thu, Mar 24, 2016 at 8:00 AM, Igor.Podoski@ts.fujitsu.com
> > > >> <Igor.Podoski@ts.fujitsu.com> wrote:
> > > >>> Hi Cephers!
> > > >>>
> > > >>> Currently when we had a disk failure, assert() and then abort()
> > > >>> was
> > triggered and process was killed (ABRT). Other osds will eventually
> > mark dead one as down, but it depends of heartbeat settings and
> > monitor settings
> > (mon_osd_min_down_reporters/mon_osd_min_down_reports). During
> > dead-not-marked-as-down osd you can see blocked IO during writes and
> reads.
> > > >>>
> > > >>> Recently I've made https://github.com/ceph/ceph/pull/7740 which
> > > >>> is
> > about sending MakrMeDown msg to monitor just before osd is going bye-
> > bye. It prevents blocked IO in above case, and any other assert that
> > is not on message sending path, so I need messenger/pipes/connections
> > working for this. I've made some test and it looks good, when I pull
> > out drive from my cluster during rados bench, IO blocks for less than
> > 1 second or not at all, previously it was > 10 sec (on my cluster settings).
> > > >>>
> > > >>> Sage pointed me that some time ago was similar PR
> > https://github.com/ceph/ceph/pull/6514 and there was a thought about
> > ceph-watchdog process, that could monitor osd's and send info directly
> > to monitor when they disappear. This would prevent all assert() cases,
> > and other ones like kill -9 or similar.
> > > >>>
> > > >>> I have a few ideas how such functionality could be implemented,
> > > >>> so
> > my question is - does any of you started already doing something similar?
> > > >>>
> > > >>> Let's have a brain storm about it!
> > > >>>
> > > >>> Ideas about improving 7740/6514 MarkMeDown internal mechanism:
> > > >>> - I think, I could send message with MarkMeDown payload, but in
> > > >>> a
> > raw way, not through Messenger path. This could be as good as bad in
> > this case.
> > > >>> - I could poke osd-neighbor through signal and neighbor will
> > > >>> send
> > Mark(SignalSender)Down message (this won't work If whole hdd
> > controller will be down, all osd will be dead in narrow time window).
> > So it's like instant bad-health heartbeat message. Still depends of
> > Messenger send path of osd-neighbor.
> > > >>
> > > >>>
> > > >>> External ceph-watchdog:
> > > >>> Just like Sage wrote
> > https://github.com/ceph/ceph/pull/6514#issuecomment-159372845 Or
> > similar: each osd, during start passes its own PID to ceph-watchdog
> > process through shared memory/socket/named pipe (whatever).
> > Ceph-watchdog checks if current PID exists, by checking changes in
> > /proc/PID or /proc/PID/cmd directory/file (maybe Inotify could handle
> > this). When file or folder is changed(missing) it sends
> > MarkThisOsdDown to monitor and that's all. But this won't be watchdog
> strict, rather process down notify.
> > > >>>
> > > >>> Or maybe both ways PR7740 + external ?
> > > >>
> > > >> I'm not involved in any of this, but since you asked for a brain
> > > >> storm... ;)
> > > >>
> > > >> Is it worth bothering with the corrupted data structures case at all?
> > > >> Trying to handle it from within the aborting ceph-osd process is
> > > >> not a very easy thing to do ("raw way, not through Messenger",
> > > >> signals, etc) and if you do it wrong, you'd mask the original
> > > >> stack trace.  An external ceph-watchdog is yet another entity
> > > >> which has to be set up, maintained and accounted for.
> > > >>
> > > >> Why not just distinguish legitimate/expected errors which we
> > > >> check for but currently handle with assert(0) and the actual
> > > >> assert failures?  In the vast majority of cases that fall into
> > > >> the former bucket all of the internal data structures, including
> > > >> the messenger, will be in order and so we can send a MarkMeDown
> > message
> > > >> and fail gracefully.  Implementing it is just a matter of
> > > >> identifying those sites, but that's not a bad exercise to do even
> > > >> on its
> > own.
> > > >>
> > > >> The actual assert failures can abort() as they do now.  Any such
> > > >> failure is a serious bug and there's hopefully not too many of
> > > >> them to worry about shrinking the timeout to a minimum, unless
> > > >> there are hard numbers that prove otherwise, of course.  And if
> > > >> you kill -9 your OSDs, you deserve to wait for MONs to catch up.
> > > >> Am I missing any use cases here?
> > > >
> > > > This is something Sam and I have talked about in the past, but
> > > > apparently Sage didn't like that idea in
> > > > https://github.com/ceph/ceph/pull/6514 and suggested a daemon
> > > > watcher instead?
> > > > Personally I tend towards building that kind of functionality into
> > > > the daemon, although he's right it will never be quite as good at
> > > > catching all cases as an external manager. The upside is that we
> > > > don't have to worry about the failure cases between the two of them.
> > > > ;) -Greg
> > >
> > > There's no reason the watcher process can't be a child that's kicked
> > > off when the OSD startups. If there's a pipe between the two, when
> > > the parent goes away the child will get a EOF on reading from the
> > > pipe. On Linux you can also do a cute trick to have the child
> > > notified when parent quits using prctl(PR_SET_PDEATHSIG, SIG???).
> >
> > That does simplify the startup/management piece, but it means one
> > watcher per OSD, and since we want the watcher to have an active mon
> > session to make the notification quick, it doubles the mon session load.
> 
> We could also do it like this:
> 
> ceph-watchdog creates named pipe in /var/lib/ceph
> 
> osd before abort will:
> - open file
> - wite its own id 0,1,2...
> - close file
> 
> ceph-watchdog:
> - waits for osd ids on named pipe
> - issues a mon_command()  e.g. cmd=[{"prefix": "osd down", "ids": ["1"]}]  to
> the monitor just like ceph osd down, this can be done by librados from
> C/python, already have small PoC in python for this, seems to work.

Of course it keeps connection to monitor open/active all the time.

> Thanks to above we have one watcher per host, no connections from osd ->
> watchdog, but looking on the downsides:
> - we could hit open files limit
> - or anything else using open/write/close
> - multiple OSD's could write to pipe in the same time (maybe using small
> constant writes here won't be an issue, currently checking this)

Additional advantage by writing OSD id to fifo - we could easily do a backup mechanism in systemd for open/write/close fail.

> Regards,
> Igor.
> 
> > Honestly I don't think the separate daemon is that much of an
> > issue--it's a systemd unit file and a pretty simple watchdog process.
> > The key management and systemd enable/activate bit is the part that
> > will be annoying.
> >
> > sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

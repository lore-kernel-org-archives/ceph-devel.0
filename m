From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cephfs set_layout on filesystem root?
Date: Wed, 19 Jan 2011 10:55:56 -0700
Message-ID: <1295459756.6777.41.camel@sale659.sandia.gov>
References: <1295455606.6777.23.camel@sale659.sandia.gov>
 <AANLkTi=LNa0AyiT4UfyrJLQrUCrPDACBocsiQV=yw7GQ@mail.gmail.com>
 <1295457888.6777.33.camel@sale659.sandia.gov>
 <AANLkTimZ_=WxGPJUcAM0LOwxazXj3nVgNvQSCqRFOk9k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:43531 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1ASR4L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 12:56:11 -0500
In-Reply-To: <AANLkTimZ_=WxGPJUcAM0LOwxazXj3nVgNvQSCqRFOk9k@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

On Wed, 2011-01-19 at 10:34 -0700, Gregory Farnum wrote:
> On Wed, Jan 19, 2011 at 9:24 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > Hi Greg,
> >
> > On Wed, 2011-01-19 at 10:00 -0700, Gregory Farnum wrote:
> >> On Wed, Jan 19, 2011 at 8:46 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> >> > Hi,
> >> >
> >> > I've been experimenting with using cephfs to set
> >> > the object/stripe size on a Ceph filesystem root,
> >> > and it seems to not persist across a filesystem
> >> > restart.  Is that expected behavior?
> >> > ...
> >> > Am I missing something?
> >> Hmmm, not that I see. It should definitely be a persistent setting.
> >>
> >> <debug_mode>
> >> Have you tried this on non-root directories, and were results the same
> >> or different?
> >> </debug_mode>
> >> -Greg
> >>
> >
> > I tried to test this, but got this instead after
> > restarting my filesystem:
> >
> > 2011-01-19 10:16:31.073571 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 47/47/9) [41] r=0 mlcod 0'0 !hml degraded] clear_prior
> > 2011-01-19 10:16:31.073584 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml degraded] noting past interval(47-47 [41]/[41])
> > 2011-01-19 10:16:31.073598 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml degraded] cancel_recovery
> > 2011-01-19 10:16:31.073610 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml degraded] clear_recovery_state
> > 2011-01-19 10:16:31.073623 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml inactive] clear_primary_state
> > 2011-01-19 10:16:31.073653 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml inactive] clear_prior
> > 2011-01-19 10:16:31.073668 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml inactive] up [41] -> [41,53], acting [41] -> [41,53], role 0 -> 0
> > 2011-01-19 10:16:31.073681 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml inactive] on_change
> > 2011-01-19 10:16:31.073783 7f318f7fe940 osd41 48 pg[3.62f( empty n=0 ec=2 les=18 48/48/9) [41,53] r=0 mlcod 0'0 !hml inactive] [41] -> [41,53], replicas changed
> > 2011-01-19 10:16:31.092006 7f318f7fe940 osd41 48 write_superblock sb(01d356fc-7539-8c8d-7e49-8a2f42242802 osd41 e48 [1,48] lci=[9,23])
> > os/FileStore.cc: In function 'void FileStore::sync_entry()':
> > os/FileStore.cc:2309: FAILED assert(r == 0)
> >  ceph version 0.24.1 (commit:6152f5227d1ab177230211b6d25e62d6094e26e6)
> >  1: (FileStore::sync_entry()+0x25d9) [0x5a79a9]
> >  2: (FileStore::SyncThread::entry()+0xd) [0x522b7d]
> >  3: (Thread::_entry_func(void*)+0x7) [0x48a467]
> >  4: /lib64/libpthread.so.0 [0x7f319d05c73d]
> >  5: (clone()+0x6d) [0x7f319bf72f6d]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> >
> > ---
> >
> > So the sequence of events was:
> > - create new file system, start, mount
> > - create a directory, change its object/stripe sizes (to 512 KiB)
> > - unmount, shut down filesystem, restart
> >  ==> osd assert.
> Okay, this is probably unrelated to your attempt to change non-root
> dir layouts. (It's in the OSD, which just isn't going to care at all
> about metadata changes.) Can you gather up the debug info for that and
> file a bug report?

Given Sage's reply, do you still want this information?

-- Jim

> 
> I'll work on reproducing the dir layout issue here shortly (shouldn't
> be hard) and let you know what I come up with. :)
> -Greg
> 



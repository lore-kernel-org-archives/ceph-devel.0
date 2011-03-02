From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 2 Mar 2011 16:25:06 -0700
Message-ID: <1299108306.4750.66.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov>
 <1299106628.4750.62.camel@sale659.sandia.gov>
 <AANLkTikg0n23FdcRc-r=aLbT3UbfORu6xhFP+WQ-6KL2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:33006 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab1CBXZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 18:25:18 -0500
In-Reply-To: <AANLkTikg0n23FdcRc-r=aLbT3UbfORu6xhFP+WQ-6KL2@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-02 at 16:20 -0700, Gregory Farnum wrote:
> On Wed, Mar 2, 2011 at 2:57 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> >
> > On Wed, 2011-03-02 at 14:59 -0700, Jim Schutt wrote:
> >>
> >> On Wed, 2011-03-02 at 14:45 -0700, Sage Weil wrote:
> >> > On Wed, 2 Mar 2011, Jim Schutt wrote:
> >> > >
> >> > > On Wed, 2011-03-02 at 10:10 -0700, Sage Weil wrote:
> >> > > > > I'll see if I see the same signature with master,
> >> > > > > and post logs.
> >> > > >
> >> > > > Thanks!  Keep us posted.
> >> > >
> >> > > Hmmm, I'm not having much luck with master (commit
> >> > > 0fb5ef2ce92 + extra debugging) on a 96-osd filesystem;
> >> > > lots of dead OSDs during startup.
> >> >
> >> > Commit c916905a8a14029653aae45f0a9fb6c9b4c39e05 (master) should fix this.
> >>
> >> I try it out, thanks!
> >
> > I don't get any more core files with master commit 67355779ecc.
> > Now my cosds just die - no stack trace in the log, no core
> > file, nothing in syslog or dmesg ...
> Another commit got in that changed the logging behavior slightly --
> which log file are you opening?
> 

Well, I don't have any specific logging config.
So my logs would show up in /var/log/ceph, and
they still seem to be there.  They contain logging
info, just not a stack trace that might explain
why the cosd died.

-- Jim




From: Sage Weil <sage@newdream.net>
Subject: Re: ECONNREFUSED implies OSD definitely failed
Date: Fri, 29 Apr 2016 08:29:59 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604290828520.26967@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com> <20160428143251.GA1541@suse.de> <20160429074639.GG26146@predictor>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1482829140-1461933002=:26967"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbcD2M3x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2016 08:29:53 -0400
In-Reply-To: <20160429074639.GG26146@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>
Cc: Lars Marowsky-Bree <lmb@suse.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1482829140-1461933002=:26967
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 29 Apr 2016, Piotr Dałek wrote:
> On Thu, Apr 28, 2016 at 04:32:51PM +0200, Lars Marowsky-Bree wrote:
> > On 2016-04-22T12:24:52, Sage Weil <sweil@redhat.com> wrote:
> > 
> > > Piotr has a PR at
> > > 
> > > 	https://github.com/ceph/ceph/pull/8558
> > > 
> > > that changes the messenger and OSD logic so that if we get an ECONNREFUSED 
> > > trying to talk to another OSD we can definitively conclude that the OSD is 
> > > down/failed, without waiting for the normal heartbeat timeout.
> > > 
> > > I think this is true in normal networking environments.  My only concern 
> > > is that there might be cases where the OSD isn't actually down and some 
> > > transient network issue could cause ECONNREFUSED.  Like... some 
> > > firewally magic networky thing.  If a transient ECONNREFUSED was possible, 
> > > it could cause some ugly flapping.
> > > 
> > > Can anyone think of something that might cause this?  Even if it is 
> > > something obscure, it means we should have a config option to disable this 
> > > new behavior (we probably should anyway).
> > 
> > Exactly this - the system reconfiguring it's network interfaces and
> > firewall rules (in a suboptimal fashion; it should drop, not reject, but
> > ...).
> 
> I'm not convinced that we should care about this. I think that probability
> of (re)connect event occurrence during firewall reconfiguration is quite
> low.

Yeah, I tend to agree.

Let's just add a config option to control the new behavior so that if, for 
some reason, there is an environment where this does happen the fast-fail 
can be disabled.

sage
--8323329-1482829140-1461933002=:26967--

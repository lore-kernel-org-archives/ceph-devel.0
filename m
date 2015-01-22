From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: crush_location hook vs calamari
Date: Thu, 22 Jan 2015 09:18:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501220858320.19192@cobra.newdream.net>
References: <CAOWd=nBExJbD72ereRmn_mv_u=cODRnvDif8RcUiLejcQqKoOg@mail.gmail.com> <CAGd4Wr2+AD2J690cdcSwknLhUX16SR+WRQDVpn=+UB9mnO0-Yg@mail.gmail.com> <alpine.DEB.2.00.1501160924050.15918@cobra.newdream.net> <CAOWd=nCSAqmSok7+sXm8VqZDUWbdsBDiLovzcDVUXk3018pQ2w@mail.gmail.com>
 <CAOWd=nAEyuENX63roRhXDnf3QGi4ewm=61FyBAjNHZsGRMVyMg@mail.gmail.com> <alpine.DEB.2.00.1501190814300.26676@cobra.newdream.net> <CAOWd=nAN5SX2L=eQyn=kCV7skbyWa=qR5AKLkZ8wNnL4je3MJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbbAVRSO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 12:18:14 -0500
In-Reply-To: <CAOWd=nAN5SX2L=eQyn=kCV7skbyWa=qR5AKLkZ8wNnL4je3MJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>

On Tue, 20 Jan 2015, Gregory Meno wrote:
> >> [...]
> >> You are right about not really addressing calamari. The thing I need
> >> to solve is how to make ceph-crush-location script smart about
> >> coexisting with changes to the crush map.
> >
> > Yep, let's solve that problem first.  :)
> 
> So I see solving this problem with Calamari is a precursor to
> improving the way this is handled in Ceph.
> 
> How does this sound:
> 
> When Calamari makes a change to the CRUSH map where an OSD gets
> reparented to a different CRUSH tree  it stores a set of key-value
> pairs and physical host in ceph config-key e.g.
> 
> rootA -> hostA -> OSD1, OSD2
> 
> becomes
> 
> rootA -> hostA -> OSD1
> 
> rootB -> hostB -> OSD2
> 
> and
> 
> ceph config-key get 'calamari:1:osd_crush_location:osd.2' = {'paths':
> [[root=rootB, host=hostB]], 'physical_host': hostA}
> 
> When the OSD starts up a calamari-specific script sends a mon command
> to get the data we persisted in the config-key, if none exists we
> return the default crush_path, otherwise if match the physical_host to
> the node where this OSD is starting then we return the stored path. If
> the host match fails we return the default crush_path so that
> hot-plugging continues to work.
> 
> and Calamari sets "osd crush location hook" on all OSDs it manages

Hmm, with that logic, I think what we have now will actually work 
unmodified?  If the *actual* crush location is, say,

 root=a rack=b host=c

and the hook says

 root=foo rack=bb host=c

it will make no change. It looks for the innermost (by crush type id) 
field and if it matches it's a no-op.  OTOH if the hook says

 root=foo rack=bb host=cc

then it will move it to a new location.  Again, though, we start with the 
innermost fields and stop once there is a match.  So if rack=bb exists but 
under root=bar, we will end up with

 root=bar rack=bb host=cc

because we stop at the first item that is already present 
(rack=bb).

Mainly this means that if we move a host to a new rack the OSDs won't move 
themselves around... the admin needs to adjust the crush map explicitly.

Anwyay, does that look right?

...

If that *doesn't* work, it brings up a couple questions, though...

1) Should this be a 'calamari' override or a generic ceph one?  It could 
go straight into the default hook.  That would simplify things.

2) I have some doubts about whether the crush location update via the init 
script is a good idea.  I have a half-finished patch that move this step 
into the OSD itself so that the init script doesn't block when the mons 
are down; instead, ceph-osd will start (and maybe fork) as usual and then 
retry until the mons become available, do the crush update, and then do 
the rest of its boot sequence.  We also avoid duplicating the 
implementation in the sysvinit script and upstart/systemd helper (which 
IIRC is somewhat awkward to trigger, the original motivation for this 
patch).

sage

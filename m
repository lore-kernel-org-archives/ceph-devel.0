From: Sage Weil <sweil@redhat.com>
Subject: Re: Fwd: crush_location hook vs calamari
Date: Thu, 22 Jan 2015 09:28:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501220926540.19192@cobra.newdream.net>
References: <CAOWd=nBExJbD72ereRmn_mv_u=cODRnvDif8RcUiLejcQqKoOg@mail.gmail.com> <CAGd4Wr2+AD2J690cdcSwknLhUX16SR+WRQDVpn=+UB9mnO0-Yg@mail.gmail.com> <alpine.DEB.2.00.1501160924050.15918@cobra.newdream.net> <CAOWd=nCSAqmSok7+sXm8VqZDUWbdsBDiLovzcDVUXk3018pQ2w@mail.gmail.com>
 <CAOWd=nAEyuENX63roRhXDnf3QGi4ewm=61FyBAjNHZsGRMVyMg@mail.gmail.com> <alpine.DEB.2.00.1501190814300.26676@cobra.newdream.net> <CAOWd=nAN5SX2L=eQyn=kCV7skbyWa=qR5AKLkZ8wNnL4je3MJw@mail.gmail.com> <alpine.DEB.2.00.1501220858320.19192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57938 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbbAVR20 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Jan 2015 12:28:26 -0500
In-Reply-To: <alpine.DEB.2.00.1501220858320.19192@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>

On Thu, 22 Jan 2015, Sage Weil wrote:
> 2) I have some doubts about whether the crush location update via the init 
> script is a good idea.  I have a half-finished patch that move this step 
> into the OSD itself so that the init script doesn't block when the mons 
> are down; instead, ceph-osd will start (and maybe fork) as usual and then 
> retry until the mons become available, do the crush update, and then do 
> the rest of its boot sequence.  We also avoid duplicating the 
> implementation in the sysvinit script and upstart/systemd helper (which 
> IIRC is somewhat awkward to trigger, the original motivation for this 
> patch).

Nevermind, I remember why this didn't get very far.. the OSD works off the 
crush_location option but that still needs to be filled in by the hook, so 
either the init systems needs to do a --crush-location `...` deal (meh) or 
ceph-osd has to call the hook directly (meh).

sage


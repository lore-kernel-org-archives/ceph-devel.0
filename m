From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 21 Apr 2017 13:16:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704211313220.6575@piezo.novalocal>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl> <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl> <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com> <68eaf07b-e611-fb55-ca9c-08dceb8cae14@digiware.nl>
 <5d1fbebf-243b-ece9-0a77-961f4d269c53@suse.cz> <20170421091325.t23jra6qdbfjgjeh@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2134854468-1492780585=:6575"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58033 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1039783AbdDUNQ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Apr 2017 09:16:27 -0400
In-Reply-To: <20170421091325.t23jra6qdbfjgjeh@nora.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Fabian_Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>, Joao Eduardo Luis <joao@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2134854468-1492780585=:6575
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2017, Fabian Grünbichler wrote:
> On Thu, Apr 20, 2017 at 08:11:38PM +0200, Nathan Cutler wrote:
> > Hi Willem:
> > 
> > It sounds like you are trying to use the sysvinit scripts? These have been
> > unmaintained (presumably with lots of weeds growing up) since infernalis.
> > Until now I have been assuming that all init systems other than systemd
> > (sysvinit, upstart, etc.) are deprecated in Ceph.
> 
> Slightly OT, but AFAICT http://tracker.ceph.com/issues/18305 still
> applies to the official ceph.com Kraken Debian packages, i.e., ceph-base
> installs and activates the init.d script, which then races against the
> (udev-activated) ceph-osd systemd units. If anything except systemd is
> indeed deprecated, I wonder why the Debian packages (still) ship AND
> activate both systemd units and Sys V init scripts?
> 
> (Note that the proposed fix probably does not apply as is anymore,
> because ceph-disk and the systemd units have been changed in the
> meantime).

I think the issue with Debian (generally) is that it "supports" multiple 
init systems (sysvinit and systemd both), even though systemd is the one 
installed default.  Which means we ship the sysvinit script and systemd 
unit files.

(There may very well be a bug in how we "activate" them, though!)

sage
--8323329-2134854468-1492780585=:6575--

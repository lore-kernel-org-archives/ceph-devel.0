From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Mon, 16 Oct 2017 22:34:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710162233120.26702@piezo.us.to>
References: <dae3fb33-f7ac-454b-9a3c-1c311ab8ce71@zimbra>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:44937 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbdJPWe6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Oct 2017 18:34:58 -0400
In-Reply-To: <dae3fb33-f7ac-454b-9a3c-1c311ab8ce71@zimbra>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Verevkin <anthony@verevkin.ca>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com, Alfredo Deza <adeza@redhat.com>

On Mon, 16 Oct 2017, Anthony Verevkin wrote:
> 
> > From: "Sage Weil" <sage@newdream.net>
> > To: "Alfredo Deza" <adeza@redhat.com>
> > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com
> > Sent: Monday, October 9, 2017 11:09:29 AM
> > Subject: [ceph-users] killing ceph-disk [was Re: ceph-volume: migration and disk partition support]
> > 
> > To put this in context, the goal here is to kill ceph-disk in mimic.
> > 
> 
>  
> > Perhaps the "out" here is to support a "dir" option where the user
> > can
> > manually provision and mount an OSD on /var/lib/ceph/osd/*, with
> > 'journal'
> > or 'block' symlinks, and ceph-volume will do the last bits that
> > initialize
> > the filestore or bluestore OSD from there.  Then if someone has a
> > scenario
> > that isn't captured by LVM (or whatever else we support) they can
> > always
> > do it manually?
> > 
> 
> In fact, now that bluestore only requires a few small files and symlinks 
> to remain in /var/lib/ceph/osd/* without the extra requirements for 
> xattrs support and xfs, why not simply leave those folders on OS root 
> filesystem and only point symlinks to bluestore block and db devices? 
> That would simplify the osd deployment so much - and the symlinks can 
> then point to /dev/disk/by-uuid or by-path or lvm path or whatever. The 
> only downside for this approach that I see is that disks themselves 
> would no longer be transferable between the hosts as those few files 
> that describe the OSD are no longer on the disk itself.

:) this is exactly what we're doing, actually:

	https://github.com/ceph/ceph/pull/18256

We plan to backport this to luminous, hopefully in time for the next 
point release.

dm-crypt is still slightly annoying to set up, but it will still be much 
easier.

sage

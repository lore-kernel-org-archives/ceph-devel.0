From: Sage Weil <sweil@redhat.com>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 21 Apr 2017 13:19:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704211316290.6575@piezo.novalocal>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl> <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl> <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com> <68eaf07b-e611-fb55-ca9c-08dceb8cae14@digiware.nl>
 <5d1fbebf-243b-ece9-0a77-961f4d269c53@suse.cz> <CAJ4mKGZzDTN4KQxFyM0Oify-w0PvxVaX77qwXSYhhMpRGpRkDg@mail.gmail.com> <de44a5b4-593e-ed88-c3f4-93520fea972e@digiware.nl> <3292c3e5-8a5f-5c41-8f57-3d8427c7ead8@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1039748AbdDUNTY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Apr 2017 09:19:24 -0400
In-Reply-To: <3292c3e5-8a5f-5c41-8f57-3d8427c7ead8@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Joao Eduardo Luis <joao@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 21 Apr 2017, Willem Jan Withagen wrote:
> On 21-4-2017 09:33, Willem Jan Withagen wrote:
> > On 20-04-17 20:18, Gregory Farnum wrote:
> >> On Thu, Apr 20, 2017 at 11:11 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> >>> Hi Willem:
> >>>
> >>> It sounds like you are trying to use the sysvinit scripts? These have been
> >>> unmaintained (presumably with lots of weeds growing up) since infernalis.
> >>> Until now I have been assuming that all init systems other than systemd
> >>> (sysvinit, upstart, etc.) are deprecated in Ceph.
> > 
> > sysvinit => init-ceph?
> > 
> > If that is the case and is "abandoned", I could start making it more to
> > my liking to use it under FreeBSD. FreeBSD does not (yet) have this wild
> > choice of init systems.
> 
> Right,
> 
> Did some digging into this.
> 1) init-ceph.in sort of looks abondoned. There are very few changes to
> this file during 2016 and 2017, mostly by me for FreeBSD, and some
> others have to do with the move to cmake.
> 
> 2) I checked in our cluster, and yes the ceph.conf file only holds
> global settings. There is only a global definition of the monitor hosts
> and that is all there is about hosts.
> 
> So I'll have to figure out what to do in ceph-deploy, ceph-disk and or
> init-ceph.
> Least invasive in this would be to modify init-ceph to analyze
> /var/lib/ceph for what should be started.

I think the primary user of init-ceph at this point is vstart.sh; 
developers use it to start and stop daemons from their source directory.

init-ceph suffers from the fact that it maintains compatibility back 
through its original version, circa 2007, when we defined all daemons in 
ceph.conf, and every variation of weirdness since then.  Since I 
don't think many/any distros are using it by default, now, I think we can 
probably afford to drop some of that old cruft and modernize it a bit.  
Unfortunatly vstart is making use of the daemons-defined-in-conf thing, 
though, but it wouldn't bother me to modernize vstart, either.

sage

From: Sage Weil <sage@newdream.net>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 05:55:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com> <mpad83$pu4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36757 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbG2MzL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 08:55:11 -0400
In-Reply-To: <mpad83$pu4$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Jul 2015, Alex Elsayed wrote:
> Travis Rhoden wrote:
> 
> > On Tue, Jul 28, 2015 at 12:13 PM, Sage Weil <sweil@redhat.com> wrote:
> >> Hey,
> >>
> >> I've finally had some time to play with the systemd integration branch on
> >> fedora 22.  It's in wip-systemd and my current list of issues includes:
> >>
> >> - after mon creation ceph-create-keys isn't run automagically
> >>   - Personally I kind of hate how it was always run on mon startup and
> >>   not
> >> just during cluster creation so I wouldn't mind *so* much if this became
> >> an explicit step, maybe triggered by ceph-deploy, after mon create.
> > 
> > I would be happy to see this become an explicit step as well.  We
> > could make it conditional such that ceph-deploy only runs it if we are
> > dealing with systemd, but I think re-running ceph-create-keys is
> > always safe.  It just aborts if
> > /etc/ceph/{cluster}.client.admin.keyring is already present.
> 
> Another option is to have the ceph-mon@.service have a Wants= and After= on 
> ceph-create-keys@.service, which has a 
> ConditionPathExists=!/path/to/key/from/templated/%I
> 
> With that, it would only run ceph-create-keys if the keys do not exist 
> already - otherwise, it'd be skipped-as-successful.

This sounds promising!

> >> - udev's attempt to trigger ceph-disk isn't working for me.  the osd
> >> service gets started but the mount isn't present and it fails to start.
> >> I'm a systemd noob and haven't sorted out how to get udev to log
> >> something
> >> meaningful to debug it.  Perhaps we should merge in the udev +
> >> systemd revamp patches here too...
> 
> Personally, my opinion is that ceph-disk is doing too many things at once, 
> and thus fits very poorly into the systemd architecture...
> 
> I mean, it tries to partition, format, mount, introspect the filesystem 
> inside, and move the mount, depending on what the initial state was.

There is a series from David Disseldorp[1] that fixes much of this, by 
doing most of these steps in short-lived systemd tasks (instead of a 
complicated slow ceph-disk invocation directly from udev, which breaks 
udev).

> Now, part of the issue is that the final mountpoint depends on data inside 
> the filesystem - OSD id, etc. To me, that seems... mildly absurd at least.
> 
> If the _mountpoint_ was only dependent on the partuuid, and the ceph OSD 
> self-identified from the contents of the path it's passed, that would 
> simplify things immensely IMO when it comes to systemd integration because 
> the mount logic wouldn't need any hokey double-mounting, and could likely 
> use the systemd mount machinery much more easily - thus avoiding race issues 
> like the above.

Hmm.  Well, we could name the mount point with the uuid and symlink the 
osd id to that.  We could also do something sneaky like embed the osd id 
in the least significant bits of the uuid, but that throws away a lot of 
entropy and doesn't capture the cluster name (which also needs to be known 
before mount).

If the mounting and binding to the final location is done in a systemd job 
identified by the uuid, it seems like systemd would effectively handle the 
mutual exclusion and avoid races?

sage


[1] https://github.com/ddiss/ceph/tree/wip_bnc926756_split_udev_systemd_master

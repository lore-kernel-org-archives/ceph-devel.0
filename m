From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 07:08:49 -0700
Message-ID: <mpampk$1pq$1@ger.gmane.org>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com> <mpad83$pu4$1@ger.gmane.org> <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51933 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbbG2OJD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 10:09:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZKS2W-0003HZ-Hp
	for ceph-devel@vger.kernel.org; Wed, 29 Jul 2015 16:09:00 +0200
Received: from 66-87-138-120.pools.spcsdns.net ([66.87.138.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 16:09:00 +0200
Received: from eternaleye by 66-87-138-120.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 16:09:00 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> On Wed, 29 Jul 2015, Alex Elsayed wrote:
>> Travis Rhoden wrote:
>> 
>> > On Tue, Jul 28, 2015 at 12:13 PM, Sage Weil <sweil@redhat.com> wrote:
>> >> Hey,
>> >>
>> >> I've finally had some time to play with the systemd integration branch
>> >> on
>> >> fedora 22.  It's in wip-systemd and my current list of issues
>> >> includes:
>> >>
>> >> - after mon creation ceph-create-keys isn't run automagically
>> >>   - Personally I kind of hate how it was always run on mon startup and
>> >>   not
>> >> just during cluster creation so I wouldn't mind *so* much if this
>> >> became an explicit step, maybe triggered by ceph-deploy, after mon
>> >> create.
>> > 
>> > I would be happy to see this become an explicit step as well.  We
>> > could make it conditional such that ceph-deploy only runs it if we are
>> > dealing with systemd, but I think re-running ceph-create-keys is
>> > always safe.  It just aborts if
>> > /etc/ceph/{cluster}.client.admin.keyring is already present.
>> 
>> Another option is to have the ceph-mon@.service have a Wants= and After=
>> on ceph-create-keys@.service, which has a
>> ConditionPathExists=!/path/to/key/from/templated/%I
>> 
>> With that, it would only run ceph-create-keys if the keys do not exist
>> already - otherwise, it'd be skipped-as-successful.
> 
> This sounds promising!
> 
>> >> - udev's attempt to trigger ceph-disk isn't working for me.  the osd
>> >> service gets started but the mount isn't present and it fails to
>> >> start. I'm a systemd noob and haven't sorted out how to get udev to
>> >> log something
>> >> meaningful to debug it.  Perhaps we should merge in the udev +
>> >> systemd revamp patches here too...
>> 
>> Personally, my opinion is that ceph-disk is doing too many things at
>> once, and thus fits very poorly into the systemd architecture...
>> 
>> I mean, it tries to partition, format, mount, introspect the filesystem
>> inside, and move the mount, depending on what the initial state was.
> 
> There is a series from David Disseldorp[1] that fixes much of this, by
> doing most of these steps in short-lived systemd tasks (instead of a
> complicated slow ceph-disk invocation directly from udev, which breaks
> udev).
> 
>> Now, part of the issue is that the final mountpoint depends on data
>> inside the filesystem - OSD id, etc. To me, that seems... mildly absurd
>> at least.
>> 
>> If the _mountpoint_ was only dependent on the partuuid, and the ceph OSD
>> self-identified from the contents of the path it's passed, that would
>> simplify things immensely IMO when it comes to systemd integration
>> because the mount logic wouldn't need any hokey double-mounting, and
>> could likely use the systemd mount machinery much more easily - thus
>> avoiding race issues like the above.
> 
> Hmm.  Well, we could name the mount point with the uuid and symlink the
> osd id to that.  We could also do something sneaky like embed the osd id
> in the least significant bits of the uuid, but that throws away a lot of
> entropy and doesn't capture the cluster name (which also needs to be known
> before mount).

Does it?

If the mount point is (say) /var/ceph/$UUID, and ceph-osd can take a --
datadir parameter from which it _reads_ the cluster and ID if they aren't 
passed on the command line, I think that'd resolve the issue rather tidily 
_without_ requring that be known prior to mount.

And if I understand correctly, that data is _already in there_ for ceph-disk 
to mount it in the "final location" - it's just shuffling around who reads 
it.

> If the mounting and binding to the final location is done in a systemd job
> identified by the uuid, it seems like systemd would effectively handle the
> mutual exclusion and avoid races?

What I object to is the idea of a "final location" that depends on the 
contents of the filesystem - it's bass-ackwards IMO.

> sage
> 
> 
> [1]
> 
[https://github.com/ddiss/ceph/tree/wip_bnc926756_split_udev_systemd_master
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



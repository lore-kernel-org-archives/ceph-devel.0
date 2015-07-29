From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 04:25:55 -0700
Message-ID: <mpad83$pu4$1@ger.gmane.org>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40697 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbbG2L0L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 07:26:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZKPUu-00071H-99
	for ceph-devel@vger.kernel.org; Wed, 29 Jul 2015 13:26:08 +0200
Received: from 66-87-138-120.pools.spcsdns.net ([66.87.138.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 13:26:08 +0200
Received: from eternaleye by 66-87-138-120.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 13:26:08 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Travis Rhoden wrote:

> On Tue, Jul 28, 2015 at 12:13 PM, Sage Weil <sweil@redhat.com> wrote:
>> Hey,
>>
>> I've finally had some time to play with the systemd integration branch on
>> fedora 22.  It's in wip-systemd and my current list of issues includes:
>>
>> - after mon creation ceph-create-keys isn't run automagically
>>   - Personally I kind of hate how it was always run on mon startup and
>>   not
>> just during cluster creation so I wouldn't mind *so* much if this became
>> an explicit step, maybe triggered by ceph-deploy, after mon create.
> 
> I would be happy to see this become an explicit step as well.  We
> could make it conditional such that ceph-deploy only runs it if we are
> dealing with systemd, but I think re-running ceph-create-keys is
> always safe.  It just aborts if
> /etc/ceph/{cluster}.client.admin.keyring is already present.

Another option is to have the ceph-mon@.service have a Wants= and After= on 
ceph-create-keys@.service, which has a 
ConditionPathExists=!/path/to/key/from/templated/%I

With that, it would only run ceph-create-keys if the keys do not exist 
already - otherwise, it'd be skipped-as-successful.

>>
>> - udev's attempt to trigger ceph-disk isn't working for me.  the osd
>> service gets started but the mount isn't present and it fails to start.
>> I'm a systemd noob and haven't sorted out how to get udev to log
>> something
>> meaningful to debug it.  Perhaps we should merge in the udev +
>> systemd revamp patches here too...

Personally, my opinion is that ceph-disk is doing too many things at once, 
and thus fits very poorly into the systemd architecture...

I mean, it tries to partition, format, mount, introspect the filesystem 
inside, and move the mount, depending on what the initial state was.

Now, part of the issue is that the final mountpoint depends on data inside 
the filesystem - OSD id, etc. To me, that seems... mildly absurd at least.

If the _mountpoint_ was only dependent on the partuuid, and the ceph OSD 
self-identified from the contents of the path it's passed, that would 
simplify things immensely IMO when it comes to systemd integration because 
the mount logic wouldn't need any hokey double-mounting, and could likely 
use the systemd mount machinery much more easily - thus avoiding race issues 
like the above.

>>
>> - ceph-detect-init is only recently unbroken in master for fedora 22.
>>
>> - ceph-deploy doesn't know that fedora should be systemd yet.
>>
>> - ceph-deploy has a wip-systemd branch with a few things so far:
>>   - on mon create, we unconditionally systemctl enable ceph.target.
>> i think osd create and mds create and rgw create should do the same
>> thing, since the ceph.target is a catch-all bucket for any ceph service,
>> and i don't think we want to enable it on install?
>>   - rgw create and mds create don't work yet
>>   - osd create doesn't enable ceph.target
> 
> yeah, the ceph-deploy changes needed to properly support systemd are
> pretty big. As part of that effort, ceph-deploy could use some
> refactoring to more gracefully handle multiple init systems.  Owen has
> proposed some of the changes necessary already, and there is some
> current discussion about what constitutes minor vs major refactoring.
> See https://github.com/ceph/ceph-deploy/pull/317 for some WIP toward
> abstracting the init system in ceph-deploy.
> 
>>
>> - I'm guessing my ceph.spec changes to install teh systemd unit files
>> aren't quite right... please review!  The gitbuilder turnaround is so
>> slow it's hard to iterate and I don't really know what I'm doing here.
>>
>> Owen, I'd like to get this just a tad bit more functional and then merge
>> ASAP, then up any issues in the weeks leading up to infernalis.  What say
>> ye?
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 08:17:31 -0700
Message-ID: <mpaqqd$blm$1@ger.gmane.org>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com> <mpad83$pu4$1@ger.gmane.org> <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net> <mpampk$1pq$1@ger.gmane.org> <alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net> <mpao1u$pe2$1@ger.gmane.org> <alpine.DEB.2.00.1507290748290.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59676 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbbG2PSP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 11:18:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZKT7K-0007P4-E1
	for ceph-devel@vger.kernel.org; Wed, 29 Jul 2015 17:18:02 +0200
Received: from 66-87-138-120.pools.spcsdns.net ([66.87.138.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 17:18:02 +0200
Received: from eternaleye by 66-87-138-120.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 17:18:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> On Wed, 29 Jul 2015, Alex Elsayed wrote:
<snip for gmane>
>> My thinking is more that the "osd data = " key makes a lot less sense in
>> the systemd world overall - passing the OSD the full path on the
>> commandline via some --datadir would mean you could trivially use
>> systemd's instance templating, and just do
>> 
>> ExecStart=/usr/bin/ceph-osd -f --datadir=/var/lib/ceph/osd/%i
>> 
>> and be done with it. Could even do RequiresMountsFor=/var/lib/ceph/osd/%i
>> too, which would order it after (and make it depend on) any systemd.mount
>> units for that path.
> 
> Note that there is a 1:1 equivalence between command line options and
> config options, so osd data = /foo and --osd-data foo are the same thing.
> Not that I think that matters here--although it's possible to manually
> specify paths in ceph.conf users can't do that if they want the udev magic
> to work (that's already true today, without systemd).

Sure, though my thought was that the udev magic would work more sanely _via_ 
this. The missing part is loading the cluster and ID from the OSD data dir.

> In any case, though, if your %i above is supposed to be the uuid, that's
> much less friendly than what we have now, where users can do
> 
>  systemctl stop ceph-osd@12
> 
> to stop osd.12.
> 
> I'm not sure it's worth giving up the bind mount complexity unless it
> really becomes painful to support, given how much nicer the admin
> experience is...

Well, that does presuppose that they've either SSHed into the machine 
manually, or are using systemctl -H to do so via systemctl. That's already 
not an especially nice user experience, since they need to manually consider 
the cluster's structure.

Something more like 'ceph tell osd.N die' or similar could work, and 
SuccessExitStatus= could be used to make it even nicer (that even if it 
gives a different exit status for "die" as opposed to other successes, 
systemd can say "any of these exit codes are okay, don't autorestart")

However, neither of those handles unmounting, and it still doesn't handle 
starting. All of the above are still partial solutions; hopefully iteration 
can result in something better in all ways.

Also, note that if RequiresMountsFor= is used, unmounting the filesystem - 
by device or by mountpoint - will stop the unit due to proper dependency 
handling. (If RMF doesn't, BindsTo does - BindsTo will additionally do so if 
the device is unmounted or suddenly unplugged without systemd intervention)

systemctl stop dev-sdc.device # all OSDs running off of sdc stop
systemctl stop dev-sdd1.device # Just one partition this time

Nice and tidy.


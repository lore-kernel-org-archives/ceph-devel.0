From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: ceph and systemd
Date: Thu, 08 May 2014 03:57:03 -0700
Message-ID: <lkfnu0$2q5$1@ger.gmane.org>
References: <alpine.DEB.2.00.1405072119170.25032@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44238 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbaEHK5W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 May 2014 06:57:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1WiM0p-0001wX-8p
	for ceph-devel@vger.kernel.org; Thu, 08 May 2014 12:57:15 +0200
Received: from 66-87-113-65.pools.spcsdns.net ([66.87.113.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 May 2014 12:57:15 +0200
Received: from eternaleye by 66-87-113-65.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 May 2014 12:57:15 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:


> Now that the world seems to be converging on systemd, we need to sort out
> a proper strategy for Ceph.  Right now we have both sysvinit (old and
> crufty but functional) and upstart, but neither are especially nice to
> work with.
> 
> The first order of business is to identify someone who knows (or is
> motivated to learn) how systemd does things and who can figure out how to
> integrate things nicely.
> 
> Here's a quick brain dump:
> 
> The main challenge is that, unlike most basic services, we start lots of
> daemons on the same host.  The "new" way we handle that is by enumerating
> them in with directories in /var/lib/ceph.  E.g.,
> 
> /var/lib/ceph
> 	osd/
> 		ceph-530/
> 		ceph-14/
> 		bigcluster-121/
> 	mon/
> 		ceph-foo/
> 	mds/
> 		bigcluster-foo/
> 
> That is, /var/lib/ceph/$type/$cluster-$id/, where $cluster is normally
> 'ceph' (and that is all that is supported with sysvinit at the moment).
> The config file is then /etc/ceph/$cluster.conf, logs are
> /var/log/ceph/$cluster-$type.log, and so on.
> 
> In each daemon directory, you touch either 'sysvinit' or 'upstart' to
> indicate which init system is responsible for stopping/starting.  Here,
> we'd presumably add 'systemd' to indicate that the new hotness is now
> responsible for managing the daemon.
> 
> In the upstart world, which I'm guessing is most like systemd,

You're going to want to take care with that assumption - systemd and upstart 
are both dynamic (unlike sysvinit), but the edges of their graphs are 
swapped.

Systemd works in terms of dependencies - A wants B, so B gets started.
Upstart works in terms of _events_ - B starts, propagating "B has started". 
Everything that listened for that event - A, C, Aunt Muriel - now starts.

> there are a few meta-jobs for ceph-osd-all, ceph-mon-all, ceph-mds-all,
> and a ceph-all meta-job for those, so that everything can be
> started/stopped together.

The analogous construct in systemd is a 'target' - a grouping of services, 
or other targets. Let's say you define ceph-mon.target, with the following 
contents:

cat > /usr/lib/systemd/system/ceph-mon.target <<ENDTARGET
[Unit]
Description=Ceph MON Daemons
ENDTARGET

If you put 'WantedBy=ceph-mon.target'  in the [Install] section of your 
individual monitor services, then 'systemctl enable' will cause them to be 
started by the target and 'systemctl disable' will clear that.

> Or, you can start/stop individual daemons with something like
>  sudo start ceph-osd id=123 cluster=ceph

That, however, is slightly trickier. You see, while systemd does support 
templated units, they only take _one_ parameter. You create a ceph-
mon@.service, but _start_ it as ceph-mon@param.service.

The param is in an escaped form (see systemd.unit(5), "If this applies, a 
special way to escape the path name is used..."), and the unit file has 
access to it via two substitutions - %i is verbatim, and %I is with the 
escaping undone. / is escaped as -, and ;iteral hyphens get escaped as \x2d 
(as space is \x20 &c). These do _not_ interpolate spaces, IIRC - they get 
passed as a single argument.

As an example, foo@bar-baz.service would see bar-baz in %i and bar/baz in %I

If I remember correctly, / is forbidden in all three of those variables, and 
thus it would be safe to use it as a separator - resulting in units being 
invoked as ceph-mon@big\x2dcluster-mon-a.service, and on the Exec= line you 
could use %I (big-cluster/mon/a). That would require some additional code to 
parse that format, though.

Alternately you could write a 'generator', an executable which creates units 
at runtime. See http://www.freedesktop.org/wiki/Software/systemd/Generators

That would have the benefit of being able to parse ceph.conf (or whatever) 
and generate _exactly_ the units that would do the job.

> For OSDs, things are a bit more complicated because we are wired into udev
> to automatically mount the file systems and to make things more plug and
> play.  The basic strategy is this:
> 
>  - we partition disks with GPT
>  - we use fixed GPT partition types UUIDs to mark osd data volumes and osd
>    journals.
>  - udev rules trigger 'ceph-disk activate $device' for osd data or
>    'ceph-disk activate-journal $device' for osd journals.
>  - ceph-disk mounts the device at /var/lib/ceph/tmp/something, identifies
>    what cluster and osd id it belongs to, bind-mounts that to the correct
>    /var/lib/ceph/osd/* location, and then starts the daemon with whatever
>    init system is indicated.  There's a bunch of other logic to make sure
>    that journals are also mounted, or to start up dm-crypt if enabled, and
>    so on.

Systemd integrates with udev via '.device' units. A WantedBy= declaration in 
a service can specify a .device, which will result in the service being 
started when the device becomes available. This can also be done via 
SYSTEMD_WANTS= udev rules. You may also want to look into systemd-gpt-auto-
generator, which does something similar.

A short-term option might be (eliding several things):

ceph-journal@.service:
[Service]
Exec=/usr/bin/ceph-disk activate-journal /dev/$i

ceph-disk@.service:
[Service]
Exec=/usr/bin/ceph-disk activate /dev/$i

ceph-disks.rules:
ENV{ID_PART_ENTRY_TYPE}==<journal> SYSTEMD_WANTS="ceph-
journal@${name}.service"
ENV{ID_PART_ENTRY_TYPE}==<data> SYSTEMD_WANTS="ceph-disk@${name}.service"


Out of curiousity, have you considered using the partition label (not FS 
label, I mean the GPT one) to identify cluster/osd-id? That'd completely 
avoid the need to do a test-mount.

Additionaly, it might be nice to _unconditionally_ create a device-mapper 
target for the partition - linear or dm-crypt, depending. If you give it a 
deterministic name (there's the partlabel again), you could push the 
mounting logic into systemd via .mount/.automount (mount-on-access) units 
more easily.

> At the end of the day, it means that there's no configuration needed in
> fstab or ceph.conf.  You can simply plug (marked) drives into a machine
> and they will get formatted, provisioned, and added into the cluster in
> the correct location in the CRUSH map.  Or, you can pull a disk from one
> box and plug it into another and it will join back into the cluster
> (provided both the data and journal are present).

Makes sense to me.

> Anyway, the first order of business is to find someone who is
> systemd-savvy...

Not sure how savvy I am, but I'm willing to help

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



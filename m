From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: systemd status
Date: Thu, 30 Jul 2015 13:40:23 -0600
Message-ID: <CAANLjFq_Ja9SZNUpx1qkNcPRpqpEX5aLM_co5XUMhwFd8PQ6Bg@mail.gmail.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
	<CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com>
	<mpad83$pu4$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>
	<mpampk$1pq$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net>
	<mpao1u$pe2$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290748290.22099@cobra.newdream.net>
	<mpaqqd$blm$1@ger.gmane.org>
	<alpine.DEB.2.00.1507300538210.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33274 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbG3TkZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 15:40:25 -0400
Received: by wicmv11 with SMTP id mv11so33312703wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 12:40:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507300538210.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alex Elsayed <eternaleye@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I could do this if it means much better systemd
integration/monitoring/etc. Creating a directory of symlinks should be
trivial and I would use it for mapping/manual navigation.

I also like the idea of "ceph tell osd.x die". Could the OSD process
call systemctl to shut down the process and unmount itself?
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Jul 30, 2015 at 6:45 AM, Sage Weil  wrote:
> On Wed, 29 Jul 2015, Alex Elsayed wrote:
>> Sage Weil wrote:
>>
>> > On Wed, 29 Jul 2015, Alex Elsayed wrote:
>>
>> >> My thinking is more that the "osd data = " key makes a lot less sense in
>> >> the systemd world overall - passing the OSD the full path on the
>> >> commandline via some --datadir would mean you could trivially use
>> >> systemd's instance templating, and just do
>> >>
>> >> ExecStart=/usr/bin/ceph-osd -f --datadir=/var/lib/ceph/osd/%i
>> >>
>> >> and be done with it. Could even do RequiresMountsFor=/var/lib/ceph/osd/%i
>> >> too, which would order it after (and make it depend on) any systemd.mount
>> >> units for that path.
>> >
>> > Note that there is a 1:1 equivalence between command line options and
>> > config options, so osd data = /foo and --osd-data foo are the same thing.
>> > Not that I think that matters here--although it's possible to manually
>> > specify paths in ceph.conf users can't do that if they want the udev magic
>> > to work (that's already true today, without systemd).
>>
>> Sure, though my thought was that the udev magic would work more sanely _via_
>> this. The missing part is loading the cluster and ID from the OSD data dir.
>>
>> > In any case, though, if your %i above is supposed to be the uuid, that's
>> > much less friendly than what we have now, where users can do
>> >
>> >  systemctl stop ceph-osd@12
>> >
>> > to stop osd.12.
>> >
>> > I'm not sure it's worth giving up the bind mount complexity unless it
>> > really becomes painful to support, given how much nicer the admin
>> > experience is...
>>
>> Well, that does presuppose that they've either SSHed into the machine
>> manually, or are using systemctl -H to do so via systemctl. That's already
>> not an especially nice user experience, since they need to manually consider
>> the cluster's structure.
>>
>> Something more like 'ceph tell osd.N die' or similar could work, and
>> SuccessExitStatus= could be used to make it even nicer (that even if it
>> gives a different exit status for "die" as opposed to other successes,
>> systemd can say "any of these exit codes are okay, don't autorestart")
>>
>> However, neither of those handles unmounting, and it still doesn't handle
>> starting. All of the above are still partial solutions; hopefully iteration
>> can result in something better in all ways.
>>
>> Also, note that if RequiresMountsFor= is used, unmounting the filesystem -
>> by device or by mountpoint - will stop the unit due to proper dependency
>> handling. (If RMF doesn't, BindsTo does - BindsTo will additionally do so if
>> the device is unmounted or suddenly unplugged without systemd intervention)
>>
>> systemctl stop dev-sdc.device # all OSDs running off of sdc stop
>> systemctl stop dev-sdd1.device # Just one partition this time
>>
>> Nice and tidy.
>
> So, it seems like plan B would be something like:
>
> - mounts on /var/lib/ceph/osd/data/$uuid.  For new backends that have
> multiple mounts (newstore likely will), we may also have something like
> /var/lib/ceph/osd/data-fast/$uuid as an SSD partition or something.
>
> - systemd ceph-osd@$uuid task runs
>     ceph-osd --cluster ceph --id 123 --osd-uuid $uuid
>
> - simpler udev rules
>
> - simpler ceph-disk behavior
>
> - The 'one cluster per host' restriction would go away.  This is currently
> there because we only have a single systemd parameter for the @ services
> and we're using the osd id (which is not unique across clusters).  The
> uuid would be, so that's a win.
>
> But,
>
> - admin can't tell from 'systemctl | grep ceph' or from 'df' or 'mount'
> which OSD is which, but they could from 'ps ax | grep ceph-osd'.
>
> - stopping an individual osd would be done by $uuid instead of osd id:
>
>  systemctl stop ceph-osd@66f354f2-752e-409f-8194-be05f6b071d9
>
> For an admin this is probably a cut&paste from ps ax output?
>
> - we could perhaps make a 'ceph-disk stop' and 'ceph-disk umount' commands
> to make this a bit simpler?
>
> What do people think?  I like simple, but I don't want to make life too
> hard on the admin.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVun2kCRDmVDuy+mK58QAAyuwP/A2iTot7iknxuCGdfpmV
Cl+zst2My4Ezw6n9T2r8aweRPmBdPTvz5NV6GeFcX2n3U5jBmC4DNee0ThZW
EYdCcsCG9rNP3Ej+hcRjxqQbkvIdyzRS1Uj0E6HFsM4aiH113FELsrwt/uRC
xKjh2UJCUy9Ur2LIxFSPATWQ1WzF9k4RQmSD4++nOCh+q5BkefRpp3C/UbOz
5lZpFLXn1phyEaHEeX8lCyCPM0UhypK0vDEhV6U7DH0h9XCn0sDJrTtvmgTr
Vpozl1kxxAaaVxw9dW4hhSyQZ2AuyxBnFwPgfwsFl9LzDtOmuf0jJS/mrYvj
6szc98mc9f1UvEb0VNT7AFhV32jZOoP95aVllL7EBhmOBoGMiO+BKgzFGXtI
fNu0z6N0kHnqtbN8XlkIkBs7DPmAoOyqcaCGkyyANLBQBa0ivnRmU0eF/9jI
HKzWkGmz2NLlhmCEms24xwSdc8A//VamNc7bpCsyGq8rDPpw0wlIMKvO6Iah
atTHkrTc8mL5EUQHw93N9Wt6MOEVnu6W7fJLqK1ATG1E8Jb+742LoNUqxx4L
HT9RVXC1xIO30MpMfQOd3wLC2FH9Pb/qfNIJGrn+0yCTHGLjqDTkuRl66CVu
S5tiyumUYlu3R1GaAj0gQDTyq5Gqwi5hk9plCiyPMXZSkhuBSpPRhtHjELsP
8s8F
=Mo2p
-----END PGP SIGNATURE-----

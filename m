From: Vasiliy Angapov <angapov@gmail.com>
Subject: Re: systemd status
Date: Thu, 30 Jul 2015 00:50:54 +0800
Message-ID: <CAGtbiz1=yV8sW7d3Jc42NgUNdHXuakzM5RyfCkgCVXpOWRYykw@mail.gmail.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
	<CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com>
	<mpad83$pu4$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>
	<mpampk$1pq$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net>
	<mpao1u$pe2$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290748290.22099@cobra.newdream.net>
	<mpaqqd$blm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33065 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbbG2Qu4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 12:50:56 -0400
Received: by lbbyj8 with SMTP id yj8so10947379lbb.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 09:50:54 -0700 (PDT)
In-Reply-To: <mpaqqd$blm$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi colleagues,

I see some systemd-related actions here. Can you please also have a
look at how I managed to rule Ceph with systemd -
https://github.com/angapov/ceph-systemd/ ?
It uses systemd generator script, which is called every time host
boots up or when we issue "systemctl daemon-reload". It automates all
the routine job of adding/removing systemd unit files. It also has a
convenient ceph-osd and ceph-mon targets, which allows to start/stop
OSDs/MONs all at once.
I got production cluster working with it already, so this is fine for
me. It handles only OSD and MON daemons for the moment but RGW can be
added in a seconds.

The idea of systemd generators adds much more flexibility to Ceph like
the original init script has.

Best regards, Vasily.

On Wed, Jul 29, 2015 at 11:17 PM, Alex Elsayed <eternaleye@gmail.com> wrote:
> Sage Weil wrote:
>
>> On Wed, 29 Jul 2015, Alex Elsayed wrote:
> <snip for gmane>
>>> My thinking is more that the "osd data = " key makes a lot less sense in
>>> the systemd world overall - passing the OSD the full path on the
>>> commandline via some --datadir would mean you could trivially use
>>> systemd's instance templating, and just do
>>>
>>> ExecStart=/usr/bin/ceph-osd -f --datadir=/var/lib/ceph/osd/%i
>>>
>>> and be done with it. Could even do RequiresMountsFor=/var/lib/ceph/osd/%i
>>> too, which would order it after (and make it depend on) any systemd.mount
>>> units for that path.
>>
>> Note that there is a 1:1 equivalence between command line options and
>> config options, so osd data = /foo and --osd-data foo are the same thing.
>> Not that I think that matters here--although it's possible to manually
>> specify paths in ceph.conf users can't do that if they want the udev magic
>> to work (that's already true today, without systemd).
>
> Sure, though my thought was that the udev magic would work more sanely _via_
> this. The missing part is loading the cluster and ID from the OSD data dir.
>
>> In any case, though, if your %i above is supposed to be the uuid, that's
>> much less friendly than what we have now, where users can do
>>
>>  systemctl stop ceph-osd@12
>>
>> to stop osd.12.
>>
>> I'm not sure it's worth giving up the bind mount complexity unless it
>> really becomes painful to support, given how much nicer the admin
>> experience is...
>
> Well, that does presuppose that they've either SSHed into the machine
> manually, or are using systemctl -H to do so via systemctl. That's already
> not an especially nice user experience, since they need to manually consider
> the cluster's structure.
>
> Something more like 'ceph tell osd.N die' or similar could work, and
> SuccessExitStatus= could be used to make it even nicer (that even if it
> gives a different exit status for "die" as opposed to other successes,
> systemd can say "any of these exit codes are okay, don't autorestart")
>
> However, neither of those handles unmounting, and it still doesn't handle
> starting. All of the above are still partial solutions; hopefully iteration
> can result in something better in all ways.
>
> Also, note that if RequiresMountsFor= is used, unmounting the filesystem -
> by device or by mountpoint - will stop the unit due to proper dependency
> handling. (If RMF doesn't, BindsTo does - BindsTo will additionally do so if
> the device is unmounted or suddenly unplugged without systemd intervention)
>
> systemctl stop dev-sdc.device # all OSDs running off of sdc stop
> systemctl stop dev-sdd1.device # Just one partition this time
>
> Nice and tidy.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

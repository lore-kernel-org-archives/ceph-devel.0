From: Gregory Meno <gmeno@redhat.com>
Subject: Re: Fwd: crush_location hook vs calamari
Date: Tue, 20 Jan 2015 11:40:09 -0500
Message-ID: <CAOWd=nAN5SX2L=eQyn=kCV7skbyWa=qR5AKLkZ8wNnL4je3MJw@mail.gmail.com>
References: <CAOWd=nBExJbD72ereRmn_mv_u=cODRnvDif8RcUiLejcQqKoOg@mail.gmail.com>
	<CAGd4Wr2+AD2J690cdcSwknLhUX16SR+WRQDVpn=+UB9mnO0-Yg@mail.gmail.com>
	<alpine.DEB.2.00.1501160924050.15918@cobra.newdream.net>
	<CAOWd=nCSAqmSok7+sXm8VqZDUWbdsBDiLovzcDVUXk3018pQ2w@mail.gmail.com>
	<CAOWd=nAEyuENX63roRhXDnf3QGi4ewm=61FyBAjNHZsGRMVyMg@mail.gmail.com>
	<alpine.DEB.2.00.1501190814300.26676@cobra.newdream.net>
Reply-To: gmeno@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:37583 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbATQkK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 11:40:10 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so8845650qgd.11
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 08:40:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501190814300.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>

On Mon, Jan 19, 2015 at 11:18 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 19 Jan 2015, Gregory Meno wrote:
>> On Fri, Jan 16, 2015 at 12:39 PM, Sage Weil <sweil@redhat.com> wrote:
>> >
>> > [adding ceph-devel, ceph-calamari]
>> >
>> > On Fri, 16 Jan 2015, John Spray wrote:
>> > > Ideally we would have a solution that preserved the OSD hot-plugging
>> > > ability (it's a neat feature).
>> > >
>> > > Perhaps the crush location logic should be:
>> > > * If nobody ever overrode me, default behaviour
>> > > * If someone (calamari) set an explicit location, preserve that
>> > > * UNLESS I am on a different hostname than I was when the explicit
>> > > location was set, in which case kick in the hotplug behaviour
>> >
>> > This would be nice...
>>
>>
>> I agree this sounds fine, and easy enough to explain.
>>
>> >
>> >
>> > > The hotplug path might just be to reset my location in the existing
>> > > way, or if calamari was really clever it could define how to handle a
>> > > hostname change within a different root (typically the 'ssd' root
>> > > people create) such that if I unplugged ssd_root->myhost_ssd and
>> > > plugged it into foohost, then it would reset its crush location to
>> > > ssd_root->foohost_ssd instead of root->foohost.
>> > >
>> > > We might want to consider adding a flag into the crush map itself so
>> > > that nodes can be "locked" to indicate that their location was set by
>> > > human intent rather than the crush-location script.
>> >
>> > Perhaps a per-osd flag in the OSDMap?  We have a field for this right now,
>> > although none of the fields are user-modifiable (they are things up up and
>> > exists).  I think that makes the most sense.
>>
>>
>> So If I understand this correctly we are talking about adding data to
>> the CRUSH map for the crush-location script to read.
>>
>> It appears to not talk to the cluster presently
>> ubuntu@vpm148:~$ strace ceph-crush-location --cluster ceph --id 0
>> --type osd 2>&1 | grep ^open
>> open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
>> open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
>> open("/usr/bin/ceph-crush-location", O_RDONLY) = 3
>
> Yeah, and it should stay that way IMO so that it is an simple hook that
> admins can implement to output the k/v pairs.  I think the smarts should
> go in init-ceph where it calls 'ceph osd crush create-or-move'.  We can
> either add a conditional check in the script there (as well as
> ceph-osd-prestart.sh, which upstart and systemd use), or make a new mon
> command that puts the smarts in the mon.
>

+1

> The former is probably simpler, although slightly racy.  It will probably
> need to do 'ceph osd dump -f json' to parse out the per-osd flags and
> check for something.
>
> The latter might be 'ceph osd update-location-on-start <osd.NNN> <k/v
> pairs>'?
>
>> [...]
>> You are right about not really addressing calamari. The thing I need
>> to solve is how to make ceph-crush-location script smart about
>> coexisting with changes to the crush map.
>
> Yep, let's solve that problem first.  :)

So I see solving this problem with Calamari is a precursor to
improving the way this is handled in Ceph.

How does this sound:

When Calamari makes a change to the CRUSH map where an OSD gets
reparented to a different CRUSH tree  it stores a set of key-value
pairs and physical host in ceph config-key e.g.

rootA -> hostA -> OSD1, OSD2

becomes

rootA -> hostA -> OSD1

rootB -> hostB -> OSD2

and

ceph config-key get 'calamari:1:osd_crush_location:osd.2' = {'paths':
[[root=rootB, host=hostB]], 'physical_host': hostA}

When the OSD starts up a calamari-specific script sends a mon command
to get the data we persisted in the config-key, if none exists we
return the default crush_path, otherwise if match the physical_host to
the node where this OSD is starting then we return the stored path. If
the host match fails we return the default crush_path so that
hot-plugging continues to work.

and Calamari sets "osd crush location hook" on all OSDs it manages

Gregory


>
> sage
>
>>
>> Gregory
>>
>>
>> >
>> > sage
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> > >
>> > > John
>> > >
>> > > On Fri, Jan 16, 2015 at 2:14 PM, Gregory Meno <gmeno@redhat.com> wrote:
>> > > > The problem I am trying to solve is:
>> > > > Calamari now has the ability to manage the crush map and for that to be
>> > > > useful I need to prevent the default behavior of OSDs set update on start.
>> > > >
>> > > > The config surrounding crush_location seems complicated enough that I want
>> > > > some help deciding on the best approach.
>> > > >
>> > > > http://tracker.ceph.com/issues/8667 contains the background info
>> > > >
>> > > > options:
>> > > > - Calamari sets "osd update on start to false" on all OSDs it manages.
>> > > >
>> > > > - Calamari sets "osd crush location hook" on all OSDs it manages
>> > > >
>> > > > criteria:
>> > > >
>> > > > - don't piss off admins with existing clusters and configs
>> > > >
>> > > > - solution applies after life-cycle requires addition of new OSDs
>> > > >
>> > > > - ??? am I missing more
>> > > >
>> > > > comparison:
>> > > >  TBD
>> > > >
>> > > > recommendation:
>> > > >
>> > > > after talking to Dan the solution that seems best is:
>> > > >
>> > > > Have calamari set "osd crush location hook" to a script that asks either
>> > > > calamari or the cluster for the OSDs last known location in the CRUSH map if
>> > > > this is a new OSD fallback to a sensible default e.g. the behavior as it
>> > > > "osd update on start" were true
>> > > >
>> > > > The thing I like most about this approach is that we edit the config file
>> > > > one time.
>> > > >
>> > > > regards,
>> > > > Gregory
>> > >
>> > >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

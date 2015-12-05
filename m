From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: rgw: new multisite update
Date: Fri, 4 Dec 2015 22:34:49 -0800
Message-ID: <CADRKj5ToZVUoP4qAro9ZnmTJTXS4vzMs++2S4-2Vk9U=_3pXwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35504 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbLEGeu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Dec 2015 01:34:50 -0500
Received: by vkha189 with SMTP id a189so77783474vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 22:34:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Orit, Casey and I have been working for quite a while now on a new
multi-site framework that will replace the current sync-agent system.
There are many improvements that we are working on, and we think it
will be worth the wait (and effort!).
First and foremost, the main complain that we hear about the rgw, and
specifically about its multisite feature is the configuration
complexity. The new scheme will make things much easier to configure,
and will handle changes dynamically. There will be many new commands
that will remove the need to manually edit and inject json
configurations as was previously needed. Changes to the zones
configuration will be applied to running gateways, and these will be
able to handle those changes without the need to restarts the
processes.

We're getting rid of the sync agent, and the gateways themselves will
handle the sync process. Removing the sync agent will help with making
the system much easier to set and configure. It also helps with the
sync process itself in many aspects.
The data sync will now be active-active, so all zones within the same
zone group will be writable. Note that 'region' is now called 'zone
group'; there was too much confusion with the old term. The metadata
changes will keep the master-slave scheme to keep things simpler in
that arena.
We added a new entity called 'realm', which is a container for zone
groups. Multiple realms can be created, which provides the ability to
run completely different configurations on the same clusters with
minimum effort.
A new entity called 'period' (might be renamed to 'config') holds the
realm configuration structure. A period changes when the master zone
changes. A period epoch is being incremented whenever there's a change
in the configuration that does not modify the master.

New radosgw-admin commands were added to provide better view into the
sync process status itself. The scheme still requires handling 3
different logs (metadata, data, bucket indexes), and the sync statuses
reflect the position in those logs (for incremental sync), or which
entry is being synced (for the full sync).

There is also a new admin socket command ('cr dump') that dumps the
current state of the coroutines framework (that was created for this
feature), which helps quite a bit with debugging problems.

Migrating from the old sync agent to the new sync will require the new
sync to start from scratch. Note that this process should not copy any
actual data, but the sync will need to build the new sync status (and
verify that all the data is in place in the zones).

So, when is this going to be ready?

We're aiming at having it in Jewel. At the moment nothing is merged
yet (still at the wip-rgw-new-multisite branch); we're trying to make
sure that things still work against it (e.g., the sync agent can still
work), and we'll get it merged once we feel comfortable with the
backward compatibility. The metadata sync is still missing some
functionality that is related to fail over recovery, and the error
reporting and retry still needs some more work. The data sync itself
has a few cases that we don't handle correctly. The realm/period
bootstrapping still needs some more work. Documentation is almost non
existent. But the most important piece that we actually need to work
on is the testing. We need to make sure that we have tests coverage
for all the new functionality. Which brings me to this:

It would be great if we had people outside of the team that could take
an early look on it and help with mapping the pain points. It would be
even greater if someone could help with the actual development of the
automated tests (via teuthology), but even just manually testing and
reporting of any issues will help a lot. Note: Danger! Danger! this
could and will eat your data! It shouldn't be tested on a production
environment (yet!).

The following is a sample config of a single zone group, with two
separate zones. There are two machines that we set up the zones on:
rgw1, rgw2, where rgw1 serves as the master for metadata.

Note that there are a bunch of commands that we'll be able to redact
later (e.g., all the default setting ones, separate commands to create
a zone and attach it to a zonegroup). In some of the cases when you
create the first realm/zonegroup/zone, the entity will automatically
become the default. However, I've ran into some issues when trying to
set multiple realms on a single cluster, and not having the default
caused some issues. We'll need to clean that up.


access_key=<access key>
secret=<secret>

# run on rgw1
$ radosgw-admin realm create --rgw-realm=earth
$ radosgw-admin zonegroup create --rgw-zonegroup=us
--endpoints=http://rgw1:80 --master
$ radosgw-admin zonegroup default --rgw-zonegroup=us
$ radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-1
--access-key=${access_key} --secret=${secret}
--endponts=http://rgw1:80
$ radosgw-admin zone default --rgw-zone=us-1
$ radosgw-admin zonegroup add --rgw-zonegroup=us --rgw-zone=us-1
$ radosgw-admin user create --uid=zone.jup --display-name="Zone User"
--access-key=${access_key} --secret=${secret} --system
$ radosgw-admin period update --commit

$ radosgw --rgw-zone=us-1 --rgw-frontends="civetweb port=80"

# run on rgw2
$ radosgw-admin realm pull --url=http://rgw1
--access-key=${access_key} --secret=${secret}
$ radosgw-admin realm default --rgw-realm=earth
$ radosgw-admin zonegroup default --rgw-zonegroup=us
$ radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-2
--access-key=${access_key} --secret=${secret}
--endpoints=http://rgw2:80
$ radosgw-admin period update --commit

$ radosgw --rgw-zone=us-2 --rgw-frontends="civetweb port=80"

At this point both zones should be running and syncing from each
other. There are still a lot of rough edges, things that we're working
to fix and clean up. As I said, it would be great to have some other
people trying this, so that we understand better the pain points, and
we can map the issues. As was mentioned before, this whole feature can
be found at the wip-rgw-new-multisite development branch. It should
used only in test environments, and it *will* eat your data (and if by
any chance it doesn't eat your data, let us know and we'll try to
figure out what went wrong). Beware!

Thanks!
Yehuda

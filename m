From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Braindump: path names, partition labels, FHS, auto-discovery
Date: Tue, 6 Mar 2012 13:19:55 -0800
Message-ID: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:48320 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2CFVUP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Mar 2012 16:20:15 -0500
Received: by dadp12 with SMTP id p12so7084869dad.11
        for <ceph-devel@vger.kernel.org>; Tue, 06 Mar 2012 13:20:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

As you may have noticed, the docs [1] and Chef cookbooks [2] currently
use /srv/osd.$id and such paths. That's, shall we say, Not Ideal(tm).

[1] http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#creating-a-ceph-conf-file
[2] https://github.com/ceph/ceph-cookbooks/blob/master/ceph/recipes/bootstrap_osd.rb#L70


I initially used /srv purely because I needed to get them going quick,
and that directory was guaranteed to exist. Let's figure out the long
term goal.

The kinds of things we have:

- configuration, edited by humans (ONLY)
- machine-editable state similar to configuration
- OSD data is typically a dedicated filesystem, accommodate that
- OSD journal can be just about any file, including block devices

OSD journal flexibility is limiting for automation.. support three
major use cases:

- OSD journal may be fixed-basename file inside osd data directory
- OSD journal may be a file on a shared SSD
- OSD journal may be a block device (e.g. full SSD, partition on SSD,
2nd LUN on the same RAID with different tuning)

Requirements:

- FHS compliant: http://www.pathname.com/fhs/
- works well with Debian and RPM packaging
- OSD creation/teardown is completely automated
- ceph.conf is static for the whole cluster; not edited by per-machine
automation
- we're assuming GPT partitions, at least for not

Desirable things:

- ability to isolate daemons from each other more, e.g.
AppArmor/SELinux/different uids; e.g. do not assume all daemons can
mkdir in the same directory (ceph-mon vs ceph-osd)
- ability to move OSD data disk from server A to server B (e.g.
chassis swap due to faulty mother board)


The Plan (ta-daaa!):

(These will be just the defaults -- if you're hand-rolling your setup,
and disagree, just override them.)

(Apologies if this gets sketchy, I haven't had time to distill these
thoughts into something prettier.)

- FHS says human-editable configuration goes in /etc
- FHS says machine-editable state goes in /var/lib/ceph
- use /var/lib/ceph/mon/$id/ for mon.$id
- use /var/lib/ceph/osd-journal/$id for osd.$id journal; symlink to
actual location
- use /var/lib/ceph/osd-data/$id for osd.$id data; may be a symlink to
actual location?
- embed the same random UUID in osd data & osd journal at ceph-osd
mkfs time, for safety

On a disk hot plug event (and at bootup):
- found = {}
- scan the partitions for partition label with the prefix
"ceph-osd-data-". Take the remaining portion as $id and mount the fs
in /var/lib/ceph/osd-data/$id. Add $id to found (TODO handle
pre-existing). if osd-data/$id/journal exists, symlink osd-journal/$id
to it (TODO handle pre-existing).
- scan for partition label with the prefix "ceph-osd-journal-" and
special GUID type. Take the remaining portion as $id and symlink the
block device to /var/lib/ceph/osd-journal/$id. Add $id to found. (TODO
handle pre-existing)
- for each $id in found, if we have both osd-journal and osd-data,
start a ceph-osd for it


Moving journal

As an admin, I want to move an OSD data disk from one physical host
(chassis) to another (e.g. for maintenance of non-hotswap power
supply).
I might have a single SSD, divided into multiple partitions, each
acting as the journal for a single OSD data disk. I want to spread the
load evenly across the rest of the cluster, so I move the OSD data
disks to multiple destination machines, as long as they have 1 slot
free. Naturally, I cannot easily saw the SSD apart and move it
physically.

I would like to be able to:

1. shut down the osd daemon
2. explicitly flush out & invalidate the journal on SSD (after this,
the journal would not be marked with the osd id and fsid anymore)
3. move the HDD
4. on the new host, assign a blank SSD partition and initialize it
with the right fsid etc metadata

It may actually be nicer to think of this as:

1. shut down the osd daemon
2. move the journal inside the osd data dir, invalidate the old one
(flushing it is an optimization)
3. physically move the HDD
4. move the journal from inside the osd data dir to assigned block device

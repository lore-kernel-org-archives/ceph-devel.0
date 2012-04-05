From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: defaults paths #2
Date: Thu, 5 Apr 2012 16:36:39 -0700
Message-ID: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41801 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab2DEXhA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 19:37:00 -0400
Received: by yhmm54 with SMTP id m54so1064202yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 16:36:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

[Apologies for starting a new thread, vger unsubscribed me without
warning, I'm reading the previous thread via web]

In response to the thread at http://marc.info/?t=133360781700001&r=1&w=2


Sage:
> The locations could be:
>  keyring:
>   /etc/ceph/$cluster.keyring  (fallback to /etc/ceph/keyring)

I think all the osds and mons will have their secrets inside their
data dir. This, if used, will be just for the command line tools.

>  osd_data, mon_data:
>   /var/lib/ceph/$cluster.$name
>   /var/lib/ceph/$cluster/$name
>   /var/lib/ceph/data/$cluster.$name
>   /var/lib/ceph/$type-data/$cluster-$id

I'm thinking.. /var/lib/ceph/$type/$cluster-$id, where $type is osd or mon.
And this is what is in the wip-defaults branch now, it seems.



Bernard Grymonpon <bernard@openminds.be>:
> As a osd consists of data and the journal, it should stay together, with all info for \
> that one osd in one place:
>
> I would suggest
>
> /var/lib/ceph/osd/$id/data
> and
> /var/lib/ceph/osd/$id/journal

Journal can live inside .../data (when just a file on the same spindle
is ok), we don't need to use a directory tree level just for that.

> ($id could be replaced by $uuid or $name, for which I would prefer $uuid)

In some ways $uuid is cleaner, but this is something that is too
visible for admins, and the $id space still exists and cannot tolerate
collisions, so we might as well use those.



Andrey Korolyov <andrey@xdel.ru>:
> Right, but probably we need journal separation at the directory level
> by default, because there is a very small amount of cases when speed
> of main storage is sufficient for journal or when resulting speed
> decrease is not significant, so journal by default may go into
> /var/lib/ceph/osd/journals/$i/journal where osd/journals mounted on
> the fast disk.

Journals as files in a single, separate, dedicated filesystem (most
likely on SSD) is on my list of use cases to be supported. I don't
think we need to always use /var/lib/ceph/osd/journals just to support
that; I think I can arrange the support without that clumsiness.
Details are still pending.

I think many people with that hardware setup will choose to just GPT
partition the SSD, and have a lot less code in the way of the IO.



Bernard Grymonpon <bernard@openminds.be>:
> I feel it's up to the sysadmin to mount / symlink the correct storage devices on the \
> correct paths - ceph should not be concerned that some volumes might need to sit \
> together.

I think we agree on intents, but I disagree strongly with the words
you chose. The sysadmin should not need to symlink anything. We will
bring up a whole cluster, and enable you to manage that easily.
Anything less is a failure. You may choose to opt out of some of that
higher smarts, if you want to do it differently, but we will need to
provide that. Managing a big cluster without automation is painful,
and people shouldn't need to reinvent the wheel.

Now, whether that automation uses symlinks to point things to the
right places or not, that's almost an implementation detail.



Bernard Grymonpon <bernard@openminds.be>:
> I assume most OSD nodes will normally run a single OSD, so this would not apply to \
> most nodes.

Expected use right now is 1 OSD per hard drive, 8-12 hard drives per
server. That's what we'll be benchmarking on, primarily.



Wido den Hollander <wido@widodh.nl>:
> I think that's a wrong assumption. On most systems I think multiple OSDs
> will exist, it's debatable if one would run OSDs from different clusters
> very often.

I expect mixing clusters to be rare, but that use case has been made
strongly enough that it seems we will support it as a first-class
feature.

> I'm currently using: osd data = /var/lib/ceph/$name
>
> To get back to what sage mentioned, why add the "-data" suffix to a
> directory name? Isn't it obvious that a directory will contain data?

He was separating osd-data from osd-journal. Since that we've
simplified that to /var/lib/ceph/$type/$cluster-$id, which is close to
what you have, but 1) separating osd data dirs from rest of
/var/lib/ceph, for future expansion room 2) adding the cluster name.

> As I think it is a very specific scenario where a machine would be
> participating in multiple Ceph clusters I'd vote for:
>
>   /var/lib/ceph/$type/$id

I really want to avoid having two different cases, two different code
paths to test, a more rare variant that can break without being
noticed. I want everything to always look the same. "ceph-" seems a
small enough price to pay for that.



Bernard Grymonpon <bernard@openminds.be>:
> If it is recommended setup to have multiple OSDs per node (like, one OSD per physical \
> drive), then we need to take that in account - but don't assume that one node only \
> has one SSD disk for journals, which would be shared between all OSDs...

As I tried to explain in an earlier "braindump" email, we'll support journals

1. inside osd data
2. on shared ssd as file
3. separate block dev (e.g. ssd or raid 2nd lun with different config)

and find the right journal automagically, by matching uuids. This is
what I'm working on right now.



Bernard Grymonpon <bernard@openminds.be>:
> I would suggest you fail the startup of the daemon, as it doesn't have all the needed \
> parts - I personally don't like these "autodiscover" thingies, you never know why \
> they are waiting/searching for,...

If you don't like hotplug, you can disable it.

Having hundreds of machines with ~10 disks each and the data center
being remote and managed by people you've never seen will probably
make you like the automation more. Having failed disks turn on an LED,
ops swapping in a new drive from a dedicated pile of pre-prepared
spares, and things just.. working.. is the goal.

> Say that we duplicate a node, for some testing/failover/... I would not
> want to daemon to automatically start, just because the data is there...

If you do that, just turn hotplug off before you plug the disks in to
the replica. There's not much you can do with it, though -- starting
the osds is a no-no, in this case.

I would argue that random copying of osd data disks or journals is an
accident waiting to happen. But there's nothing inherent in the design
to say you can't do that. Just don't do hotplug.

We can't rely on hotplug working anyway. There will *always* be a
change for the admin to manually say "hey, here's a new block device
for you, see if there's something to run there".

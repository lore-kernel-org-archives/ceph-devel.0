From: Gregory Farnum <gfarnum@redhat.com>
Subject: CephFS Redmine shuffle
Date: Wed, 13 Jul 2016 18:56:07 -0700
Message-ID: <CAJ4mKGYVpzsyEtHQFTUZiknpJ+aaBiupFwr_9YZB+ghYCPNg=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35076 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbcGNB4J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2016 21:56:09 -0400
Received: by mail-vk0-f44.google.com with SMTP id w127so32361755vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 18:56:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

All,
If you're subscribed to Redmine notifications, you probably noticed me
going nuts yesterday (and a little today) with the CephFS tickets.
This was a continuation of work I did last month to try and make more
useful Categories than we previously had =E2=80=94 when I finished that=
, John
pointed out we had both projects (eg, fsck) and components (eg, the
MDS) listed, and that was a bit weird.

So, thanks to the power of custom fields, I created a "Component"
field in the CephFS tracker[1] and moved a bunch of stuff around while
cleaning up the component-based older categories, and adding some
newer ones[2]. Another benefit of this is that you can select more
than one component =E2=80=94 no more trying to decide if that protocol =
bug is
part of the Client or the MDS!

Also, now that the categories are more useful from a planning
perspective, the Agile board plugin is a lot more useful. We haven't
done team planning in a while, but I went through and sorted each
category's card into a reasonable order. Bonus: you can also look at
the board filtering on component (or anything else, really); those are
not sorted nearly as carefully (most are semi-reasonable, but the MDS
component in particular is not) but I think as time goes on and people
sort stuff more frequently it will fall out.

The agile board is also nice because we can look at bugs and features
in a single (useful, hopefully) view and prioritize across those
categories more than our past views have allowed =E2=80=94 and ignore b=
ugs in
one feature area that you don't care about while still looking at a
decent triage view. :)

Remaining sticky points:
* you can't select more than one category, which became more desirable
as I started sorting. I mostly erred towards putting stuff that only
applies with one project into that project (is cross-MDS scrubbing a
multi-MDS or fsck feature? I went with multi-MDS), but it'd be great
not to have to choose. Sadly categories in Redmine have some special
handling compared to other fields; I think it's about efficient
queries in the database etc.

* The Trello board (https://trello.com/b/iZmo1ExD/cephfs). There's no
coordination and while many items are duplicated, plenty aren't. I
*suspect* we'll end up using Redmine for team task tracking and Trello
for stuff that requires coordinating with other groups, and larger
feature aggregates. But we'll see how it evolves.


Anyway, if you think there's something in the new settings that isn't
working, please suggest fixes. It's not hard to add new
categories/components!
-Greg

[1]: ceph-fuse, Client, Common/Protocol, Ganesha FSAL, Hadoop/Java,
kceph, libcephfs, MDS, MDSMonitor, osdc, qa-suite, Samba VFS, tools,
VolumeClient

[2]: Administration/Usability, code hygiene, Correctness/Safety,
Hadoop, Introspection/control, Manila, multi-FS, multi-MDS, NFS,
Performance/Resource Usage, Quotas, samba/cifs, Security Model,
Snapshots, Testing
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

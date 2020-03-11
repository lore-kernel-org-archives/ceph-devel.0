From: Ugis <ugis22@gmail.com>
Subject: Proposal on monitor backup and ceph DR in general
Date: Wed, 11 Mar 2020 21:23:16 +0200
Message-ID: <CAE63xUNCa-4VHH9C57GVhMD7MUi6D_po=y3Z9DyyX+wdc+2ixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf1-f45.google.com ([209.85.167.45]:35097 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbgCKTXa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Mar 2020 15:23:30 -0400
Received: by mail-lf1-f45.google.com with SMTP id v8so1786498lfe.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2020 12:23:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, sage@redhat.com, Wido den Hollander <wido@widodh.nl>, clewis@centraldesktop.com

Hi,

Returning to ceph monitor backup topic after some time. This is rather
to spark discussion as there is still place for improvement in ceph
disaster recovery area.

I have reviewed info regarding how to plan Disaster Recovery for ceph
cluster focusing on making sure monitor data is safe.
For example the official "Troubleshooting monitors"
https://docs.ceph.com/docs/nautilus/rados/troubleshooting/troubleshooting-mon/
or older Wido's blog here
https://blog.widodh.nl/2014/03/safely-backing-up-your-ceph-monitors/
and several threads in mailinglist.

Conclusion is you don't backup ceph monitors just increase their count
to reduce likehood of them all failing at once.

Still things are different in case OSDs are encrypted with dmcrypt.
Lets say power outage has happened and all monitor data is lost. Then
even "Recovery using OSDs" would not help as LUKS keys live only in
monitors - right?

So for proposal part - to have complete and easy to use ceph DR
something of following would be needed: vital info(monitor DBs, ceph
config, mgr, mds data etc.) stored in redundant and convenient to
restore form.

- OSDs or monitors themselves should be the place to store that
redundant critical info. In case of OSDs - not all of them, just some
specified count enough to be sure at least one will survive in any
case. OSDs being better candidates over monitors as those have higher
probability to be distributed among racks, PDUs.
- on those selected OSDs special robust storage would could be
implemented(not specialist here but copy-on-write fs or circular
buffer seem suitable). Could be raw, dedicated partition to be sure
there is no filesystem below to be broken. Size of 1GB should be
enough(?)
- when enabling this "ceph recovery feature" user would have to
specify password and all data would be encrypted using it. May be just
use LUKS container that already handles passwords and put CoW/ring
buffer inside of it.
- monitors and other critical daemons would have to stream/replicate
their DB changes to these dedicated safe-storages. Also I don't know
how exactly currently mons communicate and do it fast enough but maybe
etcd would help here https://etcd.io/
- eventually all critical changes would be streamed to those robust,
distributed containers protected by password.
- in case disaster strikes there would be special tool that could
recover all needed info. I envision tool that you run on reinstalled
mon/mgr/mds node, supply that storage LUKS blob+password as input and
specify what to restore(mon/mds/mgr/all). It would restore requested
daemon data up to part-second difference after crash and user can
easily bring back mon quorum and the rest of ceph vital parts.

It seams to me that either mons/mgrs need to advance and to include
"ceph recovery module" that would do all of the above or special
daemon is needed for that. Such daemons should be deployable also in
remote locations that are reachable with fast enough link.

Sure the above may seem over complicating things but discussion is
needed as there is no Disaster Recovery chapter for ceph itself in
documentation in one place. There are scattered parts how to recover
monitors, how to mirror RBDs etc, but no single place with procedure
"implement these steps and you will be able to easily recover your
ceph cluster".

BR,
Ugis

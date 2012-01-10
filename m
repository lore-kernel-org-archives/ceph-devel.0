From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Subject: Adding new mon to existing cluster in ceph v0.39(+?)
Date: Tue, 10 Jan 2012 13:47:26 +0100
Message-ID: <CAMwB3TgxYQ8BsLCfTp+6-ZB_g0V4VGGDFqLxvxKmo3773CTwiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48922 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab2AJMr2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 07:47:28 -0500
Received: by wgbdr10 with SMTP id dr10so2996721wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2012 04:47:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have some problem with adding a new mon to existing ceph cluster.

Now cluster contains a 3 mon's, but i started with only one in one
machine. Then adding a second, and third machine, with new mon's, and
OSD. Adding, a new OSD is quiet simple, but adding, a new mon is
compilation of some pieces in old doc of ceph, new doc, and a group
mails.

This -> http://ceph.newdream.net/docs/latest/ops/manage/grow/mon/ -
not working properly in section (Adding a monitor)

Maybe this will be useful for someone:

1. Create a new mon structure with existing one working mon instance,
maybe created with mkcepfs in init of cluster.

  a) edit ceph.conf, and add new mon definition in mon part of conf in
whole cluster.

  b) ceph auth get mon. -o /tmp/monkey

  c) fsid=3D`ceph fsid --concise`

  d) ceph-mon -i <new-mon-id> --mkfs -k /tmp/monkey --fsid $fsid

2. Before you start new mon (check if new mon is not working - in my
case it's not starting even if i try :)), some things musts be done
before.
It's based on http://ceph.newdream.net/docs/latest/ops/manage/grow/mon/
(Removing a monitor from an unhealthy or down cluster)

  a) On a surviving monitor node, find the most recent monmap in mon
dir, like in doc about removing monitor.

  b) On a surviving monitor node:

   $ cp $mon_data/monmap/<latest-monmap-id> /tmp/foo
   $ monmaptool /tmp/foo --add <new-mon-id> <new-mon-ip>:<new-mon-port>

  c) Inject a new monmap to working ceph mon.

     ceph-mon -i <surviving-mon-id> --inject-monmap /tmp/foo

     ceph -s will show new number of mons.

  d) copy /tmp/foo, and inject this monmap, to every mon, that works
in existing cluster, even on machine with new mon to update, a monmap
in new mon directory.

  e) Start new mon:

   service ceph start mon

then mon_status will show a new list of mon in ceph cluster.

   ceph mon_status

Now new mon works perfect.


Maybe it's not a supported way to insert a new mon to cluster, but for
me now it's only way that works :)

--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

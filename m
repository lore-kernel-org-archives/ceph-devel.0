From: Gregory Farnum <greg@inktank.com>
Subject: rbd locking and handling broken clients
Date: Wed, 13 Jun 2012 10:40:50 -0700
Message-ID: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59338 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752687Ab2FMRkv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jun 2012 13:40:51 -0400
Received: by lahd3 with SMTP id d3so628307lah.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 10:40:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: mandell@pistoncloud.com

We've had some user reports lately on rbd images being broken by
misbehaving clients =97=A0namely, rbd image I is mounted on computer A,
computer A starts misbehaving, and so I is mounted on computer B. But
because A is misbehaving it keeps writing to the image, corrupting it
horribly.
To handle this, we're working on two separate but related features:
1) Advisory RBD image locking. See
http://tracker.newdream.net/issues/1480 and the wip-rbd-locking
branch. With this addition clients gain the ability to do shared and
exclusive locking of images, which protects against accidentally
mounting a disk in two places at once =97 but because the images are
distributed across all OSDs this is of course entirely advisory, and=A0=
a
misbehaving client is still perfectly capable of writing to a disk it
shouldn't. To handle that, we're also looking at...
2) Client fencing. See http://tracker.newdream.net/issues/2531. There
is an existing "blacklist" functionality in the OSDs/OSDMap, where you
can specify an "entity_addr_t" (consisting of an IP, a port, and a
nonce =97 so essentially unique per-process) which is not allowed to
communicate with the cluster any longer. The problem with this is that
since it's distributed as part of the OSDMap (via gossip), then if
it's important to have a point-in-time transition (as with an rbd
image), the new client needs every OSD to update their map before it
starts doing any reads or writes.
The initial idea in the bug was to have some sort of command you could
run on a per-image basis, which breaks the locks and does the
blacklist for the old locker =97 but if the problem is a misbehaving
hypervisor, then you may have to run that for several hundred images,
where each command needs to talk to several hundred OSDs. That's
super-lame and nobody wants to do it. The alternative is making an
admin/script do it on their own using the existing "ceph osd
blacklist" and about-to-exist "rbd lock break" functionality as
appropriate. That's also super-lame, because then they have to come up
with some way of spreading the map, and it's difficult to embed in
external libraries. So what I'm currently (as of 15 seconds ago)
leaning towards is a new rados command which will do the blacklist and
make sure the new map is distributed to each OSD ("rados
blacklist_and_spread 'address'"), and then requiring the automatic
system to:
a) Run the blacklist command,
b) individually break the locks necessary,
c) remount the image(s) elsewhere.

Are there any thoughts on these plans? Do they satisfy your needs in
this area, or are there holes you can think of?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

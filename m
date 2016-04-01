From: Marcel Lauhoff <lauhoff@uni-mainz.de>
Subject: Started developing a deduplication feature
Date: Fri, 1 Apr 2016 19:25:57 +0200
Message-ID: <8737r5w89m.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate-01.zdv.uni-mainz.de ([134.93.178.241]:5657 "EHLO
	mailgate-01.zdv.uni-mainz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbcDARfz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 13:35:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi Ceph,

deduplication has been discussed on the list a couple of times.
Over the next months I'll be working on a prototype.

In short: Use a content-addressed storage pool backed by a pool
acting as storage and distributed fingerprint index.



Two pools: (1) pool that does the content addressing, (2) storage / index pool.

OSDs in the first pool readdress and chuck/reassemble objects.
They then store the new objects/chunks in a second pool.
The first pool uses a new PG backend ("CAS Backend"),
while the second can use replication or erasure coding.

The CAS backend computes fingerprints for incoming objects and
stores the fingerprint <-> original object name mapping.
It then forwards the data to a storage pool, addressing the objects by
fingerprint (the content defined name).

The storage pool therefore serves as a distributed fingerprint index.
CRUSH selects the responsible OSDs. The OSDs know their objects.

Deduplication happens when two objects/chunks have the same
fingerprint.

My current milestones:
- Develop CAS backend, fingerprinting, recipes store
- Support limited set of operations (like EC does)
- Support RBD (with/without Cache) and evaluate
- Add Chunking, Garbage Collection, ..

Currently I'm adding a new PG backend into the OSD code base. I'll
push the code the my github clone as soon as it does "something" :)

~irq0

--
Marcel Lauhoff
Mail: lauhoff@uni-mainz.de
XMPP: mlauhoff@jabber.uni-mainz.de

From: Amit Vijairania <amit.vijairania@gmail.com>
Subject: Crushmap ruleset for rack aware PG placement
Date: Mon, 15 Sep 2014 00:47:42 -0700
Message-ID: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:55807 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaIOHrn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 03:47:43 -0400
Received: by mail-ig0-f175.google.com with SMTP id h15so3475759igd.8
        for <ceph-devel@vger.kernel.org>; Mon, 15 Sep 2014 00:47:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "William Bloom (wibloom)" <wibloom@cisco.com>, "Cecil Lee -X (cecille - TEKSYSTEMS INC at Cisco)" <cecille@cisco.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello!

In a two (2) rack Ceph cluster, with 15 hosts per rack (10 OSD per
host / 150 OSDs per rack), is it possible to create a ruleset for a
pool such that the Primary and Secondary PGs/replicas are placed in
one rack and Tertiary PG/replica is placed in the other rack?

root standard {
  id -1 # do not change unnecessarily
  # weight 734.400
  alg straw
  hash 0 # rjenkins1
  item rack1 weight 367.200
  item rack2 weight 367.200
}

Given there are only two (2) buckets, but three (3) replica, is it
even possible?

I think following Giant blueprint is trying to address scenario I
described above.. Is the following blueprint targeted for Giant
release?
http://wiki.ceph.com/Planning/Blueprints/Giant/crush_extension_for_more_flexible_object_placement


Regards,
Amit Vijairania  |  Cisco Systems, Inc.
--*--

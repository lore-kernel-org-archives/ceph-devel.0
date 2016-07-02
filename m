From: Hunger <pr1@hunger.hu>
Subject: Fwd: OSD unresponsive via the TCP interface when having unfound objects
Date: Sat, 2 Jul 2016 22:28:54 +0200
Message-ID: <57782406.5010106@hunger.hu>
References: <CANyuAwhHKwwFgDhiBCe2j5-e8rojFiA_QKo_45aL2ot+cCpgAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proactivesec.com ([78.131.57.238]:32620 "EHLO
	mail.proactivesec.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbcGBUfG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Jul 2016 16:35:06 -0400
Received: from [192.168.127.1] (unknown [192.168.127.1])
	by mail.proactivesec.com (PMS) with ESMTP id 1426DB7FBD
	for <ceph-devel@vger.kernel.org>; Sat,  2 Jul 2016 22:29:04 +0200 (CEST)
in-reply-to: <CANyuAwhHKwwFgDhiBCe2j5-e8rojFiA_QKo_45aL2ot+cCpgAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

possible bug found in OSD. Please read it below.

Thanks,

-h



---------- Forwarded message ----------
From: Matyas Koszik <koszikmatyas@gmail.com>
Date: Sat, Jul 2, 2016 at 9:26 PM
Subject: OSD unresponsive via the TCP interface when having unfound objects
To: ceph-users@ceph.com


Hi,

After a set of transient failures I was greeted with a bunch of unfound
objects. This should not be a problem, since there's the
'mark_unfound_lost' pg command that can fix it. Unfortunately that does not
work, since the primary OSDs for the unfound objects refuse to serve TCP
commands.

Example:

pg 4.a5 is active+recovery_wait+degraded, acting [10,20], 6 unfound


[root@store4 ~]# ceph pg 4.a5 mark_unfound_lost revert
[... hangs indefinitely]

I can't even issue simple commands to the osd:
[root@store4 ~]# ceph tell osd.10 version
[... hangs indefinitely]

On the other hand:
[root@store4 ~]# ceph tell osd.20 version
{
    "version": "ceph version 10.2.2
(45107e21c568dd033c2f0a3107dec8f0b0e58374)"
}


But if I shut down osd.10, then osd.20 becomes unresponsive like .10 was.

This unresponsiveness happens only via TCP:
[root@store2 osd]# ceph --admin-daemon /var/run/ceph/ceph-osd.10.asok
version
{"version":"10.2.2"}


I turned logging up to 20 on the osd, and there's a lot of these messages,
that I don't observe on a healthy osd:
share_map_peer 0x7faac7f77600 already has epoch 37602
share_map_peer 0x7faac7f77600 already has epoch 37602
share_map_peer 0x7faac8ccaa00 already has epoch 37602
share_map_peer 0x7faac8ccaa00 already has epoch 37602
..

This does not tell me anything useful unfortunately.

Being unable to fix the 77 unfound objects is a real problem because it
seems that their primary osds are also blocking for every request, so I'm
now in the infamous situation of "my whole cluster hangs" (of course,
there're some vms that only use unaffected osds, but a lot of them are
affected.)

What can I do to fix this situation without having to destroy those pgs?

Thanks,
Matyas




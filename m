From: =?ISO-8859-1?Q?Micka=EBl_Can=E9vet?= <canevet@embl.fr>
Subject: Multiple disks per server.
Date: Tue, 04 May 2010 14:18:25 +0200
Message-ID: <4BE01091.7040103@embl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from emblmta1.embl.fr ([193.49.43.176]:38949 "EHLO emblmta1.embl.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758556Ab0EDM2G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 May 2010 08:28:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm testing ceph on 4 old servers.

As there is more then one disk per server available for data (2 with 6=20
disks and 2 with 10 disks for a total of 32 disks over 4 nodes), I was=20
wondering how to define OSDs.

I have choice between one OSD per disk (32 OSDs on the cluster) or one=20
OSD per server with one btrfs filesystem over all disks of the server (=
4=20
OSDs on the cluster). Which one is the best solution ?

In the first case, if I lose one disk, I lose only a small part of=20
available space. In the other case, if I lose one disk, I lose the whol=
e=20
server (as btrfs filesystem is in stripping) much more space.

On the other hand, if I lose the whole server in the first case, I can=20
lose all replicates of a data because they may be on two different OSD=20
on the same server.

Is there a way to define OSD groups so that we can be sure that 2=20
replicates are not on OSDs of the same group (could be usefull for=20
multiple OSDs per server, but also mutliple server per computing room -=
=20
if I lose one whole room, a lot of server, I will be sure that I have=20
not lost every replicates).

Thanks a lot.
Micka=EBl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

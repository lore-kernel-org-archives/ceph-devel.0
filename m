From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Improving responsiveness of KVM guests on Ceph storage
Date: Sun, 30 Dec 2012 18:05:33 +0100
Message-ID: <50E0745D.8050306@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx06.stofanet.dk ([212.10.10.58]:49885 "EHLO mx06.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957Ab2L3RFg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 30 Dec 2012 12:05:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi guys,

I'm testing Ceph as storage for KVM virtual machine images and found an=
=20
inconvenience that I am hoping it is possible to find the cause of.

I'm running a single KVM Linux guest on top of Ceph storage. In that=20
guest I run rsync to download files from the internet. When rsync is=20
running, the guest will seemingly stall and run very slowly.

=46or example if I log in via SSH to the guest and use the command prom=
pt,=20
nothing will happen for a long period (30+ seconds), then it processes =
a=20
few typed characters, and then it blocks for another long period of=20
time, then process a bit more, etc.

I was hoping to be able to tweak the system so that it runs more like=20
when using conventional storage - i.e. perhaps the rsync won't be super=
=20
fast, but the machine will be equally responsive all the time.

I'm hoping that you can provide some hints on how to best benchmark or=20
test the system to find the cause of this?

The ceph OSDs periodically logs thse two messages, that I do not fully=20
understand:

12-12-30 17:07:12.894920 7fc8f3242700  1 heartbeat_map is_healthy=20
'OSD::op_tp thread 0x7fc8cbfff700' had timed out after 30
2012-12-30 17:07:13.599126 7fc8cbfff700  1 heartbeat_map reset_timeout=20
'OSD::op_tp thread 0x7fc8cbfff700' had timed out after 30

Is this to be expected when the system is in use, or does it indicate=20
that something is wrong?

Ceph also logs messages such as this:

2012-12-30 17:07:36.932272 osd.0 10.0.0.1:6800/9157 286340 : [WRN] slow=
=20
request 30.751940 seconds old, received at 2012-12-30 17:07:06.180236:=20
osd_op(client.4705.0:16074961 rb.0.11b7.4a933baa.0000000c188f [write=20
532480~4096] 0.f2a63fe) v4 currently waiting for sub ops


My setup:

3 servers running Fedora 17 with Ceph 0.55.1 from RPM.
Each server runs one osd and one mon. One of the servers also runs an m=
ds.
Backing file system is btrfs stored on a md-raid . Journal is stored on=
=20
the same SATA disks as the rests of the data.
Each server has 3 bonded gigabit/sec NICs.

One server running Fedora 16 with qemu-kvm.
Has gigabit/sec NIC connected to the same network as the Ceph servers,=20
and a gigabit/sec NIC connected to the Internet.
Disk is mounted with:

-drive format=3Drbd,file=3Drbd:data/image1:rbd_cache=3D1,if=3Dvirtio


iostat on the KVM guest gives:

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,00    0,00    0,00  100,00    0,00    0,00

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s=20
avgrq-sz avgqu-sz   await  svctm  %util
vda               0,00     1,40    0,10    0,30     0,80    13,60=20
36,00     1,66 2679,25 2499,75  99,99


Top on the KVM host shows 90% CPU idle and 0.0% I/O waiting.

iostat on a OSD gives:
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,13    0,00    1,50   15,79    0,00   82,58

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s=20
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda             240,70   441,20   33,00   42,70  1122,40  1961,80=20
81,48    14,45  164,42  319,14   44,85   6,63  50,22
sdb             299,10   393,10   33,90   38,40  1363,60  1720,60=20
85,32    13,55  171,32  316,21   43,41   6,55  47,39
sdc             268,50   441,60   28,80   45,40  1191,60  1977,00=20
85,41    19,08  159,39  345,98   41,02   6,56  48,69
sdd             255,50   445,50   30,20   45,00  1150,40  1975,80=20
83,14    18,18  155,97  338,90   33,20   6,95  52,23
md0               0,00     0,00    1,20  132,70     4,80  4086,40=20
61,11     0,00    0,00    0,00    0,00   0,00   0,00


The figures are similar on all three OSDs.

I am thinking that one possible cause could be that the journal is=20
stored on the same disks as the rest of the data, but I don't know how=20
to benchmark if this is actually the case (?)

Thanks for any help or advice, you can offer!

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

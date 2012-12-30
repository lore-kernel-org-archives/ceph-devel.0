From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Improving responsiveness of KVM guests on Ceph storage
Date: Mon, 31 Dec 2012 01:12:56 +0300
Message-ID: <CABYiri9A4LxEgjrGHRVfn_WSLR9_ztHKN_+GJBh7KButwa68JA@mail.gmail.com>
References: <50E0745D.8050306@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65029 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab2L3WNT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Dec 2012 17:13:19 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so11185433obb.33
        for <ceph-devel@vger.kernel.org>; Sun, 30 Dec 2012 14:13:16 -0800 (PST)
In-Reply-To: <50E0745D.8050306@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Kristian_S=C3=B8gaard?= <jens@mermaidconsulting.dk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Dec 30, 2012 at 9:05 PM, Jens Kristian S=C3=B8gaard
<jens@mermaidconsulting.dk> wrote:
> Hi guys,
>
> I'm testing Ceph as storage for KVM virtual machine images and found =
an
> inconvenience that I am hoping it is possible to find the cause of.
>
> I'm running a single KVM Linux guest on top of Ceph storage. In that =
guest I
> run rsync to download files from the internet. When rsync is running,=
 the
> guest will seemingly stall and run very slowly.
>
> For example if I log in via SSH to the guest and use the command prom=
pt,
> nothing will happen for a long period (30+ seconds), then it processe=
s a few
> typed characters, and then it blocks for another long period of time,=
 then
> process a bit more, etc.
>
> I was hoping to be able to tweak the system so that it runs more like=
 when
> using conventional storage - i.e. perhaps the rsync won't be super fa=
st, but
> the machine will be equally responsive all the time.
>
> I'm hoping that you can provide some hints on how to best benchmark o=
r test
> the system to find the cause of this?
>
> The ceph OSDs periodically logs thse two messages, that I do not full=
y
> understand:
>
> 12-12-30 17:07:12.894920 7fc8f3242700  1 heartbeat_map is_healthy
> 'OSD::op_tp thread 0x7fc8cbfff700' had timed out after 30
> 2012-12-30 17:07:13.599126 7fc8cbfff700  1 heartbeat_map reset_timeou=
t
> 'OSD::op_tp thread 0x7fc8cbfff700' had timed out after 30
>
> Is this to be expected when the system is in use, or does it indicate=
 that
> something is wrong?
>
> Ceph also logs messages such as this:
>
> 2012-12-30 17:07:36.932272 osd.0 10.0.0.1:6800/9157 286340 : [WRN] sl=
ow
> request 30.751940 seconds old, received at 2012-12-30 17:07:06.180236=
:
> osd_op(client.4705.0:16074961 rb.0.11b7.4a933baa.0000000c188f [write
> 532480~4096] 0.f2a63fe) v4 currently waiting for sub ops
>
>
> My setup:
>
> 3 servers running Fedora 17 with Ceph 0.55.1 from RPM.
> Each server runs one osd and one mon. One of the servers also runs an=
 mds.
> Backing file system is btrfs stored on a md-raid . Journal is stored =
on the
> same SATA disks as the rests of the data.
> Each server has 3 bonded gigabit/sec NICs.
>
> One server running Fedora 16 with qemu-kvm.
> Has gigabit/sec NIC connected to the same network as the Ceph servers=
, and a
> gigabit/sec NIC connected to the Internet.
> Disk is mounted with:
>
> -drive format=3Drbd,file=3Drbd:data/image1:rbd_cache=3D1,if=3Dvirtio
>
>
> iostat on the KVM guest gives:
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0,00    0,00    0,00  100,00    0,00    0,00
>
> Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avg=
rq-sz
> avgqu-sz   await  svctm  %util
> vda               0,00     1,40    0,10    0,30     0,80    13,60 36,=
00
> 1,66 2679,25 2499,75  99,99
>
>
> Top on the KVM host shows 90% CPU idle and 0.0% I/O waiting.
>
> iostat on a OSD gives:
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0,13    0,00    1,50   15,79    0,00   82,58
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avg=
rq-sz
> avgqu-sz   await r_await w_await  svctm  %util
> sda             240,70   441,20   33,00   42,70  1122,40  1961,80 81,=
48
> 14,45  164,42  319,14   44,85   6,63  50,22
> sdb             299,10   393,10   33,90   38,40  1363,60  1720,60 85,=
32
> 13,55  171,32  316,21   43,41   6,55  47,39
> sdc             268,50   441,60   28,80   45,40  1191,60  1977,00 85,=
41
> 19,08  159,39  345,98   41,02   6,56  48,69
> sdd             255,50   445,50   30,20   45,00  1150,40  1975,80 83,=
14
> 18,18  155,97  338,90   33,20   6,95  52,23
> md0               0,00     0,00    1,20  132,70     4,80  4086,40 61,=
11
> 0,00    0,00    0,00    0,00   0,00   0,00
>
>
> The figures are similar on all three OSDs.
>
> I am thinking that one possible cause could be that the journal is st=
ored on
> the same disks as the rest of the data, but I don't know how to bench=
mark if
> this is actually the case (?)
>
> Thanks for any help or advice, you can offer!

Hi Jens,

You may try do play with SCHED_RT, I have found it hard to use for
myself, but you can achieve your goal by adding small RT slices via
``cpu'' cgroup to vcpu/emulator threads, it dramatically increases
overall VM` responsibility. I have thrown it off because RT scheduler
is a very strange thing - it may cause endless lockup on disk
operation during heavy operations or produce ever-stuck ``kworker'' on
some cores if you have killed VM which has separate RT slices for vcpu
threads. Of course, some Ceph tuning like writeback cache and large
journal may help you too, I`m speaking primarily of VM` performance by
itself.

>
> --
> Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

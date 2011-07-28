From: huang jun <hjwsm1989@gmail.com>
Subject: osd down
Date: Thu, 28 Jul 2011 21:16:56 +0800
Message-ID: <CABAwU-ZrsJjXSX+2VV_1qbOJ7+4jeNzvThd6PC_CSOLBoG70RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59421 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab1G1NQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 09:16:57 -0400
Received: by mail-wy0-f174.google.com with SMTP id 8so102145wyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 06:16:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hello,all
today,we encountered a strange problem.
we write data into OSD cluster, in the beginning,it works well.
but few hours later, the client can not write anymore data.
"ceph -s" shows OSD down. and we can not even ssh into that OSD, the
keyboard can not work, screen got drak.
after reboot it manually, from the kern.log of the down OSD in below
=85=85=85=85
Jul 28 11:25:40 T02-OSD152 kernel: [ 4393.176941] r8169 0000:01:00.0:
eth0: link up
Jul 28 11:26:00 T02-OSD152 kernel: [ 4413.166737] r8169 0000:01:00.0:
eth0: link up
Jul 28 11:26:00 T02-OSD152 kernel: [ 4413.426215] r8169 0000:01:00.0:
eth0: link up
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@6802/3615
took stat stat(2011-07-23 13:45:26.302800 oprate=3D0 qlen=3D0
recent_qlen=3D0 rdlat=3D0 / 0 fshedin=3D0)
2011-07-23 13:45:26.171417 7f754f9bc700 osd0 7 take_peer_stat peer
osd1 stat(2011-07-23 13:45:26.302800 oprate=3D0 qlen=3D0 recent_qlen=3D=
0
rdlat=3D0 / 0 fshedin=3D0)
2011-07-23 13:45:26.171423 7f754f9bc700 osd0 7 _share_map_outgoing
osd1 192.168.0.155:6801/3615 already has epoch 7
2011-07-23 13:45:26.988122 7f754f9bc700 -- 192.168.0.152:6802/3446 <=3D=
=3D
osd2 192.168.0.156:6802/3527 15264 =3D=3D=3D=3D osd_ping(e7 as_of 7 hea=
rtbeat)
v1 =3D=3D=3D=3D 61+0+0 (2575005658 0 0) 0x2514000 con 0x186bc80
2011-07-23 13:45:26.988166 7f754f9bc700 osd0 7 handle_osd_ping osd2
192.168.0.156:6802/3527 took stat stat(2011-07-23 13:45:27.115844
oprate=3D0 qlen=3D0 recent_qlen=3D0 rdlat=3D0 / 0 fshedin=3D0)
2011-07-23 13:45:26.988180 7f754f9bc700 osd0 7 take_peer_stat peer
osd2 stat(2011-07-23 13:45:27.115844 oprate=3D0 qlen=3D0 recent_qlen=3D=
0
rdlat=3D0 / 0 fshedin=3D0)
2011-07-23 13:45:26.988187 7f754f9bc700 osd0 7 _share_map_outgoing
osd2 192.168.0.156:6801/3527 already has epoch 7
2011-07-23 13:45:27.009638 7f75559c8700 osd0 7 tick
2011-07-23 13:45:27.009695 7f75559c8700 osd0 7 scrub_should_schedule
loadavg 0.03 < max 0.5 =3D no, randomly backing off
2011-07-23 13:45:27.094897 7f75541c5700 filestore(/data/osd0)
sync_entry woke after 1.000086
2011-07-23 13:45:27.094920 7f75541c5700 journal commit_start op_seq
3393, applied_seq 3393, committed_seq 3393
2011-07-23 13:45:27.094935 7f75541c5700 journal commit_start nothing to=
 do
2011-07-23 13:45:27.094951 7f75541c5700 filestore(/data/osd0)
sync_entry waiting for max_interval 1.000000
2011-07-23 13:45:27.171283 7f754f9bc700 -- 192.168.0.152:6802/3446 <=3D=
=3D
osd1 192.168.0.155:6802/3615 15248 =3D=3D=3D=3D osd_ping(e7 as_of 7 hea=
rtbeat)
v1 =3D=3D=3D=3D 61+0+0 (1684980217 0 0) 0x254c000 con 0x186b140
2011-07-23 13:45:27.171329 7f754f9bc700 osd0 7 handle_osd_ping osd1
192.168.0.155:6802/3615 took stat stat(2011-07-23 13:45:27.303017
oprate=3D0 qlen=3D0 recent_qlen=3D0 rdlat=3D0 / 0 fshedin=3D0)
2011-07-23 13:45:27.171343 7f754f9bc700 osd0 7 take_peer_stat peer
osd1 stat(2011-07-23 13:45:27.303017 oprate=3D0 qlen=3D0 recent_qlen=3D=
0
rdlat=3D0 / 0 fshedin=3D0)
2011-07-23 13:45:27.171350 7f754f9bc700 osd0 7 _share_map_outgoing
osd1 192.1Jul 28 14:50:56 T02-OSD152 kernel: imklog 3.18.6, log source
=3D /proc/kmsg started.
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000] Initializing cgroup
subsys cpuset
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000] Initializing cgroup s=
ubsys cpu
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000] Linux version
2.6.37.6 (root@T02-OSD151) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1
SMP Mon Jul 18 10:23:56 CST 2011
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000] Command line:
root=3D/dev/sda2 quiet vga=3D788 splash ro
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000] BIOS-provided
physical RAM map:
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
0000000000000000 - 000000000009dc00 (usable)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
000000000009dc00 - 00000000000a0000 (reserved)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000000e4000 - 0000000000100000 (reserved)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
0000000000100000 - 00000000dcf70000 (usable)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000dcf70000 - 00000000dcf88000 (ACPI data)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000dcf88000 - 00000000dcfdc000 (ACPI NVS)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000dcfdc000 - 00000000dd800000 (reserved)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000dde00000 - 00000000e0000000 (reserved)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000fee00000 - 00000000fee01000 (reserved)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
00000000ff800000 - 0000000100000000 (reserved)
Jul 28 14:50:56 T02-OSD152 kernel: [    0.000000]  BIOS-e820:
0000000100000000 - 0000000118000000 (usable)
=85=85=85=85
we are confused by this message, how did OSD log infos goes into
kern.log. By the way, we search " kernel: imklog 3.18.6, log source =3D
/proc/kmsg started." in google, it said something about syslog deamon.
We run rsyslogd deamon in all OSD to backup OSD debug log. I'm not
sure wherther this resulted in the OSD down.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

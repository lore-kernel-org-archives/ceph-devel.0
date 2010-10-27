From: Yonggang Liu <myidpt@gmail.com>
Subject: Re: mds port 6800 socket closed when accessing mount point
Date: Wed, 27 Oct 2010 15:05:27 -0400
Message-ID: <AANLkTimkopsoDCC+REf2ffdbe8noSj2wSLU4b_3ZH=d7@mail.gmail.com>
References: <AANLkTindXNKvAYcN1WLN7VDdTz41DATMgNgfqbMm5879@mail.gmail.com>
	<AANLkTinOrT4W=Ow9uzwC93XeA7ZFZwEQ5uc-PMv_0-C_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36079 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab0J0TF3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Oct 2010 15:05:29 -0400
Received: by eye27 with SMTP id 27so989080eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Oct 2010 12:05:28 -0700 (PDT)
In-Reply-To: <AANLkTinOrT4W=Ow9uzwC93XeA7ZFZwEQ5uc-PMv_0-C_@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

Hi Colin,

Thank you for your reply. I ran "ps uax | grep ceph" on 4 machines to
check if the daemons are running. I got:
On client:
root      1721  0.0  0.0      0     0 ?        S    17:53   0:00 [ceph-=
msgr/0]
root      1725  0.0  0.0      0     0 ?        S    17:53   0:00
[ceph-writeback/]
root      1726  0.0  0.0      0     0 ?        S    17:53   0:00
[ceph-pg-invalid]
root      1727  0.0  0.0      0     0 ?        S    17:53   0:00 [ceph-=
trunc]
On mds0:
root      1930  0.5  1.2  48468  3280 ?        S<sl 15:55   0:01
/usr/bin/cmon -i 0 -c /tmp/ceph.conf.1869
root      1979  4.7  1.4  76340  3740 ?        S<sl 15:55   0:13
/usr/bin/cmds -i 0 -c /tmp/ceph.conf.1869
On osd0:
root      1657  0.4  7.4 214316 18988 ?        S<sl 15:55   0:01
/usr/bin/cosd -i 0 -c /tmp/ceph.conf.1869
On osd1:
root      1676  0.7 10.6 220624 27180 ?        S<sl 15:55   0:02
/usr/bin/cosd -i 1 -c /tmp/ceph.conf.1869


These are the last few lines of log files I got from /var/log/ceph/:
On mds0
mds.0.log:
2010-10-27 15:56:09.238267 b362fb70 failed to decode message of type
784 v4865: buffer::end_of_buffer
2010-10-27 15:56:09.238960 b362fb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fceb20 sd=3D-1 pgs=3D9 cs=3D7 l=3D0=
).fault
with nothing to send, going to standby
2010-10-27 15:56:23.330586 b352eb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd0168 sd=3D12 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (socket i=
s
192.168.89.131:41725/0)
2010-10-27 15:56:23.330744 b352eb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd0168 sd=3D12 pgs=3D0 cs=3D0
l=3D0).accept connect_seq 7 vs existing 7 state 3
2010-10-27 15:56:23.332473 b352eb70 failed to decode message of type
784 v4865: buffer::end_of_buffer
2010-10-27 15:56:23.332730 b352eb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd0168 sd=3D-1 pgs=3D10 cs=3D8
l=3D0).fault with nothing to send, going to standby
2010-10-27 15:56:52.022573 b332cb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd1720 sd=3D12 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (socket i=
s
192.168.89.131:41726/0)
2010-10-27 15:56:52.022945 b332cb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd1720 sd=3D12 pgs=3D0 cs=3D0
l=3D0).accept connect_seq 8 vs existing 8 state 3
2010-10-27 15:56:52.025299 b332cb70 failed to decode message of type
784 v4865: buffer::end_of_buffer
2010-10-27 15:56:52.025569 b332cb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd1720 sd=3D-1 pgs=3D11 cs=3D9
l=3D0).fault with nothing to send, going to standby
2010-10-27 15:57:48.106337 b362fb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd07c0 sd=3D12 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (socket i=
s
192.168.89.131:41727/0)
2010-10-27 15:57:48.106522 b362fb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd07c0 sd=3D12 pgs=3D0 cs=3D0
l=3D0).accept connect_seq 9 vs existing 9 state 3
2010-10-27 15:57:48.109498 b362fb70 failed to decode message of type
784 v4865: buffer::end_of_buffer
2010-10-27 15:57:48.109761 b362fb70 -- 192.168.89.133:6800/1978 >>
192.168.89.131:0/1344076202 pipe(0x9fd07c0 sd=3D-1 pgs=3D12 cs=3D10
l=3D0).fault with nothing to send, going to standby

On osd0
osd.0.log:
2010-10-27 15:55:01.470502 --- 1633 opened log /var/log/ceph/osd.0.log =
---
ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee33541)
2010-10-27 15:55:01.485828 b72d38e0 filestore(/data/osd0) mkfs in /data=
/osd0
2010-10-27 15:55:01.486106 b72d38e0 filestore(/data/osd0) mkfs
removing old file fsid
2010-10-27 15:55:01.516527 b72d38e0 filestore(/data/osd0) mkjournal
created journal on /journal
2010-10-27 15:55:01.516734 b72d38e0 filestore(/data/osd0) mkfs done in
/data/osd0
2010-10-27 15:55:01.519606 b72d38e0 filestore(/data/osd0) mount did
NOT detect btrfs
2010-10-27 15:55:01.519794 b72d38e0 filestore(/data/osd0) mount found s=
naps <>
2010-10-27 15:55:01.548307 b5acfb70 FileStore::op_tp worker finish
2010-10-27 15:55:01.548455 b52ceb70 FileStore::op_tp worker finish
2010-10-27 15:55:01.548812 b72d38e0 journal close /journal
2010-10-27 15:55:25.201288 --- 1656 opened log /var/log/ceph/osd.0.log =
---
ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee33541)
2010-10-27 15:55:25.223381 b74508e0 filestore(/data/osd0) mount did
NOT detect btrfs
2010-10-27 15:55:25.224253 b74508e0 filestore(/data/osd0) mount found s=
naps <>
2010-10-27 15:55:25.225396 b74508e0 journal read_entry 4096 : seq 1 203=
 bytes
2010-10-27 15:55:26.841749 abffeb70 -- 0.0.0.0:6801/1656 >>
192.168.89.135:6801/1675 pipe(0x94ced18 sd=3D13 pgs=3D0 cs=3D0 l=3D0).c=
onnect
claims to be 0.0.0.0:6801/1675 not 192.168.89.135:6801/1675 -
presumably this is the same node!
2010-10-27 15:56:04.219613 abaf9b70 -- 192.168.89.134:6800/1656 >>
192.168.89.131:0/1344076202 pipe(0x96463e0 sd=3D16 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (socket i=
s
192.168.89.131:36746/0)

On osd1
osd.1.log:
2010-10-27 15:54:59.752615 --- 1652 opened log /var/log/ceph/osd.1.log =
---
ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee33541)
2010-10-27 15:54:59.766128 b73518e0 filestore(/data/osd1) mkfs in /data=
/osd1
2010-10-27 15:54:59.766658 b73518e0 filestore(/data/osd1) mkfs
removing old file fsid
2010-10-27 15:54:59.796938 b73518e0 filestore(/data/osd1) mkjournal
created journal on /journal
2010-10-27 15:54:59.797816 b73518e0 filestore(/data/osd1) mkfs done in
/data/osd1
2010-10-27 15:54:59.800957 b73518e0 filestore(/data/osd1) mount did
NOT detect btrfs
2010-10-27 15:54:59.801087 b73518e0 filestore(/data/osd1) mount found s=
naps <>
2010-10-27 15:54:59.832202 b534cb70 FileStore::op_tp worker finish
2010-10-27 15:54:59.832504 b5b4db70 FileStore::op_tp worker finish
2010-10-27 15:54:59.832723 b73518e0 journal close /journal
2010-10-27 15:55:23.050042 --- 1675 opened log /var/log/ceph/osd.1.log =
---
ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee33541)
2010-10-27 15:55:23.056671 b72e18e0 filestore(/data/osd1) mount did
NOT detect btrfs
2010-10-27 15:55:23.056921 b72e18e0 filestore(/data/osd1) mount found s=
naps <>
2010-10-27 15:55:23.057368 b72e18e0 journal read_entry 4096 : seq 1 203=
 bytes
2010-10-27 15:55:23.207216 b12d4b70 osd1 2 map says i am down or have
a different address.  switching to boot state.
2010-10-27 15:55:23.207540 b12d4b70 log [WRN] : map e2 wrongly marked m=
e down

I noticed on osd1, the last two lines of osd.1.log are unusual, but
I'm not sure if they are the reason to the problem ...

Thank you very much,


On Wed, Oct 27, 2010 at 1:10 PM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> Hi Yonggang,
>
> Are all of the daemons still running? What is at the end of the logfi=
les?
>
> regards,
> Colin
>
>
> On Wed, Oct 27, 2010 at 9:42 AM, Yonggang Liu <myidpt@gmail.com> wrot=
e:
>> Hello,
>>
>> I'm totally new to Ceph. Last a few days I set up 4 VMs to run Ceph:
>> "mds0" for the metadata server and monitor, "osd0" and "osd1" for tw=
o
>> data servers, and "client" for the client machine. The VMs are runni=
ng
>> Debian 5.0 with kernel 2.6.32-5-686 (Ceph module is enabled).
>> I followed "Building kernel client" and "Debian" from the wiki, and =
I
>> was able to start Ceph and mount Ceph at the client. But the problem
>> is, the mounted point always fail with an infinite response time
>> (after I mount Ceph for about 1 min or less). To illustrate it bette=
r,
>> I will show you the information I got on the client and mds0 machine=
s:
>>
>> mds0 (192.168.89.133):
>> debian:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
>> (A lot of info)
>> debian:~# /etc/init.d/ceph -a start
>> (some info)
>>
>> client (192.168.89.131):
>> debian:~# mount -t ceph 192.168.89.133:/ /ceph
>> debian:~# cd /ceph
>> debian:/ceph# cp ~/app_ch.xls .
>> debian:/ceph# ls
>> (waiting for ever)
>> ^C
>>
>> After the failure I ran dmesg at the client side and got:
>> client (192.168.89.131):
>> debian:/ceph# dmesg -c
>> [ =A0636.664425] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/=
5 5/5)
>> [ =A0636.694973] ceph: client4100 fsid 423ad64c-bbf0-3011-bb47-36a89=
f8787c6
>> [ =A0636.700716] ceph: mon0 192.168.89.133:6789 session established
>> [ =A0664.114551] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0664.848722] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0665.914923] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0667.840396] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0672.054106] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0680.894531] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0696.928496] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0720.171754] ceph: mds0 caps stale
>> [ =A0728.999701] ceph: mds0 192.168.89.133:6800 socket closed
>> [ =A0794.640943] ceph: mds0 192.168.89.133:6800 socket closed
>>
>> Immediately after the failure, I ran netstat at mds0:
>> mds0 (192.168.89.133):
>> debian:~# netstat -anp
>> Active Internet connections (servers and established)
>> Proto Recv-Q Send-Q Local Address =A0 =A0 =A0 =A0 =A0 Foreign Addres=
s
>> State =A0 =A0 =A0 PID/Program name
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:6800 =A0 =A0 =A0 =A0 =A0 =A0=
0.0.0.0:*
>> LISTEN =A0 =A0 =A01889/cmds
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:22 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00.0.0.0:*
>> LISTEN =A0 =A0 =A01529/sshd
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 0.0.0.=
0:*
>> LISTEN =A0 =A0 =A01840/cmon
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.16=
8.89.131:56855
>> ESTABLISHED 1840/cmon
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:43647 =A0 =A0192.16=
8.89.133:6789
>> ESTABLISHED 1889/cmds
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:22 =A0 =A0 =A0 192.=
168.89.1:58304
>> ESTABLISHED 1530/0
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:39826 =A0 =A0192.16=
8.89.134:6800
>> ESTABLISHED 1889/cmds
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.16=
8.89.134:41289
>> ESTABLISHED 1840/cmon
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.16=
8.89.131:52814
>> TIME_WAIT =A0 -
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.16=
8.89.135:41021
>> ESTABLISHED 1840/cmon
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:42069 =A0 =A0192.16=
8.89.135:6800
>> ESTABLISHED 1889/cmds
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.16=
8.89.133:43647
>> ESTABLISHED 1840/cmon
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.16=
8.89.131:52815
>> TIME_WAIT =A0 -
>> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.16=
8.89.131:52816
>> TIME_WAIT =A0 -
>> tcp6 =A0 =A0 =A0 0 =A0 =A0 =A00 :::22 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 :::*
>> LISTEN =A0 =A0 =A01529/sshd
>> udp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:68 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00.0.0.0:*
>> =A0 =A0 =A0 =A0 1490/dhclient3
>> Active UNIX domain sockets (servers and established)
>> Proto RefCnt Flags =A0 =A0 =A0 Type =A0 =A0 =A0 State =A0 =A0 =A0 =A0=
 I-Node =A0 PID/Program
>> name =A0 =A0Path
>> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A02972 =A0 =A0 546/udevd
>> =A0 =A0 =A0 =A0@/org/kernel/udev/udevd
>> unix =A04 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A05343
>> 1358/rsyslogd =A0 =A0 =A0 /dev/log
>> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A05662 =A0 =A0 1530/0
>> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A05486 =A0 =A0 1490/dhclient3
>> debian:~#
>> debian:~# dmesg -c
>> debian:~# (nothing shows up)
>>
>> I saw the port 6800 on the metadata server talking with the client i=
s
>> on "TIME_WAIT" stage. That means the connection is closed.
>> This is the ceph.conf I have:
>> [global]
>> =A0 =A0 =A0 pid file =3D /var/run/ceph/$type.$id.pid
>> [mon]
>> =A0 =A0 =A0 mon data =3D /data/mon$id
>> =A0 =A0 =A0 mon subscribe interval =3D 6000
>> =A0 =A0 =A0 mon osd down out interval =3D 6000
>> [mon0]
>> =A0 =A0 =A0 host =3D mds0
>> =A0 =A0 =A0 mon addr =3D 192.168.89.133:6789
>> [mds]
>> =A0 =A0 =A0 mds session timeout =3D 6000
>> =A0 =A0 =A0 mds session autoclose =3D 6000
>> =A0 =A0 =A0 mds client lease =3D 6000
>> =A0 =A0 =A0 keyring =3D /data/keyring.$name
>> [mds0]
>> =A0 =A0 =A0 host =3D mds0
>> [osd]
>> =A0 =A0 =A0 sudo =3D true
>> =A0 =A0 =A0 osd data =3D /data/osd$id
>> =A0 =A0 =A0 osd journal =3D /journal
>> =A0 =A0 =A0 osd journal size =3D 1024
>> =A0 =A0 =A0 filestore journal writeahead =3D true
>> [osd0]
>> =A0 =A0 =A0 host =3D osd0
>> [osd1]
>> =A0 =A0 =A0 host =3D osd1
>> [group everyone]
>> =A0 =A0 =A0 addr =3D 0.0.0.0/0
>> [mount]
>> =A0 =A0 =A0 allow =3D %everyone
>> ;-----------------------------------end-----------------------------=
------
>>
>> The Ceph version I was using is 0.22.1.
>>
>> Can anyone help me to solve this problem? Thanks in advance!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>



--=20
Yonggang Liu
Advanced Computing and Information Systems Laboratory
University of Florida
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

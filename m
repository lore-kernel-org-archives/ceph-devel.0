From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: mds port 6800 socket closed when accessing mount point
Date: Wed, 27 Oct 2010 20:53:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010272048550.14714@cobra.newdream.net>
References: <AANLkTindXNKvAYcN1WLN7VDdTz41DATMgNgfqbMm5879@mail.gmail.com>
 <AANLkTinOrT4W=Ow9uzwC93XeA7ZFZwEQ5uc-PMv_0-C_@mail.gmail.com>
 <AANLkTimkopsoDCC+REf2ffdbe8noSj2wSLU4b_3ZH=d7@mail.gmail.com>
 <Pine.LNX.4.64.1010271344240.1155@cobra.newdream.net>
 <AANLkTinvD4tv75_nwo3Z6GkoyS4BiEWKezMv4KStBVx0@mail.gmail.com>
 <AANLkTinRohgc3kve=cTdb7_t4wJ=82wvJkyqNypm1TDA@mail.gmail.com>
 <Pine.LNX.4.64.1010271714250.1155@cobra.newdream.net>
 <AANLkTinNkm20OMNboc43WUkc3hXDS5UPAs5Vuh1tMAQp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-725731937-1288237998=:14714"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38962 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab0J1DuG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Oct 2010 23:50:06 -0400
In-Reply-To: <AANLkTinNkm20OMNboc43WUkc3hXDS5UPAs5Vuh1tMAQp@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yonggang Liu <myidpt@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-725731937-1288237998=:14714
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 27 Oct 2010, Yonggang Liu wrote:
> > In any case, the source of the offending message is
> >
> > 192.168.89.131:0/753148386
> >
> > The large number at the end is just random. =A0I'm guessing that's the
> > kernel client mounting/trying to mount the file system. =A0What kernel
> > version, or version of the kernel module are you using?
> >
> Here's the kernel version of all my VMs:
> mds0:~# uname -a
> Linux mds0 2.6.32-5-686 #1 SMP Tue Oct 19 14:40:34 UTC 2010 i686 GNU/Linu=
x
>=20
> The mount command I was using is:
> mount -t ceph mds0:/ /ceph
> Do you mean the failure is due to the client kernel?

Right.  Where is the ceph kernel module coming from?  Are you building=20
from ceph-client-standalone.git, or some other source?  If it's from=20
-standalone.git, what commit are you on? (git rev-parse HEAD)

sage




>=20
> > Thanks-
> > sage
> >
>=20
> Thank you!
>=20
> >
> > On Wed, 27 Oct 2010, Yonggang Liu wrote:
> >
> >> ---------- Forwarded message ----------
> >> From: Yonggang Liu <myidpt@gmail.com>
> >> Date: Wed, Oct 27, 2010 at 7:32 PM
> >> Subject: Re: mds port 6800 socket closed when accessing mount point
> >> To: Sage Weil <sage@newdream.net>
> >>
> >>
> >> Hi Sage,
> >>
> >> Thank you very much for your reply. In your question, the PID 1978 is
> >> not a running process; it is the PID Ceph considers the mds0 process
> >> is using. But the real PID of mds0 was not that one (seem to be 1979).
> >> I redid the process and gathered the results. I think I see a little
> >> bit of the problem now. When I'm starting Ceph, the program prints out
> >> the PIDs of the daemons running on each machine, but these PIDs are
> >> not the exact PIDs of the real running daemons.
> >>
> >> I started the system and got the PID information:
> >> mds0:~# /etc/init.d/ceph -a start
> >> =3D=3D=3D mon.0 =3D=3D=3D
> >> Starting Ceph mon0 on mds0...
> >> =A0** WARNING: Ceph is still under heavy development, and is only suit=
able for **
> >> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with i=
mportant data. =A0 =A0 =A0 **
> >> starting mon.0 rank 0 at 192.168.89.133:6789/0 mon_data /data/mon0
> >> fsid 9ff93f53-5e63-011c-4437-8e3f780cfcde
> >> =3D=3D=3D mds.0 =3D=3D=3D
> >> Starting Ceph mds0 on mds0...
> >> =A0** WARNING: Ceph is still under heavy development, and is only suit=
able for **
> >> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with i=
mportant data. =A0 =A0 =A0 **
> >> starting mds.0 at 0.0.0.0:6800/1824
> >> =3D=3D=3D osd.0 =3D=3D=3D
> >> Starting Ceph osd0 on osd0...
> >> =A0** WARNING: Ceph is still under heavy development, and is only suit=
able for **
> >> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with i=
mportant data. =A0 =A0 =A0 **
> >> starting osd0 at 0.0.0.0:6800/1622 osd_data /data/osd0 /data/osd0/jour=
nal
> >> =3D=3D=3D osd.1 =3D=3D=3D
> >> Starting Ceph osd1 on osd1...
> >> =A0** WARNING: Ceph is still under heavy development, and is only suit=
able for **
> >> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with i=
mportant data. =A0 =A0 =A0 **
> >> starting osd1 at 0.0.0.0:6800/1616 osd_data /data/osd1 /data/osd1/jour=
nal
> >>
> >> So from the print, the PIDs known by Ceph are:
> >> moon.0 =A0 =A0 =A0 0
> >> mds.0 =A0 =A0 =A0 =A0 1824
> >> osd.0 =A0 =A0 =A0 =A0 =A01622
> >> osd.1 =A0 =A0 =A0 =A0 =A01616
> >>
> >> But I checked the PIDs by using "ps uax | grep ceph" on the 3
> >> machines, I got this:
> >> On mds0:
> >> root =A0 =A0 =A01792 =A01.0 =A01.2 =A046412 =A03260 ? =A0 =A0 =A0 =A0S=
<sl 20:14 =A0 0:07
> >> /usr/bin/cmon -i 0 -c /etc/ceph/ceph.conf
> >> root =A0 =A0 =A01825 28.3 =A01.2 =A072228 =A03076 ? =A0 =A0 =A0 =A0S<s=
l 20:14 =A0 3:06
> >> /usr/bin/cmds -i 0 -c /etc/ceph/ceph.conf
> >> On osd0:
> >> root =A0 =A0 =A01623 =A00.9 =A08.3 214820 21356 ? =A0 =A0 =A0 =A0S<sl =
20:07 =A0 0:01
> >> /usr/bin/cosd -i 0 -c /tmp/ceph.conf.1747
> >> On osd1:
> >> root =A0 =A0 =A01617 =A00.7 =A07.5 213780 19264 ? =A0 =A0 =A0 =A0S<sl =
20:07 =A0 0:01
> >> /usr/bin/cosd -i 1 -c /tmp/ceph.conf.1747
> >> (Note the second fields are the PIDs)
> >>
> >> Run "netstat -anp | grep 6800" on mds0, I got:
> >> mds0:~# netstat -anp | grep 6800
> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:6800 =A0 =A0 =A0 =A0 =A0 =A0=
0.0.0.0:*
> >> LISTEN =A0 =A0 =A01825/cmds
> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:33216 =A0 =A0192.168.=
89.135:6800
> >> ESTABLISHED 1825/cmds
> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:56908 =A0 =A0192.168.=
89.134:6800
> >> ESTABLISHED 1825/cmds
> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.168.=
89.131:45334
> >> ESTABLISHED 1825/cmds
> >> (I can see PID 1825 is taking care of the client - mds0 communication)
> >>
> >> At the end of file "mds.0.log", I saw the PID 1824:
> >> 2010-10-27 20:57:45.537898 b35e4b70 failed to decode message of type
> >> 784 v2: buffer::end_of_buffer
> >> 2010-10-27 20:57:45.538652 b35e4b70 -- 192.168.89.133:6800/1824 >>
> >> 192.168.89.131:0/753148386 pipe(0x9f43488 sd=3D-1 pgs=3D9 cs=3D7 l=3D0=
).fault
> >> with nothing to send, going to standby
> >> 2010-10-27 20:58:18.044950 b30fdb70 -- 192.168.89.133:6800/1824 >>
> >> 192.168.89.131:0/753148386 pipe(0x9f7cca8 sd=3D10 pgs=3D0 cs=3D0 l=3D0=
).accept
> >> peer addr is really 192.168.89.131:0/753148386 (socket is
> >> 192.168.89.131:45342/0)
> >> 2010-10-27 20:58:18.045247 b30fdb70 -- 192.168.89.133:6800/1824 >>
> >> 192.168.89.131:0/753148386 pipe(0x9f7cca8 sd=3D10 pgs=3D0 cs=3D0 l=3D0=
).accept
> >> connect_seq 7 vs existing 7 state 3
> >> 2010-10-27 20:58:18.053628 b30fdb70 failed to decode message of type
> >> 784 v2: buffer::end_of_buffer
> >> 2010-10-27 20:58:18.054824 b30fdb70 -- 192.168.89.133:6800/1824 >>
> >> 192.168.89.131:0/753148386 pipe(0x9f7cca8 sd=3D-1 pgs=3D10 cs=3D8 l=3D=
0).fault
> >> initiating reconnect
> >>
> >> So this is strange. It seems the PIDs known by Ceph are not the real
> >> PIDs of the processes. I don't know how this could happen.
> >>
> >> The version of the Ceph code is:
> >> mds0:~# ceph --version
> >> ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee33541)
> >>
> >> Thank you very much!
> >>
> >>
> >> On Wed, Oct 27, 2010 at 4:47 PM, Sage Weil <sage@newdream.net> wrote:
> >> > Hi,
> >> >
> >> > On Wed, 27 Oct 2010, Yonggang Liu wrote:
> >> >> 2010-10-27 15:56:23.332473 b352eb70 failed to decode message of typ=
e
> >> >> 784 v4865: buffer::end_of_buffer
> >> >
> >> > This is the problem. =A0Can you tell what 192.168.89.133:6800/1978 i=
s?
> >> > (That 1978 is a pid, btw.) =A0It's probably a 'cfuse' I'm guessing? =
=A0(The
> >> > ceph daemons all start with 'c', but don't have 'ceph' in the name.)
> >> >
> >> > 784 is a client_caps message. The 'v4865' looks like an uninitialize=
d
> >> > variable to me, as it should be a small integer.
> >> >
> >> > Whatever daemon that is, can you run it with the '-v' argument to se=
e
> >> > exactly which version it is?
> >> >
> >> > Thanks!
> >> > sage
> >> >
> >> >
> >> >
> >> >
> >> >> 2010-10-27 15:56:23.332730 b352eb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd0168 sd=3D-1 pgs=3D10 cs=3D8
> >> >> l=3D0).fault with nothing to send, going to standby
> >> >> 2010-10-27 15:56:52.022573 b332cb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd1720 sd=3D12 pgs=3D0 cs=3D0
> >> >> l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (sock=
et is
> >> >> 192.168.89.131:41726/0)
> >> >> 2010-10-27 15:56:52.022945 b332cb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd1720 sd=3D12 pgs=3D0 cs=3D0
> >> >> l=3D0).accept connect_seq 8 vs existing 8 state 3
> >> >> 2010-10-27 15:56:52.025299 b332cb70 failed to decode message of typ=
e
> >> >> 784 v4865: buffer::end_of_buffer
> >> >> 2010-10-27 15:56:52.025569 b332cb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd1720 sd=3D-1 pgs=3D11 cs=3D9
> >> >> l=3D0).fault with nothing to send, going to standby
> >> >> 2010-10-27 15:57:48.106337 b362fb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd07c0 sd=3D12 pgs=3D0 cs=3D0
> >> >> l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (sock=
et is
> >> >> 192.168.89.131:41727/0)
> >> >> 2010-10-27 15:57:48.106522 b362fb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd07c0 sd=3D12 pgs=3D0 cs=3D0
> >> >> l=3D0).accept connect_seq 9 vs existing 9 state 3
> >> >> 2010-10-27 15:57:48.109498 b362fb70 failed to decode message of typ=
e
> >> >> 784 v4865: buffer::end_of_buffer
> >> >> 2010-10-27 15:57:48.109761 b362fb70 -- 192.168.89.133:6800/1978 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x9fd07c0 sd=3D-1 pgs=3D12 cs=3D10
> >> >> l=3D0).fault with nothing to send, going to standby
> >> >>
> >> >> On osd0
> >> >> osd.0.log:
> >> >> 2010-10-27 15:55:01.470502 --- 1633 opened log /var/log/ceph/osd.0.=
log ---
> >> >> ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee3354=
1)
> >> >> 2010-10-27 15:55:01.485828 b72d38e0 filestore(/data/osd0) mkfs in /=
data/osd0
> >> >> 2010-10-27 15:55:01.486106 b72d38e0 filestore(/data/osd0) mkfs
> >> >> removing old file fsid
> >> >> 2010-10-27 15:55:01.516527 b72d38e0 filestore(/data/osd0) mkjournal
> >> >> created journal on /journal
> >> >> 2010-10-27 15:55:01.516734 b72d38e0 filestore(/data/osd0) mkfs done=
 in
> >> >> /data/osd0
> >> >> 2010-10-27 15:55:01.519606 b72d38e0 filestore(/data/osd0) mount did
> >> >> NOT detect btrfs
> >> >> 2010-10-27 15:55:01.519794 b72d38e0 filestore(/data/osd0) mount fou=
nd snaps <>
> >> >> 2010-10-27 15:55:01.548307 b5acfb70 FileStore::op_tp worker finish
> >> >> 2010-10-27 15:55:01.548455 b52ceb70 FileStore::op_tp worker finish
> >> >> 2010-10-27 15:55:01.548812 b72d38e0 journal close /journal
> >> >> 2010-10-27 15:55:25.201288 --- 1656 opened log /var/log/ceph/osd.0.=
log ---
> >> >> ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee3354=
1)
> >> >> 2010-10-27 15:55:25.223381 b74508e0 filestore(/data/osd0) mount did
> >> >> NOT detect btrfs
> >> >> 2010-10-27 15:55:25.224253 b74508e0 filestore(/data/osd0) mount fou=
nd snaps <>
> >> >> 2010-10-27 15:55:25.225396 b74508e0 journal read_entry 4096 : seq 1=
 203 bytes
> >> >> 2010-10-27 15:55:26.841749 abffeb70 -- 0.0.0.0:6801/1656 >>
> >> >> 192.168.89.135:6801/1675 pipe(0x94ced18 sd=3D13 pgs=3D0 cs=3D0 l=3D=
0).connect
> >> >> claims to be 0.0.0.0:6801/1675 not 192.168.89.135:6801/1675 -
> >> >> presumably this is the same node!
> >> >> 2010-10-27 15:56:04.219613 abaf9b70 -- 192.168.89.134:6800/1656 >>
> >> >> 192.168.89.131:0/1344076202 pipe(0x96463e0 sd=3D16 pgs=3D0 cs=3D0
> >> >> l=3D0).accept peer addr is really 192.168.89.131:0/1344076202 (sock=
et is
> >> >> 192.168.89.131:36746/0)
> >> >>
> >> >> On osd1
> >> >> osd.1.log:
> >> >> 2010-10-27 15:54:59.752615 --- 1652 opened log /var/log/ceph/osd.1.=
log ---
> >> >> ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee3354=
1)
> >> >> 2010-10-27 15:54:59.766128 b73518e0 filestore(/data/osd1) mkfs in /=
data/osd1
> >> >> 2010-10-27 15:54:59.766658 b73518e0 filestore(/data/osd1) mkfs
> >> >> removing old file fsid
> >> >> 2010-10-27 15:54:59.796938 b73518e0 filestore(/data/osd1) mkjournal
> >> >> created journal on /journal
> >> >> 2010-10-27 15:54:59.797816 b73518e0 filestore(/data/osd1) mkfs done=
 in
> >> >> /data/osd1
> >> >> 2010-10-27 15:54:59.800957 b73518e0 filestore(/data/osd1) mount did
> >> >> NOT detect btrfs
> >> >> 2010-10-27 15:54:59.801087 b73518e0 filestore(/data/osd1) mount fou=
nd snaps <>
> >> >> 2010-10-27 15:54:59.832202 b534cb70 FileStore::op_tp worker finish
> >> >> 2010-10-27 15:54:59.832504 b5b4db70 FileStore::op_tp worker finish
> >> >> 2010-10-27 15:54:59.832723 b73518e0 journal close /journal
> >> >> 2010-10-27 15:55:23.050042 --- 1675 opened log /var/log/ceph/osd.1.=
log ---
> >> >> ceph version 0.22.1 (commit:7464f9688001aa89f9673ba14e6d075d0ee3354=
1)
> >> >> 2010-10-27 15:55:23.056671 b72e18e0 filestore(/data/osd1) mount did
> >> >> NOT detect btrfs
> >> >> 2010-10-27 15:55:23.056921 b72e18e0 filestore(/data/osd1) mount fou=
nd snaps <>
> >> >> 2010-10-27 15:55:23.057368 b72e18e0 journal read_entry 4096 : seq 1=
 203 bytes
> >> >> 2010-10-27 15:55:23.207216 b12d4b70 osd1 2 map says i am down or ha=
ve
> >> >> a different address. =A0switching to boot state.
> >> >> 2010-10-27 15:55:23.207540 b12d4b70 log [WRN] : map e2 wrongly mark=
ed me down
> >> >>
> >> >> I noticed on osd1, the last two lines of osd.1.log are unusual, but
> >> >> I'm not sure if they are the reason to the problem ...
> >> >>
> >> >> Thank you very much,
> >> >>
> >> >>
> >> >> On Wed, Oct 27, 2010 at 1:10 PM, Colin McCabe <cmccabe@alumni.cmu.e=
du> wrote:
> >> >> > Hi Yonggang,
> >> >> >
> >> >> > Are all of the daemons still running? What is at the end of the l=
ogfiles?
> >> >> >
> >> >> > regards,
> >> >> > Colin
> >> >> >
> >> >> >
> >> >> > On Wed, Oct 27, 2010 at 9:42 AM, Yonggang Liu <myidpt@gmail.com> =
wrote:
> >> >> >> Hello,
> >> >> >>
> >> >> >> I'm totally new to Ceph. Last a few days I set up 4 VMs to run C=
eph:
> >> >> >> "mds0" for the metadata server and monitor, "osd0" and "osd1" fo=
r two
> >> >> >> data servers, and "client" for the client machine. The VMs are r=
unning
> >> >> >> Debian 5.0 with kernel 2.6.32-5-686 (Ceph module is enabled).
> >> >> >> I followed "Building kernel client" and "Debian" from the wiki, =
and I
> >> >> >> was able to start Ceph and mount Ceph at the client. But the pro=
blem
> >> >> >> is, the mounted point always fail with an infinite response time
> >> >> >> (after I mount Ceph for about 1 min or less). To illustrate it b=
etter,
> >> >> >> I will show you the information I got on the client and mds0 mac=
hines:
> >> >> >>
> >> >> >> mds0 (192.168.89.133):
> >> >> >> debian:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
> >> >> >> (A lot of info)
> >> >> >> debian:~# /etc/init.d/ceph -a start
> >> >> >> (some info)
> >> >> >>
> >> >> >> client (192.168.89.131):
> >> >> >> debian:~# mount -t ceph 192.168.89.133:/ /ceph
> >> >> >> debian:~# cd /ceph
> >> >> >> debian:/ceph# cp ~/app_ch.xls .
> >> >> >> debian:/ceph# ls
> >> >> >> (waiting for ever)
> >> >> >> ^C
> >> >> >>
> >> >> >> After the failure I ran dmesg at the client side and got:
> >> >> >> client (192.168.89.131):
> >> >> >> debian:/ceph# dmesg -c
> >> >> >> [ =A0636.664425] ceph: loaded (mon/mds/osd proto 15/32/24, osdma=
p 5/5 5/5)
> >> >> >> [ =A0636.694973] ceph: client4100 fsid 423ad64c-bbf0-3011-bb47-3=
6a89f8787c6
> >> >> >> [ =A0636.700716] ceph: mon0 192.168.89.133:6789 session establis=
hed
> >> >> >> [ =A0664.114551] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0664.848722] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0665.914923] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0667.840396] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0672.054106] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0680.894531] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0696.928496] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0720.171754] ceph: mds0 caps stale
> >> >> >> [ =A0728.999701] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >> [ =A0794.640943] ceph: mds0 192.168.89.133:6800 socket closed
> >> >> >>
> >> >> >> Immediately after the failure, I ran netstat at mds0:
> >> >> >> mds0 (192.168.89.133):
> >> >> >> debian:~# netstat -anp
> >> >> >> Active Internet connections (servers and established)
> >> >> >> Proto Recv-Q Send-Q Local Address =A0 =A0 =A0 =A0 =A0 Foreign Ad=
dress
> >> >> >> State =A0 =A0 =A0 PID/Program name
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:6800 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> >> >> >> LISTEN =A0 =A0 =A01889/cmds
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:22 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00.0.0.0:*
> >> >> >> LISTEN =A0 =A0 =A01529/sshd
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 0.=
0.0.0:*
> >> >> >> LISTEN =A0 =A0 =A01840/cmon
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 19=
2.168.89.131:56855
> >> >> >> ESTABLISHED 1840/cmon
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:43647 =A0 =A019=
2.168.89.133:6789
> >> >> >> ESTABLISHED 1889/cmds
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:22 =A0 =A0 =A0 =
192.168.89.1:58304
> >> >> >> ESTABLISHED 1530/0
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:39826 =A0 =A019=
2.168.89.134:6800
> >> >> >> ESTABLISHED 1889/cmds
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 19=
2.168.89.134:41289
> >> >> >> ESTABLISHED 1840/cmon
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 19=
2.168.89.131:52814
> >> >> >> TIME_WAIT =A0 -
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 19=
2.168.89.135:41021
> >> >> >> ESTABLISHED 1840/cmon
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:42069 =A0 =A019=
2.168.89.135:6800
> >> >> >> ESTABLISHED 1889/cmds
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 19=
2.168.89.133:43647
> >> >> >> ESTABLISHED 1840/cmon
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 19=
2.168.89.131:52815
> >> >> >> TIME_WAIT =A0 -
> >> >> >> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 19=
2.168.89.131:52816
> >> >> >> TIME_WAIT =A0 -
> >> >> >> tcp6 =A0 =A0 =A0 0 =A0 =A0 =A00 :::22 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 :::*
> >> >> >> LISTEN =A0 =A0 =A01529/sshd
> >> >> >> udp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:68 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00.0.0.0:*
> >> >> >> =A0 =A0 =A0 =A0 1490/dhclient3
> >> >> >> Active UNIX domain sockets (servers and established)
> >> >> >> Proto RefCnt Flags =A0 =A0 =A0 Type =A0 =A0 =A0 State =A0 =A0 =
=A0 =A0 I-Node =A0 PID/Program
> >> >> >> name =A0 =A0Path
> >> >> >> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A02972 =A0 =A0 546/udevd
> >> >> >> =A0 =A0 =A0 =A0@/org/kernel/udev/udevd
> >> >> >> unix =A04 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A05343
> >> >> >> 1358/rsyslogd =A0 =A0 =A0 /dev/log
> >> >> >> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A05662 =A0 =A0 1530/0
> >> >> >> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A05486 =A0 =A0 1490/dhclient3
> >> >> >> debian:~#
> >> >> >> debian:~# dmesg -c
> >> >> >> debian:~# (nothing shows up)
> >> >> >>
> >> >> >> I saw the port 6800 on the metadata server talking with the clie=
nt is
> >> >> >> on "TIME_WAIT" stage. That means the connection is closed.
> >> >> >> This is the ceph.conf I have:
> >> >> >> [global]
> >> >> >> =A0 =A0 =A0 pid file =3D /var/run/ceph/$type.$id.pid
> >> >> >> [mon]
> >> >> >> =A0 =A0 =A0 mon data =3D /data/mon$id
> >> >> >> =A0 =A0 =A0 mon subscribe interval =3D 6000
> >> >> >> =A0 =A0 =A0 mon osd down out interval =3D 6000
> >> >> >> [mon0]
> >> >> >> =A0 =A0 =A0 host =3D mds0
> >> >> >> =A0 =A0 =A0 mon addr =3D 192.168.89.133:6789
> >> >> >> [mds]
> >> >> >> =A0 =A0 =A0 mds session timeout =3D 6000
> >> >> >> =A0 =A0 =A0 mds session autoclose =3D 6000
> >> >> >> =A0 =A0 =A0 mds client lease =3D 6000
> >> >> >> =A0 =A0 =A0 keyring =3D /data/keyring.$name
> >> >> >> [mds0]
> >> >> >> =A0 =A0 =A0 host =3D mds0
> >> >> >> [osd]
> >> >> >> =A0 =A0 =A0 sudo =3D true
> >> >> >> =A0 =A0 =A0 osd data =3D /data/osd$id
> >> >> >> =A0 =A0 =A0 osd journal =3D /journal
> >> >> >> =A0 =A0 =A0 osd journal size =3D 1024
> >> >> >> =A0 =A0 =A0 filestore journal writeahead =3D true
> >> >> >> [osd0]
> >> >> >> =A0 =A0 =A0 host =3D osd0
> >> >> >> [osd1]
> >> >> >> =A0 =A0 =A0 host =3D osd1
> >> >> >> [group everyone]
> >> >> >> =A0 =A0 =A0 addr =3D 0.0.0.0/0
> >> >> >> [mount]
> >> >> >> =A0 =A0 =A0 allow =3D %everyone
> >> >> >> ;-----------------------------------end-------------------------=
----------
> >> >> >>
> >> >> >> The Ceph version I was using is 0.22.1.
> >> >> >>
> >> >> >> Can anyone help me to solve this problem? Thanks in advance!
> >> >> >> --
> >> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
> >> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >> >>
> >> >> >
> >> >>
> >> >>
> >> >>
> >> >> --
> >> >> Yonggang Liu
> >> >> Advanced Computing and Information Systems Laboratory
> >> >> University of Florida
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >> >>
> >> >>
> >>
> >>
> >>
> >> --
> >> Yonggang Liu
> >> Advanced Computing and Information Systems Laboratory
> >> University of Florida
> >>
> >>
> >>
> >> --
> >> Yonggang Liu
> >> Advanced Computing and Information Systems Laboratory
> >> University of Florida
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
>=20
>=20
>=20
> --=20
> Yonggang Liu
> Advanced Computing and Information Systems Laboratory
> University of Florida
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-725731937-1288237998=:14714--

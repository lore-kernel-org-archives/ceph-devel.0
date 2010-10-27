From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: mds port 6800 socket closed when accessing mount point
Date: Wed, 27 Oct 2010 10:10:11 -0700
Message-ID: <AANLkTinOrT4W=Ow9uzwC93XeA7ZFZwEQ5uc-PMv_0-C_@mail.gmail.com>
References: <AANLkTindXNKvAYcN1WLN7VDdTz41DATMgNgfqbMm5879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40169 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0J0RKN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Oct 2010 13:10:13 -0400
Received: by fxm16 with SMTP id 16so901445fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Oct 2010 10:10:11 -0700 (PDT)
In-Reply-To: <AANLkTindXNKvAYcN1WLN7VDdTz41DATMgNgfqbMm5879@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yonggang Liu <myidpt@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Yonggang,

Are all of the daemons still running? What is at the end of the logfile=
s?

regards,
Colin


On Wed, Oct 27, 2010 at 9:42 AM, Yonggang Liu <myidpt@gmail.com> wrote:
> Hello,
>
> I'm totally new to Ceph. Last a few days I set up 4 VMs to run Ceph:
> "mds0" for the metadata server and monitor, "osd0" and "osd1" for two
> data servers, and "client" for the client machine. The VMs are runnin=
g
> Debian 5.0 with kernel 2.6.32-5-686 (Ceph module is enabled).
> I followed "Building kernel client" and "Debian" from the wiki, and I
> was able to start Ceph and mount Ceph at the client. But the problem
> is, the mounted point always fail with an infinite response time
> (after I mount Ceph for about 1 min or less). To illustrate it better=
,
> I will show you the information I got on the client and mds0 machines=
:
>
> mds0 (192.168.89.133):
> debian:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
> (A lot of info)
> debian:~# /etc/init.d/ceph -a start
> (some info)
>
> client (192.168.89.131):
> debian:~# mount -t ceph 192.168.89.133:/ /ceph
> debian:~# cd /ceph
> debian:/ceph# cp ~/app_ch.xls .
> debian:/ceph# ls
> (waiting for ever)
> ^C
>
> After the failure I ran dmesg at the client side and got:
> client (192.168.89.131):
> debian:/ceph# dmesg -c
> [ =A0636.664425] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/5=
 5/5)
> [ =A0636.694973] ceph: client4100 fsid 423ad64c-bbf0-3011-bb47-36a89f=
8787c6
> [ =A0636.700716] ceph: mon0 192.168.89.133:6789 session established
> [ =A0664.114551] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0664.848722] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0665.914923] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0667.840396] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0672.054106] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0680.894531] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0696.928496] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0720.171754] ceph: mds0 caps stale
> [ =A0728.999701] ceph: mds0 192.168.89.133:6800 socket closed
> [ =A0794.640943] ceph: mds0 192.168.89.133:6800 socket closed
>
> Immediately after the failure, I ran netstat at mds0:
> mds0 (192.168.89.133):
> debian:~# netstat -anp
> Active Internet connections (servers and established)
> Proto Recv-Q Send-Q Local Address =A0 =A0 =A0 =A0 =A0 Foreign Address
> State =A0 =A0 =A0 PID/Program name
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:6800 =A0 =A0 =A0 =A0 =A0 =A0=
0.0.0.0:*
> LISTEN =A0 =A0 =A01889/cmds
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:22 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00.0.0.0:*
> LISTEN =A0 =A0 =A01529/sshd
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 0.0.0.0=
:*
> LISTEN =A0 =A0 =A01840/cmon
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.168=
=2E89.131:56855
> ESTABLISHED 1840/cmon
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:43647 =A0 =A0192.168=
=2E89.133:6789
> ESTABLISHED 1889/cmds
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:22 =A0 =A0 =A0 192.1=
68.89.1:58304
> ESTABLISHED 1530/0
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:39826 =A0 =A0192.168=
=2E89.134:6800
> ESTABLISHED 1889/cmds
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.168=
=2E89.134:41289
> ESTABLISHED 1840/cmon
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.168=
=2E89.131:52814
> TIME_WAIT =A0 -
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.168=
=2E89.135:41021
> ESTABLISHED 1840/cmon
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:42069 =A0 =A0192.168=
=2E89.135:6800
> ESTABLISHED 1889/cmds
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6789 =A0 =A0 192.168=
=2E89.133:43647
> ESTABLISHED 1840/cmon
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.168=
=2E89.131:52815
> TIME_WAIT =A0 -
> tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.89.133:6800 =A0 =A0 192.168=
=2E89.131:52816
> TIME_WAIT =A0 -
> tcp6 =A0 =A0 =A0 0 =A0 =A0 =A00 :::22 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 :::*
> LISTEN =A0 =A0 =A01529/sshd
> udp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:68 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00.0.0.0:*
> =A0 =A0 =A0 =A0 1490/dhclient3
> Active UNIX domain sockets (servers and established)
> Proto RefCnt Flags =A0 =A0 =A0 Type =A0 =A0 =A0 State =A0 =A0 =A0 =A0=
 I-Node =A0 PID/Program
> name =A0 =A0Path
> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A02972 =A0 =A0 546/udevd
> =A0 =A0 =A0 =A0@/org/kernel/udev/udevd
> unix =A04 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A05343
> 1358/rsyslogd =A0 =A0 =A0 /dev/log
> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A05662 =A0 =A0 1530/0
> unix =A02 =A0 =A0 =A0[ ] =A0 =A0 =A0 =A0 DGRAM =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A05486 =A0 =A0 1490/dhclient3
> debian:~#
> debian:~# dmesg -c
> debian:~# (nothing shows up)
>
> I saw the port 6800 on the metadata server talking with the client is
> on "TIME_WAIT" stage. That means the connection is closed.
> This is the ceph.conf I have:
> [global]
> =A0 =A0 =A0 pid file =3D /var/run/ceph/$type.$id.pid
> [mon]
> =A0 =A0 =A0 mon data =3D /data/mon$id
> =A0 =A0 =A0 mon subscribe interval =3D 6000
> =A0 =A0 =A0 mon osd down out interval =3D 6000
> [mon0]
> =A0 =A0 =A0 host =3D mds0
> =A0 =A0 =A0 mon addr =3D 192.168.89.133:6789
> [mds]
> =A0 =A0 =A0 mds session timeout =3D 6000
> =A0 =A0 =A0 mds session autoclose =3D 6000
> =A0 =A0 =A0 mds client lease =3D 6000
> =A0 =A0 =A0 keyring =3D /data/keyring.$name
> [mds0]
> =A0 =A0 =A0 host =3D mds0
> [osd]
> =A0 =A0 =A0 sudo =3D true
> =A0 =A0 =A0 osd data =3D /data/osd$id
> =A0 =A0 =A0 osd journal =3D /journal
> =A0 =A0 =A0 osd journal size =3D 1024
> =A0 =A0 =A0 filestore journal writeahead =3D true
> [osd0]
> =A0 =A0 =A0 host =3D osd0
> [osd1]
> =A0 =A0 =A0 host =3D osd1
> [group everyone]
> =A0 =A0 =A0 addr =3D 0.0.0.0/0
> [mount]
> =A0 =A0 =A0 allow =3D %everyone
> ;-----------------------------------end------------------------------=
-----
>
> The Ceph version I was using is 0.22.1.
>
> Can anyone help me to solve this problem? Thanks in advance!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

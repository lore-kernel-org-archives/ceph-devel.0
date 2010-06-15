From: Min Zhou <coderplay@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Wed, 16 Jun 2010 04:54:10 +0800
Message-ID: <AANLkTinreVMIcxZAUuKWDjYbh2cvLi025d0QWYD8SSJs@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
	<AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
	<AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
	<AANLkTik8gRPzwBzzI8rJGp2b-o6dpoFzRcGJZORC81sY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44933 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0FOUyM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 16:54:12 -0400
Received: by gye5 with SMTP id 5so3564541gye.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 13:54:11 -0700 (PDT)
In-Reply-To: <AANLkTik8gRPzwBzzI8rJGp2b-o6dpoFzRcGJZORC81sY@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Thanks Yehuda,

After correcting the my ceph.conf, it seems work now besides from some =
warnings.
Here is the new version of my ceph.conf

$ cat ~/ceph_conf/ceph.conf
[global]
       log dir =3D ceph_conf/out
       logger dir =3D ceph_conf/log
       chdir =3D ""
       pid file =3D ceph_conf/out/$type$id.pid
[mds]
       pid file =3D ceph_conf/out/$name.pid
       lockdep =3D 1
       debug ms =3D 1
       debug mds =3D 20
       mds log max segments =3D 2
[mds0]
       host=3Dhdp2
[mds1]
       host=3Dhdp3
[mon]
       lockdep =3D 1
       debug mon =3D 20
       debug paxos =3D 20
       debug ms =3D 1
       mon data =3D ceph_osd/dev/mon$id
[mon0]
       host =3D hdp2
       mon addr =3D 192.168.0.2:6789
[mon1]
       host =3D hdp3
       mon addr =3D 192.168.0.3:6789
[osd]
       lockdep =3D 1
       debug ms =3D 1
       debug osd =3D 25
       debug journal =3D 20
       debug filestore =3D 10
[osd0]
       host =3D hdp4
       user $USER
       osd data =3D ceph_osd/dev/osd0
       osd journal =3D ceph_osd/dev/osd0/journal
       osd journal size =3D 100
[osd1]
       host =3D hdp5
       user $USER
       osd data =3D ceph_osd/dev/osd1
       osd journal =3D ceph_osd/dev/osd1/journal
       osd journal size =3D 100
[osd2]
       host =3D hdp6
       user $USER
       osd data =3D ceph_osd/dev/osd2
       osd journal =3D ceph_osd/dev/osd2/journal
       osd journal size =3D 100
[mds.a]


and the results

$ mkcephfs --allhosts -c ceph_conf/ceph.conf -v
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon  "mon addr=
" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "mon addr=
" ""
/home/ceph/ceph/bin/monmaptool --create --clobber --add
172.19.201.2:6789 --add 172.19.201.3:6789 --print /tmp/monmap.10072
/home/ceph/ceph/bin/monmaptool: monmap file /tmp/monmap.10072
/home/ceph/ceph/bin/monmaptool: generated fsid
75902357-7c87-74f5-4166-88b92901c675
epoch 1
fsid 75902357-7c87-74f5-4166-88b92901c675
last_changed 10.06.16 04:44:32.874850
created 10.06.16 04:44:32.874850
        mon0 172.19.201.2:6789/0
        mon1 172.19.201.3:6789/0
/home/ceph/ceph/bin/monmaptool: writing epoch 1 to /tmp/monmap.10072
(2 monitors)
max osd in ceph_conf/ceph.conf is 2, num osd is 3
/home/ceph/ceph/bin/osdmaptool: osdmap file '/tmp/osdmap.10072'
/home/ceph/ceph/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.10072
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "crush ma=
p src" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "crush ma=
p" ""
Building admin keyring at /tmp/admin.keyring.10072
creating /tmp/admin.keyring.10072
Building monitor keyring with all service keys
creating /tmp/monkeyring.10072
importing contents of /tmp/admin.keyring.10072 into /tmp/monkeyring.100=
72
creating /tmp/keyring.mds.0
importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.10072
creating /tmp/keyring.mds.1
importing contents of /tmp/keyring.mds.1 into /tmp/monkeyring.10072
creating /tmp/keyring.mds.a
importing contents of /tmp/keyring.mds.a into /tmp/monkeyring.10072
creating /tmp/keyring.osd.0
importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.10072
creating /tmp/keyring.osd.1
importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.10072
creating /tmp/keyring.osd.2
importing contents of /tmp/keyring.osd.2 into /tmp/monkeyring.10072
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon  "user" ""
=3D=3D=3D mon0 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon  "mon data=
" ""
--- hdp2# /home/ceph/ceph/bin/mkmonfs --clobber --mon-data
ceph_osd/dev/mon0 -i 0 --monmap /tmp/monmap.10072 --osdmap
/tmp/osdmap.10072 -k /tmp/keyring.10072 ; rm -f /tmp/keyring.10072
10.06.16 04:44:33.043908 2ab098621d30 store(ceph_osd/dev/mon0) mkfs
10.06.16 04:44:33.044025 2ab098621d30 store(ceph_osd/dev/mon0) test -d
ceph_osd/dev/mon0 && /bin/rm -rf ceph_osd/dev/mon0 ; mkdir -p
ceph_osd/dev/mon0
10.06.16 04:44:33.053747 2ab098621d30 mon0(starting).class v0
create_initial -- creating initial map
10.06.16 04:44:33.055299 2ab098621d30 mon0(starting).auth v0
create_initial -- creating initial map
10.06.16 04:44:33.055318 2ab098621d30 mon0(starting).auth v0 reading
initial keyring
/home/ceph/ceph/bin/mkmonfs: created monfs at ceph_osd/dev/mon0 for mon=
0
`/tmp/admin.keyring.10072' -> `ceph_osd/dev/mon0/admin_keyring.bin'
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "ssh
path" "/home/ceph"
=3D=3D=3D mon1 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon  "mon data=
" ""
--- ssh hdp3  "cd /home/ceph ; ulimit -c unlimited ;
/home/ceph/ceph/bin/mkmonfs --clobber --mon-data ceph_osd/dev/mon1 -i
1 --monmap /tmp/monmap.10072 --osdmap /tmp/osdmap.10072 -k
/tmp/keyring.10072 ; rm -f /tmp/keyring.10072"
10.06.16 04:44:33.552910 2b19d7082d30 store(ceph_osd/dev/mon1) mkfs
10.06.16 04:44:33.553057 2b19d7082d30 store(ceph_osd/dev/mon1) test -d
ceph_osd/dev/mon1 && /bin/rm -rf ceph_osd/dev/mon1 ; mkdir -p
ceph_osd/dev/mon1
10.06.16 04:44:33.562586 2b19d7082d30 mon1(starting).class v0
create_initial -- creating initial map
10.06.16 04:44:33.564058 2b19d7082d30 mon1(starting).auth v0
create_initial -- creating initial map
10.06.16 04:44:33.564077 2b19d7082d30 mon1(starting).auth v0 reading
initial keyring
/home/ceph/ceph/bin/mkmonfs: created monfs at ceph_osd/dev/mon1 for mon=
1
admin.keyring.10072
                           100%  123     0.1KB/s   00:00
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mds  "user" ""
=3D=3D=3D mds0 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mds  "keyring"=
 ""
WARNING: no keyring specified for mds0
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mds  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mds  "ssh
path" "/home/ceph"
=3D=3D=3D mds1 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mds  "keyring"=
 ""
WARNING: no keyring specified for mds1
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i a -t mds  "user" ""
=3D=3D=3D mds.a =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i a -t mds  "keyring"=
 ""
WARNING: no keyring specified for mds.a
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "ssh
path" "/home/ceph"
=3D=3D=3D osd0 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "osd data=
" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "keyring"=
 ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "btrfs
path" "ceph_osd/dev/osd0"
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "btrfs de=
vs" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t osd  "btrfs
options" "noatime"
--- ssh hdp4  "cd /home/ceph ; ulimit -c unlimited ; test -d
ceph_osd/dev/osd0 || mkdir -p ceph_osd/dev/osd0"
monmap.10072
                           100%  332     0.3KB/s   00:00
--- ssh hdp4  "cd /home/ceph ; ulimit -c unlimited ;
/home/ceph/ceph/bin/cosd -c ceph_conf/ceph.conf --monmap
/tmp/monmap.10072 -i 0 --mkfs --osd-data ceph_osd/dev/osd0"
root@hdp4's password:
 ** WARNING: Ceph is still under heavy development, and is only suitabl=
e for **
 **          testing and review.  Do not trust it with important data. =
      **
created object store for osd0 fsid
75902357-7c87-74f5-4166-88b92901c675 on ceph_osd/dev/osd0
WARNING: no keyring specified for osd0
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "ssh
path" "/home/ceph"
=3D=3D=3D osd1 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "osd data=
" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "keyring"=
 ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "btrfs
path" "ceph_osd/dev/osd1"
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "btrfs de=
vs" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t osd  "btrfs
options" "noatime"
--- ssh hdp5  "cd /home/ceph ; ulimit -c unlimited ; test -d
ceph_osd/dev/osd1 || mkdir -p ceph_osd/dev/osd1"
monmap.10072
                           100%  332     0.3KB/s   00:00
--- ssh hdp5  "cd /home/ceph ; ulimit -c unlimited ;
/home/ceph/ceph/bin/cosd -c ceph_conf/ceph.conf --monmap
/tmp/monmap.10072 -i 1 --mkfs --osd-data ceph_osd/dev/osd1"
root@hdp5's password:
 ** WARNING: Ceph is still under heavy development, and is only suitabl=
e for **
 **          testing and review.  Do not trust it with important data. =
      **
created object store for osd1 fsid
75902357-7c87-74f5-4166-88b92901c675 on ceph_osd/dev/osd1
WARNING: no keyring specified for osd1
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "user" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "ssh
path" "/home/ceph"
=3D=3D=3D osd2 =3D=3D=3D
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "osd data=
" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "keyring"=
 ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "btrfs
path" "ceph_osd/dev/osd2"
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "btrfs de=
vs" ""
/home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 2 -t osd  "btrfs
options" "noatime"
--- ssh hdp6  "cd /home/ceph ; ulimit -c unlimited ; test -d
ceph_osd/dev/osd2 || mkdir -p ceph_osd/dev/osd2"
monmap.10072
                           100%  332     0.3KB/s   00:00
--- ssh hdp6  "cd /home/ceph ; ulimit -c unlimited ;
/home/ceph/ceph/bin/cosd -c ceph_conf/ceph.conf --monmap
/tmp/monmap.10072 -i 2 --mkfs --osd-data ceph_osd/dev/osd2"
root@hdp6's password:
 ** WARNING: Ceph is still under heavy development, and is only suitabl=
e for **
 **          testing and review.  Do not trust it with important data. =
      **
created object store for osd2 fsid
75902357-7c87-74f5-4166-88b92901c675 on ceph_osd/dev/osd2
WARNING: no keyring specified for osd2



Still two questions:
1. Why it prompted the need of all osd's root passwords?
2. Why it still has warning that tell me no keyring specified for each =
osd.

Thanks a lot,
Min

On Wed, Jun 16, 2010 at 4:31 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 1:17 PM, Min Zhou <coderplay@gmail.com> wrote=
:
>> Here is my ceph.conf at /home/ceph/ceph.conf
> .. snip
>> =A0 =A0 =A0 pid file =3D $CEPH_CONF/out/$name.pid
> Currently there are only a limited number of variables that you can
> use for replacement: $type, $id, $num, $name and $host. You can't use
> environment variables yet, although adding it might be a good idea.
>
>> =A0 =A0 =A0 mon data =3D $CEPH_OSD_DIR/dev/mon0"
> ...
>> =A0 =A0 =A0 mon data =3D $CEPH_OSD_DIR/dev/mon1"
> The same goes here. Note also that you're missing quotes anyway.
>
>
> Thanks,
> Yehuda
>



--=20
My research interests are distributed systems, parallel computing and
bytecode based virtual machine.

My profile:
http://www.linkedin.com/in/coderplay
My blog:
http://coderplay.javaeye.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Min Zhou <coderplay@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Wed, 16 Jun 2010 04:17:42 +0800
Message-ID: <AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
	<AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50280 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207Ab0FOURn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 16:17:43 -0400
Received: by gwj15 with SMTP id 15so3541364gwj.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 13:17:42 -0700 (PDT)
In-Reply-To: <AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Here is my ceph.conf at /home/ceph/ceph.conf

$ cat ceph_conf/ceph.conf
[global]
       log dir =3D $CEPH_CONF/out
       logger dir =3D $CEPH_CONF/log
       chdir =3D ""
       pid file =3D $CEPH_CONF/out/$type$id.pid
[mds]
       pid file =3D $CEPH_CONF/out/$name.pid
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
[mon0]
       host =3D hdp2
       mon data =3D $CEPH_OSD_DIR/dev/mon0"
       mon addr =3D 192.168.0.2:6789
[mon1]
       host =3D hdp3
       mon data =3D $CEPH_OSD_DIR/dev/mon1"
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
       osd data =3D $CEPH_OSD_DIR/dev/osd0
       osd journal =3D $CEPH_OSD_DIR/dev/osd0/journal
       osd journal size =3D 100
[osd1]
       host =3D hdp5
       user $USER
       osd data =3D $CEPH_OSD_DIR/dev/osd1
       osd journal =3D $CEPH_OSD_DIR/dev/osd1/journal
       osd journal size =3D 100
[osd2]
       host =3D hdp6
       user $USER
       osd data =3D $CEPH_OSD_DIR/dev/osd2
       osd journal =3D $CEPH_OSD_DIR/dev/osd2/journal
       osd journal size =3D 100
[mds.a]

Some envionment variables were defined at file ~/.bashrc on each node.
# ceph
export CEPH_HOME=3D$HOME/ceph
export CEPH_CONF_DIR=3D$HOME/ceph_conf
export CEPH_OSD_DIR=3D$HOME/ceph_osd
export PATH=3D${CEPH_HOME}/bin:${CEPH_HOME}/sbin:${PATH}
# ceph end

I built ceph from the source into a sub-directory of the user home.

Thanks,
Min

On Wed, Jun 16, 2010 at 4:12 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 1:09 PM, Min Zhou <coderplay@gmail.com> wrote=
:
>> Hi all,
>>
>> I am a newbie of ceph, and didn't =A0find any ceph mailing list for
>> users, so I send a mail here ask for helping.
>> below is the error information
>>
>> $ mkcephfs --allhosts -c ceph_conf/ceph.conf -v
>> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon =A0"mon=
 addr" ""
>> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon =A0"mon=
 addr" ""
>> /home/ceph/ceph/bin/monmaptool --create --clobber --add
>> 192.168.0.2:6789 --add 192.168.0.3:6789 --print /tmp/monmap.8107
>> /home/ceph/ceph/bin/monmaptool: monmap file /tmp/monmap.8107
>> /home/ceph/ceph/bin/monmaptool: generated fsid
>> 2b00c868-cfd6-2473-c27d-302b5cddc194
>> epoch 1
>> fsid 2b00c868-cfd6-2473-c27d-302b5cddc194
>> last_changed 10.06.16 04:02:28.247612
>> created 10.06.16 04:02:28.247612
>> =A0 =A0 =A0 =A0mon0 192.168.0.2:6789/0
>> =A0 =A0 =A0 =A0mon1 192.168.0.3:6789/0
>> /home/ceph/ceph/bin/monmaptool: writing epoch 1 to /tmp/monmap.8107 =
(2 monitors)
>> max osd in ceph_conf/ceph.conf is 2, num osd is 3
>> /home/ceph/ceph/bin/osdmaptool: osdmap file '/tmp/osdmap.8107'
>> /home/ceph/ceph/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.8107
>> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon =A0"cru=
sh map src" ""
>> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon =A0"cru=
sh map" ""
>> Building admin keyring at /tmp/admin.keyring.8107
>> creating /tmp/admin.keyring.8107
>> Building monitor keyring with all service keys
>> creating /tmp/monkeyring.8107
>> importing contents of /tmp/admin.keyring.8107 into /tmp/monkeyring.8=
107
>> creating /tmp/keyring.mds.0
>> importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.8107
>> creating /tmp/keyring.mds.1
>> importing contents of /tmp/keyring.mds.1 into /tmp/monkeyring.8107
>> creating /tmp/keyring.mds.a
>> importing contents of /tmp/keyring.mds.a into /tmp/monkeyring.8107
>> creating /tmp/keyring.osd.0
>> importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.8107
>> creating /tmp/keyring.osd.1
>> importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.8107
>> creating /tmp/keyring.osd.2
>> importing contents of /tmp/keyring.osd.2 into /tmp/monkeyring.8107
>> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon =A0"use=
r" ""
>> =3D=3D=3D mon0 =3D=3D=3D
>> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon =A0"mon=
 data" ""
>> /home/ceph/ceph/lib/ceph/ceph_common.sh: eval: line 167: unexpected
>
> Can you send your ceph.conf?
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

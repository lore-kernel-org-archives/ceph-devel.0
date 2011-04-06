From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: Re: The installation: When we start Ceph, the system stops running.
Date: Wed, 6 Apr 2011 11:02:37 +0800
Message-ID: <BANLkTikog1p1xfZwRFYg7zev98vrpzCVeg@mail.gmail.com>
References: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
	<20110401164211.GA12619@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39344 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab1DFDCi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 23:02:38 -0400
Received: by vws1 with SMTP id 1so798772vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 20:02:37 -0700 (PDT)
In-Reply-To: <20110401164211.GA12619@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>, henry.cy.chang@gmail.com, chengmao2010@gmail.com
Cc: ceph-devel@vger.kernel.org

Thanks for your help!!
 But I have the other question:
 If  I do "/etc/init.d/ceph -a stop "
 the system doesn't stop all the deamon which include cmon and cosd.
 Therefore I have to enter each host to close the deamon seperatly.
 Finally, there is no deamon running in the system.
 I want to know why we cannot stop the deamon by "/etc/init.d/ceph -a s=
top "???
 What's wrong with my system??

 The ceph.conf as shown below:


 [global]
       pid file =3D /var/run/ceph/$name.pid
      debug ms =3D1
      auth supported =3D cephx

 [mon]
        mon data =3D /data1/mon$id

        ;debug ms =3D 1
        ;debug mon =3D 20
       ;debug paxos =3D 20
        ;debug auth =3D 20

 [mon0]
        host =3D Ceph1
        mon addr =3D 192.168.200.201:6789

 [mon1]
         host =3D Ceph2
         mon addr =3D 192.168.200.202:6789

 [mon2]
        host =3D Ceph3
        mon addr =3D 192.168.200.203:6789

[mds]
        keyring =3D /etc/ceph/keyring.$name
        ;debug ms =3D 1
        ;debug mds =3D 20

 [mds0]
        host =3D Ceph4
 [mds1]
        host =3D Ceph5

 [osd]
        keyring =3D /etc/ceph/keyring.$name
        osd data =3D /mnt/btrfs/osd$id
        osd journal =3D /opt/osd/osd$id/journal
       ;osd journal =3D /data/osd$id/journal
         osd journal size =3D 512
       ;debug ms =3D 1
        ;debug osd =3D 20
        ;debug filestore =3D 20
        ;debug journal =3D 20

 [osd0]
        host =3D Ceph6
        btrfs devs =3D /dev/sdb1

 [osd1]
        host =3D Ceph6
        btrfs devs =3D /dev/sdc1

 [osd2]
        host =3D Ceph6
        btrfs devs =3D /dev/sdd1

 [osd3]
        host =3D Ceph7
        btrfs devs =3D /dev/sdb1

 [osd4]
        host =3D Ceph7
        btrfs devs =3D /dev/sdc1

 [osd5]
        host =3D Ceph7
        btrfs devs =3D /dev/sdd1



>
> =D4=DA 2011=C4=EA4=D4=C21=C8=D5=CF=C2=CE=E74:31=A3=ACYuki <chengmao20=
10@gmail.com> =8C=91=B5=C0=A3=BA
>> The cmon deamon is already running=A3=ACyou should stop it first=A1=A3=
do
>> "/etc/init.d/ceph -a stop " first ,than mkcephfs ,finally start the =
whole
>> ceph system
>>
>> -----=D3=CA=BC=FE=D4=AD=BC=FE-----
>> =B7=A2=BC=FE=C8=CB: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] =B4=FA=B1=ED =EA=90=95=D4=DE=
=B1
>> =B7=A2=CB=CD=CA=B1=BC=E4: 2011=C4=EA4=D4=C21=C8=D5 14:54
>> =CA=D5=BC=FE=C8=CB: ceph-devel@vger.kernel.org
>> =D6=F7=CC=E2: The installation: When we start Ceph, the system stops=
 running.
>>
>> Hi,
>> I set an environment of 20 servers which include 2 MDSs, 3 MONs and =
15
>> OSDes.
>> My version is 0.25.2 and OS is Fedora 14.
>> There's a problem when I was installing the Ceph.
>> When I finished "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrf=
s
>> -k keyring.bin" .
>> I start the whole Ceph system.
>> But here is the problem I met:
>> The system stops running and it shows the error messages as shown be=
low:
>>
>> =3D=3D=3D mon.0 =3D=3D=3D
>> Starting Ceph mon0 on Ceph1...already running
>> =3D=3D=3D mon.1 =3D=3D=3D
>> Starting Ceph mon1 on Ceph2...
>>  ** WARNING: Ceph is still under heavy development, and is only suit=
able for
>> **
>>  **          testing and review.  Do not trust it with important dat=
a.
>> **
>> starting mon.1 rank 1 at 192.168.200.202:6789/0 mon_data /data1/mon1
>> fsid f1eb5c4c-5127-5038-6ea9-0cf47e6536c2
>> accepter.bind unable to bind to 192.168.200.202:6789: Address alread=
y in use
>> failed: 'ssh Ceph2  /usr/local/bin/cmon -i 1 -c /tmp/ceph.conf.29519=
 '
>>
>> I want to know why  the system cannot run smoothly.


2011/4/2 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Fri, Apr 01, 2011 at 02:53:55PM +0800, =EA=90=95=D4=DE=B1 wrote:
>> Hi,
>> I set an environment of 20 servers which include 2 MDSs, 3 MONs and =
15
>> OSDes.
>> My version is 0.25.2 and OS is Fedora 14.
>> There's a problem when I was installing the Ceph.
>> When I finished "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrf=
s
>> -k keyring.bin" .
>> I start the whole Ceph system.
>> But here is the problem I met:
>> The system stops running and it shows the error messages as shown be=
low:
>
> Hi. I see Henry already replied, with good ideas. If that was not
> enough to get you going -- especially the part about making sure no
> ceph daemons are left running from a previous attempt -- please share
> your config file. You might e.g. have two cmon daemons trying to bind
> to the same port.
>
> --
> :(){ :|:&};:
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: installation: where do I start debugging this error?
Date: Tue, 7 Dec 2010 20:26:33 -0800
Message-ID: <AANLkTikYY41zbofYNdLKamcp7mquyvwR9PdUttxuZgxi@mail.gmail.com>
References: <AANLkTinfNC1fXqynJ8abp8Ms8GpkLN806MgpCvGaJiCe@mail.gmail.com>
	<1291775597.1958.5.camel@cephhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52934 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0LHE0e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 23:26:34 -0500
Received: by qwa26 with SMTP id 26so788738qwa.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Dec 2010 20:26:34 -0800 (PST)
In-Reply-To: <1291775597.1958.5.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 7, 2010 at 6:33 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
>
>
>
>
>
>
> =E5=9C=A8 2010-12-08=E4=B8=89=E7=9A=84 09:53 +0800=EF=BC=8CBrian Chri=
sman=E5=86=99=E9=81=93=EF=BC=9A
>> I've built and installed RPMs for ceph for RHEL6beta.
>> I've placed the below ceph.conf in /etc/ceph on both of my test node=
s
>> (test10, test11).
>>
>> I build a ceph filesystem and hide the key
>> mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyring.bi=
n
>> cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
>> chmod 600 /etc/ceph/secret
>> scp -p /etc/ceph/secret test11:/etc/ceph
>>
>> Then I start the daemons on each node:
>> service ceph start
>>
>> My daemons start up on both nodes with 'service ceph -a start'
>> root =C2=A0 =C2=A0 =C2=A03199 =C2=A0 =C2=A0 1 =C2=A00 17:18 ? =C2=A0=
 =C2=A0 =C2=A0 =C2=A000:00:00 /usr/local/bin/cmon -i
>> 0 -c /tmp/ceph.conf.5365
>> root =C2=A0 =C2=A0 =C2=A03228 =C2=A0 =C2=A0 1 =C2=A00 17:18 ? =C2=A0=
 =C2=A0 =C2=A0 =C2=A000:00:00 /usr/local/bin/cmds -i
>> test10 -c /tmp/ceph.conf.5365
>> root =C2=A0 =C2=A0 =C2=A03285 =C2=A0 =C2=A0 1 =C2=A00 17:18 ? =C2=A0=
 =C2=A0 =C2=A0 =C2=A000:00:00 /usr/local/bin/cosd -i
>> 0 -c /tmp/ceph.conf.5365
>> (similar output on other node)
>>
>> I attempt to mount the ceph filesystem on test10 (using test11's IP)=
:
>> mount -t ceph -o name=3Dadmin,secretfile=3D/etc/ceph/keyring.bin
>> 10.200.98.111:/ /mnt/ceph
>> mount error 5 =3D Input/output error
>>
>
> Hi ,i take the followng steps , fail to mount,too.
>
> ## save auth secret to a file:
> $cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
> chmod 600 /etc/ceph/secret
> ## future ,support,read a secret from a file
> $ mount -t ceph 172.16.50.10:6789:/foo /mnt/ceph
> =C2=A0 -o name=3Dadmin,secretfile=3Dsecret
>
> but ,the following steps ,mount ceph is successful.
>
>
> # enable cephx, add a user and secret
> =C2=A0 =C2=A0$ mount -t ceph -o name=3Dadmin,secret=3D<secret>
> =C2=A0 =C2=A0 =C2=A0 1.2.3.4:/ /mnt/ceph
> $ mount -t ceph 172.16.50.10:6791:/foo /mnt/ceph
> =C2=A0 =C2=A0-o name=3Dadmin,secret=3D=E2=80=98AQArWtdMiI1uDRAAVbNRMe=
iwsjK+DEMeB7ewLg=3D=3D=E2=80=99
>
> # cauthtool --list keyring.bin
> client.admin
> =C2=A0key: AQArWtdMiI1uDRAAVbNRMeiwsjK+DEMeB7ewLg=3D=3D
> auid: 0
> caps: [mds] allow
> caps: [mon] allow *
> caps: [osd] allow *

Same issue.. being that I'm seeing mon daemons timing out while
attempting to connect, I'm guessing there's an issue here other than
crypto..

[root@test10 ~]# mount -t ceph -o
name=3Dadmin,secret=3DAQC63/5MEMaTLBAAuiYetlbkHBjj0WNtAjOsQg=3D=3D
10.200.98.111:/ /mnt/ceph
mount error 5 =3D Input/output error
[root@test10 ~]# cauthtool --list /etc/ceph/keyring.bin
client.admin
        key: AQC63/5MEMaTLBAAuiYetlbkHBjj0WNtAjOsQg=3D=3D
       auid: 0
       caps: [mds] allow
       caps: [mon] allow *
       caps: [osd] allow *
[root@test10 ~]#


>
>
>
>
>
>> /var/log/messages seems to show me what the problem is:
>> Dec =C2=A07 17:45:19 test10 kernel: libceph: mon0 10.200.98.111:6789
>> connection failed
>> (a few more of those before mount fails)
>> on test11, the daemon is up and listening on that port:
>> tcp =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A00 10.200.98.111=
:6789 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010.200.98.111:56805
>> =C2=A0 =C2=A0 =C2=A0ESTABLISHED 7781/cmon
>>
>> And here's /var/log/ceph/mon.1.log on test11 (the .111 node)
>> 2010-12-07 17:36:20.136921 --- 7780 opened log /var/log/ceph/mon.1.l=
og ---
>> ceph version 0.24~rc (commit:378d13df9505e4ea9a32f42cb713cdcf7aaccda=
0)
>> 2010-12-07 17:36:20.137164 7f80c51e3720 store(/data/mon1) mount
>> 2010-12-07 17:36:20.138241 7f80c51e3720 mon.1@1(starting) e1 init fs=
id
>> 1b4cabdb-30d2-752d-005f-517a7fa982f8
>> 2010-12-07 17:36:20.165407 7f80c51e3720 log [INF] : mon.1 calling ne=
w
>> monitor election
>> 2010-12-07 17:36:20.192343 7f80c51e1710 -- 10.200.98.111:6789/0 >>
>> 10.200.98.110:6789/0 pipe(0x1cafd20 sd=3D6 pgs=3D0 cs=3D0 l=3D0).fau=
lt first
>> fault
>>
>> And for test10 (the .110 node)
>> 2010-12-07 17:36:49.183357 --- 5767 opened log /var/log/ceph/mon.0.l=
og ---
>> ceph version 0.24~rc (commit:378d13df9505e4ea9a32f42cb713cdcf7aaccda=
0)
>> 2010-12-07 17:36:49.183545 7ff24669c720 store(/data/mon0) mount
>> 2010-12-07 17:36:49.184556 7ff24669c720 mon.0@0(starting) e1 init fs=
id
>> 1b4cabdb-30d2-752d-005f-517a7fa982f8
>> 2010-12-07 17:36:49.600650 7ff24669c720 log [INF] : mon.0 calling ne=
w
>> monitor election
>> 2010-12-07 17:36:49.645875 7ff24669a710 -- 10.200.98.110:6789/0 >>
>> 10.200.98.111:6789/0 pipe(0xac7d20 sd=3D6 pgs=3D0 cs=3D0 l=3D0).faul=
t first
>> fault
>>
>>
>> Does this mean my cmon on 111 is getting into a state where it's not
>> receiving incoming connections?
>> Any suggestions on where to go from here?
>>
>> thanks,
>> Brian Chrisman
>>
>>
>>
>> ----- ceph.conf in /etc/ceph -----
>> ; From sample:
>> [global]
>> =C2=A0 =C2=A0 =C2=A0 auth supported =3D cephx
>>
>> [mon]
>> =C2=A0 =C2=A0 =C2=A0 mon data =3D /data/mon$id
>>
>> =C2=A0 =C2=A0 =C2=A0 ; logging, for debugging monitor crashes, in or=
der of
>> =C2=A0 =C2=A0 =C2=A0 ; their likelihood of being helpful :)
>> =C2=A0 =C2=A0 =C2=A0 ;debug ms =3D 1
>> =C2=A0 =C2=A0 =C2=A0 ;debug mon =3D 20
>> =C2=A0 =C2=A0 =C2=A0 ;debug paxos =3D 20
>> =C2=A0 =C2=A0 =C2=A0 ;debug auth =3D 20
>>
>> [mon0]
>> =C2=A0 =C2=A0 =C2=A0 host =3D test10
>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 10.200.98.110:6789
>>
>> [mon1]
>> =C2=A0 =C2=A0 =C2=A0 host =3D test11
>> =C2=A0 =C2=A0 =C2=A0 mon addr =3D 10.200.98.111:6789
>>
>> [mds]
>> =C2=A0 =C2=A0 =C2=A0 keyring =3D /data/keyring.$name
>> =C2=A0 =C2=A0 =C2=A0 ;debug ms =3D 1
>> =C2=A0 =C2=A0 =C2=A0 ;debug mds =3D 20
>>
>> [mds.test10]
>> =C2=A0 =C2=A0 =C2=A0 host =3D test10
>>
>> [mds.test11]
>> =C2=A0 =C2=A0 =C2=A0 host =3D test11
>>
>> [osd]
>> =C2=A0 =C2=A0 =C2=A0 osd data =3D /data/osd$id
>> =C2=A0 =C2=A0 =C2=A0 osd journal =3D /data/osd$id/journal
>> =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 1000 ; journal size, in me=
gabytes
>> =C2=A0 =C2=A0 =C2=A0 ;debug ms =3D 1
>> =C2=A0 =C2=A0 =C2=A0 ;debug osd =3D 20
>> =C2=A0 =C2=A0 =C2=A0 ;debug filestore =3D 20
>> =C2=A0 =C2=A0 =C2=A0 ;debug journal =3D 20
>>
>> [osd0]
>> =C2=A0 =C2=A0 =C2=A0 host =3D test10
>> =C2=A0 =C2=A0 =C2=A0 btrfs devs =3D /dev/sdd4
>>
>> [osd1]
>> =C2=A0 =C2=A0 =C2=A0 host =3D test11
>> =C2=A0 =C2=A0 =C2=A0 btrfs devs =3D /dev/sdd4
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

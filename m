From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: [ceph-users] testing ceph
Date: Mon, 4 Nov 2013 11:55:25 -0500
Message-ID: <CANtztVwtxd_dhU9U3zOF=qn3mO9Lu_zAPC9ti1OARO9p666aNA@mail.gmail.com>
References: <DUB116-W8372DACD4F54B9145260E4E00B0@phx.gbl>
	<5272373C.4020906@inktank.com>
	<DUB116-W91D38BDD6BED25D0F26267E0F60@phx.gbl>
	<776ECADDC3FA214BB89434DD0C805BB902764120@DC2EXCHMULTI1.savvis.ad.savvis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33617 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3KDQz0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Nov 2013 11:55:26 -0500
Received: by mail-ob0-f175.google.com with SMTP id wm4so7258518obc.6
        for <ceph-devel@vger.kernel.org>; Mon, 04 Nov 2013 08:55:25 -0800 (PST)
In-Reply-To: <776ECADDC3FA214BB89434DD0C805BB902764120@DC2EXCHMULTI1.savvis.ad.savvis.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Trivedi, Narendra" <Narendra.Trivedi@savvis.com>
Cc: charles L <charlesboy009@hotmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Mon, Nov 4, 2013 at 10:56 AM, Trivedi, Narendra
<Narendra.Trivedi@savvis.com> wrote:
> Bingo! A lot of people are getting this dreadful GenericErro and Fail=
ed to
> create 1 OSD. Does anyone know why despite /etc/ceph being there on e=
ach
> node?

/etc/ceph is created by installing ceph on a node, and purgedata will
remove the contents of /etc/ceph/
and not the actual directory in the latest (1.3) version.

Also, FYI purgedata on multiple nodes doesn=92t work sometime i.e. it
> says it is uninstalled ceph and removed /etc/ceph from all nodes but =
they
> are there on all nodes except the first one (i.e. the first argument =
to the
> purgedata command ). Hence sometimes, I have to issue purgedata to
> individual nodes.

That does sound unexpected behavior from ceph-deploy. Can you share
some logs that demonstrate
this? Like I said, /etc/ceph is actually no longer removed in the
latest version, just the contents.

And you say "sometimes" as in, this doesn't happen consistently? Or do
you mean something else?

Again, log output and how you got there would be useful to try and
determine what is going on.

>
>
>
> From: ceph-users-bounces@lists.ceph.com
> [mailto:ceph-users-bounces@lists.ceph.com] On Behalf Of charles L
> Sent: Monday, November 04, 2013 9:26 AM
> To: ceph-devel@vger.kernel.org; ceph-users@ceph.com
>
>
> Subject: Re: [ceph-users] testing ceph
>
>
>
>
>
>  Pls can somebody help?  Im  getting this error.
>
>
>
> ceph@CephAdmin:~$ ceph-deploy osd create server1:sda:/dev/sdj1
>
> [ceph_deploy.cli][INFO  ] Invoked (1.3): /usr/bin/ceph-deploy osd cre=
ate
> server1:sda:/dev/sdj1
>
> [ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks
> server1:/dev/sda:/dev/sdj1
>
> [server1][DEBUG ] connected to host: server1
>
> [server1][DEBUG ] detect platform information from remote host
>
> [server1][DEBUG ] detect machine type
>
> [ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
>
> [ceph_deploy.osd][DEBUG ] Deploying osd to server1
>
> [server1][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.=
conf
>
> [server1][INFO  ] Running command: sudo udevadm trigger
> --subsystem-match=3Dblock --action=3Dadd
>
> [ceph_deploy.osd][DEBUG ] Preparing host server1 disk /dev/sda journa=
l
> /dev/sdj1 activate True
>
> [server1][INFO  ] Running command: sudo ceph-disk-prepare --fs-type x=
fs
> --cluster ceph -- /dev/sda /dev/sdj1
>
> [server1][ERROR ] WARNING:ceph-disk:OSD will not be hot-swappable if =
journal
> is not the same device as the osd data
>
> [server1][ERROR ] Could not create partition 1 from 34 to 2047
>
> [server1][ERROR ] Error encountered; not saving changes.
>
> [server1][ERROR ] ceph-disk: Error: Command '['sgdisk', '--largest-ne=
w=3D1',
> '--change-name=3D1:ceph data',
> '--partition-guid=3D1:d3ca8a92-7ba5-412e-abf5-06af958b788d',
> '--typecode=3D1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be', '--', '/dev/sd=
a']'
> returned non-zero exit status 4
>
> [server1][ERROR ] Traceback (most recent call last):
>
> [server1][ERROR ]   File
> "/usr/lib/python2.7/dist-packages/ceph_deploy/lib/remoto/process.py",=
 line
> 68, in run
>
> [server1][ERROR ]     reporting(conn, result, timeout)
>
> [server1][ERROR ]   File
> "/usr/lib/python2.7/dist-packages/ceph_deploy/lib/remoto/log.py", lin=
e 13,
> in reporting
>
> [server1][ERROR ]     received =3D result.receive(timeout)
>
> [server1][ERROR ]   File
> "/usr/lib/python2.7/dist-packages/ceph_deploy/lib/remoto/lib/execnet/=
gateway_base.py",
> line 455, in receive
>
> [server1][ERROR ]     raise self._getremoteerror() or EOFError()
>
> [server1][ERROR ] RemoteError: Traceback (most recent call last):
>
> [server1][ERROR ]   File "<string>", line 806, in executetask
>
> [server1][ERROR ]   File "", line 35, in _remote_run
>
> [server1][ERROR ] RuntimeError: command returned non-zero exit status=
: 1
>
> [server1][ERROR ]
>
> [server1][ERROR ]
>
> [ceph_deploy.osd][ERROR ] Failed to execute command: ceph-disk-prepar=
e
> --fs-type xfs --cluster ceph -- /dev/sda /dev/sdj1
>
> [ceph_deploy][ERROR ] GenericError: Failed to create 1 OSDs
>
>
>
>
>
>
>
>
>
>
>
>
>
>> Date: Thu, 31 Oct 2013 10:55:56 +0000
>> From: joao.luis@inktank.com
>> To: charlesboy009@hotmail.com; ceph-devel@vger.kernel.org
>> Subject: Re: testing ceph
>>
>> On 10/31/2013 04:54 AM, charles L wrote:
>> > Hi,
>> > Pls is this a good setup for a production environment test of ceph=
? My
>> > focus is on the SSD ... should it be partitioned(sdf1,2 ,3,4) and =
shared by
>> > the four OSDs on a host? or is this a better configuration for the=
 SSD to be
>> > just one partition(sdf1) while all osd uses that one partition?
>> > my setup:
>> > - 6 Servers with one 250gb boot disk for OS(sda),
>> > four-2Tb Disks each for the OSDs i.e Total disks =3D 6x4 =3D 24 di=
sks (sdb
>> > -sde)
>> > and one-60GB SSD for Osd Journal(sdf).
>> > -RAM =3D 32GB on each server with 2 GB network link.
>> > hostname for servers: Server1 -Server6
>>
>> Charles,
>>
>> What you are describing on the ceph.conf below is definitely not a g=
ood
>> idea. If you really want to use just one SSD and share it across
>> multiple OSDs, then you have two possible approaches:
>>
>> - partition that disk and assign a *different* partition to each OSD=
; or
>> - keep only one partition, format it with some filesystem, and assig=
n a
>> *different* journal file within that fs to each OSD.
>>
>> What you are describing has you using the same partition for all OSD=
s.
>> This will likely create issues due to multiple OSDs writing and read=
ing
>> from a single journal. TBH I'm not familiar enough with the journal
>> mechanism to know whether the OSDs will detect that situation.
>>
>> -Joao
>>
>> >
>> > [osd.0]
>> > host =3D server1
>> > devs =3D /dev/sdb
>> > osd journal =3D /dev/sdf1
>> > [osd.1]
>> > host =3D server1
>> > devs =3D /dev/sdc
>> > osd journal =3D /dev/sdf2
>> >
>> > [osd.3]
>> > host =3D server1
>> > devs =3D /dev/sdd
>> > osd journal =3D /dev/sdf2
>> >
>> > [osd.4]
>> > host =3D server1
>> > devs =3D /dev/sde
>> > osd journal =3D /dev/sdf2
>> > [osd.5]
>> > host =3D server2
>> > devs =3D /dev/sdb
>> > osd journal =3D /dev/sdf2
>> > ...
>> > [osd.23]
>> > host =3D server6
>> > devs =3D /dev/sde
>> > osd journal =3D /dev/sdf2
>> >
>> > Thanks. --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>> >
>>
>>
>> --
>> Joao Eduardo Luis
>> Software Engineer | http://inktank.com | http://ceph.com
>
>
> This message contains information which may be confidential and/or
> privileged. Unless you are the intended recipient (or authorized to r=
eceive
> for the intended recipient), you may not read, use, copy or disclose =
to
> anyone the message or any information contained in the message. If yo=
u have
> received the message in error, please advise the sender by reply e-ma=
il and
> delete the message and any attachment(s) thereto without retaining an=
y
> copies.
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

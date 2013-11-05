From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Tue, 05 Nov 2013 18:49:49 -0300
Message-ID: <527967FD.1010205@kepler.cl>
References: <52780140.6090409@kepler.cl> <alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net> <52792D7F.20500@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:32988 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab3KEVty (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 16:49:54 -0500
Received: by mail-qc0-f178.google.com with SMTP id x19so5209213qcw.37
        for <ceph-devel@vger.kernel.org>; Tue, 05 Nov 2013 13:49:53 -0800 (PST)
In-Reply-To: <52792D7F.20500@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas Michels <asalas@kepler.cl>, Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello sage,
I followed your lead and went a bit further in my source code reading=20
and I notice serveral problems:
first most of the id use in ceph osd_clients, mds_clients, mon_client=20
use the data type u64 which will be a problem
as most of the windows in use are windows XP or Windows server 2003 in=20
32 bits. As they are used for id tag for
things like snapshot pages (if I understand well) that can be a problem=
=20
for a port no?

What I read so far was
mount.ceph files > kernel/fs/ceph files which contains the mds_client=20
files and the kernel ioctl interface ... >  include / linux / ceph =20
files which integrates libcephfs.h. and all the needed files

there is three clients, there is auth.h a messenger, a msgpool, buffer,=
=20
rados that depends on msgr that include in every aspect of the messages=
=20
formation  one or more __le64 message.

I m far from understanding the whole code and the interactions betwin=20
all the files and which we can skip and which we can keep.

how can we translate those data type into 32bit in order for ceph=20
cluster to understand them and ceph-windows-client to transmit them?

Regards

signature

*Alph=E9 Salas*
Ingeniero T.I

asalas@kepler.cl




On 11/05/13 14:40, Alphe Salas Michels wrote:
>
> signature *Hi, Sage !
> thank you for you enthousiast reply.
> I sure want to make the best use of everything or anything previously=
=20
> done to tend to
> write ceph cliente for windows.
>
> Apart using libre tools for building the future ceph cliente I am ope=
n=20
> to anything.
> I would recommand eclipse CDT or Code::BLocks they are based on=20
> mingwin open and easyly enhanceable.**
>
> more free tools can be found here:
> http://www.freebyte.com/programming/cpp/#cppcompilers
>
>
> I will read libcephfs source code and take some notes about the proto=
col.
> I was more going from what I know and trying to track down how=20
> mount.ceph work with the parameters passed to it.
> since it point finally to Kernel/fs/ceph and that I don t really=20
> understand how that module work and that it probably points to some=20
> other dependencies Reading libcephfs source code could be a big gain=20
> of time.
>
> basically on the protocol what is  need are:
>
> 1) open and maintain a connection (socket open, auth, etc )
> 2) retreive a map of directories and disk Quota (disk sizing Y TB=20
> free,  Z TB total)
> 3) procedure to send files / directories in a maner that it will allo=
w=20
> our client to fit ceph transmission protocols
> (limit bandwith for stability?, limit connection amount?, limit cpu=20
> use?, Cache for preparing data transfer (a FIFO cache)?)
> 4)Procedure to retreive files / directory from ceph cluster
> 5) Management copy/move files /Directories, FS stats, Connection=20
> Stats. logging.
>
> My idea to progress is to take those main bulletpoint in ceph protoco=
l=20
> based on general ideas of what ceph file system does and start=20
> identifying parts from libcephfs to match those "needs".
>
> Any suggestion and contributions are welcome.
>
>
> *
> On 11/05/13 11:23, Sage Weil wrote:
>> Hi Alphe,
>>
>> On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
>>> Good day developers!
>>>
>>> I would like to propose to the one interested  work with me to=20
>>> develop a ceph
>>> cliente for MS windows world, Basing us on dokanFS.
>>>
>>> My company is a ceph enthousiast that use on a dayly basis ceph and=
=20
>>> that need
>>> both transfer speed and big expendable and cheap storage.
>>> My company is specialised in data recovery and we want to=20
>>> participate to ceph
>>> effort by bringing a ceph cliente for windows.
>> Awesome!
>>
>>> Our experience shows us that the best gateway is each clientes bein=
g=20
>>> its own
>>> gateway, instead of having a bottle neck server or a cluster of=20
>>> bottle neck
>>> servers as gateway (FTP, samba, SFTP,webdav, s3, etc..).
>>>
>>> We already did some research in that domain.
>>>
>>> Dokan FS is an intent  to write an opensource fuse like cliente for=
 MS
>>> windows.
>>>
>>> More information on DOKANFS can be triggered here
>>> http://dokan-dev.net/en/download/
>>>
>>> Positive points of using DOKANFS.
>>>
>>> - its opensourced and well licenced mit licence, gpl licence and=20
>>> lgpl licence.
>>>
>>> Negative point of using DOKAN FS.
>>> - unreachable author
>>> - Poor documentation . Dev comments in japanese.
>>> - Work in progress so it is unstable and needs to be updated,=20
>>> debugged and
>>> maintained by a MS Windows file system expert developper.
>> I am not very familiar with windows storage APIs, but somebody told =
me
>> at once point there were several interfaces against which a new file
>> system could be implemented, everything from a full in-kernel driver=
 to
>> something that is explorer-based.  Are any of those suitable? Using =
a
>> potentially abandoned fuse-like layer makes me a bit nervous.
>>
>> That said,
>>> I try past year to do a merge from ceph-fuse to dokanfs
>>> here are what I learnt.
>>> - Ceph-fuse and related source code is around 60 000 lines of code.
>>> - Ceph protocol isn t documented so it is like trying to draw a map=
=20
>>> of america
>>> using only a sextan and a compass.
>>>
>>> Those led me to those conclusions:
>>> - I can t do it alone.
>>> - It is easier to draw down the ceph protocol way to work from=20
>>> kernel/fs/ceph
>>> sources and mount.ceph
>>> - Ceph depending libraries may be unexistant or not up to date in=20
>>> their port
>>> on MS Windows (cygwin)
>> I think the most sane path should be to make libcephfs sufficiently
>> portable to build on windows (or cygwin).  For the bits used by the
>> client-side coe, I don't think there should be much in the way of
>> dependencies, and the main challenge would be untangling the build f=
or
>> the necessary pieces out from the rest of Ceph.
>>
>> Have you seen the wip-port portability work that is currently=20
>> underway by
>> Noah and Alan?  That may solve many of the cygwin problems you are=20
>> seeing
>> today.
>>
>>> - MS file system specialist are hard do find in the "open source=20
>>> libre world"
>>> so I will try in the commercial world.
>>>
>>> The commercial world has some problems too. They need ceph protocol=
=20
>>> draft to
>>> implemente it to their own product They will have licencing /commer=
cial
>>> politics that infringe lgpl, and hide that most of the work is done=
=20
>>> by people
>>> other than them. They will not participate in a financial way to ce=
ph
>>> enhancement and growth.
>> I don't think reimplementing the client code is an efficient way=20
>> forward.
>> Unless the goal is a pure kernel implementation...but a significant
>> ongoing investment in development resources would be needed for that=
=20
>> going
>> forward.  I suspect that is a challenge for a platform that does not
>> typically rally that sort of community effort.
>>
>> The easiest thing is of course just to use CIFS and Samba (which wor=
ks
>> today).  A fuse-like approach is probably a reasonably middle ground=
=20
>> (both
>> in initial effort and maintainability going forward)...
>>
>> sage
>>
>>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

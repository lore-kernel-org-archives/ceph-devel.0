From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Thu, 07 Nov 2013 15:02:52 -0300
Message-ID: <527BD5CC.6050002@kepler.cl>
References: <988607914.48.1383835814711.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:62206 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3KGSC6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 13:02:58 -0500
Received: by mail-qe0-f47.google.com with SMTP id b4so820986qen.6
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 10:02:56 -0800 (PST)
In-Reply-To: <988607914.48.1383835814711.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>, Ketor D <d.ketor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello D.Ketor and Matt Benjamin,
You give me alot to think about and this is great!
I merged your previous post to make a single reply that anyone can=20
report to easyly

Windows NFS 4.1 is available here:
http://www.citi.umich.edu/projects/nfsv4/windows/readme.html

pnfs is another name for NFS4.X. It is presented as alternative to ceph=
=20
and we get known terminology as MDS and OSD but without the self healin=
g=20
part if I understand well my rapid look on the topic. (when I say rapid=
=20
look I mean ... 5 minutes spent in that... which is really small amount=
=20
of time to get an accurate view on something)


starting from mount.ceph ... I know that mount.ceph does little but it=20
is a great hint to know what ceph needs and do things.
Basically mount.ceph modprobe the ceph driver in the linux kernel then=20
call mount with the line command passed args and the cephfs type as=20
argument. Then the kernel does the work I don t understand yet what is=20
the start calls that are made to the ceph driver but it seemed to me=20
that is was relatively light. (a first impression compared to ceph-fuse=
=2E)

I think I will do both isolate source code from ceph-client kernel=20
(cephfs module for linux kernel) and the one pointed by Sage starting=20
from client/fuse_ll.cc in ceph master branch. The common files betwin=20
those 2 extractions will be our core set of mandatory features.

Then we try to compile with cygwin a cephfs client library . Then we=20
will try to interface with a modified windows nfs 4.1 client or pnfs or=
=20
any other that will accept to be compiled with gcc for win32...

the fact that windows 8.1 is and windows 2012 are out of reach at the=20
moment is not a problem to me.

Our first concern is to understand what is ceph protocol. Then adapt it=
=20
to something that can be used on windows prior windows 8.1. Dokan fs if=
=20
I remember well use too the WDK (windows driver dev-kit ) for it s=20
compilation so possibly we will see the same limitations.

We need to multiply our source of information by example regarding=20
ceph-client (kernel or fuse, radosgw is on a different layer so I will=20
not try anything around it at first.) And we need to multiply our sourc=
e=20
of information by example regarding virtual file system technologies on=
=20
windoes OS.
Alot of work but all of those available source code everyone point at m=
e=20
will make our best solution. And in the end we will choose technologies=
=20
knowing what we do and what concequencies they have.

regards,




Regards

signature

*Alph=C3=A9 Salas*
Ingeniero T.I

asalas@kepler.cl


On 11/07/13 11:29, Ketor D wrote:
> Hi Alphe:
>        Yes Callback Filesystem is very expensive and can't open sourc=
e.
> It's not a good choice for ceph4win.
>        Another way for ceph4win maybe develop a kernel-mode fs like
> pnfs. pnfs has a kernel-mode windows client. I think you can read its
> src code and maybe migrating from ceph kernel client to windows kerne=
l
> fs is easier than from userspace ceph fuse client.And a kernel-mode f=
s
> client has greater performance than userspace fs like ceph-fuse clien=
t
> and ceph kernel client.
>
>        Regards.
>
On 11/07/13 11:50, Matt W. Benjamin wrote:
> Hi,
>
> The Window NFS v4.1 client is what we work on, so this may be good fo=
r
> code sharing.  The license is lgplv2, like Ceph's.
>
> Something important to be aware of is that the client uses rdbss, whi=
ch
> is a (partial) fsd abstraction that simplified implementation
> quite a bit, kind of like a mini driver.  However, Microsoft's suppor=
t
> for rdbss has been in limbo for a bit.  For example, to link with
> the rdbss symbols you can't use the Windows 8 driver kit--you'll need
> to use the one for Windows 7.  (There's a private rdbss2 used interna=
lly
> by Microsoft's SMB implemenation.  A the moment, 3rd party drivers
> can't use that.)
>
> We've been in communication with Microsoft about this issue, and know=
 of
> a few other fsds using it, but it could be a good thing for that lobb=
ying
> effort to have another user--or it could be a dead end :(.
>
> There are a couple of other choices if you're looking to go this rout=
e,
> that I'm aware of (and we may need to take them too, if RDBSS has no
> way forward), but the required work could be a lot larger.
>
> Matt
>
> ----- "Ketor D"<d.ketor@gmail.com>  wrote:
>
>> Hi Alphe:
>>        Yes Callback Filesystem is very expensive and can't open
>> source.
>> It's not a good choice for ceph4win.
>>        Another way for ceph4win maybe develop a kernel-mode fs like
>> pnfs. pnfs has a kernel-mode windows client. I think you can read it=
s
>> src code and maybe migrating from ceph kernel client to windows
>> kernel
>> fs is easier than from userspace ceph fuse client.And a kernel-mode
>> fs
>> client has greater performance than userspace fs like ceph-fuse
>> client
>> and ceph kernel client.
>>
>>        Regards.
>>
>>
>>
>> On Thu, Nov 7, 2013 at 8:13 PM, Alphe Salas Michels<asalas@kepler.cl=
>
>> wrote:
>>> Commercial libraries are a pain ...
>>>
>>> If we want the more permossive licence offered by callback file
>> system we
>>> have to buy it for 20.000 usd. Then we will have to provide a
>> backbox that
>>> we have no control upon and that will kill our product anytime they
>> want anf
>>> if they decide to stop their commercial activity we will be in the
>> same
>>> situation that with dokanfs but without having the source code of
>> the black
>>> box. If i have to spend 20 000 dollars i would prefere paying
>> someone to
>>> retake dokanfs or to write from scratch a dokanfs fuselike software
>> make it
>>> all shiny and pumpy fantastic and ready to plug to ceph client.
>>>
>>> I would prefere if people have to pay something to get access to
>> ceph4win
>>> that this money goes in ceph main branch pockets... Or as a gift yo=
u
>> donante
>>> to ceph 10 dollars  you get 2 free registration codes for
>> ceph4win... or
>>> something like that.
>>>
>>> If ceph4win as to be comercial then I would prefer delegate the tas=
k
>> to a
>>> company like south river technologies and their great product
>> webdrive. I
>>> would mininaly get involved in that project and simply buy the fina=
l
>> product
>>> to sell it together with my ceph based product (which could be a
>> calxeda
>>> ceph box or something like that).
>>>
>>> I m open anyway to any proposition. But I doubt that callback
>> filesystem
>>> offers us a suitable solution in the way I see ceph4win to be sprea=
d
>> and
>>> used... I m maybe wrong. And anything that will be done around
>> ceph4win will
>>> be public documented etc... And licensed the way that if someone
>> want to
>>> build a commercial solution on top of it, that would be a
>> possibility.
>>> My idea is to giveback somehow to ceph project and at same time
>> forge a
>>> better knowledge in ceph technologies. Because like many in libre
>> world I
>>> think the business is in the services around the software more than
>> on the
>>> software. That the ones writing code should be financed and benefit=
s
>> from
>>> the one selling and giving support of the software at all levels. I
>> m
>>> probably too idealistic. And too optimistic after all I m the one
>> saying I
>>> will do this stuff I have no idea how but well it is interesting an=
d
>> fun so
>>> lets do it.
>>>
>>> Regards,
>>>
>>> P.S: using commercial backend libraries appart including their own
>> cost will
>>> force you to use commercial IDE like MS VisualStudio because their
>> library
>>> has some kind of drm that only that IDE compiler can use. So alot o=
f
>> cost
>>> and yet there is nothing done. If I had to open a kickstarter
>> project saying
>>> we need 60 000 USD to do ceph4win with that monney we will buy the
>> right to
>>> use and share a commercial copyrighted library but abandonned
>> punctually to
>>> us in  public domaine and that we will eventually produce something
>> out of
>>> it. I doubt I will get a dollar.
>>>
>>> We still can suggest the idea to Edlos the commercial company that
>> has the
>>> copyright of Callback FS, Or to buy them their product in a blender
>> way
>>> (blender was bought with donation before being put opensource and
>> public
>>> domaine), Or to open source their library. But in commercial minds
>>> opensourcing =3D death of their technical advantage and death of
>> their
>>> marketing strategy. They will have to invent something more to
>> retrieve
>>> monney from it.
>>>
>>> El nov 6, 2013 11:22 p.m., "Ketor D" <d.ketor@gmail.com
>>> <mailto:d.ketor@gmail.com>> escribi=C3=B3:
>>>
>>>
>>>     Hi Alphe,
>>>               I think you could try Callback Filesystem dev
>> framework. It
>>>     is a commerical dev framework and is maintained by Edlos today.
>>>               I have communicated with Edlos to get a try code for
>>>     development. To dokan, Callback Filesystem has vary document an=
d
>> maybe
>>>     more stabilize.
>>>
>>>               Regards.
>>>
>>>
>>>
>>>     On Thu, Nov 7, 2013 at 10:00 AM, Alphe Salas <asalas@kepler.cl
>>>     <mailto:asalas@kepler.cl>> wrote:
>>>      > Hello ketor thank you for your interest un ceph4win. Since
>> muy
>>>     first mail I
>>>      > exposed the lacks of dokanfs and that I m far from being a
>>>     specialist un
>>>      > filesystems.
>>>      > I exposed what i like un dokanfs bit I not a fan=C3=A1tic of=
 it.
>> Muy
>>>     goal is to
>>>      > have something working quickly.
>>>      >
>>>      > So I am up to any proposici=C3=B3n sure the one with the mor=
e docs
>> and
>>>     support
>>>      > will be the best choice. As for right now what I need is
>>>     understand what are
>>>      > the files involved what are the interfaces functions and wha=
t
>> are
>>>     the needed
>>>      > library dependencies and if they exist ported to windows wit=
h
>>>     cygwin. And
>>>      > all that is retrieved from source code.
>>>      >
>>>      > Regards.
>>>      >
>>>      > El nov 6, 2013 10:34 p.m., "Ketor D" <d.ketor@gmail.com
>>>     <mailto:d.ketor@gmail.com>> escribi=C3=B3:
>>>
>>>      >
>>>      >> Hi Alphe,
>>>      >>      We are taking an interest in your work on Ceph Client
>> for
>>>     Windows
>>>      >> with Dokan.As we know, the performance of Dokan is not very
>>>     good, and it's
>>>      >> abandoned 3 years ago.
>>>      >>      I have learned and used OpenDedup(SDFS) for a long
>> time.
>>>       OpenDedup
>>>      >> has a Dokan version. And the author of OpenDedup said
>>>      >>
>>>      >> The Dokan library is quite flakey  and testing should be
>>>     performed before
>>>      >> putting into production
>>>      >>
>>>      >>       So what do you think about this? And if there is
>> another
>>>     solution of
>>>      >> fuse-like filesystem dev framwork on Windows?
>>>      >>
>>>      >>        Best Wish!
>>>      >>
>>>      >>
>>>      >>
>>>      >> On Thu, Nov 7, 2013 at 5:47 AM, Alphe Salas Michels
>>>     <asalas@kepler.cl  <mailto:asalas@kepler.cl>>
>>>
>>>      >> wrote:
>>>      >>>
>>>      >>> Hello I created the github repository for this project
>>>      >>>https://github.com/alphe/Ceph4Win
>>>      >>>
>>>      >>> Regards,
>>>      >>>
>>>      >>> signature
>>>      >>>
>>>      >>> *Alph=C3=A9 Salas*
>>>      >>> Ingeniero T.I
>>>      >>>
>>>      >>>asalas@kepler.cl  <mailto:asalas@kepler.cl>
>>>
>>>      >>> *<http://www.kepler.cl>*
>>>      >>>
>>>      >>> On 11/05/13 21:00, Sage Weil wrote:
>>>      >>>>
>>>      >>>> Hi Alphe,
>>>      >>>>
>>>      >>>> On Tue, 5 Nov 2013, Alphe Salas Michels wrote:
>>>      >>>>>
>>>      >>>>> signature *Hi, Sage !
>>>      >>>>> thank you for you enthousiast reply.
>>>      >>>>> I sure want to make the best use of everything or
>> anything
>>>     previously
>>>      >>>>> done to
>>>      >>>>> tend to
>>>      >>>>> write ceph cliente for windows.
>>>      >>>>>
>>>      >>>>> Apart using libre tools for building the future ceph
>> cliente
>>>     I am open
>>>      >>>>> to
>>>      >>>>> anything.
>>>      >>>>> I would recommand eclipse CDT or Code::BLocks they are
>> based
>>>     on mingwin
>>>      >>>>> open
>>>      >>>>> and easyly enhanceable.**
>>>      >>>>>
>>>      >>>>> more free tools can be found here:
>>>      >>>>>http://www.freebyte.com/programming/cpp/#cppcompilers
>>>      >>>>>
>>>      >>>>>
>>>      >>>>> I will read libcephfs source code and take some notes
>> about the
>>>      >>>>> protocol.
>>>      >>>>
>>>      >>>> I think you don't need to worry about hte protocol at all=
,
>> since
>>>      >>>> libcephs
>>>      >>>> implements it for you (and will capture any future
>> changes).
>>>      >>>>
>>>      >>>>> I was more going from what I know and trying to track do=
wn
>> how
>>>      >>>>> mount.ceph work
>>>      >>>>> with the parameters passed to it.
>>>      >>>>> since it point finally to Kernel/fs/ceph and that I don =
t
>> really
>>>      >>>>> understand
>>>      >>>>> how that module work and that it probably points to some
>> other
>>>      >>>>> dependencies
>>>      >>>>> Reading libcephfs source code could be a big gain of
>> time.
>>>      >>>>
>>>      >>>> (I would also ignore mount.ceph as everything it does it
>>>     specific to
>>>      >>>> how Linux mounts work.)
>>>      >>>>
>>>      >>>>> basically on the protocol what is  need are:
>>>      >>>>>
>>>      >>>>> 1) open and maintain a connection (socket open, auth, et=
c
>> )
>>>      >>>>> 2) retreive a map of directories and disk Quota (disk
>> sizing
>>>     Y TB free,
>>>      >>>>> Z TB
>>>      >>>>> total)
>>>      >>>>> 3) procedure to send files / directories in a maner that
>> it
>>>     will allow
>>>      >>>>> our
>>>      >>>>> client to fit ceph transmission protocols
>>>      >>>>> (limit bandwith for stability?, limit connection amount?=
,
>>>     limit cpu
>>>      >>>>> use?,
>>>      >>>>> Cache for preparing data transfer (a FIFO cache)?)
>>>      >>>>> 4)Procedure to retreive files / directory from ceph
>> cluster
>>>      >>>>> 5) Management copy/move files /Directories, FS stats,
>>>     Connection Stats.
>>>      >>>>> logging.
>>>      >>>>>
>>>      >>>>> My idea to progress is to take those main bulletpoint in
>> ceph
>>>     protocol
>>>      >>>>> based
>>>      >>>>> on general ideas of what ceph file system does and start
>>>     identifying
>>>      >>>>> parts
>>>      >>>>> from libcephfs to match those "needs".
>>>      >>>>
>>>      >>>> Instead, I would look at include/cephfs/libcephfs.h, the
>>>     interface that
>>>      >>>> libcephfs provides, and try to map that to what the fuse
>> layer
>>>     expects.
>>>      >>>> There is both a path-based that I suspsect lends itself
>> well
>>>     to the
>>>      >>>> Windows interface and (very soon now) a handle based API
>> that is
>>>      >>>> targetted
>>>      >>>> at the Unix-style VFS layers.  I'm mostly guessing,
>> though,
>>>     since I've
>>>      >>>> never seen any low-level fs code in windows before.
>>>      >>>>
>>>      >>>> In this case, the analogous code for Linux should be
>>>     client/fuse_ll.cc
>>>      >>>> itself (and not much else), although there will probably =
be
>> a
>>>     few tricks
>>>      >>>> necessary to map cleanly onto how the windows interfaces
>> work.
>>>      >>>>
>>>      >>>> Does that make sense?
>>>      >>>>
>>>      >>>> Cheers!
>>>      >>>> sage
>>>      >>>>
>>>      >>>>
>>>      >>>>> Any suggestion and contributions are welcome.
>>>      >>>>>
>>>      >>>>>
>>>      >>>>> *
>>>      >>>>> On 11/05/13 11:23, Sage Weil wrote:
>>>      >>>>>>
>>>      >>>>>> Hi Alphe,
>>>      >>>>>>
>>>      >>>>>> On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
>>>      >>>>>>>
>>>      >>>>>>> Good day developers!
>>>      >>>>>>>
>>>      >>>>>>> I would like to propose to the one interested  work wi=
th
>> me to
>>>      >>>>>>> develop a
>>>      >>>>>>> ceph
>>>      >>>>>>> cliente for MS windows world, Basing us on dokanFS.
>>>      >>>>>>>
>>>      >>>>>>> My company is a ceph enthousiast that use on a dayly
>> basis
>>>     ceph and
>>>      >>>>>>> that
>>>      >>>>>>> need
>>>      >>>>>>> both transfer speed and big expendable and cheap
>> storage.
>>>      >>>>>>> My company is specialised in data recovery and we want
>> to
>>>     participate
>>>      >>>>>>> to
>>>      >>>>>>> ceph
>>>      >>>>>>> effort by bringing a ceph cliente for windows.
>>>      >>>>>>
>>>      >>>>>> Awesome!
>>>      >>>>>>
>>>      >>>>>>> Our experience shows us that the best gateway is each
>>>     clientes being
>>>      >>>>>>> its
>>>      >>>>>>> own
>>>      >>>>>>> gateway, instead of having a bottle neck server or a
>> cluster of
>>>      >>>>>>> bottle
>>>      >>>>>>> neck
>>>      >>>>>>> servers as gateway (FTP, samba, SFTP,webdav, s3,
>> etc..).
>>>      >>>>>>>
>>>      >>>>>>> We already did some research in that domain.
>>>      >>>>>>>
>>>      >>>>>>> Dokan FS is an intent  to write an opensource fuse lik=
e
>>>     cliente for
>>>      >>>>>>> MS
>>>      >>>>>>> windows.
>>>      >>>>>>>
>>>      >>>>>>> More information on DOKANFS can be triggered here
>>>      >>>>>>>http://dokan-dev.net/en/download/
>>>      >>>>>>>
>>>      >>>>>>> Positive points of using DOKANFS.
>>>      >>>>>>>
>>>      >>>>>>> - its opensourced and well licenced mit licence, gpl
>>>     licence and lgpl
>>>      >>>>>>> licence.
>>>      >>>>>>>
>>>      >>>>>>> Negative point of using DOKAN FS.
>>>      >>>>>>> - unreachable author
>>>      >>>>>>> - Poor documentation . Dev comments in japanese.
>>>      >>>>>>> - Work in progress so it is unstable and needs to be
>> updated,
>>>      >>>>>>> debugged and
>>>      >>>>>>> maintained by a MS Windows file system expert
>> developper.
>>>      >>>>>>
>>>      >>>>>> I am not very familiar with windows storage APIs, but
>>>     somebody told me
>>>      >>>>>> at once point there were several interfaces against whi=
ch
>> a
>>>     new file
>>>      >>>>>> system could be implemented, everything from a full
>>>     in-kernel driver
>>>      >>>>>> to
>>>      >>>>>> something that is explorer-based.  Are any of those
>>>     suitable?  Using a
>>>      >>>>>> potentially abandoned fuse-like layer makes me a bit
>> nervous.
>>>      >>>>>>
>>>      >>>>>> That said,
>>>      >>>>>>
>>>      >>>>>>>
>>>      >>>>>>> I try past year to do a merge from ceph-fuse to dokanf=
s
>>>      >>>>>>> here are what I learnt.
>>>      >>>>>>> - Ceph-fuse and related source code is around 60 000
>> lines
>>>     of code.
>>>      >>>>>>> - Ceph protocol isn t documented so it is like trying
>> to
>>>     draw a map
>>>      >>>>>>> of
>>>      >>>>>>> america
>>>      >>>>>>> using only a sextan and a compass.
>>>      >>>>>>>
>>>      >>>>>>> Those led me to those conclusions:
>>>      >>>>>>> - I can t do it alone.
>>>      >>>>>>> - It is easier to draw down the ceph protocol way to
>> work from
>>>      >>>>>>> kernel/fs/ceph
>>>      >>>>>>> sources and mount.ceph
>>>      >>>>>>> - Ceph depending libraries may be unexistant or not up
>> to
>>>     date in
>>>      >>>>>>> their
>>>      >>>>>>> port
>>>      >>>>>>> on MS Windows (cygwin)
>>>      >>>>>>
>>>      >>>>>> I think the most sane path should be to make libcephfs
>>>     sufficiently
>>>      >>>>>> portable to build on windows (or cygwin).  For the bits
>> used
>>>     by the
>>>      >>>>>> client-side coe, I don't think there should be much in
>> the
>>>     way of
>>>      >>>>>> dependencies, and the main challenge would be untanglin=
g
>> the
>>>     build for
>>>      >>>>>> the necessary pieces out from the rest of Ceph.
>>>      >>>>>>
>>>      >>>>>> Have you seen the wip-port portability work that is
>>>     currently underway
>>>      >>>>>> by
>>>      >>>>>> Noah and Alan?  That may solve many of the cygwin
>> problems
>>>     you are
>>>      >>>>>> seeing
>>>      >>>>>> today.
>>>      >>>>>>
>>>      >>>>>>> - MS file system specialist are hard do find in the
>> "open
>>>     source
>>>      >>>>>>> libre
>>>      >>>>>>> world"
>>>      >>>>>>> so I will try in the commercial world.
>>>      >>>>>>>
>>>      >>>>>>> The commercial world has some problems too. They need
>> ceph
>>>     protocol
>>>      >>>>>>> draft
>>>      >>>>>>> to
>>>      >>>>>>> implemente it to their own product They will have
>> licencing
>>>      >>>>>>> /commercial
>>>      >>>>>>> politics that infringe lgpl, and hide that most of the
>> work
>>>     is done
>>>      >>>>>>> by
>>>      >>>>>>> people
>>>      >>>>>>> other than them. They will not participate in a
>> financial
>>>     way to ceph
>>>      >>>>>>> enhancement and growth.
>>>      >>>>>>
>>>      >>>>>> I don't think reimplementing the client code is an
>> efficient way
>>>      >>>>>> forward.
>>>      >>>>>> Unless the goal is a pure kernel implementation...but a
>>>     significant
>>>      >>>>>> ongoing investment in development resources would be
>> needed
>>>     for that
>>>      >>>>>> going
>>>      >>>>>> forward.  I suspect that is a challenge for a platform
>> that
>>>     does not
>>>      >>>>>> typically rally that sort of community effort.
>>>      >>>>>>
>>>      >>>>>> The easiest thing is of course just to use CIFS and
>> Samba
>>>     (which works
>>>      >>>>>> today).  A fuse-like approach is probably a reasonably
>>>     middle ground
>>>      >>>>>> (both
>>>      >>>>>> in initial effort and maintainability going forward)...
>>>      >>>>>>
>>>      >>>>>> sage
>>>      >>>>>>
>>>      >>>>>>
>>>      >>>>>
>>>      >>>
>>>      >>> --
>>>      >>> To unsubscribe from this list: send the line "unsubscribe
>>>     ceph-devel" in
>>>      >>> the body of a message tomajordomo@vger.kernel.org
>>>     <mailto:majordomo@vger.kernel.org>
>>>
>>>      >>> More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>>      >>
>>>      >>
>>>      >
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in
>> the body of a message tomajordomo@vger.kernel.org
>> More majordomo info athttp://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

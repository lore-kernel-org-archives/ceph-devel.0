From: Malcolm Haak <malcolm@sgi.com>
Subject: Re: writing a ceph cliente for MS windows
Date: Fri, 8 Nov 2013 10:11:22 +1000
Message-ID: <527C2C2A.7070309@sgi.com>
References: <988607914.48.1383835814711.JavaMail.root@thunderbeast.private.linuxbox.com> <527BD5CC.6050002@kepler.cl> <527BFC4D.6040607@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.179.29]:38355 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab3KHAL3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Nov 2013 19:11:29 -0500
In-Reply-To: <527BFC4D.6040607@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas Michels <asalas@kepler.cl>, "Matt W. Benjamin" <matt@linuxbox.com>, Ketor D <d.ketor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I'm just going to throw these in there.

http://www.acc.umu.se/~bosse/

They are GPLv2 some already use sockets and such from inside the kernel=
=2E=20
  Heck you might even be able to mod the HTTP one to use rados gateway.=
=20
I don't know as I havent sat down and pulled them apart enough yet.

They might help, but they might be useless. Not sure.

On 08/11/13 06:47, Alphe Salas Michels wrote:
> Hello all I finally finished my first source code extraction that sta=
rts
> from ceph/src/client/fuse_ll.c
> The result is accurate unlike previous provided results. basically th=
e
> script start from a file extract all the private includes definitions
> #include "something.h" and recursively extract private includes too. =
the
> best way to know who is related with who.
>
> starting from fuse_ll.cc I optain 390 files retreived and 120 000 lin=
es
> of code !
> involved dirs are : in ceph/src
> objclass/, common/, msg/, common/, osdc/, include/, client/, mds/,
> global/, json_spirit/, log/, os/, crush/, mon/, osd/, auth/
>
> probably not a good way to analyse what amount of work it means since
> most of those directories are the implementation of servers (osd, mon=
,
> mds) and even if only a tiny bit of them is needed at client level. y=
ou
> need two structures from ./osd/OSD.h and  my script by relation will
> take into acount the whole directory...
>
> I ran the script with libcephfs.cc as start point and got almost the
> same results. 131 000 lines of code and 386 files most of the same di=
rs
> involved.
>
>
>
> I think I will spend alot of time doing the manual source code isolat=
ion
> and understand way each #include is set in the files I read (what
> purpose they have do they allow to integrate a crucial data type or n=
ot.
>
>
> The other way around will be to read src/libcephfs.cc. It seems short=
er
> but without understanding what part is used for each included header =
I
> can t say anything...
>
>
>
> I will keep reading the source code and take notes. I think in the ca=
se
> of libcephfs I will gain alot of time.
>
> signature
>
> *Alph=C3=A9 Salas*
> Ingeniero T.I
>
> asalas@kepler.cl
> *www.kepler.cl <http://www.kepler.cl>*
>
> On 11/07/13 15:02, Alphe Salas Michels wrote:
>> Hello D.Ketor and Matt Benjamin,
>> You give me alot to think about and this is great!
>> I merged your previous post to make a single reply that anyone can
>> report to easyly
>>
>> Windows NFS 4.1 is available here:
>> http://www.citi.umich.edu/projects/nfsv4/windows/readme.html
>>
>> pnfs is another name for NFS4.X. It is presented as alternative to
>> ceph and we get known terminology as MDS and OSD but without the sel=
f
>> healing part if I understand well my rapid look on the topic. (when =
I
>> say rapid look I mean ... 5 minutes spent in that... which is really
>> small amount of time to get an accurate view on something)
>>
>>
>> starting from mount.ceph ... I know that mount.ceph does little but =
it
>> is a great hint to know what ceph needs and do things.
>> Basically mount.ceph modprobe the ceph driver in the linux kernel th=
en
>> call mount with the line command passed args and the cephfs type as
>> argument. Then the kernel does the work I don t understand yet what =
is
>> the start calls that are made to the ceph driver but it seemed to me
>> that is was relatively light. (a first impression compared to ceph-f=
use.)
>>
>> I think I will do both isolate source code from ceph-client kernel
>> (cephfs module for linux kernel) and the one pointed by Sage startin=
g
>> from client/fuse_ll.cc in ceph master branch. The common files betwi=
n
>> those 2 extractions will be our core set of mandatory features.
>>
>> Then we try to compile with cygwin a cephfs client library . Then we
>> will try to interface with a modified windows nfs 4.1 client or pnfs
>> or any other that will accept to be compiled with gcc for win32...
>>
>> the fact that windows 8.1 is and windows 2012 are out of reach at th=
e
>> moment is not a problem to me.
>>
>> Our first concern is to understand what is ceph protocol. Then adapt
>> it to something that can be used on windows prior windows 8.1. Dokan
>> fs if I remember well use too the WDK (windows driver dev-kit ) for =
it
>> s compilation so possibly we will see the same limitations.
>>
>> We need to multiply our source of information by example regarding
>> ceph-client (kernel or fuse, radosgw is on a different layer so I wi=
ll
>> not try anything around it at first.) And we need to multiply our
>> source of information by example regarding virtual file system
>> technologies on windoes OS.
>> Alot of work but all of those available source code everyone point a=
t
>> me will make our best solution. And in the end we will choose
>> technologies knowing what we do and what concequencies they have.
>>
>> regards,
>>
>>
>>
>>
>> Regards
>>
>> signature
>>
>> *Alph=C3=A9 Salas*
>> Ingeniero T.I
>>
>> asalas@kepler.cl
>>
>>
>> On 11/07/13 11:29, Ketor D wrote:
>>> Hi Alphe:
>>>        Yes Callback Filesystem is very expensive and can't open sou=
rce.
>>> It's not a good choice for ceph4win.
>>>        Another way for ceph4win maybe develop a kernel-mode fs like
>>> pnfs. pnfs has a kernel-mode windows client. I think you can read i=
ts
>>> src code and maybe migrating from ceph kernel client to windows ker=
nel
>>> fs is easier than from userspace ceph fuse client.And a kernel-mode=
 fs
>>> client has greater performance than userspace fs like ceph-fuse cli=
ent
>>> and ceph kernel client.
>>>
>>>        Regards.
>>>
>> On 11/07/13 11:50, Matt W. Benjamin wrote:
>>> Hi,
>>>
>>> The Window NFS v4.1 client is what we work on, so this may be good =
for
>>> code sharing.  The license is lgplv2, like Ceph's.
>>>
>>> Something important to be aware of is that the client uses rdbss, w=
hich
>>> is a (partial) fsd abstraction that simplified implementation
>>> quite a bit, kind of like a mini driver.  However, Microsoft's supp=
ort
>>> for rdbss has been in limbo for a bit.  For example, to link with
>>> the rdbss symbols you can't use the Windows 8 driver kit--you'll ne=
ed
>>> to use the one for Windows 7.  (There's a private rdbss2 used inter=
nally
>>> by Microsoft's SMB implemenation.  A the moment, 3rd party drivers
>>> can't use that.)
>>>
>>> We've been in communication with Microsoft about this issue, and kn=
ow of
>>> a few other fsds using it, but it could be a good thing for that
>>> lobbying
>>> effort to have another user--or it could be a dead end :(.
>>>
>>> There are a couple of other choices if you're looking to go this ro=
ute,
>>> that I'm aware of (and we may need to take them too, if RDBSS has n=
o
>>> way forward), but the required work could be a lot larger.
>>>
>>> Matt
>>>
>>> ----- "Ketor D"<d.ketor@gmail.com>  wrote:
>>>
>>>> Hi Alphe:
>>>>        Yes Callback Filesystem is very expensive and can't open
>>>> source.
>>>> It's not a good choice for ceph4win.
>>>>        Another way for ceph4win maybe develop a kernel-mode fs lik=
e
>>>> pnfs. pnfs has a kernel-mode windows client. I think you can read =
its
>>>> src code and maybe migrating from ceph kernel client to windows
>>>> kernel
>>>> fs is easier than from userspace ceph fuse client.And a kernel-mod=
e
>>>> fs
>>>> client has greater performance than userspace fs like ceph-fuse
>>>> client
>>>> and ceph kernel client.
>>>>
>>>>        Regards.
>>>>
>>>>
>>>>
>>>> On Thu, Nov 7, 2013 at 8:13 PM, Alphe Salas Michels<asalas@kepler.=
cl>
>>>> wrote:
>>>>> Commercial libraries are a pain ...
>>>>>
>>>>> If we want the more permossive licence offered by callback file
>>>> system we
>>>>> have to buy it for 20.000 usd. Then we will have to provide a
>>>> backbox that
>>>>> we have no control upon and that will kill our product anytime th=
ey
>>>> want anf
>>>>> if they decide to stop their commercial activity we will be in th=
e
>>>> same
>>>>> situation that with dokanfs but without having the source code of
>>>> the black
>>>>> box. If i have to spend 20 000 dollars i would prefere paying
>>>> someone to
>>>>> retake dokanfs or to write from scratch a dokanfs fuselike softwa=
re
>>>> make it
>>>>> all shiny and pumpy fantastic and ready to plug to ceph client.
>>>>>
>>>>> I would prefere if people have to pay something to get access to
>>>> ceph4win
>>>>> that this money goes in ceph main branch pockets... Or as a gift =
you
>>>> donante
>>>>> to ceph 10 dollars  you get 2 free registration codes for
>>>> ceph4win... or
>>>>> something like that.
>>>>>
>>>>> If ceph4win as to be comercial then I would prefer delegate the t=
ask
>>>> to a
>>>>> company like south river technologies and their great product
>>>> webdrive. I
>>>>> would mininaly get involved in that project and simply buy the fi=
nal
>>>> product
>>>>> to sell it together with my ceph based product (which could be a
>>>> calxeda
>>>>> ceph box or something like that).
>>>>>
>>>>> I m open anyway to any proposition. But I doubt that callback
>>>> filesystem
>>>>> offers us a suitable solution in the way I see ceph4win to be spr=
ead
>>>> and
>>>>> used... I m maybe wrong. And anything that will be done around
>>>> ceph4win will
>>>>> be public documented etc... And licensed the way that if someone
>>>> want to
>>>>> build a commercial solution on top of it, that would be a
>>>> possibility.
>>>>> My idea is to giveback somehow to ceph project and at same time
>>>> forge a
>>>>> better knowledge in ceph technologies. Because like many in libre
>>>> world I
>>>>> think the business is in the services around the software more th=
an
>>>> on the
>>>>> software. That the ones writing code should be financed and benef=
its
>>>> from
>>>>> the one selling and giving support of the software at all levels.=
 I
>>>> m
>>>>> probably too idealistic. And too optimistic after all I m the one
>>>> saying I
>>>>> will do this stuff I have no idea how but well it is interesting =
and
>>>> fun so
>>>>> lets do it.
>>>>>
>>>>> Regards,
>>>>>
>>>>> P.S: using commercial backend libraries appart including their ow=
n
>>>> cost will
>>>>> force you to use commercial IDE like MS VisualStudio because thei=
r
>>>> library
>>>>> has some kind of drm that only that IDE compiler can use. So alot=
 of
>>>> cost
>>>>> and yet there is nothing done. If I had to open a kickstarter
>>>> project saying
>>>>> we need 60 000 USD to do ceph4win with that monney we will buy th=
e
>>>> right to
>>>>> use and share a commercial copyrighted library but abandonned
>>>> punctually to
>>>>> us in  public domaine and that we will eventually produce somethi=
ng
>>>> out of
>>>>> it. I doubt I will get a dollar.
>>>>>
>>>>> We still can suggest the idea to Edlos the commercial company tha=
t
>>>> has the
>>>>> copyright of Callback FS, Or to buy them their product in a blend=
er
>>>> way
>>>>> (blender was bought with donation before being put opensource and
>>>> public
>>>>> domaine), Or to open source their library. But in commercial mind=
s
>>>>> opensourcing =3D death of their technical advantage and death of
>>>> their
>>>>> marketing strategy. They will have to invent something more to
>>>> retrieve
>>>>> monney from it.
>>>>>
>>>>> El nov 6, 2013 11:22 p.m., "Ketor D" <d.ketor@gmail.com
>>>>> <mailto:d.ketor@gmail.com>> escribi=C3=B3:
>>>>>
>>>>>
>>>>>     Hi Alphe,
>>>>>               I think you could try Callback Filesystem dev
>>>> framework. It
>>>>>     is a commerical dev framework and is maintained by Edlos toda=
y.
>>>>>               I have communicated with Edlos to get a try code fo=
r
>>>>>     development. To dokan, Callback Filesystem has vary document =
and
>>>> maybe
>>>>>     more stabilize.
>>>>>
>>>>>               Regards.
>>>>>
>>>>>
>>>>>
>>>>>     On Thu, Nov 7, 2013 at 10:00 AM, Alphe Salas <asalas@kepler.c=
l
>>>>>     <mailto:asalas@kepler.cl>> wrote:
>>>>>      > Hello ketor thank you for your interest un ceph4win. Since
>>>> muy
>>>>>     first mail I
>>>>>      > exposed the lacks of dokanfs and that I m far from being a
>>>>>     specialist un
>>>>>      > filesystems.
>>>>>      > I exposed what i like un dokanfs bit I not a fan=C3=A1tic =
of it.
>>>> Muy
>>>>>     goal is to
>>>>>      > have something working quickly.
>>>>>      >
>>>>>      > So I am up to any proposici=C3=B3n sure the one with the m=
ore docs
>>>> and
>>>>>     support
>>>>>      > will be the best choice. As for right now what I need is
>>>>>     understand what are
>>>>>      > the files involved what are the interfaces functions and w=
hat
>>>> are
>>>>>     the needed
>>>>>      > library dependencies and if they exist ported to windows w=
ith
>>>>>     cygwin. And
>>>>>      > all that is retrieved from source code.
>>>>>      >
>>>>>      > Regards.
>>>>>      >
>>>>>      > El nov 6, 2013 10:34 p.m., "Ketor D" <d.ketor@gmail.com
>>>>>     <mailto:d.ketor@gmail.com>> escribi=C3=B3:
>>>>>
>>>>>      >
>>>>>      >> Hi Alphe,
>>>>>      >>      We are taking an interest in your work on Ceph Clien=
t
>>>> for
>>>>>     Windows
>>>>>      >> with Dokan.As we know, the performance of Dokan is not ve=
ry
>>>>>     good, and it's
>>>>>      >> abandoned 3 years ago.
>>>>>      >>      I have learned and used OpenDedup(SDFS) for a long
>>>> time.
>>>>>       OpenDedup
>>>>>      >> has a Dokan version. And the author of OpenDedup said
>>>>>      >>
>>>>>      >> The Dokan library is quite flakey  and testing should be
>>>>>     performed before
>>>>>      >> putting into production
>>>>>      >>
>>>>>      >>       So what do you think about this? And if there is
>>>> another
>>>>>     solution of
>>>>>      >> fuse-like filesystem dev framwork on Windows?
>>>>>      >>
>>>>>      >>        Best Wish!
>>>>>      >>
>>>>>      >>
>>>>>      >>
>>>>>      >> On Thu, Nov 7, 2013 at 5:47 AM, Alphe Salas Michels
>>>>>     <asalas@kepler.cl <mailto:asalas@kepler.cl>>
>>>>>
>>>>>      >> wrote:
>>>>>      >>>
>>>>>      >>> Hello I created the github repository for this project
>>>>>      >>>https://github.com/alphe/Ceph4Win
>>>>>      >>>
>>>>>      >>> Regards,
>>>>>      >>>
>>>>>      >>> signature
>>>>>      >>>
>>>>>      >>> *Alph=C3=A9 Salas*
>>>>>      >>> Ingeniero T.I
>>>>>      >>>
>>>>>      >>>asalas@kepler.cl <mailto:asalas@kepler.cl>
>>>>>
>>>>>      >>> *<http://www.kepler.cl>*
>>>>>      >>>
>>>>>      >>> On 11/05/13 21:00, Sage Weil wrote:
>>>>>      >>>>
>>>>>      >>>> Hi Alphe,
>>>>>      >>>>
>>>>>      >>>> On Tue, 5 Nov 2013, Alphe Salas Michels wrote:
>>>>>      >>>>>
>>>>>      >>>>> signature *Hi, Sage !
>>>>>      >>>>> thank you for you enthousiast reply.
>>>>>      >>>>> I sure want to make the best use of everything or
>>>> anything
>>>>>     previously
>>>>>      >>>>> done to
>>>>>      >>>>> tend to
>>>>>      >>>>> write ceph cliente for windows.
>>>>>      >>>>>
>>>>>      >>>>> Apart using libre tools for building the future ceph
>>>> cliente
>>>>>     I am open
>>>>>      >>>>> to
>>>>>      >>>>> anything.
>>>>>      >>>>> I would recommand eclipse CDT or Code::BLocks they are
>>>> based
>>>>>     on mingwin
>>>>>      >>>>> open
>>>>>      >>>>> and easyly enhanceable.**
>>>>>      >>>>>
>>>>>      >>>>> more free tools can be found here:
>>>>> >>>>>http://www.freebyte.com/programming/cpp/#cppcompilers
>>>>>      >>>>>
>>>>>      >>>>>
>>>>>      >>>>> I will read libcephfs source code and take some notes
>>>> about the
>>>>>      >>>>> protocol.
>>>>>      >>>>
>>>>>      >>>> I think you don't need to worry about hte protocol at a=
ll,
>>>> since
>>>>>      >>>> libcephs
>>>>>      >>>> implements it for you (and will capture any future
>>>> changes).
>>>>>      >>>>
>>>>>      >>>>> I was more going from what I know and trying to track =
down
>>>> how
>>>>>      >>>>> mount.ceph work
>>>>>      >>>>> with the parameters passed to it.
>>>>>      >>>>> since it point finally to Kernel/fs/ceph and that I do=
n t
>>>> really
>>>>>      >>>>> understand
>>>>>      >>>>> how that module work and that it probably points to so=
me
>>>> other
>>>>>      >>>>> dependencies
>>>>>      >>>>> Reading libcephfs source code could be a big gain of
>>>> time.
>>>>>      >>>>
>>>>>      >>>> (I would also ignore mount.ceph as everything it does i=
t
>>>>>     specific to
>>>>>      >>>> how Linux mounts work.)
>>>>>      >>>>
>>>>>      >>>>> basically on the protocol what is need are:
>>>>>      >>>>>
>>>>>      >>>>> 1) open and maintain a connection (socket open, auth, =
etc
>>>> )
>>>>>      >>>>> 2) retreive a map of directories and disk Quota (disk
>>>> sizing
>>>>>     Y TB free,
>>>>>      >>>>> Z TB
>>>>>      >>>>> total)
>>>>>      >>>>> 3) procedure to send files / directories in a maner th=
at
>>>> it
>>>>>     will allow
>>>>>      >>>>> our
>>>>>      >>>>> client to fit ceph transmission protocols
>>>>>      >>>>> (limit bandwith for stability?, limit connection amoun=
t?,
>>>>>     limit cpu
>>>>>      >>>>> use?,
>>>>>      >>>>> Cache for preparing data transfer (a FIFO cache)?)
>>>>>      >>>>> 4)Procedure to retreive files / directory from ceph
>>>> cluster
>>>>>      >>>>> 5) Management copy/move files /Directories, FS stats,
>>>>>     Connection Stats.
>>>>>      >>>>> logging.
>>>>>      >>>>>
>>>>>      >>>>> My idea to progress is to take those main bulletpoint =
in
>>>> ceph
>>>>>     protocol
>>>>>      >>>>> based
>>>>>      >>>>> on general ideas of what ceph file system does and sta=
rt
>>>>>     identifying
>>>>>      >>>>> parts
>>>>>      >>>>> from libcephfs to match those "needs".
>>>>>      >>>>
>>>>>      >>>> Instead, I would look at include/cephfs/libcephfs.h, th=
e
>>>>>     interface that
>>>>>      >>>> libcephfs provides, and try to map that to what the fus=
e
>>>> layer
>>>>>     expects.
>>>>>      >>>> There is both a path-based that I suspsect lends itself
>>>> well
>>>>>     to the
>>>>>      >>>> Windows interface and (very soon now) a handle based AP=
I
>>>> that is
>>>>>      >>>> targetted
>>>>>      >>>> at the Unix-style VFS layers.  I'm mostly guessing,
>>>> though,
>>>>>     since I've
>>>>>      >>>> never seen any low-level fs code in windows before.
>>>>>      >>>>
>>>>>      >>>> In this case, the analogous code for Linux should be
>>>>>     client/fuse_ll.cc
>>>>>      >>>> itself (and not much else), although there will probabl=
y be
>>>> a
>>>>>     few tricks
>>>>>      >>>> necessary to map cleanly onto how the windows interface=
s
>>>> work.
>>>>>      >>>>
>>>>>      >>>> Does that make sense?
>>>>>      >>>>
>>>>>      >>>> Cheers!
>>>>>      >>>> sage
>>>>>      >>>>
>>>>>      >>>>
>>>>>      >>>>> Any suggestion and contributions are welcome.
>>>>>      >>>>>
>>>>>      >>>>>
>>>>>      >>>>> *
>>>>>      >>>>> On 11/05/13 11:23, Sage Weil wrote:
>>>>>      >>>>>>
>>>>>      >>>>>> Hi Alphe,
>>>>>      >>>>>>
>>>>>      >>>>>> On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
>>>>>      >>>>>>>
>>>>>      >>>>>>> Good day developers!
>>>>>      >>>>>>>
>>>>>      >>>>>>> I would like to propose to the one interested  work =
with
>>>> me to
>>>>>      >>>>>>> develop a
>>>>>      >>>>>>> ceph
>>>>>      >>>>>>> cliente for MS windows world, Basing us on dokanFS.
>>>>>      >>>>>>>
>>>>>      >>>>>>> My company is a ceph enthousiast that use on a dayly
>>>> basis
>>>>>     ceph and
>>>>>      >>>>>>> that
>>>>>      >>>>>>> need
>>>>>      >>>>>>> both transfer speed and big expendable and cheap
>>>> storage.
>>>>>      >>>>>>> My company is specialised in data recovery and we wa=
nt
>>>> to
>>>>>     participate
>>>>>      >>>>>>> to
>>>>>      >>>>>>> ceph
>>>>>      >>>>>>> effort by bringing a ceph cliente for windows.
>>>>>      >>>>>>
>>>>>      >>>>>> Awesome!
>>>>>      >>>>>>
>>>>>      >>>>>>> Our experience shows us that the best gateway is eac=
h
>>>>>     clientes being
>>>>>      >>>>>>> its
>>>>>      >>>>>>> own
>>>>>      >>>>>>> gateway, instead of having a bottle neck server or a
>>>> cluster of
>>>>>      >>>>>>> bottle
>>>>>      >>>>>>> neck
>>>>>      >>>>>>> servers as gateway (FTP, samba, SFTP,webdav, s3,
>>>> etc..).
>>>>>      >>>>>>>
>>>>>      >>>>>>> We already did some research in that domain.
>>>>>      >>>>>>>
>>>>>      >>>>>>> Dokan FS is an intent  to write an opensource fuse l=
ike
>>>>>     cliente for
>>>>>      >>>>>>> MS
>>>>>      >>>>>>> windows.
>>>>>      >>>>>>>
>>>>>      >>>>>>> More information on DOKANFS can be triggered here
>>>>> >>>>>>>http://dokan-dev.net/en/download/
>>>>>      >>>>>>>
>>>>>      >>>>>>> Positive points of using DOKANFS.
>>>>>      >>>>>>>
>>>>>      >>>>>>> - its opensourced and well licenced mit licence, gpl
>>>>>     licence and lgpl
>>>>>      >>>>>>> licence.
>>>>>      >>>>>>>
>>>>>      >>>>>>> Negative point of using DOKAN FS.
>>>>>      >>>>>>> - unreachable author
>>>>>      >>>>>>> - Poor documentation . Dev comments in japanese.
>>>>>      >>>>>>> - Work in progress so it is unstable and needs to be
>>>> updated,
>>>>>      >>>>>>> debugged and
>>>>>      >>>>>>> maintained by a MS Windows file system expert
>>>> developper.
>>>>>      >>>>>>
>>>>>      >>>>>> I am not very familiar with windows storage APIs, but
>>>>>     somebody told me
>>>>>      >>>>>> at once point there were several interfaces against w=
hich
>>>> a
>>>>>     new file
>>>>>      >>>>>> system could be implemented, everything from a full
>>>>>     in-kernel driver
>>>>>      >>>>>> to
>>>>>      >>>>>> something that is explorer-based.  Are any of those
>>>>>     suitable?  Using a
>>>>>      >>>>>> potentially abandoned fuse-like layer makes me a bit
>>>> nervous.
>>>>>      >>>>>>
>>>>>      >>>>>> That said,
>>>>>      >>>>>>
>>>>>      >>>>>>>
>>>>>      >>>>>>> I try past year to do a merge from ceph-fuse to doka=
nfs
>>>>>      >>>>>>> here are what I learnt.
>>>>>      >>>>>>> - Ceph-fuse and related source code is around 60 000
>>>> lines
>>>>>     of code.
>>>>>      >>>>>>> - Ceph protocol isn t documented so it is like tryin=
g
>>>> to
>>>>>     draw a map
>>>>>      >>>>>>> of
>>>>>      >>>>>>> america
>>>>>      >>>>>>> using only a sextan and a compass.
>>>>>      >>>>>>>
>>>>>      >>>>>>> Those led me to those conclusions:
>>>>>      >>>>>>> - I can t do it alone.
>>>>>      >>>>>>> - It is easier to draw down the ceph protocol way to
>>>> work from
>>>>>      >>>>>>> kernel/fs/ceph
>>>>>      >>>>>>> sources and mount.ceph
>>>>>      >>>>>>> - Ceph depending libraries may be unexistant or not =
up
>>>> to
>>>>>     date in
>>>>>      >>>>>>> their
>>>>>      >>>>>>> port
>>>>>      >>>>>>> on MS Windows (cygwin)
>>>>>      >>>>>>
>>>>>      >>>>>> I think the most sane path should be to make libcephf=
s
>>>>>     sufficiently
>>>>>      >>>>>> portable to build on windows (or cygwin).  For the bi=
ts
>>>> used
>>>>>     by the
>>>>>      >>>>>> client-side coe, I don't think there should be much i=
n
>>>> the
>>>>>     way of
>>>>>      >>>>>> dependencies, and the main challenge would be untangl=
ing
>>>> the
>>>>>     build for
>>>>>      >>>>>> the necessary pieces out from the rest of Ceph.
>>>>>      >>>>>>
>>>>>      >>>>>> Have you seen the wip-port portability work that is
>>>>>     currently underway
>>>>>      >>>>>> by
>>>>>      >>>>>> Noah and Alan?  That may solve many of the cygwin
>>>> problems
>>>>>     you are
>>>>>      >>>>>> seeing
>>>>>      >>>>>> today.
>>>>>      >>>>>>
>>>>>      >>>>>>> - MS file system specialist are hard do find in the
>>>> "open
>>>>>     source
>>>>>      >>>>>>> libre
>>>>>      >>>>>>> world"
>>>>>      >>>>>>> so I will try in the commercial world.
>>>>>      >>>>>>>
>>>>>      >>>>>>> The commercial world has some problems too. They nee=
d
>>>> ceph
>>>>>     protocol
>>>>>      >>>>>>> draft
>>>>>      >>>>>>> to
>>>>>      >>>>>>> implemente it to their own product They will have
>>>> licencing
>>>>>      >>>>>>> /commercial
>>>>>      >>>>>>> politics that infringe lgpl, and hide that most of t=
he
>>>> work
>>>>>     is done
>>>>>      >>>>>>> by
>>>>>      >>>>>>> people
>>>>>      >>>>>>> other than them. They will not participate in a
>>>> financial
>>>>>     way to ceph
>>>>>      >>>>>>> enhancement and growth.
>>>>>      >>>>>>
>>>>>      >>>>>> I don't think reimplementing the client code is an
>>>> efficient way
>>>>>      >>>>>> forward.
>>>>>      >>>>>> Unless the goal is a pure kernel implementation...but=
 a
>>>>>     significant
>>>>>      >>>>>> ongoing investment in development resources would be
>>>> needed
>>>>>     for that
>>>>>      >>>>>> going
>>>>>      >>>>>> forward.  I suspect that is a challenge for a platfor=
m
>>>> that
>>>>>     does not
>>>>>      >>>>>> typically rally that sort of community effort.
>>>>>      >>>>>>
>>>>>      >>>>>> The easiest thing is of course just to use CIFS and
>>>> Samba
>>>>>     (which works
>>>>>      >>>>>> today).  A fuse-like approach is probably a reasonabl=
y
>>>>>     middle ground
>>>>>      >>>>>> (both
>>>>>      >>>>>> in initial effort and maintainability going forward).=
=2E.
>>>>>      >>>>>>
>>>>>      >>>>>> sage
>>>>>      >>>>>>
>>>>>      >>>>>>
>>>>>      >>>>>
>>>>>      >>>
>>>>>      >>> --
>>>>>      >>> To unsubscribe from this list: send the line "unsubscrib=
e
>>>>>     ceph-devel" in
>>>>>      >>> the body of a message tomajordomo@vger.kernel.org
>>>>>     <mailto:majordomo@vger.kernel.org>
>>>>>
>>>>>      >>> More majordomo info at
>>>> http://vger.kernel.org/majordomo-info.html
>>>>>      >>
>>>>>      >>
>>>>>      >
>>>>>
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in
>>>> the body of a message tomajordomo@vger.kernel.org
>>>> More majordomo info athttp://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

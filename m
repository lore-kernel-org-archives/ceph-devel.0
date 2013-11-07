From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Thu, 07 Nov 2013 09:13:10 -0300
Message-ID: <527B83D6.1070305@kepler.cl>
References: <CAME-gASugOE=-ZoY3-sAa4vCzOd+TXBiEavjoUH3gDLG+1K38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:53008 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3KGMNO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 07:13:14 -0500
Received: by mail-qe0-f52.google.com with SMTP id w7so319134qeb.39
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 04:13:14 -0800 (PST)
In-Reply-To: <CAME-gASugOE=-ZoY3-sAa4vCzOd+TXBiEavjoUH3gDLG+1K38w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, d.ketor@gmail.com


Commercial libraries are a pain ...

If we want the more permossive licence offered by callback file system=20
we have to buy it for 20.000 usd. Then we will have to provide a backbo=
x=20
that we have no control upon and that will kill our product anytime the=
y=20
want anf if they decide to stop their commercial activity we will be in=
=20
the same situation that with dokanfs but without having the source code=
=20
of the black box. If i have to spend 20 000 dollars i would prefere=20
paying someone to retake dokanfs or to write from scratch a dokanfs=20
fuselike software make it all shiny and pumpy fantastic and ready to=20
plug to ceph client.

I would prefere if people have to pay something to get access to=20
ceph4win that this money goes in ceph main branch pockets... Or as a=20
gift you donante to ceph 10 dollars  you get 2 free registration codes=20
for ceph4win... or something like that.

If ceph4win as to be comercial then I would prefer delegate the task to=
=20
a company like south river technologies and their great product=20
webdrive. I would mininaly get involved in that project and simply buy=20
the final product to sell it together with my ceph based product (which=
=20
could be a calxeda ceph box or something like that).

I m open anyway to any proposition. But I doubt that callback filesyste=
m=20
offers us a suitable solution in the way I see ceph4win to be spread an=
d=20
used... I m maybe wrong. And anything that will be done around ceph4win=
=20
will be public documented etc... And licensed the way that if someone=20
want to build a commercial solution on top of it, that would be a=20
possibility.

My idea is to giveback somehow to ceph project and at same time forge a=
=20
better knowledge in ceph technologies. Because like many in libre world=
=20
I think the business is in the services around the software more than o=
n=20
the software. That the ones writing code should be financed and benefit=
s=20
from the one selling and giving support of the software at all levels. =
I=20
m probably too idealistic. And too optimistic after all I m the one=20
saying I will do this stuff I have no idea how but well it is=20
interesting and fun so lets do it.

Regards,

P.S: using commercial backend libraries appart including their own cost=
=20
will force you to use commercial IDE like MS VisualStudio because their=
=20
library has some kind of drm that only that IDE compiler can use. So=20
alot of cost and yet there is nothing done. If I had to open a=20
kickstarter project saying we need 60 000 USD to do ceph4win with that=20
monney we will buy the right to use and share a commercial copyrighted=20
library but abandonned punctually to us in  public domaine and that we=20
will eventually produce something out of it. I doubt I will get a dolla=
r.

We still can suggest the idea to Edlos the commercial company that has=20
the copyright of Callback FS, Or to buy them their product in a blender=
=20
way (blender was bought with donation before being put opensource and=20
public domaine), Or to open source their library. But in commercial=20
minds opensourcing =3D death of their technical advantage and death of=20
their marketing strategy. They will have to invent something more to=20
retrieve monney from it.

El nov 6, 2013 11:22 p.m., "Ketor D" <d.ketor@gmail.com=20
<mailto:d.ketor@gmail.com>> escribi=F3:

    Hi Alphe,
              I think you could try Callback Filesystem dev framework. =
It
    is a commerical dev framework and is maintained by Edlos today.
              I have communicated with Edlos to get a try code for
    development. To dokan, Callback Filesystem has vary document and ma=
ybe
    more stabilize.

              Regards.



    On Thu, Nov 7, 2013 at 10:00 AM, Alphe Salas <asalas@kepler.cl
    <mailto:asalas@kepler.cl>> wrote:
     > Hello ketor thank you for your interest un ceph4win. Since muy
    first mail I
     > exposed the lacks of dokanfs and that I m far from being a
    specialist un
     > filesystems.
     > I exposed what i like un dokanfs bit I not a fan=E1tic of it. Mu=
y
    goal is to
     > have something working quickly.
     >
     > So I am up to any proposici=F3n sure the one with the more docs =
and
    support
     > will be the best choice. As for right now what I need is
    understand what are
     > the files involved what are the interfaces functions and what ar=
e
    the needed
     > library dependencies and if they exist ported to windows with
    cygwin. And
     > all that is retrieved from source code.
     >
     > Regards.
     >
     > El nov 6, 2013 10:34 p.m., "Ketor D" <d.ketor@gmail.com
    <mailto:d.ketor@gmail.com>> escribi=F3:
     >
     >> Hi Alphe,
     >>      We are taking an interest in your work on Ceph Client for
    Windows
     >> with Dokan.As we know, the performance of Dokan is not very
    good, and it's
     >> abandoned 3 years ago.
     >>      I have learned and used OpenDedup(SDFS) for a long time.
      OpenDedup
     >> has a Dokan version. And the author of OpenDedup said
     >>
     >> The Dokan library is quite flakey  and testing should be
    performed before
     >> putting into production
     >>
     >>       So what do you think about this? And if there is another
    solution of
     >> fuse-like filesystem dev framwork on Windows?
     >>
     >>        Best Wish!
     >>
     >>
     >>
     >> On Thu, Nov 7, 2013 at 5:47 AM, Alphe Salas Michels
    <asalas@kepler.cl <mailto:asalas@kepler.cl>>
     >> wrote:
     >>>
     >>> Hello I created the github repository for this project
     >>> https://github.com/alphe/Ceph4Win
     >>>
     >>> Regards,
     >>>
     >>> signature
     >>>
     >>> *Alph=E9 Salas*
     >>> Ingeniero T.I
     >>>
     >>> asalas@kepler.cl <mailto:asalas@kepler.cl>
     >>> *<http://www.kepler.cl>*
     >>>
     >>> On 11/05/13 21:00, Sage Weil wrote:
     >>>>
     >>>> Hi Alphe,
     >>>>
     >>>> On Tue, 5 Nov 2013, Alphe Salas Michels wrote:
     >>>>>
     >>>>> signature *Hi, Sage !
     >>>>> thank you for you enthousiast reply.
     >>>>> I sure want to make the best use of everything or anything
    previously
     >>>>> done to
     >>>>> tend to
     >>>>> write ceph cliente for windows.
     >>>>>
     >>>>> Apart using libre tools for building the future ceph cliente
    I am open
     >>>>> to
     >>>>> anything.
     >>>>> I would recommand eclipse CDT or Code::BLocks they are based
    on mingwin
     >>>>> open
     >>>>> and easyly enhanceable.**
     >>>>>
     >>>>> more free tools can be found here:
     >>>>> http://www.freebyte.com/programming/cpp/#cppcompilers
     >>>>>
     >>>>>
     >>>>> I will read libcephfs source code and take some notes about =
the
     >>>>> protocol.
     >>>>
     >>>> I think you don't need to worry about hte protocol at all, si=
nce
     >>>> libcephs
     >>>> implements it for you (and will capture any future changes).
     >>>>
     >>>>> I was more going from what I know and trying to track down h=
ow
     >>>>> mount.ceph work
     >>>>> with the parameters passed to it.
     >>>>> since it point finally to Kernel/fs/ceph and that I don t re=
ally
     >>>>> understand
     >>>>> how that module work and that it probably points to some oth=
er
     >>>>> dependencies
     >>>>> Reading libcephfs source code could be a big gain of time.
     >>>>
     >>>> (I would also ignore mount.ceph as everything it does it
    specific to
     >>>> how Linux mounts work.)
     >>>>
     >>>>> basically on the protocol what is  need are:
     >>>>>
     >>>>> 1) open and maintain a connection (socket open, auth, etc )
     >>>>> 2) retreive a map of directories and disk Quota (disk sizing
    Y TB free,
     >>>>> Z TB
     >>>>> total)
     >>>>> 3) procedure to send files / directories in a maner that it
    will allow
     >>>>> our
     >>>>> client to fit ceph transmission protocols
     >>>>> (limit bandwith for stability?, limit connection amount?,
    limit cpu
     >>>>> use?,
     >>>>> Cache for preparing data transfer (a FIFO cache)?)
     >>>>> 4)Procedure to retreive files / directory from ceph cluster
     >>>>> 5) Management copy/move files /Directories, FS stats,
    Connection Stats.
     >>>>> logging.
     >>>>>
     >>>>> My idea to progress is to take those main bulletpoint in cep=
h
    protocol
     >>>>> based
     >>>>> on general ideas of what ceph file system does and start
    identifying
     >>>>> parts
     >>>>> from libcephfs to match those "needs".
     >>>>
     >>>> Instead, I would look at include/cephfs/libcephfs.h, the
    interface that
     >>>> libcephfs provides, and try to map that to what the fuse laye=
r
    expects.
     >>>> There is both a path-based that I suspsect lends itself well
    to the
     >>>> Windows interface and (very soon now) a handle based API that=
 is
     >>>> targetted
     >>>> at the Unix-style VFS layers.  I'm mostly guessing, though,
    since I've
     >>>> never seen any low-level fs code in windows before.
     >>>>
     >>>> In this case, the analogous code for Linux should be
    client/fuse_ll.cc
     >>>> itself (and not much else), although there will probably be a
    few tricks
     >>>> necessary to map cleanly onto how the windows interfaces work=
=2E
     >>>>
     >>>> Does that make sense?
     >>>>
     >>>> Cheers!
     >>>> sage
     >>>>
     >>>>
     >>>>> Any suggestion and contributions are welcome.
     >>>>>
     >>>>>
     >>>>> *
     >>>>> On 11/05/13 11:23, Sage Weil wrote:
     >>>>>>
     >>>>>> Hi Alphe,
     >>>>>>
     >>>>>> On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
     >>>>>>>
     >>>>>>> Good day developers!
     >>>>>>>
     >>>>>>> I would like to propose to the one interested  work with m=
e to
     >>>>>>> develop a
     >>>>>>> ceph
     >>>>>>> cliente for MS windows world, Basing us on dokanFS.
     >>>>>>>
     >>>>>>> My company is a ceph enthousiast that use on a dayly basis
    ceph and
     >>>>>>> that
     >>>>>>> need
     >>>>>>> both transfer speed and big expendable and cheap storage.
     >>>>>>> My company is specialised in data recovery and we want to
    participate
     >>>>>>> to
     >>>>>>> ceph
     >>>>>>> effort by bringing a ceph cliente for windows.
     >>>>>>
     >>>>>> Awesome!
     >>>>>>
     >>>>>>> Our experience shows us that the best gateway is each
    clientes being
     >>>>>>> its
     >>>>>>> own
     >>>>>>> gateway, instead of having a bottle neck server or a clust=
er of
     >>>>>>> bottle
     >>>>>>> neck
     >>>>>>> servers as gateway (FTP, samba, SFTP,webdav, s3, etc..).
     >>>>>>>
     >>>>>>> We already did some research in that domain.
     >>>>>>>
     >>>>>>> Dokan FS is an intent  to write an opensource fuse like
    cliente for
     >>>>>>> MS
     >>>>>>> windows.
     >>>>>>>
     >>>>>>> More information on DOKANFS can be triggered here
     >>>>>>> http://dokan-dev.net/en/download/
     >>>>>>>
     >>>>>>> Positive points of using DOKANFS.
     >>>>>>>
     >>>>>>> - its opensourced and well licenced mit licence, gpl
    licence and lgpl
     >>>>>>> licence.
     >>>>>>>
     >>>>>>> Negative point of using DOKAN FS.
     >>>>>>> - unreachable author
     >>>>>>> - Poor documentation . Dev comments in japanese.
     >>>>>>> - Work in progress so it is unstable and needs to be updat=
ed,
     >>>>>>> debugged and
     >>>>>>> maintained by a MS Windows file system expert developper.
     >>>>>>
     >>>>>> I am not very familiar with windows storage APIs, but
    somebody told me
     >>>>>> at once point there were several interfaces against which a
    new file
     >>>>>> system could be implemented, everything from a full
    in-kernel driver
     >>>>>> to
     >>>>>> something that is explorer-based.  Are any of those
    suitable?  Using a
     >>>>>> potentially abandoned fuse-like layer makes me a bit nervou=
s.
     >>>>>>
     >>>>>> That said,
     >>>>>>
     >>>>>>>
     >>>>>>> I try past year to do a merge from ceph-fuse to dokanfs
     >>>>>>> here are what I learnt.
     >>>>>>> - Ceph-fuse and related source code is around 60 000 lines
    of code.
     >>>>>>> - Ceph protocol isn t documented so it is like trying to
    draw a map
     >>>>>>> of
     >>>>>>> america
     >>>>>>> using only a sextan and a compass.
     >>>>>>>
     >>>>>>> Those led me to those conclusions:
     >>>>>>> - I can t do it alone.
     >>>>>>> - It is easier to draw down the ceph protocol way to work =
from
     >>>>>>> kernel/fs/ceph
     >>>>>>> sources and mount.ceph
     >>>>>>> - Ceph depending libraries may be unexistant or not up to
    date in
     >>>>>>> their
     >>>>>>> port
     >>>>>>> on MS Windows (cygwin)
     >>>>>>
     >>>>>> I think the most sane path should be to make libcephfs
    sufficiently
     >>>>>> portable to build on windows (or cygwin).  For the bits use=
d
    by the
     >>>>>> client-side coe, I don't think there should be much in the
    way of
     >>>>>> dependencies, and the main challenge would be untangling th=
e
    build for
     >>>>>> the necessary pieces out from the rest of Ceph.
     >>>>>>
     >>>>>> Have you seen the wip-port portability work that is
    currently underway
     >>>>>> by
     >>>>>> Noah and Alan?  That may solve many of the cygwin problems
    you are
     >>>>>> seeing
     >>>>>> today.
     >>>>>>
     >>>>>>> - MS file system specialist are hard do find in the "open
    source
     >>>>>>> libre
     >>>>>>> world"
     >>>>>>> so I will try in the commercial world.
     >>>>>>>
     >>>>>>> The commercial world has some problems too. They need ceph
    protocol
     >>>>>>> draft
     >>>>>>> to
     >>>>>>> implemente it to their own product They will have licencin=
g
     >>>>>>> /commercial
     >>>>>>> politics that infringe lgpl, and hide that most of the wor=
k
    is done
     >>>>>>> by
     >>>>>>> people
     >>>>>>> other than them. They will not participate in a financial
    way to ceph
     >>>>>>> enhancement and growth.
     >>>>>>
     >>>>>> I don't think reimplementing the client code is an efficien=
t way
     >>>>>> forward.
     >>>>>> Unless the goal is a pure kernel implementation...but a
    significant
     >>>>>> ongoing investment in development resources would be needed
    for that
     >>>>>> going
     >>>>>> forward.  I suspect that is a challenge for a platform that
    does not
     >>>>>> typically rally that sort of community effort.
     >>>>>>
     >>>>>> The easiest thing is of course just to use CIFS and Samba
    (which works
     >>>>>> today).  A fuse-like approach is probably a reasonably
    middle ground
     >>>>>> (both
     >>>>>> in initial effort and maintainability going forward)...
     >>>>>>
     >>>>>> sage
     >>>>>>
     >>>>>>
     >>>>>
     >>>
     >>> --
     >>> To unsubscribe from this list: send the line "unsubscribe
    ceph-devel" in
     >>> the body of a message to majordomo@vger.kernel.org
    <mailto:majordomo@vger.kernel.org>
     >>> More majordomo info at http://vger.kernel.org/majordomo-info.h=
tml
     >>
     >>
     >



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

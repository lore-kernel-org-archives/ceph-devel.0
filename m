From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Fri, 08 Nov 2013 11:15:30 -0300
Message-ID: <527CF202.8040409@kepler.cl>
References: <988607914.48.1383835814711.JavaMail.root@thunderbeast.private.linuxbox.com> <527BD5CC.6050002@kepler.cl> <527BFC4D.6040607@kepler.cl> <527C2C2A.7070309@sgi.com> <CAME-gARbjR++qXsx9Sx4KbuggthONrscHToxCTUKrci_MLMDzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:64637 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab3KHOPg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Nov 2013 09:15:36 -0500
Received: by mail-qa0-f54.google.com with SMTP id j7so1689214qaq.20
        for <ceph-devel@vger.kernel.org>; Fri, 08 Nov 2013 06:15:35 -0800 (PST)
In-Reply-To: <CAME-gARbjR++qXsx9Sx4KbuggthONrscHToxCTUKrci_MLMDzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Ketor D <d.ketor@gmail.com>, "Matt W. Benjamin" <matt@linuxbox.com>

Hello malcom and matt thank you for apporting some more information=20
source. OpenAFS is sure interesting httpfs too.

I hope it will help us on deciding the best path to follow in our=20
interface with window.
Actually I still trying to isolate the needed client code in the=20
shortest way possible.

Regards.

Alphe Salas

El nov 7, 2013 9:11 p.m., "Malcolm Haak" <malcolm@sgi.com=20
<mailto:malcolm@sgi.com>> escribi=C3=B3:

    I'm just going to throw these in there.

    http://www.acc.umu.se/~bosse/ <http://www.acc.umu.se/%7Ebosse/>

    They are GPLv2 some already use sockets and such from inside the
    kernel.  Heck you might even be able to mod the HTTP one to use
    rados gateway. I don't know as I havent sat down and pulled them
    apart enough yet.

    They might help, but they might be useless. Not sure.

    On 08/11/13 06:47, Alphe Salas Michels wrote:

        Hello all I finally finished my first source code extraction
        that starts
        from ceph/src/client/fuse_ll.c
        The result is accurate unlike previous provided results.
        basically the
        script start from a file extract all the private includes
        definitions
        #include "something.h" and recursively extract private includes
        too. the
        best way to know who is related with who.

        starting from fuse_ll.cc I optain 390 files retreived and 120
        000 lines
        of code !
        involved dirs are : in ceph/src
        objclass/, common/, msg/, common/, osdc/, include/, client/, md=
s/,
        global/, json_spirit/, log/, os/, crush/, mon/, osd/, auth/

        probably not a good way to analyse what amount of work it means
        since
        most of those directories are the implementation of servers
        (osd, mon,
        mds) and even if only a tiny bit of them is needed at client
        level. you
        need two structures from ./osd/OSD.h and  my script by relation=
 will
        take into acount the whole directory...

        I ran the script with libcephfs.cc as start point and got almos=
t the
        same results. 131 000 lines of code and 386 files most of the
        same dirs
        involved.



        I think I will spend alot of time doing the manual source code
        isolation
        and understand way each #include is set in the files I read (wh=
at
        purpose they have do they allow to integrate a crucial data typ=
e
        or not.


        The other way around will be to read src/libcephfs.cc. It seems
        shorter
        but without understanding what part is used for each included
        header I
        can t say anything...



        I will keep reading the source code and take notes. I think in
        the case
        of libcephfs I will gain alot of time.

        signature

        *Alph=C3=A9 Salas*
        Ingeniero T.I

        asalas@kepler.cl <mailto:asalas@kepler.cl>
        *www.kepler.cl <http://www.kepler.cl> <http://www.kepler.cl>*

        On 11/07/13 15:02, Alphe Salas Michels wrote:

            Hello D.Ketor and Matt Benjamin,
            You give me alot to think about and this is great!
            I merged your previous post to make a single reply that
            anyone can
            report to easyly

            Windows NFS 4.1 is available here:
            http://www.citi.umich.edu/projects/nfsv4/windows/readme.htm=
l

            pnfs is another name for NFS4.X. It is presented as
            alternative to
            ceph and we get known terminology as MDS and OSD but withou=
t
            the self
            healing part if I understand well my rapid look on the
            topic. (when I
            say rapid look I mean ... 5 minutes spent in that... which
            is really
            small amount of time to get an accurate view on something)


            starting from mount.ceph ... I know that mount.ceph does
            little but it
            is a great hint to know what ceph needs and do things.
            Basically mount.ceph modprobe the ceph driver in the linux
            kernel then
            call mount with the line command passed args and the cephfs
            type as
            argument. Then the kernel does the work I don t understand
            yet what is
            the start calls that are made to the ceph driver but it
            seemed to me
            that is was relatively light. (a first impression compared
            to ceph-fuse.)

            I think I will do both isolate source code from ceph-client
            kernel
            (cephfs module for linux kernel) and the one pointed by Sag=
e
            starting
            from client/fuse_ll.cc in ceph master branch. The common
            files betwin
            those 2 extractions will be our core set of mandatory featu=
res.

            Then we try to compile with cygwin a cephfs client library =
=2E
            Then we
            will try to interface with a modified windows nfs 4.1 clien=
t
            or pnfs
            or any other that will accept to be compiled with gcc for
            win32...

            the fact that windows 8.1 is and windows 2012 are out of
            reach at the
            moment is not a problem to me.

            Our first concern is to understand what is ceph protocol.
            Then adapt
            it to something that can be used on windows prior windows
            8.1. Dokan
            fs if I remember well use too the WDK (windows driver
            dev-kit ) for it
            s compilation so possibly we will see the same limitations.

            We need to multiply our source of information by example
            regarding
            ceph-client (kernel or fuse, radosgw is on a different laye=
r
            so I will
            not try anything around it at first.) And we need to
            multiply our
            source of information by example regarding virtual file sys=
tem
            technologies on windoes OS.
            Alot of work but all of those available source code everyon=
e
            point at
            me will make our best solution. And in the end we will choo=
se
            technologies knowing what we do and what concequencies they
            have.

            regards,




            Regards

            signature

            *Alph=C3=A9 Salas*
            Ingeniero T.I

            asalas@kepler.cl <mailto:asalas@kepler.cl>


            On 11/07/13 11:29, Ketor D wrote:

                Hi Alphe:
                        Yes Callback Filesystem is very expensive and
                can't open source.
                It's not a good choice for ceph4win.
                        Another way for ceph4win maybe develop a
                kernel-mode fs like
                pnfs. pnfs has a kernel-mode windows client. I think yo=
u
                can read its
                src code and maybe migrating from ceph kernel client to
                windows kernel
                fs is easier than from userspace ceph fuse client.And a
                kernel-mode fs
                client has greater performance than userspace fs like
                ceph-fuse client
                and ceph kernel client.

                        Regards.

            On 11/07/13 11:50, Matt W. Benjamin wrote:

                Hi,

                The Window NFS v4.1 client is what we work on, so this
                may be good for
                code sharing.  The license is lgplv2, like Ceph's.

                Something important to be aware of is that the client
                uses rdbss, which
                is a (partial) fsd abstraction that simplified
                implementation
                quite a bit, kind of like a mini driver.  However,
                Microsoft's support
                for rdbss has been in limbo for a bit.  For example, to
                link with
                the rdbss symbols you can't use the Windows 8 driver
                kit--you'll need
                to use the one for Windows 7.  (There's a private rdbss=
2
                used internally
                by Microsoft's SMB implemenation.  A the moment, 3rd
                party drivers
                can't use that.)

                We've been in communication with Microsoft about this
                issue, and know of
                a few other fsds using it, but it could be a good thing
                for that
                lobbying
                effort to have another user--or it could be a dead end =
:(.

                There are a couple of other choices if you're looking t=
o
                go this route,
                that I'm aware of (and we may need to take them too, if
                RDBSS has no
                way forward), but the required work could be a lot larg=
er.

                Matt

                ----- "Ketor D"<d.ketor@gmail.com
                <mailto:d.ketor@gmail.com>>  wrote:

                    Hi Alphe:
                            Yes Callback Filesystem is very expensive
                    and can't open
                    source.
                    It's not a good choice for ceph4win.
                            Another way for ceph4win maybe develop a
                    kernel-mode fs like
                    pnfs. pnfs has a kernel-mode windows client. I thin=
k
                    you can read its
                    src code and maybe migrating from ceph kernel clien=
t
                    to windows
                    kernel
                    fs is easier than from userspace ceph fuse
                    client.And a kernel-mode
                    fs
                    client has greater performance than userspace fs
                    like ceph-fuse
                    client
                    and ceph kernel client.

                            Regards.



                    On Thu, Nov 7, 2013 at 8:13 PM, Alphe Salas
                    Michels<asalas@kepler.cl <mailto:asalas@kepler.cl>>
                    wrote:

                        Commercial libraries are a pain ...

                        If we want the more permossive licence offered
                        by callback file

                    system we

                        have to buy it for 20.000 usd. Then we will hav=
e
                        to provide a

                    backbox that

                        we have no control upon and that will kill our
                        product anytime they

                    want anf

                        if they decide to stop their commercial activit=
y
                        we will be in the

                    same

                        situation that with dokanfs but without having
                        the source code of

                    the black

                        box. If i have to spend 20 000 dollars i would
                        prefere paying

                    someone to

                        retake dokanfs or to write from scratch a
                        dokanfs fuselike software

                    make it

                        all shiny and pumpy fantastic and ready to plug
                        to ceph client.

                        I would prefere if people have to pay something
                        to get access to

                    ceph4win

                        that this money goes in ceph main branch
                        pockets... Or as a gift you

                    donante

                        to ceph 10 dollars  you get 2 free registration
                        codes for

                    ceph4win... or

                        something like that.

                        If ceph4win as to be comercial then I would
                        prefer delegate the task

                    to a

                        company like south river technologies and their
                        great product

                    webdrive. I

                        would mininaly get involved in that project and
                        simply buy the final

                    product

                        to sell it together with my ceph based product
                        (which could be a

                    calxeda

                        ceph box or something like that).

                        I m open anyway to any proposition. But I doubt
                        that callback

                    filesystem

                        offers us a suitable solution in the way I see
                        ceph4win to be spread

                    and

                        used... I m maybe wrong. And anything that will
                        be done around

                    ceph4win will

                        be public documented etc... And licensed the wa=
y
                        that if someone

                    want to

                        build a commercial solution on top of it, that
                        would be a

                    possibility.

                        My idea is to giveback somehow to ceph project
                        and at same time

                    forge a

                        better knowledge in ceph technologies. Because
                        like many in libre

                    world I

                        think the business is in the services around th=
e
                        software more than

                    on the

                        software. That the ones writing code should be
                        financed and benefits

                    from

                        the one selling and giving support of the
                        software at all levels. I

                    m

                        probably too idealistic. And too optimistic
                        after all I m the one

                    saying I

                        will do this stuff I have no idea how but well
                        it is interesting and

                    fun so

                        lets do it.

                        Regards,

                        P.S: using commercial backend libraries appart
                        including their own

                    cost will

                        force you to use commercial IDE like MS
                        VisualStudio because their

                    library

                        has some kind of drm that only that IDE compile=
r
                        can use. So alot of

                    cost

                        and yet there is nothing done. If I had to open
                        a kickstarter

                    project saying

                        we need 60 000 USD to do ceph4win with that
                        monney we will buy the

                    right to

                        use and share a commercial copyrighted library
                        but abandonned

                    punctually to

                        us in  public domaine and that we will
                        eventually produce something

                    out of

                        it. I doubt I will get a dollar.

                        We still can suggest the idea to Edlos the
                        commercial company that

                    has the

                        copyright of Callback FS, Or to buy them their
                        product in a blender

                    way

                        (blender was bought with donation before being
                        put opensource and

                    public

                        domaine), Or to open source their library. But
                        in commercial minds
                        opensourcing =3D death of their technical
                        advantage and death of

                    their

                        marketing strategy. They will have to invent
                        something more to

                    retrieve

                        monney from it.

                        El nov 6, 2013 11:22 p.m., "Ketor D"
                        <d.ketor@gmail.com <mailto:d.ketor@gmail.com>
                        <mailto:d.ketor@gmail.com
                        <mailto:d.ketor@gmail.com>>> escribi=C3=B3:


                             Hi Alphe,
                                       I think you could try Callback
                        Filesystem dev

                    framework. It

                             is a commerical dev framework and is
                        maintained by Edlos today.
                                       I have communicated with Edlos t=
o
                        get a try code for
                             development. To dokan, Callback Filesystem
                        has vary document and

                    maybe

                             more stabilize.

                                       Regards.



                             On Thu, Nov 7, 2013 at 10:00 AM, Alphe
                        Salas <asalas@kepler.cl <mailto:asalas@kepler.c=
l>
                             <mailto:asalas@kepler.cl
                        <mailto:asalas@kepler.cl>>> wrote:
                              > Hello ketor thank you for your interest
                        un ceph4win. Since

                    muy

                             first mail I
                              > exposed the lacks of dokanfs and that I
                        m far from being a
                             specialist un
                              > filesystems.
                              > I exposed what i like un dokanfs bit I
                        not a fan=C3=A1tic of it.

                    Muy

                             goal is to
                              > have something working quickly.
                              >
                              > So I am up to any proposici=C3=B3n sure=
 the
                        one with the more docs

                    and

                             support
                              > will be the best choice. As for right
                        now what I need is
                             understand what are
                              > the files involved what are the
                        interfaces functions and what

                    are

                             the needed
                              > library dependencies and if they exist
                        ported to windows with
                             cygwin. And
                              > all that is retrieved from source code.
                              >
                              > Regards.
                              >
                              > El nov 6, 2013 10:34 p.m., "Ketor D"
                        <d.ketor@gmail.com <mailto:d.ketor@gmail.com>
                             <mailto:d.ketor@gmail.com
                        <mailto:d.ketor@gmail.com>>> escribi=C3=B3:

                              >
                              >> Hi Alphe,
                              >>      We are taking an interest in your
                        work on Ceph Client

                    for

                             Windows
                              >> with Dokan.As we know, the performance
                        of Dokan is not very
                             good, and it's
                              >> abandoned 3 years ago.
                              >>      I have learned and used
                        OpenDedup(SDFS) for a long

                    time.

                               OpenDedup
                              >> has a Dokan version. And the author of
                        OpenDedup said
                              >>
                              >> The Dokan library is quite flakey  and
                        testing should be
                             performed before
                              >> putting into production
                              >>
                              >>       So what do you think about this?
                        And if there is

                    another

                             solution of
                              >> fuse-like filesystem dev framwork on
                        Windows?
                              >>
                              >>        Best Wish!
                              >>
                              >>
                              >>
                              >> On Thu, Nov 7, 2013 at 5:47 AM, Alphe
                        Salas Michels
                             <asalas@kepler.cl <mailto:asalas@kepler.cl=
>
                        <mailto:asalas@kepler.cl <mailto:asalas@kepler.=
cl>>>

                              >> wrote:
                              >>>
                              >>> Hello I created the github repository
                        for this project
                              >>>https://github.com/alphe/Ceph4Win
                              >>>
                              >>> Regards,
                              >>>
                              >>> signature
                              >>>
                              >>> *Alph=C3=A9 Salas*
                              >>> Ingeniero T.I
                              >>>
                              >>>asalas@kepler.cl
                        <mailto:asalas@kepler.cl>
                        <mailto:asalas@kepler.cl <mailto:asalas@kepler.=
cl>>

                              >>> *<http://www.kepler.cl>*
                              >>>
                              >>> On 11/05/13 21:00, Sage Weil wrote:
                              >>>>
                              >>>> Hi Alphe,
                              >>>>
                              >>>> On Tue, 5 Nov 2013, Alphe Salas
                        Michels wrote:
                              >>>>>
                              >>>>> signature *Hi, Sage !
                              >>>>> thank you for you enthousiast reply=
=2E
                              >>>>> I sure want to make the best use of
                        everything or

                    anything

                             previously
                              >>>>> done to
                              >>>>> tend to
                              >>>>> write ceph cliente for windows.
                              >>>>>
                              >>>>> Apart using libre tools for buildin=
g
                        the future ceph

                    cliente

                             I am open
                              >>>>> to
                              >>>>> anything.
                              >>>>> I would recommand eclipse CDT or
                        Code::BLocks they are

                    based

                             on mingwin
                              >>>>> open
                              >>>>> and easyly enhanceable.**
                              >>>>>
                              >>>>> more free tools can be found here:
                         >>>>>http://www.freebyte.com/programming/cpp/#=
cppcompilers
                              >>>>>
                              >>>>>
                              >>>>> I will read libcephfs source code
                        and take some notes

                    about the

                              >>>>> protocol.
                              >>>>
                              >>>> I think you don't need to worry abou=
t
                        hte protocol at all,

                    since

                              >>>> libcephs
                              >>>> implements it for you (and will
                        capture any future

                    changes).

                              >>>>
                              >>>>> I was more going from what I know
                        and trying to track down

                    how

                              >>>>> mount.ceph work
                              >>>>> with the parameters passed to it.
                              >>>>> since it point finally to
                        Kernel/fs/ceph and that I don t

                    really

                              >>>>> understand
                              >>>>> how that module work and that it
                        probably points to some

                    other

                              >>>>> dependencies
                              >>>>> Reading libcephfs source code could
                        be a big gain of

                    time.

                              >>>>
                              >>>> (I would also ignore mount.ceph as
                        everything it does it
                             specific to
                              >>>> how Linux mounts work.)
                              >>>>
                              >>>>> basically on the protocol what is
                        need are:
                              >>>>>
                              >>>>> 1) open and maintain a connection
                        (socket open, auth, etc

                    )

                              >>>>> 2) retreive a map of directories an=
d
                        disk Quota (disk

                    sizing

                             Y TB free,
                              >>>>> Z TB
                              >>>>> total)
                              >>>>> 3) procedure to send files /
                        directories in a maner that

                    it

                             will allow
                              >>>>> our
                              >>>>> client to fit ceph transmission
                        protocols
                              >>>>> (limit bandwith for stability?,
                        limit connection amount?,
                             limit cpu
                              >>>>> use?,
                              >>>>> Cache for preparing data transfer (=
a
                        FIFO cache)?)
                              >>>>> 4)Procedure to retreive files /
                        directory from ceph

                    cluster

                              >>>>> 5) Management copy/move files
                        /Directories, FS stats,
                             Connection Stats.
                              >>>>> logging.
                              >>>>>
                              >>>>> My idea to progress is to take thos=
e
                        main bulletpoint in

                    ceph

                             protocol
                              >>>>> based
                              >>>>> on general ideas of what ceph file
                        system does and start
                             identifying
                              >>>>> parts
                              >>>>> from libcephfs to match those "need=
s".
                              >>>>
                              >>>> Instead, I would look at
                        include/cephfs/libcephfs.h, the
                             interface that
                              >>>> libcephfs provides, and try to map
                        that to what the fuse

                    layer

                             expects.
                              >>>> There is both a path-based that I
                        suspsect lends itself

                    well

                             to the
                              >>>> Windows interface and (very soon now=
)
                        a handle based API

                    that is

                              >>>> targetted
                              >>>> at the Unix-style VFS layers.  I'm
                        mostly guessing,

                    though,

                             since I've
                              >>>> never seen any low-level fs code in
                        windows before.
                              >>>>
                              >>>> In this case, the analogous code for
                        Linux should be
                             client/fuse_ll.cc
                              >>>> itself (and not much else), although
                        there will probably be

                    a

                             few tricks
                              >>>> necessary to map cleanly onto how th=
e
                        windows interfaces

                    work.

                              >>>>
                              >>>> Does that make sense?
                              >>>>
                              >>>> Cheers!
                              >>>> sage
                              >>>>
                              >>>>
                              >>>>> Any suggestion and contributions ar=
e
                        welcome.
                              >>>>>
                              >>>>>
                              >>>>> *
                              >>>>> On 11/05/13 11:23, Sage Weil wrote:
                              >>>>>>
                              >>>>>> Hi Alphe,
                              >>>>>>
                              >>>>>> On Mon, 4 Nov 2013, Alphe Salas
                        Michels wrote:
                              >>>>>>>
                              >>>>>>> Good day developers!
                              >>>>>>>
                              >>>>>>> I would like to propose to the on=
e
                        interested  work with

                    me to

                              >>>>>>> develop a
                              >>>>>>> ceph
                              >>>>>>> cliente for MS windows world,
                        Basing us on dokanFS.
                              >>>>>>>
                              >>>>>>> My company is a ceph enthousiast
                        that use on a dayly

                    basis

                             ceph and
                              >>>>>>> that
                              >>>>>>> need
                              >>>>>>> both transfer speed and big
                        expendable and cheap

                    storage.

                              >>>>>>> My company is specialised in data
                        recovery and we want

                    to

                             participate
                              >>>>>>> to
                              >>>>>>> ceph
                              >>>>>>> effort by bringing a ceph cliente
                        for windows.
                              >>>>>>
                              >>>>>> Awesome!
                              >>>>>>
                              >>>>>>> Our experience shows us that the
                        best gateway is each
                             clientes being
                              >>>>>>> its
                              >>>>>>> own
                              >>>>>>> gateway, instead of having a
                        bottle neck server or a

                    cluster of

                              >>>>>>> bottle
                              >>>>>>> neck
                              >>>>>>> servers as gateway (FTP, samba,
                        SFTP,webdav, s3,

                    etc..).

                              >>>>>>>
                              >>>>>>> We already did some research in
                        that domain.
                              >>>>>>>
                              >>>>>>> Dokan FS is an intent  to write a=
n
                        opensource fuse like
                             cliente for
                              >>>>>>> MS
                              >>>>>>> windows.
                              >>>>>>>
                              >>>>>>> More information on DOKANFS can b=
e
                        triggered here
                         >>>>>>>http://dokan-dev.net/en/download/
                              >>>>>>>
                              >>>>>>> Positive points of using DOKANFS.
                              >>>>>>>
                              >>>>>>> - its opensourced and well
                        licenced mit licence, gpl
                             licence and lgpl
                              >>>>>>> licence.
                              >>>>>>>
                              >>>>>>> Negative point of using DOKAN FS.
                              >>>>>>> - unreachable author
                              >>>>>>> - Poor documentation . Dev
                        comments in japanese.
                              >>>>>>> - Work in progress so it is
                        unstable and needs to be

                    updated,

                              >>>>>>> debugged and
                              >>>>>>> maintained by a MS Windows file
                        system expert

                    developper.

                              >>>>>>
                              >>>>>> I am not very familiar with window=
s
                        storage APIs, but
                             somebody told me
                              >>>>>> at once point there were several
                        interfaces against which

                    a

                             new file
                              >>>>>> system could be implemented,
                        everything from a full
                             in-kernel driver
                              >>>>>> to
                              >>>>>> something that is explorer-based.
                          Are any of those
                             suitable?  Using a
                              >>>>>> potentially abandoned fuse-like
                        layer makes me a bit

                    nervous.

                              >>>>>>
                              >>>>>> That said,
                              >>>>>>
                              >>>>>>>
                              >>>>>>> I try past year to do a merge fro=
m
                        ceph-fuse to dokanfs
                              >>>>>>> here are what I learnt.
                              >>>>>>> - Ceph-fuse and related source
                        code is around 60 000

                    lines

                             of code.
                              >>>>>>> - Ceph protocol isn t documented
                        so it is like trying

                    to

                             draw a map
                              >>>>>>> of
                              >>>>>>> america
                              >>>>>>> using only a sextan and a compass=
=2E
                              >>>>>>>
                              >>>>>>> Those led me to those conclusions=
:
                              >>>>>>> - I can t do it alone.
                              >>>>>>> - It is easier to draw down the
                        ceph protocol way to

                    work from

                              >>>>>>> kernel/fs/ceph
                              >>>>>>> sources and mount.ceph
                              >>>>>>> - Ceph depending libraries may be
                        unexistant or not up

                    to

                             date in
                              >>>>>>> their
                              >>>>>>> port
                              >>>>>>> on MS Windows (cygwin)
                              >>>>>>
                              >>>>>> I think the most sane path should
                        be to make libcephfs
                             sufficiently
                              >>>>>> portable to build on windows (or
                        cygwin).  For the bits

                    used

                             by the
                              >>>>>> client-side coe, I don't think
                        there should be much in

                    the

                             way of
                              >>>>>> dependencies, and the main
                        challenge would be untangling

                    the

                             build for
                              >>>>>> the necessary pieces out from the
                        rest of Ceph.
                              >>>>>>
                              >>>>>> Have you seen the wip-port
                        portability work that is
                             currently underway
                              >>>>>> by
                              >>>>>> Noah and Alan?  That may solve man=
y
                        of the cygwin

                    problems

                             you are
                              >>>>>> seeing
                              >>>>>> today.
                              >>>>>>
                              >>>>>>> - MS file system specialist are
                        hard do find in the

                    "open

                             source
                              >>>>>>> libre
                              >>>>>>> world"
                              >>>>>>> so I will try in the commercial w=
orld.
                              >>>>>>>
                              >>>>>>> The commercial world has some
                        problems too. They need

                    ceph

                             protocol
                              >>>>>>> draft
                              >>>>>>> to
                              >>>>>>> implemente it to their own produc=
t
                        They will have

                    licencing

                              >>>>>>> /commercial
                              >>>>>>> politics that infringe lgpl, and
                        hide that most of the

                    work

                             is done
                              >>>>>>> by
                              >>>>>>> people
                              >>>>>>> other than them. They will not
                        participate in a

                    financial

                             way to ceph
                              >>>>>>> enhancement and growth.
                              >>>>>>
                              >>>>>> I don't think reimplementing the
                        client code is an

                    efficient way

                              >>>>>> forward.
                              >>>>>> Unless the goal is a pure kernel
                        implementation...but a
                             significant
                              >>>>>> ongoing investment in development
                        resources would be

                    needed

                             for that
                              >>>>>> going
                              >>>>>> forward.  I suspect that is a
                        challenge for a platform

                    that

                             does not
                              >>>>>> typically rally that sort of
                        community effort.
                              >>>>>>
                              >>>>>> The easiest thing is of course jus=
t
                        to use CIFS and

                    Samba

                             (which works
                              >>>>>> today).  A fuse-like approach is
                        probably a reasonably
                             middle ground
                              >>>>>> (both
                              >>>>>> in initial effort and
                        maintainability going forward)...
                              >>>>>>
                              >>>>>> sage
                              >>>>>>
                              >>>>>>
                              >>>>>
                              >>>
                              >>> --
                              >>> To unsubscribe from this list: send
                        the line "unsubscribe
                             ceph-devel" in
                              >>> the body of a message
                        tomajordomo@vger.kernel.org
                        <mailto:tomajordomo@vger.kernel.org>
                             <mailto:majordomo@vger.kernel.org
                        <mailto:majordomo@vger.kernel.org>>

                              >>> More majordomo info at

                    http://vger.kernel.org/majordomo-info.html

                              >>
                              >>
                              >



                    --
                    To unsubscribe from this list: send the line
                    "unsubscribe ceph-devel"
                    in
                    the body of a message tomajordomo@vger.kernel.org
                    <mailto:tomajordomo@vger.kernel.org>
                    More majordomo info
                    athttp://vger.kernel.org/majordomo-info.html
                    <http://vger.kernel.org/majordomo-info.html>



        --
        To unsubscribe from this list: send the line "unsubscribe
        ceph-devel" in
        the body of a message to majordomo@vger.kernel.org
        <mailto:majordomo@vger.kernel.org>
        More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Wed, 06 Nov 2013 18:47:23 -0300
Message-ID: <527AB8EB.2030603@kepler.cl>
References: <52780140.6090409@kepler.cl> <alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net> <52792D7F.20500@kepler.cl> <alpine.DEB.2.00.1311051556550.9474@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:53467 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3KFVr1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 16:47:27 -0500
Received: by mail-qe0-f41.google.com with SMTP id x7so136131qeu.14
        for <ceph-devel@vger.kernel.org>; Wed, 06 Nov 2013 13:47:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311051556550.9474@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello I created the github repository for this project=20
https://github.com/alphe/Ceph4Win

Regards,
signature

*Alph=E9 Salas*
Ingeniero T.I

asalas@kepler.cl
*<http://www.kepler.cl>*
On 11/05/13 21:00, Sage Weil wrote:
> Hi Alphe,
>
> On Tue, 5 Nov 2013, Alphe Salas Michels wrote:
>> signature *Hi, Sage !
>> thank you for you enthousiast reply.
>> I sure want to make the best use of everything or anything previousl=
y done to
>> tend to
>> write ceph cliente for windows.
>>
>> Apart using libre tools for building the future ceph cliente I am op=
en to
>> anything.
>> I would recommand eclipse CDT or Code::BLocks they are based on ming=
win open
>> and easyly enhanceable.**
>>
>> more free tools can be found here:
>> http://www.freebyte.com/programming/cpp/#cppcompilers
>>
>>
>> I will read libcephfs source code and take some notes about the prot=
ocol.
> I think you don't need to worry about hte protocol at all, since libc=
ephs
> implements it for you (and will capture any future changes).
>
>> I was more going from what I know and trying to track down how mount=
=2Eceph work
>> with the parameters passed to it.
>> since it point finally to Kernel/fs/ceph and that I don t really und=
erstand
>> how that module work and that it probably points to some other depen=
dencies
>> Reading libcephfs source code could be a big gain of time.
> (I would also ignore mount.ceph as everything it does it specific to
> how Linux mounts work.)
>
>> basically on the protocol what is  need are:
>>
>> 1) open and maintain a connection (socket open, auth, etc )
>> 2) retreive a map of directories and disk Quota (disk sizing Y TB fr=
ee,  Z TB
>> total)
>> 3) procedure to send files / directories in a maner that it will all=
ow our
>> client to fit ceph transmission protocols
>> (limit bandwith for stability?, limit connection amount?, limit cpu =
use?,
>> Cache for preparing data transfer (a FIFO cache)?)
>> 4)Procedure to retreive files / directory from ceph cluster
>> 5) Management copy/move files /Directories, FS stats, Connection Sta=
ts.
>> logging.
>>
>> My idea to progress is to take those main bulletpoint in ceph protoc=
ol based
>> on general ideas of what ceph file system does and start identifying=
 parts
>> from libcephfs to match those "needs".
> Instead, I would look at include/cephfs/libcephfs.h, the interface th=
at
> libcephfs provides, and try to map that to what the fuse layer expect=
s.
> There is both a path-based that I suspsect lends itself well to the
> Windows interface and (very soon now) a handle based API that is targ=
etted
> at the Unix-style VFS layers.  I'm mostly guessing, though, since I'v=
e
> never seen any low-level fs code in windows before.
>
> In this case, the analogous code for Linux should be client/fuse_ll.c=
c
> itself (and not much else), although there will probably be a few tri=
cks
> necessary to map cleanly onto how the windows interfaces work.
>
> Does that make sense?
>
> Cheers!
> sage
>
>
>> Any suggestion and contributions are welcome.
>>
>>
>> *
>> On 11/05/13 11:23, Sage Weil wrote:
>>> Hi Alphe,
>>>
>>> On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
>>>> Good day developers!
>>>>
>>>> I would like to propose to the one interested  work with me to dev=
elop a
>>>> ceph
>>>> cliente for MS windows world, Basing us on dokanFS.
>>>>
>>>> My company is a ceph enthousiast that use on a dayly basis ceph an=
d that
>>>> need
>>>> both transfer speed and big expendable and cheap storage.
>>>> My company is specialised in data recovery and we want to particip=
ate to
>>>> ceph
>>>> effort by bringing a ceph cliente for windows.
>>> Awesome!
>>>
>>>> Our experience shows us that the best gateway is each clientes bei=
ng its
>>>> own
>>>> gateway, instead of having a bottle neck server or a cluster of bo=
ttle
>>>> neck
>>>> servers as gateway (FTP, samba, SFTP,webdav, s3, etc..).
>>>>
>>>> We already did some research in that domain.
>>>>
>>>> Dokan FS is an intent  to write an opensource fuse like cliente fo=
r MS
>>>> windows.
>>>>
>>>> More information on DOKANFS can be triggered here
>>>> http://dokan-dev.net/en/download/
>>>>
>>>> Positive points of using DOKANFS.
>>>>
>>>> - its opensourced and well licenced mit licence, gpl licence and l=
gpl
>>>> licence.
>>>>
>>>> Negative point of using DOKAN FS.
>>>> - unreachable author
>>>> - Poor documentation . Dev comments in japanese.
>>>> - Work in progress so it is unstable and needs to be updated, debu=
gged and
>>>> maintained by a MS Windows file system expert developper.
>>> I am not very familiar with windows storage APIs, but somebody told=
 me
>>> at once point there were several interfaces against which a new fil=
e
>>> system could be implemented, everything from a full in-kernel drive=
r to
>>> something that is explorer-based.  Are any of those suitable?  Usin=
g a
>>> potentially abandoned fuse-like layer makes me a bit nervous.
>>>
>>> That said,
>>>   =20
>>>> I try past year to do a merge from ceph-fuse to dokanfs
>>>> here are what I learnt.
>>>> - Ceph-fuse and related source code is around 60 000 lines of code=
=2E
>>>> - Ceph protocol isn t documented so it is like trying to draw a ma=
p of
>>>> america
>>>> using only a sextan and a compass.
>>>>
>>>> Those led me to those conclusions:
>>>> - I can t do it alone.
>>>> - It is easier to draw down the ceph protocol way to work from
>>>> kernel/fs/ceph
>>>> sources and mount.ceph
>>>> - Ceph depending libraries may be unexistant or not up to date in =
their
>>>> port
>>>> on MS Windows (cygwin)
>>> I think the most sane path should be to make libcephfs sufficiently
>>> portable to build on windows (or cygwin).  For the bits used by the
>>> client-side coe, I don't think there should be much in the way of
>>> dependencies, and the main challenge would be untangling the build =
for
>>> the necessary pieces out from the rest of Ceph.
>>>
>>> Have you seen the wip-port portability work that is currently under=
way by
>>> Noah and Alan?  That may solve many of the cygwin problems you are =
seeing
>>> today.
>>>
>>>> - MS file system specialist are hard do find in the "open source l=
ibre
>>>> world"
>>>> so I will try in the commercial world.
>>>>
>>>> The commercial world has some problems too. They need ceph protoco=
l draft
>>>> to
>>>> implemente it to their own product They will have licencing /comme=
rcial
>>>> politics that infringe lgpl, and hide that most of the work is don=
e by
>>>> people
>>>> other than them. They will not participate in a financial way to c=
eph
>>>> enhancement and growth.
>>> I don't think reimplementing the client code is an efficient way fo=
rward.
>>> Unless the goal is a pure kernel implementation...but a significant
>>> ongoing investment in development resources would be needed for tha=
t going
>>> forward.  I suspect that is a challenge for a platform that does no=
t
>>> typically rally that sort of community effort.
>>>
>>> The easiest thing is of course just to use CIFS and Samba (which wo=
rks
>>> today).  A fuse-like approach is probably a reasonably middle groun=
d (both
>>> in initial effort and maintainability going forward)...
>>>
>>> sage
>>>
>>>
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

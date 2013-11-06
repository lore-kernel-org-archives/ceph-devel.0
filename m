From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Wed, 06 Nov 2013 11:37:45 -0300
Message-ID: <527A5439.7000706@kepler.cl>
References: <52780140.6090409@kepler.cl> <alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net> <52792D7F.20500@kepler.cl> <alpine.DEB.2.00.1311051556550.9474@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:45431 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102Ab3KFOhu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 09:37:50 -0500
Received: by mail-qe0-f46.google.com with SMTP id s14so6206194qeb.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Nov 2013 06:37:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311051556550.9474@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
When I initially planned past year to  do a client for ceph on windows=20
what I inspected was ceph_fuse.cc
from there I tracked all the related files using a script that read the=
=20
includes precompiler instructions and
retreive the related files from the ceph source code git master branch.=
=20
In the end the work seemed to me gigantic.

Now that we have an open discussion on that topic and that you giveme=20
the libcephfs.h and fuseII.cc hints I will start
by isolate the source code related. I will modify my previous isolate=20
script to do so. I will create a github branch under ceph if that is ok=
=20
with you, to put the documentation, the isolated files and the dev tool=
s=20
related.


Regards,

--- For notes my script working from content and related content=20
ceph_fuse.cc produced this:

find . -name '*' | xargs wc -l
wc: .: Is a directory
       0 .
wc: ./common: Is a directory
       0 ./common
      29 ./common/compiler_extensions.h
      39 ./common/simple_spin.h
      31 ./common/config_obs.h
     481 ./common/admin_socket.cc
      33 ./common/pipe.h
     119 ./common/LogEntry.h
     135 ./common/DoutStreambuf.h
     111 ./common/Cond.h
      42 ./common/code_environment.h
     112 ./common/Formatter.h
     760 ./common/config.cc
      52 ./common/escape.h
     644 ./common/DoutStreambuf.cc
     202 ./common/LogClient.cc
     573 ./common/ConfUtils.cc
     199 ./common/escape.c
      84 ./common/Timer.h
      25 ./common/hex.h
     395 ./common/Formatter.cc
      52 ./common/safe_io.h
      82 ./common/HeartbeatMap.h
      74 ./common/code_environment.cc
      17 ./common/errno.cc
      42 ./common/signal.h
     144 ./common/Mutex.h
      96 ./common/admin_socket.h
      83 ./common/common_init.h
      34 ./common/BackTrace.h
      29 ./common/version.h
      74 ./common/snap_types.h
     238 ./common/ceph_context.cc
      84 ./common/Finisher.cc
      74 ./common/ceph_argparse.h
     187 ./common/utf8.c
      39 ./common/Clock.cc
      50 ./common/Thread.h
     148 ./common/HeartbeatMap.cc
      51 ./common/utf8.h
     160 ./common/Thread.cc
       9 ./common/errno.h
      62 ./common/BackTrace.cc
      39 ./common/hex.cc
     120 ./common/safe_io.c
      27 ./common/Clock.h
     161 ./common/DecayCounter.h
     189 ./common/Timer.cc
     119 ./common/Throttle.h
     126 ./common/strtol.cc
     320 ./common/perf_counters.cc
     119 ./common/LogClient.h
      33 ./common/debug.h
      81 ./common/signal.cc
      44 ./common/pipe.c
     210 ./common/config.h
      24 ./common/static_assert.h
     186 ./common/entity_name.cc
     124 ./common/armor.c
      24 ./common/likely.h
      43 ./common/simple_spin.cc
      73 ./common/ceph_crypto.cc
      79 ./common/entity_name.h
      41 ./common/version.cc
     106 ./common/dout.h
      28 ./common/strtol.h
      86 ./common/ConfUtils.h
      86 ./common/Finisher.h
     108 ./common/LogEntry.cc
     179 ./common/perf_counters.h
      16 ./common/armor.h
      93 ./common/snap_types.cc
     409 ./common/ceph_argparse.cc
     110 ./common/common_init.cc
     114 ./common/ceph_context.h
     160 ./common/ceph_crypto.h
wc: ./msg: Is a directory
       0 ./msg
     623 ./msg/SimpleMessenger.h
     673 ./msg/Message.cc
     263 ./msg/Messenger.h
     478 ./msg/Message.h
     153 ./msg/msg_types.cc
      64 ./msg/Dispatcher.h
    2824 ./msg/SimpleMessenger.cc
     425 ./msg/msg_types.h
wc: ./messages: Is a directory
       0 ./messages
      81 ./messages/MOSDPGCreate.h
      67 ./messages/MRoute.h
      72 ./messages/MForward.h
      83 ./messages/MMonElection.h
      44 ./messages/MPGStatsAck.h
      67 ./messages/MClientSession.h
      65 ./messages/MOSDBoot.h
      90 ./messages/MClientReconnect.h
      69 ./messages/MOSDFailure.h
      78 ./messages/MOSDPing.h
      47 ./messages/MLogAck.h
     206 ./messages/MClientRequest.h
      51 ./messages/MClientCapRelease.h
      57 ./messages/MMonObserve.h
      50 ./messages/MMonSubscribeAck.h
      57 ./messages/MOSDPGMissing.h
      66 ./messages/MClientSnap.h
      55 ./messages/MCommandReply.h
     106 ./messages/MMonProbe.h
      64 ./messages/MOSDPGQuery.h
      85 ./messages/MOSDPGNotify.h
      95 ./messages/MMonSubscribe.h
     223 ./messages/MOSDSubOp.h
      55 ./messages/MGetPoolStatsReply.h
      62 ./messages/MMonObserveNotify.h
      64 ./messages/PaxosServiceMessage.h
      59 ./messages/MMonJoin.h
     101 ./messages/MPoolOp.h
      58 ./messages/MLog.h
      57 ./messages/MAuth.h
      44 ./messages/MStatfsReply.h
      54 ./messages/MMonCommandAck.h
      35 ./messages/MMonGetMap.h
      78 ./messages/MOSDPGLog.h
      52 ./messages/MStatfs.h
      54 ./messages/MOSDPGTrim.h
     172 ./messages/MClientCaps.h
     130 ./messages/MMonPaxos.h
     143 ./messages/MOSDMap.h
     222 ./messages/MOSDOpReply.h
      62 ./messages/MOSDPGRemove.h
      81 ./messages/MOSDPGScan.h
      39 ./messages/MGenericMessage.h
     146 ./messages/MOSDSubOpReply.h
      54 ./messages/MOSDPGInfo.h
      52 ./messages/MOSDPGTemp.h
      70 ./messages/MOSDRepScrub.h
     388 ./messages/MOSDOp.h
      63 ./messages/MClientRequestForward.h
      64 ./messages/MMonGetVersionReply.h
      66 ./messages/MOSDScrub.h
      59 ./messages/MCommand.h
     266 ./messages/MClientReply.h
      58 ./messages/MMonGetVersion.h
      61 ./messages/MPGStats.h
      49 ./messages/MOSDAlive.h
      51 ./messages/MRemoveSnaps.h
      83 ./messages/MClientLease.h
      35 ./messages/MPing.h
      83 ./messages/MOSDPGBackfill.h
      60 ./messages/MMonCommand.h
      80 ./messages/MPoolOpReply.h
      57 ./messages/MGetPoolStats.h
      96 ./messages/MMDSMap.h
      43 ./messages/MMonMap.h
      65 ./messages/MAuthReply.h
      12 ./ceph_ver
     186 ./acconfig
wc: ./osdc: Is a directory
       0 ./osdc
     283 ./osdc/Filer.h
    2023 ./osdc/Objecter.cc
    1774 ./osdc/ObjectCacher.cc
    1479 ./osdc/Objecter.h
     571 ./osdc/rados_bencher.h
     388 ./osdc/Filer.cc
     694 ./osdc/ObjectCacher.h
wc: ./include: Is a directory
       0 ./include
     600 ./include/frag.h
      28 ./include/addr_parsing.h
      43 ./include/ceph_features.h
      18 ./include/page.h
      22 ./include/compat.h
     192 ./include/CompatSet.h
     335 ./include/lru.h
     253 ./include/utime.h
     113 ./include/assert.h
      47 ./include/blobhash.h
      83 ./include/ceph_fs.cc
     786 ./include/encoding.h
     547 ./include/interval_set.h
     312 ./include/Context.h
     499 ./include/buffer.h
     750 ./include/ceph_fs.h
     183 ./include/msgr.h
     124 ./include/atomic.h
      29 ./include/err.h
     225 ./include/filepath.h
      38 ./include/intarith.h
      14 ./include/str_list.h
      13 ./include/color.h
      28 ./include/inttypes.h
     428 ./include/types.h
     150 ./include/addr_parsing.c
     105 ./include/cmp.h
     411 ./include/rados.h
     192 ./include/object.h
     165 ./include/xlist.h
wc: ./client: Is a directory
       0 ./client
     627 ./client/fuse_ll.cc
     661 ./client/Client.h
      15 ./client/fuse_ll.h
    6923 ./client/Client.cc
     177 ./ceph_fuse
wc: ./none: Is a directory
       0 ./none
wc: ./mds: Is a directory
       0 ./mds
     253 ./mds/MDSMap.cc
      74 ./mds/inode_backtrace.h
    1581 ./mds/mdstypes.h
     622 ./mds/MDSMap.h
wc: ./global: Is a directory
       0 ./global
      28 ./global/pidfile.h
      98 ./global/pidfile.cc
      45 ./global/signal_handler.h
     338 ./global/signal_handler.cc
     226 ./global/global_init.cc
      23 ./global/global_context.cc
      64 ./global/global_init.h
      33 ./global/global_context.h
wc: ./json_spirit: Is a directory
       0 ./json_spirit
       8 ./json_spirit/json_spirit_value.cpp
     585 ./json_spirit/json_spirit_value.h
wc: ./cephx: Is a directory
       0 ./cephx
wc: ./os: Is a directory
       0 ./os
      79 ./os/hobject.cc
     639 ./os/ObjectStore.cc
     129 ./os/hobject.h
     738 ./os/ObjectStore.h
    1378 ./rados
wc: ./crush: Is a directory
       0 ./crush
     518 ./crush/CrushWrapper.cc
      47 ./crush/CrushWrapper.i
     427 ./crush/CrushWrapper.h
wc: ./mon: Is a directory
       0 ./mon
     406 ./mon/MonCaps.cc
     106 ./mon/MonCaps.h
      40 ./mon/mon_types.h
     158 ./mon/Session.h
     810 ./mon/MonClient.cc
     267 ./mon/MonClient.h
     130 ./mon/MonMap.cc
     204 ./mon/MonMap.h
wc: ./osd: Is a directory
       0 ./osd
     694 ./osd/OSDMap.h
    1755 ./osd/osd_types.h
    1310 ./osd/OSDMap.cc
    2464 ./osd/osd_types.cc
wc: ./auth: Is a directory
       0 ./auth
      33 ./auth/AuthServiceHandler.cc
     118 ./auth/Crypto.h
      37 ./auth/AuthSupported.h
      44 ./auth/AuthServiceHandler.h
      85 ./auth/KeyRing.h
     437 ./auth/Crypto.cc
      54 ./auth/RotatingKeyRing.h
wc: ./auth/none: Is a directory
       0 ./auth/none
      52 ./auth/none/AuthNoneClientHandler.h
      31 ./auth/none/AuthNoneAuthorizeHandler.h
      41 ./auth/none/AuthNoneServiceHandler.h
      32 ./auth/none/AuthNoneProtocol.h
      39 ./auth/none/AuthNoneAuthorizeHandler.cc
      77 ./auth/RotatingKeyRing.cc
     259 ./auth/KeyRing.cc
      39 ./auth/AuthClientHandler.cc
      89 ./auth/AuthClientHandler.h
wc: ./auth/cephx: Is a directory
       0 ./auth/cephx
      69 ./auth/cephx/CephxClientHandler.h
     505 ./auth/cephx/CephxProtocol.cc
     209 ./auth/cephx/CephxClientHandler.cc
     418 ./auth/cephx/CephxKeyServer.cc
      33 ./auth/cephx/CephxAuthorizeHandler.cc
     203 ./auth/cephx/CephxServiceHandler.cc
     487 ./auth/cephx/CephxProtocol.h
      31 ./auth/cephx/CephxAuthorizeHandler.h
     298 ./auth/cephx/CephxKeyServer.h
      37 ./auth/cephx/CephxServiceHandler.h
     246 ./auth/Auth.h
      51 ./auth/AuthSupported.cc
   63501 total

So ceph_fuse.cc and related files /dependencies as a ceph related only=20
layer involves 63501 lines of source code.
note that fuseII.cc is part of that extraction but libcephfs no.

signature

*Alph=E9 Salas*
Ingeniero T.I

asalas@kepler.cl

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

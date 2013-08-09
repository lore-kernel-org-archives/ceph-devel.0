From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: Help needed porting Ceph to RSockets
Date: Fri, 9 Aug 2013 19:08:20 +0200
Message-ID: <20130809170820.GB4531@oder.mch.fsc.net>
References: <CAJA05UmTDGze7S50_j8RgHmPFYonk2Z94Fi6CQtxND9QxgRr3g@mail.gmail.com>
 <CAJA05Umgio7XftGZtQdRzyWq70pXBb3oEx2jrT3BxcBr6MLoVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:33426 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab3HIRIX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 13:08:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJA05Umgio7XftGZtQdRzyWq70pXBb3oEx2jrT3BxcBr6MLoVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Anderson <manderson8787@gmail.com>
Cc: ceph-devel@vger.kernel.org, Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, Andrey Korolyov <andrey@xdel.ru>

Hi Matthew,

please have a look at:=20
http://www.spinics.net/lists/linux-rdma/msg16710.html
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/msgr%3A_implement_=
infiniband_support_via_rsockets

Maybe you should switch this discussion from ceph-user to the ceph-deve=
l ML.

Kind Regards,
-Dieter

On Fri, Aug 09, 2013 at 09:11:07AM +0200, Matthew Anderson wrote:
>    So I've had a chance to re-visit this since B=E9choley Alexandre w=
as kind     =20
>    enough to let me know how to compile Ceph with the RDMACM library =
          =20
>    (thankyou again!).                                                =
          =20
>                                                                      =
          =20
>    At this stage it compiles and runs but there appears to be a probl=
em with   =20
>    calling rshutdown in Pipe as it seems to just wait forever for the=
 pipe to  =20
>    close which causes commands like 'ceph osd tree' to hang indefinit=
ely       =20
>    after they work successfully. Debug MS is here -                  =
          =20
>    [1]http://pastebin.com/WzMJNKZY                                   =
          =20
>                                                                      =
          =20
>    I also tried RADOS bench but it appears to be doing something simi=
lar.      =20
>    Debug MS is here - [2]http://pastebin.com/3aXbjzqS                =
          =20
>                                                                      =
          =20
>    It seems like it's very close to working... I must be missing some=
thing     =20
>    small that's causing some grief. You can see the OSD coming up in =
the ceph  =20
>    monitor and the PG's all become active+clean. When shutting down t=
he        =20
>    monitor I get the below which show's it waiting for the pipes to c=
lose -    =20
>                                                                      =
          =20
>    2013-08-09 15:08:31.339394 7f4643cfd700 20 accepter.accepter closi=
ng        =20
>    2013-08-09 15:08:31.382075 7f4643cfd700 10 accepter.accepter stopp=
ing       =20
>    2013-08-09 15:08:31.382115 7f464bd397c0 20 -- [3]172.16.0.1:6789/0=
 wait:    =20
>    stopped accepter thread                                           =
          =20
>    2013-08-09 15:08:31.382127 7f464bd397c0 20 -- [4]172.16.0.1:6789/0=
 wait:    =20
>    stopping reaper thread                                            =
          =20
>    2013-08-09 15:08:31.382146 7f4645500700 10 -- [5]172.16.0.1:6789/0=
          =20
>    reaper_entry done                                                 =
          =20
>    2013-08-09 15:08:31.382182 7f464bd397c0 20 -- [6]172.16.0.1:6789/0=
 wait:    =20
>    stopped reaper thread                                             =
          =20
>    2013-08-09 15:08:31.382194 7f464bd397c0 10 -- [7]172.16.0.1:6789/0=
 wait:    =20
>    closing pipes                                                     =
          =20
>    2013-08-09 15:08:31.382200 7f464bd397c0 10 -- [8]172.16.0.1:6789/0=
 reaper   =20
>    2013-08-09 15:08:31.382205 7f464bd397c0 10 -- [9]172.16.0.1:6789/0=
 reaper   =20
>    done                                                              =
          =20
>    2013-08-09 15:08:31.382210 7f464bd397c0 10 -- [10]172.16.0.1:6789/=
0 wait:   =20
>    waiting for pipes 0x3014c80,0x3015180,0x3015400 to close          =
          =20
>                                                                      =
          =20
>    The git repo has been updated if anyone has a few spare minutes to=
 take a   =20
>    look - [11]https://github.com/funkBuild/ceph-rsockets             =
          =20
>                                                                      =
          =20
>    Thanks again                                                      =
          =20
>    -Matt                                                             =
          =20
>                                                                      =
          =20
>    On Thu, Jun 20, 2013 at 5:09 PM, Matthew Anderson                 =
          =20
>    <[12]manderson8787@gmail.com> wrote:                              =
          =20
>                                                                      =
          =20
>      Hi All,                                                         =
          =20
>      I've had a few conversations on IRC about getting RDMA support i=
nto Ceph  =20
>      and thought I would give it a quick attempt to hopefully spur so=
me        =20
>      interest. What I would like to accomplish is an RSockets only   =
          =20
>      implementation so I'm able to use Ceph, RBD and QEMU at full spe=
ed over   =20
>      an Infiniband fabric.                                           =
          =20
>      What I've tried to do is port Pipe.cc and Acceptor.cc to rsocket=
s by      =20
>      replacing the regular socket calls with the rsocket equivalent. =
          =20
>      Unfortunately it doesn't compile and I get an error of -        =
          =20
>       CXXLD  ceph-osd                                                =
          =20
>      ./.libs/libglobal.a(libcommon_la-Accepter.o): In function       =
          =20
>      `Accepter::stop()':                                             =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:243:=
          =20
>      undefined reference to `rshutdown'                              =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:251:=
          =20
>      undefined reference to `rclose'                                 =
          =20
>      ./.libs/libglobal.a(libcommon_la-Accepter.o): In function       =
          =20
>      `Accepter::entry()':                                            =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:213:=
          =20
>      undefined reference to `raccept'                                =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:230:=
          =20
>      undefined reference to `rclose'                                 =
          =20
>      ./.libs/libglobal.a(libcommon_la-Accepter.o): In function       =
          =20
>      `Accepter::bind(entity_addr_t const&, int, int)':               =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:61: =
          =20
>      undefined reference to `rsocket'                                =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:80: =
          =20
>      undefined reference to `rsetsockopt'                            =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:87: =
          =20
>      undefined reference to `rbind'                                  =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:118:=
          =20
>      undefined reference to `rgetsockname'                           =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:128:=
          =20
>      undefined reference to `rlisten'                                =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:100:=
          =20
>      undefined reference to `rbind'                                  =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Accepter.cc:87: =
          =20
>      undefined reference to `rbind'                                  =
          =20
>      ./.libs/libglobal.a(libcommon_la-Pipe.o): In function           =
          =20
>      `Pipe::tcp_write(char const*, int)':                            =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:2175: un=
defined   =20
>      reference to `rsend'                                            =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:2162: un=
defined   =20
>      reference to `rshutdown'                                        =
          =20
>      ./.libs/libglobal.a(libcommon_la-Pipe.o): In function           =
          =20
>      `Pipe::do_sendmsg(msghdr*, int, bool)':                         =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:1867: un=
defined   =20
>      reference to `rsendmsg'                                         =
          =20
>      ./.libs/libglobal.a(libcommon_la-Pipe.o): In function           =
          =20
>      `Pipe::tcp_read_nonblocking(char*, int)':                       =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:2129: un=
defined   =20
>      reference to `rrecv'                                            =
          =20
>      ./.libs/libglobal.a(libcommon_la-Pipe.o): In function           =
          =20
>      `Pipe::tcp_read(char*, int)':                                   =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:2079: un=
defined   =20
>      reference to `rshutdown'                                        =
          =20
>      ./.libs/libglobal.a(libcommon_la-Pipe.o): In function `Pipe::con=
nect()':  =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:768: und=
efined    =20
>      reference to `rclose'                                           =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:773: und=
efined    =20
>      reference to `rsocket'                                          =
          =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:781: und=
efined    =20
>      reference to `rconnect'                                         =
          =20
>      ./.libs/libglobal.a(libcommon_la-Pipe.o): In function `Pipe::wri=
ter()':   =20
>      /home/matt/Desktop/ceph-0.61.3-rsockets/src/msg/Pipe.cc:1471: un=
defined   =20
>      reference to `rwrite'                                           =
          =20
>      collect2: error: ld returned 1 exit status                      =
          =20
>      make[3]: *** [ceph-mon] Error 1                                 =
          =20
>      From the looks of it I need to include the 'rdma/rsocket.h' libr=
ary       =20
>      somewhere else or add librdmacm but I'm not sure where.         =
          =20
>      Full disclaimer, I am terrible at C++. If anyone has a few spare=
 minutes  =20
>      to have a look into the error messages and can point out where I=
've gone  =20
>      wrong it would be greatly appreciated.                          =
          =20
>      I've put the code up at - [13]https://github.com/funkBuild/ceph-=
rsockets  =20
>      Thanks again                                                    =
          =20
>      -Matt                                                           =
          =20
>=20
> References
>=20
>    Visible links
>    1. http://pastebin.com/WzMJNKZY
>    2. http://pastebin.com/3aXbjzqS
>    3. http://172.16.0.1:6789/0
>    4. http://172.16.0.1:6789/0
>    5. http://172.16.0.1:6789/0
>    6. http://172.16.0.1:6789/0
>    7. http://172.16.0.1:6789/0
>    8. http://172.16.0.1:6789/0
>    9. http://172.16.0.1:6789/0
>   10. http://172.16.0.1:6789/0
>   11. https://github.com/funkBuild/ceph-rsockets
>   12. mailto:manderson8787@gmail.com
>   13. https://github.com/funkBuild/ceph-rsockets

> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

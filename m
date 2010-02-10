From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: csyn problem with multiple clients
Date: Wed, 10 Feb 2010 12:19:29 -0800
Message-ID: <1471eea71002101219t45e9e779g266c9a7fe2b994f6@mail.gmail.com>
References: <587488.7340.qm@web7908.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <587488.7340.qm@web7908.mail.in.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Amarnath BS <bsamarnath@yahoo.co.in>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hrm, it looks like csyn or some aspect of messaging was broken in the
v.18 release. However, I've confirmed that it works (at least that
command does) in the latest unstable version.
If you're just evaluating Ceph right now; I'd recommend doing so with
the unstable release in git, as a number of reasonably significant
enhancements have been made, especially in the messaging subsystem
where this error occurred. :)
-Greg

On Wed, Feb 10, 2010 at 2:31 AM, Amarnath BS <bsamarnath@yahoo.co.in> wrote:
>
> Hello,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 when i run csyn for many clients
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 > csyn --syn writefile 1 10000 1 --debu=
g_objecter 20 --num_client 10
> =A0=A0=A0=A0 i get error like
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 starting csyn at 0=
.0.0.0:6809/947/0
> mounting and starting 10 syn client(s)
> waiting for client(s) to finish
> 10.02.11 16:03:23.408658 unhandled message 0x82178c8 osd_map(4,4) from mo=
n0 192.168.1.101:6789/0/0
> ./msg/Dispatcher.h: In function 'virtual void Dispatcher::dispatch(Messag=
e*)':
> ./msg/Dispatcher.h:43: FAILED assert(0)
> =A01: csyn(_ZN10Dispatcher8dispatchEP7Message+0x3e7) [0x8086c97]
> =A02: csyn(_ZN15SimpleMessenger8Endpoint14dispatch_entryEv+0x368) [0x808a=
d38]
> =A03: csyn(_ZN15SimpleMessenger8Endpoint14DispatchThread5entryEv+0x14) [0=
x8099624]
> =A04: csyn(_ZN6Thread11_entry_funcEPv+0x13) [0x8099283]
> =A05: /lib/tls/i686/cmov/libpthread.so.0 [0xb782880e]
> =A06: /lib/tls/i686/cmov/libc.so.6(clone+0x5e) [0xb76738de]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.
> ./msg/Dispatcher.h: In function 'virtual void Dispatcher::dispatch(Messag=
e*)':
> ./msg/Dispatcher.h:43: FAILED assert(0)
> =A01: csyn(_ZN10Dispatcher8dispatchEP7Message+0x3e7) [0x8086c97]
> =A02: csyn(_ZN15SimpleMessenger8Endpoint14dispatch_entryEv+0x368) [0x808a=
d38]
> =A03: csyn(_ZN15SimpleMessenger8Endpoint14DispatchThread5entryEv+0x14) [0=
x8099624]
> =A04: csyn(_ZN6Thread11_entry_funcEPv+0x13) [0x8099283]
> =A05: /lib/tls/i686/cmov/libpthread.so.0 [0xb782880e]
> =A06: /lib/tls/i686/cmov/libc.so.6(clone+0x5e) [0xb76738de]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.
> terminate called after throwing an instance of 'FailedAssertion*'
> Aborted
> Please help me how to handle this.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ---Amarnath
>
>
> ________________________________
> The INTERNET now has a personality. YOURS! See your Yahoo! Homepage.
> -------------------------------------------------------------------------=
-----
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev

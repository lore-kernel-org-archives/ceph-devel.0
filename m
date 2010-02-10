From: Amarnath BS <bsamarnath@yahoo.co.in>
Subject: csyn problem with multiple clients
Date: Wed, 10 Feb 2010 16:01:11 +0530 (IST)
Message-ID: <587488.7340.qm@web7908.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6833523311757740134=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--===============6833523311757740134==
Content-Type: multipart/alternative; boundary="0-1216538824-1265797871=:7340"

--0-1216538824-1265797871=:7340
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,
=A0=A0=A0=A0=A0=A0=A0=A0=A0 when i run csyn for many clients=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 > csyn --syn writefile 1 10000 1 --debug_=
objecter 20 --num_client 10
=A0=A0=A0=A0 i get error like
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 starting csyn at 0.0=
.0.0:6809/947/0
mounting and starting 10 syn client(s)
waiting for client(s) to finish
10.02.11 16:03:23.408658 unhandled message 0x82178c8 osd_map(4,4) from mon0=
 192.168.1.101:6789/0/0
./msg/Dispatcher.h: In function 'virtual void Dispatcher::dispatch(Message*=
)':
./msg/Dispatcher.h:43: FAILED assert(0)
=A01: csyn(_ZN10Dispatcher8dispatchEP7Message+0x3e7) [0x8086c97]
=A02: csyn(_ZN15SimpleMessenger8Endpoint14dispatch_entryEv+0x368) [0x808ad3=
8]
=A03: csyn(_ZN15SimpleMessenger8Endpoint14DispatchThread5entryEv+0x14) [0x8=
099624]
=A04: csyn(_ZN6Thread11_entry_funcEPv+0x13) [0x8099283]
=A05: /lib/tls/i686/cmov/libpthread.so.0 [0xb782880e]
=A06: /lib/tls/i686/cmov/libc.so.6(clone+0x5e) [0xb76738de]
=A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed=
 to interpret this.
./msg/Dispatcher.h: In function 'virtual void Dispatcher::dispatch(Message*=
)':
./msg/Dispatcher.h:43: FAILED assert(0)
=A01: csyn(_ZN10Dispatcher8dispatchEP7Message+0x3e7) [0x8086c97]
=A02: csyn(_ZN15SimpleMessenger8Endpoint14dispatch_entryEv+0x368) [0x808ad3=
8]
=A03: csyn(_ZN15SimpleMessenger8Endpoint14DispatchThread5entryEv+0x14) [0x8=
099624]
=A04: csyn(_ZN6Thread11_entry_funcEPv+0x13) [0x8099283]
=A05: /lib/tls/i686/cmov/libpthread.so.0 [0xb782880e]
=A06: /lib/tls/i686/cmov/libc.so.6(clone+0x5e) [0xb76738de]
=A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed=
 to interpret this.
terminate called after throwing an instance of 'FailedAssertion*'
Aborted
Please help me how to handle this.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 --=
-Amarnath

=0A=0A=0A      Your Mail works best with the New Yahoo Optimized IE8. Get i=
t NOW! http://downloads.yahoo.com/in/internetexplorer/
--0-1216538824-1265797871=:7340
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hello,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; when i run csyn for many clients <br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; csyn --syn writefile =
1 10000 1 --debug_objecter 20 --num_client 10<br>&nbsp;&nbsp;&nbsp;&nbsp; i=
 get error like<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; starting csyn at 0.0.0=
.0:6809/947/0<br>mounting and starting 10 syn client(s)<br>waiting for clie=
nt(s) to finish<br>10.02.11 16:03:23.408658 unhandled message 0x82178c8 osd=
_map(4,4) from mon0 192.168.1.101:6789/0/0<br>./msg/Dispatcher.h: In functi=
on 'virtual void Dispatcher::dispatch(Message*)':<br>./msg/Dispatcher.h:43:=
 FAILED assert(0)<br>&nbsp;1: csyn(_ZN10Dispatcher8dispatchEP7Message+0x3e7=
) [0x8086c97]<br>&nbsp;2:
 csyn(_ZN15SimpleMessenger8Endpoint14dispatch_entryEv+0x368) [0x808ad38]<br=
>&nbsp;3: csyn(_ZN15SimpleMessenger8Endpoint14DispatchThread5entryEv+0x14) =
[0x8099624]<br>&nbsp;4: csyn(_ZN6Thread11_entry_funcEPv+0x13) [0x8099283]<b=
r>&nbsp;5: /lib/tls/i686/cmov/libpthread.so.0 [0xb782880e]<br>&nbsp;6: /lib=
/tls/i686/cmov/libc.so.6(clone+0x5e) [0xb76738de]<br>&nbsp;NOTE: a copy of =
the executable, or `objdump -rdS &lt;executable&gt;` is needed to interpret=
 this.<br>./msg/Dispatcher.h: In function 'virtual void Dispatcher::dispatc=
h(Message*)':<br>./msg/Dispatcher.h:43: FAILED assert(0)<br>&nbsp;1: csyn(_=
ZN10Dispatcher8dispatchEP7Message+0x3e7) [0x8086c97]<br>&nbsp;2: csyn(_ZN15=
SimpleMessenger8Endpoint14dispatch_entryEv+0x368) [0x808ad38]<br>&nbsp;3: c=
syn(_ZN15SimpleMessenger8Endpoint14DispatchThread5entryEv+0x14) [0x8099624]=
<br>&nbsp;4: csyn(_ZN6Thread11_entry_funcEPv+0x13) [0x8099283]<br>&nbsp;5: =
/lib/tls/i686/cmov/libpthread.so.0 [0xb782880e]<br>&nbsp;6:
 /lib/tls/i686/cmov/libc.so.6(clone+0x5e) [0xb76738de]<br>&nbsp;NOTE: a cop=
y of the executable, or `objdump -rdS &lt;executable&gt;` is needed to inte=
rpret this.<br>terminate called after throwing an instance of 'FailedAssert=
ion*'<br>Aborted<br>Please help me how to handle this.<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---Amarnath<br><br></t=
d></tr></table><br>=0A=0A=0A=0A      <!--1--><hr size=3D1></hr> =0AThe INTE=
RNET now has a personality. YOURS! <a href=3D"http://in.rd.yahoo.com/taglin=
e_yyi_1/*http://in.yahoo.com/" target=3D"_blank">See your Yahoo! Homepage</=
a>.
--0-1216538824-1265797871=:7340--


--===============6833523311757740134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============6833523311757740134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============6833523311757740134==--

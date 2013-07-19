From: Dan van der Ster <daniel.vanderster-vJEk5272eHo@public.gmane.org>
Subject: Re: v0.61.5 Cuttlefish update released
Date: Fri, 19 Jul 2013 09:56:50 +0200
Message-ID: <7E62B915D06C44CF9930B97632A0D05B@cern.ch>
References: <alpine.DEB.2.00.1307180944270.7945@cobra.newdream.net>
	<alpine.DEB.2.00.1307182254010.28090@cobra.newdream.net>
	<51E8E3B3.8020300@profihost.ag> <51E8E409.8020201@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1736346138=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51E8E409.8020201-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1736346138==
Content-Type: multipart/alternative; boundary="51e8f142_100f59dc_111a2"

--51e8f142_100f59dc_111a2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Was that 0.61.4 -> 0.61.5? Our upgrade of all mons and osds on SL6.4 went without incident.
--
dan


-- 
Dan van der Ster
CERN IT-DSS


On Friday, July 19, 2013 at 9:00 AM, Stefan Priebe - Profihost AG wrote:

> crash is this one:
> 
> 2013-07-19 08:59:32.137646 7f484a872780 0 ceph version
> 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b), process
> ceph-mon, pid 22172
> 2013-07-19 08:59:32.173975 7f484a872780 -1 mon/OSDMonitor.cc (http://OSDMonitor.cc): In
> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
> 7f484a872780 time 2013-07-19 08:59:32.173506
> mon/OSDMonitor.cc (http://OSDMonitor.cc): 132: FAILED assert(latest_bl.length() != 0)
> 
> ceph version 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b)
> 1: (OSDMonitor::update_from_paxos(bool*)+0x16e1) [0x51d341]
> 2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
> 3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
> 4: (Monitor::init_paxos()+0xe5) [0x48f955]
> 5: (Monitor::preinit()+0x679) [0x4bba79]
> 6: (main()+0x36b0) [0x484bb0]
> 7: (__libc_start_main()+0xfd) [0x7f48489cec8d]
> 8: /usr/bin/ceph-mon() [0x4801e9]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> --- begin dump of recent events ---
> -13> 2013-07-19 08:59:32.136172 7f484a872780 5 asok(0x131a000)
> register_command perfcounters_dump hook 0x1304010
> -12> 2013-07-19 08:59:32.136191 7f484a872780 5 asok(0x131a000)
> register_command 1 hook 0x1304010
> -11> 2013-07-19 08:59:32.136194 7f484a872780 5 asok(0x131a000)
> register_command perf dump hook 0x1304010
> -10> 2013-07-19 08:59:32.136200 7f484a872780 5 asok(0x131a000)
> register_command perfcounters_schema hook 0x1304010
> -9> 2013-07-19 08:59:32.136204 7f484a872780 5 asok(0x131a000)
> register_command 2 hook 0x1304010
> -8> 2013-07-19 08:59:32.136206 7f484a872780 5 asok(0x131a000)
> register_command perf schema hook 0x1304010
> -7> 2013-07-19 08:59:32.136208 7f484a872780 5 asok(0x131a000)
> register_command config show hook 0x1304010
> -6> 2013-07-19 08:59:32.136211 7f484a872780 5 asok(0x131a000)
> register_command config set hook 0x1304010
> -5> 2013-07-19 08:59:32.136214 7f484a872780 5 asok(0x131a000)
> register_command log flush hook 0x1304010
> -4> 2013-07-19 08:59:32.136216 7f484a872780 5 asok(0x131a000)
> register_command log dump hook 0x1304010
> -3> 2013-07-19 08:59:32.136219 7f484a872780 5 asok(0x131a000)
> register_command log reopen hook 0x1304010
> -2> 2013-07-19 08:59:32.137646 7f484a872780 0 ceph version
> 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b), process
> ceph-mon, pid 22172
> -1> 2013-07-19 08:59:32.137967 7f484a872780 1 finished
> global_init_daemonize
> 0> 2013-07-19 08:59:32.173975 7f484a872780 -1 mon/OSDMonitor.cc (http://OSDMonitor.cc): In
> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
> 7f484a872780 time 2013-07-19 08:59:32.173506
> mon/OSDMonitor.cc (http://OSDMonitor.cc): 132: FAILED assert(latest_bl.length() != 0)
> 
> ceph version 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b)
> 1: (OSDMonitor::update_from_paxos(bool*)+0x16e1) [0x51d341]
> 2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
> 3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
> 4: (Monitor::init_paxos()+0xe5) [0x48f955]
> 5: (Monitor::preinit()+0x679) [0x4bba79]
> 6: (main()+0x36b0) [0x484bb0]
> 7: (__libc_start_main()+0xfd) [0x7f48489cec8d]
> 8: /usr/bin/ceph-mon() [0x4801e9]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> Mi
> 
> Am 19.07.2013 08:58, schrieb Stefan Priebe - Profihost AG:
> > All mons do not work anymore:
> > 
> > === mon.a ===
> > Starting Ceph mon.a on ccad...
> > [21207]: (33) Numerical argument out of domain
> > failed: 'ulimit -n 8192; /usr/bin/ceph-mon -i a --pid-file
> > /var/run/ceph/mon.a.pid -c /etc/ceph/ceph.conf '
> > 
> > Stefan
> > 
> > Am 19.07.2013 07:59, schrieb Sage Weil:
> > > A note on upgrading:
> > > 
> > > One of the fixes in 0.61.5 is with a 32bit vs 64bit bug with the feature 
> > > bits. We did not realize it before, but the fix will prevent 0.61.4 (or 
> > > earlier) from forming a quorum with 0.61.5. This is similar to the upgrade 
> > > from bobtail (and the future upgrade to dumpling). As such, we recommend 
> > > you upgrade all monitors at once to avoid the potential for discruption in 
> > > service.
> > > 
> > > I'm adding a note to the release notes.
> > > 
> > > Thanks!
> > > sage
> > > 
> > > 
> > > On Thu, 18 Jul 2013, Sage Weil wrote:
> > > 
> > > > We've prepared another update for the Cuttlefish v0.61.x series. This 
> > > > release primarily contains monitor stability improvements, although there 
> > > > are also some important fixes for ceph-osd for large clusters and a few 
> > > > important CephFS fixes. We recommend that all v0.61.x users upgrade.
> > > > 
> > > > * mon: misc sync improvements (faster, more reliable, better tuning)
> > > > * mon: enable leveldb cache by default (big performance improvement)
> > > > * mon: new scrub feature (primarily for diagnostic, testing purposes)
> > > > * mon: fix occasional leveldb assertion on startup
> > > > * mon: prevent reads until initial state is committed
> > > > * mon: improved logic for trimming old osdmaps
> > > > * mon: fix pick_addresses bug when expanding mon cluster
> > > > * mon: several small paxos fixes, improvements
> > > > * mon: fix bug osdmap trim behavior
> > > > * osd: fix several bugs with PG stat reporting
> > > > * osd: limit number of maps shared with peers (which could cause domino failures)
> > > > * rgw: fix radosgw-admin buckets list (for all buckets)
> > > > * mds: fix occasional client failure to reconnect
> > > > * mds: fix bad list traversal after unlink
> > > > * mds: fix underwater dentry cleanup (occasional crash after mds restart)
> > > > * libcephfs, ceph-fuse: fix occasional hangs on umount
> > > > * libcephfs, ceph-fuse: fix old bug with O_LAZY vs O_NOATIME confusion
> > > > * ceph-disk: more robust journal device detection on RHEL/CentOS
> > > > * ceph-disk: better, simpler locking
> > > > * ceph-disk: do not inadvertantely mount over existing osd mounts
> > > > * ceph-disk: better handling for unusual device names
> > > > * sysvinit, upstart: handle symlinks in /var/lib/ceph/*
> > > > 
> > > > Please also refer to the complete release notes:
> > > > 
> > > > http://ceph.com/docs/master/release-notes/#v0-61-5-cuttlefish
> > > > 
> > > > You can get v0.61.5 from the usual locations:
> > > > 
> > > > * Git at git://github.com/ceph/ceph.git (http://github.com/ceph/ceph.git)
> > > > * Tarball at http://ceph.com/download/ceph-0.61.5.tar.gz
> > > > * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
> > > > * For RPMs, see http://ceph.com/docs/master/install/rpm
> > > > 
> > > 
> > > _______________________________________________
> > > ceph-users mailing list
> > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org (mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)
> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > 
> > 
> > 
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org (mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 



--51e8f142_100f59dc_111a2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div style=3D=22font-family: Helvetica; font-size: 13px; =
=22>Was that 0.61.4 -&gt; 0.61.5=3F Our upgrade of all mons and osds on S=
L6.4 went without incident.<div>--</div><div>dan</div></div>
                <div><div><br></div><div>--&nbsp;</div><div>Dan van der S=
ter</div><div>CERN IT-DSS</div><div><br></div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On =46riday, July 19, =
2013 at 9:00 AM, Stefan Priebe - Profihost AG wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div>crash is this one:</div><div><br=
></div><div>2013-07-19 08:59:32.137646 7f484a872780  0 ceph version</div>=
<div>0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b), proce=
ss</div><div>ceph-mon, pid 22172</div><div>2013-07-19 08:59:32.173975 7f4=
84a872780 -1 mon/<a href=3D=22http://OSDMonitor.cc=22>OSDMonitor.cc</a>: =
In</div><div>function 'virtual void OSDMonitor::update=5Ffrom=5Fpaxos(boo=
l*)' thread</div><div>7f484a872780 time 2013-07-19 08:59:32.173506</div><=
div>mon/<a href=3D=22http://OSDMonitor.cc=22>OSDMonitor.cc</a>: 132: =46A=
ILED assert(latest=5Fbl.length() =21=3D 0)</div><div><br></div><div> ceph=
 version 0.61.5-17-g83f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b)</d=
iv><div> 1: (OSDMonitor::update=5Ffrom=5Fpaxos(bool*)+0x16e1) =5B0x51d341=
=5D</div><div> 2: (PaxosService::refresh(bool*)+0xe6) =5B0x4f2c66=5D</div=
><div> 3: (Monitor::refresh=5Ffrom=5Fpaxos(bool*)+0x57) =5B0x48f7b7=5D</d=
iv><div> 4: (Monitor::init=5Fpaxos()+0xe5) =5B0x48f955=5D</div><div> 5: (=
Monitor::preinit()+0x679) =5B0x4bba79=5D</div><div> 6: (main()+0x36b0) =5B=
0x484bb0=5D</div><div> 7: (=5F=5Flibc=5Fstart=5Fmain()+0xfd) =5B0x7f48489=
cec8d=5D</div><div> 8: /usr/bin/ceph-mon() =5B0x4801e9=5D</div><div> NOTE=
: a copy of the executable, or =60objdump -rdS &lt;executable&gt;=60 is</=
div><div>needed to interpret this.</div><div><br></div><div>--- begin dum=
p of recent events ---</div><div>   -13&gt; 2013-07-19 08:59:32.136172 7f=
484a872780  5 asok(0x131a000)</div><div>register=5Fcommand perfcounters=5F=
dump hook 0x1304010</div><div>   -12&gt; 2013-07-19 08:59:32.136191 7f484=
a872780  5 asok(0x131a000)</div><div>register=5Fcommand 1 hook 0x1304010<=
/div><div>   -11&gt; 2013-07-19 08:59:32.136194 7f484a872780  5 asok(0x13=
1a000)</div><div>register=5Fcommand perf dump hook 0x1304010</div><div>  =
 -10&gt; 2013-07-19 08:59:32.136200 7f484a872780  5 asok(0x131a000)</div>=
<div>register=5Fcommand perfcounters=5Fschema hook 0x1304010</div><div>  =
  -9&gt; 2013-07-19 08:59:32.136204 7f484a872780  5 asok(0x131a000)</div>=
<div>register=5Fcommand 2 hook 0x1304010</div><div>    -8&gt; 2013-07-19 =
08:59:32.136206 7f484a872780  5 asok(0x131a000)</div><div>register=5Fcomm=
and perf schema hook 0x1304010</div><div>    -7&gt; 2013-07-19 08:59:32.1=
36208 7f484a872780  5 asok(0x131a000)</div><div>register=5Fcommand config=
 show hook 0x1304010</div><div>    -6&gt; 2013-07-19 08:59:32.136211 7f48=
4a872780  5 asok(0x131a000)</div><div>register=5Fcommand config set hook =
0x1304010</div><div>    -5&gt; 2013-07-19 08:59:32.136214 7f484a872780  5=
 asok(0x131a000)</div><div>register=5Fcommand log flush hook 0x1304010</d=
iv><div>    -4&gt; 2013-07-19 08:59:32.136216 7f484a872780  5 asok(0x131a=
000)</div><div>register=5Fcommand log dump hook 0x1304010</div><div>    -=
3&gt; 2013-07-19 08:59:32.136219 7f484a872780  5 asok(0x131a000)</div><di=
v>register=5Fcommand log reopen hook 0x1304010</div><div>    -2&gt; 2013-=
07-19 08:59:32.137646 7f484a872780  0 ceph version</div><div>0.61.5-17-g8=
3f8b88 (83f8b88e5be41371cb77b39c0966e79cad92087b), process</div><div>ceph=
-mon, pid 22172</div><div>    -1&gt; 2013-07-19 08:59:32.137967 7f484a872=
780  1 finished</div><div>global=5Finit=5Fdaemonize</div><div>     0&gt; =
2013-07-19 08:59:32.173975 7f484a872780 -1 mon/<a href=3D=22http://OSDMon=
itor.cc=22>OSDMonitor.cc</a>: In</div><div>function 'virtual void OSDMoni=
tor::update=5Ffrom=5Fpaxos(bool*)' thread</div><div>7f484a872780 time 201=
3-07-19 08:59:32.173506</div><div>mon/<a href=3D=22http://OSDMonitor.cc=22=
>OSDMonitor.cc</a>: 132: =46AILED assert(latest=5Fbl.length() =21=3D 0)</=
div><div><br></div><div> ceph version 0.61.5-17-g83f8b88 (83f8b88e5be4137=
1cb77b39c0966e79cad92087b)</div><div> 1: (OSDMonitor::update=5Ffrom=5Fpax=
os(bool*)+0x16e1) =5B0x51d341=5D</div><div> 2: (PaxosService::refresh(boo=
l*)+0xe6) =5B0x4f2c66=5D</div><div> 3: (Monitor::refresh=5Ffrom=5Fpaxos(b=
ool*)+0x57) =5B0x48f7b7=5D</div><div> 4: (Monitor::init=5Fpaxos()+0xe5) =5B=
0x48f955=5D</div><div> 5: (Monitor::preinit()+0x679) =5B0x4bba79=5D</div>=
<div> 6: (main()+0x36b0) =5B0x484bb0=5D</div><div> 7: (=5F=5Flibc=5Fstart=
=5Fmain()+0xfd) =5B0x7f48489cec8d=5D</div><div> 8: /usr/bin/ceph-mon() =5B=
0x4801e9=5D</div><div> NOTE: a copy of the executable, or =60objdump -rdS=
 &lt;executable&gt;=60 is</div><div>needed to interpret this.</div><div><=
br></div><div>Mi</div><div><br></div><div>Am 19.07.2013 08:58, schrieb St=
efan Priebe - Profihost AG:</div><blockquote type=3D=22cite=22><div><div>=
All mons do not work anymore:</div><div><br></div><div>=3D=3D=3D mon.a =3D=
=3D=3D</div><div>Starting Ceph mon.a on ccad...</div><div>=5B21207=5D: (3=
3) Numerical argument out of domain</div><div>failed: 'ulimit -n 8192;  /=
usr/bin/ceph-mon -i a --pid-file</div><div>/var/run/ceph/mon.a.pid -c /et=
c/ceph/ceph.conf '</div><div><br></div><div>Stefan</div><div><br></div><d=
iv>Am 19.07.2013 07:59, schrieb Sage Weil:</div><blockquote type=3D=22cit=
e=22><div><div>A note on upgrading:</div><div><br></div><div>One of the f=
ixes in 0.61.5 is with a 32bit vs 64bit bug with the feature </div><div>b=
its.  We did not realize it before, but the fix will prevent 0.61.4 (or <=
/div><div>earlier) from forming a quorum with 0.61.5. This is similar to =
the upgrade </div><div>from bobtail (and the future upgrade to dumpling).=
 As such, we recommend </div><div>you upgrade all monitors at once to avo=
id the potential for discruption in </div><div>service.</div><div><br></d=
iv><div>I'm adding a note to the release notes.</div><div><br></div><div>=
Thanks=21</div><div>sage</div><div><br></div><div><br></div><div>On Thu, =
18 Jul 2013, Sage Weil wrote:</div><div><br></div><blockquote type=3D=22c=
ite=22><div><div>We've prepared another update for the Cuttlefish v0.61.x=
 series. This </div><div>release primarily contains monitor stability imp=
rovements, although there </div><div>are also some important fixes for ce=
ph-osd for large clusters and a few </div><div>important Ceph=46S fixes. =
We recommend that all v0.61.x users upgrade.</div><div><br></div><div> * =
mon: misc sync improvements (faster, more reliable, better tuning)</div><=
div> * mon: enable leveldb cache by default (big performance improvement)=
</div><div> * mon: new scrub feature (primarily for diagnostic, testing p=
urposes)</div><div> * mon: fix occasional leveldb assertion on startup</d=
iv><div> * mon: prevent reads until initial state is committed</div><div>=
 * mon: improved logic for trimming old osdmaps</div><div> * mon: fix pic=
k=5Faddresses bug when expanding mon cluster</div><div> * mon: several sm=
all paxos fixes, improvements</div><div> * mon: fix bug osdmap trim behav=
ior</div><div> * osd: fix several bugs with PG stat reporting</div><div> =
* osd: limit number of maps shared with peers (which could cause domino f=
ailures)</div><div> * rgw: fix radosgw-admin buckets list (for all bucket=
s)</div><div> * mds: fix occasional client failure to reconnect</div><div=
> * mds: fix bad list traversal after unlink</div><div> * mds: fix underw=
ater dentry cleanup (occasional crash after mds restart)</div><div> * lib=
cephfs, ceph-fuse: fix occasional hangs on umount</div><div> * libcephfs,=
 ceph-fuse: fix old bug with O=5FLAZY vs O=5FNOATIME confusion</div><div>=
 * ceph-disk: more robust journal device detection on RHEL/CentOS</div><d=
iv> * ceph-disk: better, simpler locking</div><div> * ceph-disk: do not i=
nadvertantely mount over existing osd mounts</div><div> * ceph-disk: bett=
er handling for unusual device names</div><div> * sysvinit, upstart: hand=
le symlinks in /var/lib/ceph/*</div><div><br></div><div>Please also refer=
 to the complete release notes:</div><div><br></div><div>   <a href=3D=22=
http://ceph.com/docs/master/release-notes/=23v0-61-5-cuttlefish=22>http:/=
/ceph.com/docs/master/release-notes/=23v0-61-5-cuttlefish</a></div><div><=
br></div><div>You can get v0.61.5 from the usual locations:</div><div><br=
></div><div> * Git at git://<a href=3D=22http://github.com/ceph/ceph.git=22=
>github.com/ceph/ceph.git</a></div><div> * Tarball at <a href=3D=22http:/=
/ceph.com/download/ceph-0.61.5.tar.gz=22>http://ceph.com/download/ceph-0.=
61.5.tar.gz</a></div><div> * =46or Debian/Ubuntu packages, see <a href=3D=
=22http://ceph.com/docs/master/install/debian=22>http://ceph.com/docs/mas=
ter/install/debian</a></div><div> * =46or RPMs, see <a href=3D=22http://c=
eph.com/docs/master/install/rpm=22>http://ceph.com/docs/master/install/rp=
m</a></div></div></blockquote><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F</div><div>ceph-users mailing list</div><div><=
a href=3D=22mailto:ceph-users=40lists.ceph.com=22>ceph-users=40lists.ceph=
.com</a></div><div><a href=3D=22http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com=22>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</=
a></div></div></blockquote></div></blockquote><div>=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F</div><div>ceph-users mailing l=
ist</div><div><a href=3D=22mailto:ceph-users=40lists.ceph.com=22>ceph-use=
rs=40lists.ceph.com</a></div><div><a href=3D=22http://lists.ceph.com/list=
info.cgi/ceph-users-ceph.com=22>http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a></div></div></div></span>
                =20
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            
--51e8f142_100f59dc_111a2--

--===============1736346138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1736346138==--

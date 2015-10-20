From: German Anders <ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org>
Subject: Re: v0.94.4 Hammer released
Date: Tue, 20 Oct 2015 09:59:18 -0300
Message-ID: <CALKA-0LTbkzh=aJicN08=znX49K8a4pBQ4HzULc6TRwYqfpFwA@mail.gmail.com>
References: <alpine.DEB.2.00.1510191404420.18978@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2056350912=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1510191404420.18978-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2056350912==
Content-Type: multipart/alternative; boundary=001a11c31b8e71f4e7052288d432

--001a11c31b8e71f4e7052288d432
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

trying to upgrade from hammer 0.94.3 to 0.94.4 I'm getting the following
error msg while trying to restart the mon daemons:

2015-10-20 08:56:37.410321 7f59a8c9d8c0  0 ceph version 0.94.4
(95292699291242794510b39ffde3f4df67898d3a), process ceph-mon, pid 6821
2015-10-20 08:56:37.429036 7f59a8c9d8c0 -1 ERROR: on disk data includes
unsupported features: compat=3D{},rocompat=3D{},incompat=3D{7=3Dsupport she=
c
erasure code}
2015-10-20 08:56:37.429066 7f59a8c9d8c0 -1 error checking features: (1)
Operation not permitted
2015-10-20 08:56:37.458637 7f67460958c0  0 ceph version 0.94.4
(95292699291242794510b39ffde3f4df67898d3a), process ceph-mon, pid 6834
2015-10-20 08:56:37.478365 7f67460958c0 -1 ERROR: on disk data includes
unsupported features: compat=3D{},rocompat=3D{},incompat=3D{7=3Dsupport she=
c
erasure code}
2015-10-20 08:56:37.478387 7f67460958c0 -1 error checking features: (1)
Operation not permitted


any ideas?

$ ceph -v
ceph version 0.94.4 (95292699291242794510b39ffde3f4df67898d3a)


Thanks in advance,

Cheers,

*German* <ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org>

2015-10-19 18:07 GMT-03:00 Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:

> This Hammer point fixes several important bugs in Hammer, as well as
> fixing interoperability issues that are required before an upgrade to
> Infernalis. That is, all users of earlier version of Hammer or any
> version of Firefly will first need to upgrade to hammer v0.94.4 or
> later before upgrading to Infernalis (or future releases).
>
> All v0.94.x Hammer users are strongly encouraged to upgrade.
>
> Changes
> -------
>
> * build/ops: ceph.spec.in: 50-rbd.rules conditional is wrong (#12166,
> Nathan Cutler)
> * build/ops: ceph.spec.in: ceph-common needs python-argparse on older
> distros, but doesn't require it (#12034, Nathan Cutler)
> * build/ops: ceph.spec.in: radosgw requires apache for SUSE only -- makes
> no sense (#12358, Nathan Cutler)
> * build/ops: ceph.spec.in: rpm: cephfs_java not fully conditionalized
> (#11991, Nathan Cutler)
> * build/ops: ceph.spec.in: rpm: not possible to turn off Java (#11992,
> Owen Synge)
> * build/ops: ceph.spec.in: running fdupes unnecessarily (#12301, Nathan
> Cutler)
> * build/ops: ceph.spec.in: snappy-devel for all supported distros
> (#12361, Nathan Cutler)
> * build/ops: ceph.spec.in: SUSE/openSUSE builds need libbz2-devel
> (#11629, Nathan Cutler)
> * build/ops: ceph.spec.in: useless %py_requires breaks SLE11-SP3 build
> (#12351, Nathan Cutler)
> * build/ops: error in ext_mime_map_init() when /etc/mime.types is missing
> (#11864, Ken Dreyer)
> * build/ops: upstart: limit respawn to 3 in 30 mins (instead of 5 in 30s)
> (#11798, Sage Weil)
> * build/ops: With root as default user, unable to have multiple RGW
> instances running (#10927, Sage Weil)
> * build/ops: With root as default user, unable to have multiple RGW
> instances running (#11140, Sage Weil)
> * build/ops: With root as default user, unable to have multiple RGW
> instances running (#11686, Sage Weil)
> * build/ops: With root as default user, unable to have multiple RGW
> instances running (#12407, Sage Weil)
> * cli: ceph: cli throws exception on unrecognized errno (#11354, Kefu Cha=
i)
> * cli: ceph tell: broken error message / misleading hinting (#11101, Kefu
> Chai)
> * common: arm: all programs that link to librados2 hang forever on startu=
p
> (#12505, Boris Ranto)
> * common: buffer: critical bufferlist::zero bug (#12252, Haomai Wang)
> * common: ceph-object-corpus: add 0.94.2-207-g88e7ee7 hammer objects
> (#13070, Sage Weil)
> * common: do not insert emtpy ptr when rebuild emtpy bufferlist (#12775,
> Xinze Chi)
> * common: [  FAILED  ] TestLibRBD.BlockingAIO (#12479, Jason Dillaman)
> * common: LibCephFS.GetPoolId failure (#12598, Yan, Zheng)
> * common: Memory leak in Mutex.cc, pthread_mutexattr_init without
> pthread_mutexattr_destroy (#11762, Ketor Meng)
> * common: object_map_update fails with -EINVAL return code (#12611, Jason
> Dillaman)
> * common: Pipe: Drop connect_seq increase line (#13093, Haomai Wang)
> * common: recursive lock of md_config_t (0) (#12614, Josh Durgin)
> * crush: ceph osd crush reweight-subtree does not reweight parent node
> (#11855, Sage Weil)
> * doc: update docs to point to download.ceph.com (#13162, Alfredo Deza)
> * fs: ceph-fuse 0.94.2-1trusty segfaults / aborts (#12297, Greg Farnum)
> * fs: segfault launching ceph-fuse with bad --name (#12417, John Spray)
> * librados: Change radosgw pools default crush ruleset (#11640, Yuan Zhou=
)
> * librbd: correct issues discovered via lockdep / helgrind (#12345, Jason
> Dillaman)
> * librbd: Crash during TestInternal.MultipleResize (#12664, Jason Dillama=
n)
> * librbd: deadlock during cooperative exclusive lock transition (#11537,
> Jason Dillaman)
> * librbd: Possible crash while concurrently writing and shrinking an imag=
e
> (#11743, Jason Dillaman)
> * mon: add a cache layer over MonitorDBStore (#12638, Kefu Chai)
> * mon: fix crush testing for new pools (#13400, Sage Weil)
> * mon: get pools health'info have error (#12402, renhwztetecs)
> * mon: implicit erasure code crush ruleset is not validated (#11814, Loic
> Dachary)
> * mon: PaxosService: call post_refresh() instead of post_paxos_update()
> (#11470, Joao Eduardo Luis)
> * mon: pgmonitor: wrong at/near target max=C3=A2   reporting (#12401, hua=
ngjun)
> * mon: register_new_pgs() should check ruleno instead of its index
> (#12210, Xinze Chi)
> * mon: Show osd as NONE in ceph osd map <pool> <object>  output (#11820,
> Shylesh Kumar)
> * mon: the output is wrong when runing ceph osd reweight (#12251, Joao
> Eduardo Luis)
> * osd: allow peek_map_epoch to return an error (#13060, Sage Weil)
> * osd: cache agent is idle although one object is left in the cache
> (#12673, Loic Dachary)
> * osd: copy-from doesn't preserve truncate_{seq,size} (#12551, Samuel Jus=
t)
> * osd: crash creating/deleting pools (#12429, John Spray)
> * osd: fix repair when recorded digest is wrong (#12577, Sage Weil)
> * osd: include/ceph_features: define HAMMER_0_94_4 feature (#13026, Sage
> Weil)
> * osd: is_new_interval() fixes (#10399, Jason Dillaman)
> * osd: is_new_interval() fixes (#11771, Jason Dillaman)
> * osd: long standing slow requests:
> connection->session->waiting_for_map->connection ref cycle (#12338, Samue=
l
> Just)
> * osd: Mutex Assert from PipeConnection::try_get_pipe (#12437, David
> Zafman)
> * osd: pg_interval_t::check_new_interval - for ec pool, should not rely o=
n
> min_size to determine if the PG was active at the interval (#12162, Guang=
 G
> Yang)
> * osd: PGLog.cc: 732: FAILED assert(log.log.size() =3D=3D
> log_keys_debug.size()) (#12652, Sage Weil)
> * osd: PGLog::proc_replica_log: correctly handle case where entries
> between olog.head and log.tail were split out (#11358, Samuel Just)
> * osd: read on chunk-aligned xattr not handled (#12309, Sage Weil)
> * osd: suicide timeout during peering - search for missing objects
> (#12523, Guang G Yang)
> * osd: WBThrottle::clear_object: signal on cond when we reduce throttle
> values (#12223, Samuel Just)
> * rbd: crash during shutdown after writeback blocked by IO errors (#12597=
,
> Jianpeng Ma)
> * rgw: add delimiter to prefix only when path is specified (#12960,
> Sylvain Baubeau)
> * rgw: create a tool for orphaned objects cleanup (#9604, Yehuda Sadeh)
> * rgw: don't preserve acls when copying object (#11563, Yehuda Sadeh)
> * rgw: don't preserve acls when copying object (#12370, Yehuda Sadeh)
> * rgw: don't preserve acls when copying object (#13015, Yehuda Sadeh)
> * rgw: Ensure that swift keys don't include backslashes (#7647, Yehuda
> Sadeh)
> * rgw: GWWatcher::handle_error -> common/Mutex.cc: 95: FAILED assert(r =
=3D=3D
> 0) (#12208, Yehuda Sadeh)
> * rgw: HTTP return code is not being logged by CivetWeb  (#12432, Yehuda
> Sadeh)
> * rgw: init_rados failed leads to repeated delete (#12978, Xiaowei Chen)
> * rgw: init some manifest fields when handling explicit objs (#11455,
> Yehuda Sadeh)
> * rgw: Keystone Fernet tokens break auth (#12761, Abhishek Lekshmanan)
> * rgw: region data still exist in region-map after region-map update
> (#12964, dwj192)
> * rgw: remove trailing :port from host for purposes of subdomain matching
> (#12353, Yehuda Sadeh)
> * rgw: rest-bench common/WorkQueue.cc: 54: FAILED assert(_threads.empty()=
)
> (#3896, huangjun)
> * rgw: returns requested bucket name raw in Bucket response header
> (#12537, Yehuda Sadeh)
> * rgw: segmentation fault when rgw_gc_max_objs > HASH_PRIME (#12630,
> Ruifeng Yang)
> * rgw: segments are read during HEAD on Swift DLO (#12780, Yehuda Sadeh)
> * rgw: setting max number of buckets for user via ceph.conf option
> (#12714, Vikhyat Umrao)
> * rgw: Swift API: X-Trans-Id header is wrongly formatted (#12108, Radosla=
w
> Zarzynski)
> * rgw: testGetContentType and testHead failed (#11091, Radoslaw Zarzynski=
)
> * rgw: testGetContentType and testHead failed (#11438, Radoslaw Zarzynski=
)
> * rgw: testGetContentType and testHead failed (#12157, Radoslaw Zarzynski=
)
> * rgw: testGetContentType and testHead failed (#12158, Radoslaw Zarzynski=
)
> * rgw: testGetContentType and testHead failed (#12363, Radoslaw Zarzynski=
)
> * rgw: the arguments 'domain' should not be assigned when return false
> (#12629, Ruifeng Yang)
> * tests: qa/workunits/cephtool/test.sh: don't assume
> crash_replay_interval=3D45 (#13406, Sage Weil)
> * tests: TEST_crush_rule_create_erasure consistently fails on i386 builde=
r
> (#12419, Loic Dachary)
> * tools: ceph-disk zap should ensure block device (#11272, Loic Dachary)
>
> For more detailed information, see the complete changelog at
>
>   http://docs.ceph.com/docs/master/_downloads/v0.94.4.txt
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-0.94.4.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see
> http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--001a11c31b8e71f4e7052288d432
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace;font-size:small;color:rgb(11,83,148)">trying to upgrade from ha=
mmer 0.94.3 to 0.94.4 I&#39;m getting the following error msg while trying =
to restart the mon daemons:<br><br>2015-10-20 08:56:37.410321 7f59a8c9d8c0=
=C2=A0 0 ceph version 0.94.4 (95292699291242794510b39ffde3f4df67898d3a), pr=
ocess ceph-mon, pid 6821<br>2015-10-20 08:56:37.429036 7f59a8c9d8c0 -1 ERRO=
R: on disk data includes unsupported features: compat=3D{},rocompat=3D{},in=
compat=3D{7=3Dsupport shec erasure code}<br>2015-10-20 08:56:37.429066 7f59=
a8c9d8c0 -1 error checking features: (1) Operation not permitted<br>2015-10=
-20 08:56:37.458637 7f67460958c0=C2=A0 0 ceph version 0.94.4 (9529269929124=
2794510b39ffde3f4df67898d3a), process ceph-mon, pid 6834<br>2015-10-20 08:5=
6:37.478365 7f67460958c0 -1 ERROR: on disk data includes unsupported featur=
es: compat=3D{},rocompat=3D{},incompat=3D{7=3Dsupport shec erasure code}<br=
>2015-10-20 08:56:37.478387 7f67460958c0 -1 error checking features: (1) Op=
eration not permitted<br><br><br></div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace;font-size:small;color:rgb(11,83,148)">a=
ny ideas?<br><br>$ ceph -v<br>ceph version 0.94.4 (95292699291242794510b39f=
fde3f4df67898d3a)<br><br><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace;font-size:small;color:rgb(11,83,148)">Thanks =
in advance,<br><br></div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace;font-size:small;color:rgb(11,83,148)">Cheers,<br></div>=
<div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><div><div dir=3D"ltr"><p=
><b><span style=3D"font-size:10.0pt;font-family:Trebuchet MS,sans-serif;col=
or:#444444"></span></b></p><span style=3D"color:rgb(68,68,68)"><span style=
=3D"font-family:trebuchet ms,sans-serif"><font size=3D"2"><b>German</b></fo=
nt></span></span><span style=3D"color:rgb(68,68,68)"><span style=3D"font-fa=
mily:trebuchet ms,sans-serif"><font size=3D"2"><font size=3D"1"><a href=3D"=
mailto:ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org" target=3D"_blank"></a></font></font></span></s=
pan></div></div></span></div></div></div></div></div>
<br><div class=3D"gmail_quote">2015-10-19 18:07 GMT-03:00 Sage Weil <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sage@re=
dhat.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This Hammer poin=
t fixes several important bugs in Hammer, as well as<br>
fixing interoperability issues that are required before an upgrade to<br>
Infernalis. That is, all users of earlier version of Hammer or any<br>
version of Firefly will first need to upgrade to hammer v0.94.4 or<br>
later before upgrading to Infernalis (or future releases).<br>
<br>
All v0.94.x Hammer users are strongly encouraged to upgrade.<br>
<br>
Changes<br>
-------<br>
<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: 50-rbd.rules conditional is wrong (#12166, Nathan =
Cutler)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: ceph-common needs python-argparse on older distros=
, but doesn&#39;t require it (#12034, Nathan Cutler)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: radosgw requires apache for SUSE only -- makes no =
sense (#12358, Nathan Cutler)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: rpm: cephfs_java not fully conditionalized (#11991=
, Nathan Cutler)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: rpm: not possible to turn off Java (#11992, Owen S=
ynge)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: running fdupes unnecessarily (#12301, Nathan Cutle=
r)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: snappy-devel for all supported distros (#12361, Na=
than Cutler)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: SUSE/openSUSE builds need libbz2-devel (#11629, Na=
than Cutler)<br>
* build/ops: <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=3D"_=
blank">ceph.spec.in</a>: useless %py_requires breaks SLE11-SP3 build (#1235=
1, Nathan Cutler)<br>
* build/ops: error in ext_mime_map_init() when /etc/mime.types is missing (=
#11864, Ken Dreyer)<br>
* build/ops: upstart: limit respawn to 3 in 30 mins (instead of 5 in 30s) (=
#11798, Sage Weil)<br>
* build/ops: With root as default user, unable to have multiple RGW instanc=
es running (#10927, Sage Weil)<br>
* build/ops: With root as default user, unable to have multiple RGW instanc=
es running (#11140, Sage Weil)<br>
* build/ops: With root as default user, unable to have multiple RGW instanc=
es running (#11686, Sage Weil)<br>
* build/ops: With root as default user, unable to have multiple RGW instanc=
es running (#12407, Sage Weil)<br>
* cli: ceph: cli throws exception on unrecognized errno (#11354, Kefu Chai)=
<br>
* cli: ceph tell: broken error message / misleading hinting (#11101, Kefu C=
hai)<br>
* common: arm: all programs that link to librados2 hang forever on startup =
(#12505, Boris Ranto)<br>
* common: buffer: critical bufferlist::zero bug (#12252, Haomai Wang)<br>
* common: ceph-object-corpus: add 0.94.2-207-g88e7ee7 hammer objects (#1307=
0, Sage Weil)<br>
* common: do not insert emtpy ptr when rebuild emtpy bufferlist (#12775, Xi=
nze Chi)<br>
* common: [=C2=A0 FAILED=C2=A0 ] TestLibRBD.BlockingAIO (#12479, Jason Dill=
aman)<br>
* common: LibCephFS.GetPoolId failure (#12598, Yan, Zheng)<br>
* common: Memory leak in Mutex.cc, pthread_mutexattr_init without pthread_m=
utexattr_destroy (#11762, Ketor Meng)<br>
* common: object_map_update fails with -EINVAL return code (#12611, Jason D=
illaman)<br>
* common: Pipe: Drop connect_seq increase line (#13093, Haomai Wang)<br>
* common: recursive lock of md_config_t (0) (#12614, Josh Durgin)<br>
* crush: ceph osd crush reweight-subtree does not reweight parent node (#11=
855, Sage Weil)<br>
* doc: update docs to point to <a href=3D"http://download.ceph.com" rel=3D"=
noreferrer" target=3D"_blank">download.ceph.com</a> (#13162, Alfredo Deza)<=
br>
* fs: ceph-fuse 0.94.2-1trusty segfaults / aborts (#12297, Greg Farnum)<br>
* fs: segfault launching ceph-fuse with bad --name (#12417, John Spray)<br>
* librados: Change radosgw pools default crush ruleset (#11640, Yuan Zhou)<=
br>
* librbd: correct issues discovered via lockdep / helgrind (#12345, Jason D=
illaman)<br>
* librbd: Crash during TestInternal.MultipleResize (#12664, Jason Dillaman)=
<br>
* librbd: deadlock during cooperative exclusive lock transition (#11537, Ja=
son Dillaman)<br>
* librbd: Possible crash while concurrently writing and shrinking an image =
(#11743, Jason Dillaman)<br>
* mon: add a cache layer over MonitorDBStore (#12638, Kefu Chai)<br>
* mon: fix crush testing for new pools (#13400, Sage Weil)<br>
* mon: get pools health&#39;info have error (#12402, renhwztetecs)<br>
* mon: implicit erasure code crush ruleset is not validated (#11814, Loic D=
achary)<br>
* mon: PaxosService: call post_refresh() instead of post_paxos_update() (#1=
1470, Joao Eduardo Luis)<br>
* mon: pgmonitor: wrong at/near target max=C3=A2=C2=A0 =C2=A0reporting (#12=
401, huangjun)<br>
* mon: register_new_pgs() should check ruleno instead of its index (#12210,=
 Xinze Chi)<br>
* mon: Show osd as NONE in ceph osd map &lt;pool&gt; &lt;object&gt;=C2=A0 o=
utput (#11820, Shylesh Kumar)<br>
* mon: the output is wrong when runing ceph osd reweight (#12251, Joao Edua=
rdo Luis)<br>
* osd: allow peek_map_epoch to return an error (#13060, Sage Weil)<br>
* osd: cache agent is idle although one object is left in the cache (#12673=
, Loic Dachary)<br>
* osd: copy-from doesn&#39;t preserve truncate_{seq,size} (#12551, Samuel J=
ust)<br>
* osd: crash creating/deleting pools (#12429, John Spray)<br>
* osd: fix repair when recorded digest is wrong (#12577, Sage Weil)<br>
* osd: include/ceph_features: define HAMMER_0_94_4 feature (#13026, Sage We=
il)<br>
* osd: is_new_interval() fixes (#10399, Jason Dillaman)<br>
* osd: is_new_interval() fixes (#11771, Jason Dillaman)<br>
* osd: long standing slow requests: connection-&gt;session-&gt;waiting_for_=
map-&gt;connection ref cycle (#12338, Samuel Just)<br>
* osd: Mutex Assert from PipeConnection::try_get_pipe (#12437, David Zafman=
)<br>
* osd: pg_interval_t::check_new_interval - for ec pool, should not rely on =
min_size to determine if the PG was active at the interval (#12162, Guang G=
 Yang)<br>
* osd: PGLog.cc: 732: FAILED assert(log.log.size() =3D=3D log_keys_debug.si=
ze()) (#12652, Sage Weil)<br>
* osd: PGLog::proc_replica_log: correctly handle case where entries between=
 olog.head and log.tail were split out (#11358, Samuel Just)<br>
* osd: read on chunk-aligned xattr not handled (#12309, Sage Weil)<br>
* osd: suicide timeout during peering - search for missing objects (#12523,=
 Guang G Yang)<br>
* osd: WBThrottle::clear_object: signal on cond when we reduce throttle val=
ues (#12223, Samuel Just)<br>
* rbd: crash during shutdown after writeback blocked by IO errors (#12597, =
Jianpeng Ma)<br>
* rgw: add delimiter to prefix only when path is specified (#12960, Sylvain=
 Baubeau)<br>
* rgw: create a tool for orphaned objects cleanup (#9604, Yehuda Sadeh)<br>
* rgw: don&#39;t preserve acls when copying object (#11563, Yehuda Sadeh)<b=
r>
* rgw: don&#39;t preserve acls when copying object (#12370, Yehuda Sadeh)<b=
r>
* rgw: don&#39;t preserve acls when copying object (#13015, Yehuda Sadeh)<b=
r>
* rgw: Ensure that swift keys don&#39;t include backslashes (#7647, Yehuda =
Sadeh)<br>
* rgw: GWWatcher::handle_error -&gt; common/Mutex.cc: 95: FAILED assert(r =
=3D=3D 0) (#12208, Yehuda Sadeh)<br>
* rgw: HTTP return code is not being logged by CivetWeb=C2=A0 (#12432, Yehu=
da Sadeh)<br>
* rgw: init_rados failed leads to repeated delete (#12978, Xiaowei Chen)<br=
>
* rgw: init some manifest fields when handling explicit objs (#11455, Yehud=
a Sadeh)<br>
* rgw: Keystone Fernet tokens break auth (#12761, Abhishek Lekshmanan)<br>
* rgw: region data still exist in region-map after region-map update (#1296=
4, dwj192)<br>
* rgw: remove trailing :port from host for purposes of subdomain matching (=
#12353, Yehuda Sadeh)<br>
* rgw: rest-bench common/WorkQueue.cc: 54: FAILED assert(_threads.empty()) =
(#3896, huangjun)<br>
* rgw: returns requested bucket name raw in Bucket response header (#12537,=
 Yehuda Sadeh)<br>
* rgw: segmentation fault when rgw_gc_max_objs &gt; HASH_PRIME (#12630, Rui=
feng Yang)<br>
* rgw: segments are read during HEAD on Swift DLO (#12780, Yehuda Sadeh)<br=
>
* rgw: setting max number of buckets for user via ceph.conf option=C2=A0 (#=
12714, Vikhyat Umrao)<br>
* rgw: Swift API: X-Trans-Id header is wrongly formatted (#12108, Radoslaw =
Zarzynski)<br>
* rgw: testGetContentType and testHead failed (#11091, Radoslaw Zarzynski)<=
br>
* rgw: testGetContentType and testHead failed (#11438, Radoslaw Zarzynski)<=
br>
* rgw: testGetContentType and testHead failed (#12157, Radoslaw Zarzynski)<=
br>
* rgw: testGetContentType and testHead failed (#12158, Radoslaw Zarzynski)<=
br>
* rgw: testGetContentType and testHead failed (#12363, Radoslaw Zarzynski)<=
br>
* rgw: the arguments &#39;domain&#39; should not be assigned when return fa=
lse (#12629, Ruifeng Yang)<br>
* tests: qa/workunits/cephtool/test.sh: don&#39;t assume crash_replay_inter=
val=3D45 (#13406, Sage Weil)<br>
* tests: TEST_crush_rule_create_erasure consistently fails on i386 builder =
(#12419, Loic Dachary)<br>
* tools: ceph-disk zap should ensure block device (#11272, Loic Dachary)<br=
>
<br>
For more detailed information, see the complete changelog at<br>
<br>
=C2=A0 <a href=3D"http://docs.ceph.com/docs/master/_downloads/v0.94.4.txt" =
rel=3D"noreferrer" target=3D"_blank">http://docs.ceph.com/docs/master/_down=
loads/v0.94.4.txt</a><br>
<br>
Getting Ceph<br>
------------<br>
<br>
* Git at git://<a href=3D"http://github.com/ceph/ceph.git" rel=3D"noreferre=
r" target=3D"_blank">github.com/ceph/ceph.git</a><br>
* Tarball at <a href=3D"http://download.ceph.com/tarballs/ceph-0.94.4.tar.g=
z" rel=3D"noreferrer" target=3D"_blank">http://download.ceph.com/tarballs/c=
eph-0.94.4.tar.gz</a><br>
* For packages, see <a href=3D"http://ceph.com/docs/master/install/get-pack=
ages" rel=3D"noreferrer" target=3D"_blank">http://ceph.com/docs/master/inst=
all/get-packages</a><br>
* For ceph-deploy, see <a href=3D"http://ceph.com/docs/master/install/insta=
ll-ceph-deploy" rel=3D"noreferrer" target=3D"_blank">http://ceph.com/docs/m=
aster/install/install-ceph-deploy</a><br>__________________________________=
_____________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
<br></blockquote></div><br></div></div>

--001a11c31b8e71f4e7052288d432--

--===============2056350912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2056350912==--

From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v12.2.8 Luminous released
Date: Wed, 5 Sep 2018 12:19:52 -0400
Message-ID: <CAN-GepKVOysGcCLBB=Yae6RvSPW=NoH-8bj6Vje1AjH2O2cT=g@mail.gmail.com>
References: <87h8j5rzs6.fsf@suse.com>
 <CABZ+qqm3jredRJUOgy+HuZkYRjZn2yHrFmToVx4xr4UGJhmAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7669385190697047187=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqm3jredRJUOgy+HuZkYRjZn2yHrFmToVx4xr4UGJhmAtw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============7669385190697047187==
Content-Type: multipart/alternative; boundary="000000000000a34d9c0575222539"

--000000000000a34d9c0575222539
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I upgraded my home cephfs/rbd cluster to 12.2.8 during an OS upgrade to
Ubuntu 18.04 and ProxMox 5.1 (Stretch).  Everything is running well so far.

On Wed, Sep 5, 2018 at 10:21 AM Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote=
:

> Thanks for the release!
>
> We've updated some test clusters (rbd, cephfs) and it looks good so far.
>
> -- dan
>
>
> On Tue, Sep 4, 2018 at 6:30 PM Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
> wrote:
> >
> >
> > We're glad to announce the next point release in the Luminous v12.2.X
> > stable release series. This release contains a range of bugfixes and
> > stability improvements across all the components of ceph. For detailed
> > release notes with links to tracker issues and pull requests, refer to
> > the blog post at http://ceph.com/releases/v12-2-8-released/
> >
> > Upgrade Notes from previous luminous releases
> > ---------------------------------------------
> >
> > When upgrading from v12.2.5 or v12.2.6 please note that upgrade caveats
> from
> > 12.2.5 will apply to any _newer_ luminous version including 12.2.8.
> Please read
> > the notes at
> https://ceph.com/releases/12-2-7-luminous-released/#upgrading-from-v12-2-=
6
> >
> > For the cluster that installed the broken 12.2.6 release, 12.2.7 fixed
> the
> > regression and introduced a workaround option `osd distrust data digest
> =3D true`,
> > but 12.2.7 clusters still generated health warnings like ::
> >
> >   [ERR] 11.288 shard 207: soid
> >   11:1155c332:::rbd_data.207dce238e1f29.0000000000000527:head data_dige=
st
> >   0xc8997a5b !=3D data_digest 0x2ca15853
> >
> >
> > 12.2.8 improves the deep scrub code to automatically repair these
> > inconsistencies. Once the entire cluster has been upgraded and then
> fully deep
> > scrubbed, and all such inconsistencies are resolved; it will be safe to
> disable
> > the `osd distrust data digest =3D true` workaround option.
> >
> > Changelog
> > ---------
> > * bluestore: set correctly shard for existed Collection (issue#24761,
> pr#22860, Jianpeng Ma)
> > * build/ops: Boost system library is no longer required to compile and
> link example librados program (issue#25054, pr#23202, Nathan Cutler)
> > * build/ops: Bring back diff -y for non-FreeBSD (issue#24396,
> issue#21664, pr#22848, Sage Weil, David Zafman)
> > * build/ops: install-deps.sh fails on newest openSUSE Leap (issue#25064=
,
> pr#23179, Kyr Shatskyy)
> > * build/ops: Mimic build fails with -DWITH_RADOSGW=3D0 (issue#24437,
> pr#22864, Dan Mick)
> > * build/ops: order rbdmap.service before remote-fs-pre.target
> (issue#24713, pr#22844, Ilya Dryomov)
> > * build/ops: rpm: silence osd block chown (issue#25152, pr#23313, Dan
> van der Ster)
> > * cephfs-journal-tool: Fix purging when importing an zero-length journa=
l
> (issue#24239, pr#22980, yupeng chen, zhongyan gu)
> > * cephfs: MDSMonitor: uncommitted state exposed to clients/mdss
> (issue#23768, pr#23013, Patrick Donnelly)
> > * ceph-fuse mount failed because no mds (issue#22205, pr#22895, liyan)
> > * ceph-volume add a __release__ string, to help version-conditional
> calls (issue#25170, pr#23331, Alfredo Deza)
> > * ceph-volume: adds test for `ceph-volume lvm list /dev/sda`
> (issue#24784, issue#24957, pr#23350, Andrew Schoen)
> > * ceph-volume: do not use stdin in luminous (issue#25173, issue#23260,
> pr#23367, Alfredo Deza)
> > * ceph-volume enable the ceph-osd during lvm activation (issue#24152,
> pr#23394, Dan van der Ster, Alfredo Deza)
> > * ceph-volume expand on the LVM API to create multiple LVs at different
> sizes (issue#24020, pr#23395, Alfredo Deza)
> > * ceph-volume lvm.activate conditional mon-config on prime-osd-dir
> (issue#25216, pr#23397, Alfredo Deza)
> > * ceph-volume lvm.batch remove non-existent sys_api property
> (issue#34310, pr#23811, Alfredo Deza)
> > * ceph-volume lvm.listing only include devices if they exist
> (issue#24952, pr#23150, Alfredo Deza)
> > * ceph-volume: process.call with stdin in Python 3 fix (issue#24993,
> pr#23238, Alfredo Deza)
> > * ceph-volume: PVolumes.get() should return one PV when using name or
> uuid (issue#24784, pr#23329, Andrew Schoen)
> > * ceph-volume: refuse to zap mapper devices (issue#24504, pr#23374,
> Andrew Schoen)
> > * ceph-volume: tests.functional inherit SSH_ARGS from ansible
> (issue#34311, pr#23813, Alfredo Deza)
> > * ceph-volume tests/functional run lvm list after OSD provisioning
> (issue#24961, pr#23147, Alfredo Deza)
> > * ceph-volume: unmount lvs correctly before zapping (issue#24796,
> pr#23128, Andrew Schoen)
> > * ceph-volume: update batch documentation to explain filestore
> strategies (issue#34309, pr#23825, Alfredo Deza)
> > * change default filestore_merge_threshold to -10 (issue#24686,
> pr#22814, Douglas Fuller)
> > * client: add inst to asok status output (issue#24724, pr#23107, Patric=
k
> Donnelly)
> > * client: fixup parallel calls to ceph_ll_lookup_inode() in NFS FASL
> (issue#22683, pr#23012, huanwen ren)
> > * client: increase verbosity level for log messages in helper methods
> (issue#21014, pr#23014, Rishabh Dave)
> > * client:  update inode fields according to issued caps (issue#24269,
> pr#22783, "Yan, Zheng")
> > * common: Abort in OSDMap::decode() during
> qa/standalone/erasure-code/test-erasure-eio.sh (issue#23492, pr#23025, Sa=
ge
> Weil)
> > * common/DecayCounter: set last_decay to current time when decoding
> decay counter (issue#24440, pr#22779, Zhi Zhang)
> > * doc: ceph-bluestore-tool manpage not getting rendered correctly
> (issue#24800, pr#23177, Nathan Cutler)
> > * filestore: add pgid in filestore pg dir split log message
> (issue#24878, pr#23454, Vikhyat Umrao)
> > * let "ceph status" use base 10 when printing numbers not sizes
> (issue#22095, pr#22680, Jan Fajerski, Kefu Chai)
> > * librados: fix buffer overflow for aio_exec python binding
> (issue#23964, pr#22708, Aleksei Gutikov)
> > * librbd: force 'invalid object map' flag on-disk update (issue#24434,
> pr#22753, Mykola Golub)
> > * librbd: utilize the journal disabled policy when removing images
> (issue#23512, pr#23595, Jason Dillaman)
> > * mds: don't report slow request for blocked filelock request
> (issue#22428, pr#22782, "Yan, Zheng")
> > * mds: dump recent events on respawn (issue#24853, pr#23213, Patrick
> Donnelly)
> > * mds: handle discontinuous mdsmap (issue#24856, pr#23169, "Yan, Zheng"=
)
> > * mds: increase debug level for dropped client cap msg (issue#24855,
> pr#23214, Patrick Donnelly)
> > * mds: low wrlock efficiency due to dirfrags traversal (issue#24467,
> pr#22885, Xuehan Xu)
> > * mds: print mdsmap processed at low debug level (issue#24852, pr#23212=
,
> Patrick Donnelly)
> > * mds: scrub doesn't always return JSON results (issue#23958, pr#23222,
> Venky Shankar)
> > * mds: unset deleted vars in shutdown_pass (issue#23766, pr#23015,
> Patrick Donnelly)
> > * mgr: add units to performance counters (issue#22747, pr#23266, Ernest=
o
> Puerta, Rubab Syed)
> > * mgr: ceph osd safe-to-destroy crashes the mgr (issue#23249, pr#22806,
> Sage Weil)
> > * mgr/MgrClient: Protect daemon_health_metrics (issue#23352, pr#23459,
> Kjetil Joergensen, Brad Hubbard)
> > * mon: Add option to view IP addresses of clients in output of 'ceph
> features' (issue#21315, pr#22773, Paul Emmerich)
> > * mon/HealthMonitor: do not send MMonHealthChecks to pre-luminous mon
> (issue#24481, pr#22655, Sage Weil)
> > * os/bluestore: fix flush_commit locking (issue#21480, pr#22904, Sage
> Weil)
> > * os/bluestore: fix incomplete faulty range marking when doing
> compression (issue#21480, pr#22909, Igor Fedotov)
> > * os/bluestore: fix races on SharedBlob::coll in ~SharedBlob
> (issue#24859, pr#23064, Radoslaw Zarzynski)
> > * osdc: Fix the wrong BufferHead offset (issue#24484, pr#22865, dongdon=
g
> tao)
> > * osd: do_sparse_read(): Verify checksum earlier so we will try to
> repair and missed backport (issue#24875, pr#23379, xie xingguo, David
> Zafman)
> > * osd: eternal stuck PG in 'unfound_recovery' (issue#24373, pr#22546,
> Sage Weil)
> > * osd: may get empty info at recovery (issue#24588, pr#22862, Sage Weil=
)
> > * osd/OSDMap: CRUSH_TUNABLES5 added in jewel, not kraken (issue#25057,
> pr#23227, Sage Weil)
> > * osd/Session: fix invalid iterator dereference in
> Sessoin::have_backoff() (issue#24486, pr#22729, Sage Weil)
> > * pjd: cd: too many arguments (issue#24307, pr#22883, Neha Ojha)
> > * PurgeQueue sometimes ignores Journaler errors (issue#24533, pr#22811,
> John Spray)
> > * pybind: pybind/mgr/mgr_module: make rados handle available to all
> modules (issue#24788, issue#25102, pr#23235, Ernesto Puerta, Sage Weil)
> > * pybind: Python bindings use iteritems method which is not Python 3
> compatible (issue#24779, pr#22918, Nathan Cutler, Kefu Chai)
> > * pybind: rados.pyx: make all exceptions accept keyword arguments
> (issue#24033, pr#22979, Rishabh Dave)
> > * rbd: fix issues in IEC unit handling (issue#26927, issue#26928,
> pr#23776, Jason Dillaman)
> > * repeated eviction of idle client until some IO happens (issue#24052,
> pr#22780, "Yan, Zheng")
> > * rgw: add curl_low_speed_limit and curl_low_speed_time config to avoid
> the thread hangs in data sync (issue#25019, pr#23144, Mark Kogan, Zhang
> Shaowen)
> > * rgw: add unit test for cls bi list command (issue#24483, pr#22846,
> Orit Wasserman, Xinying Song)
> > * rgw: do not ignore EEXIST in RGWPutObj::execute (issue#22790,
> pr#23207, Matt Benjamin)
> > * rgw: fail to recover index from crash luminous backport (issue#24640,
> issue#24280, pr#23130, Tianshan Qu)
> > * rgw: fix gc may cause a large number of read traffic (issue#24767,
> pr#22984, Xin Liao)
> > * rgw: fix the bug of radowgw-admin zonegroup set requires realm
> (issue#21583, pr#22767, lvshanchun)
> > * rgw: have a configurable authentication order (issue#23089, pr#23501,
> Abhishek Lekshmanan)
> > * rgw: index complete miss zones_trace set (issue#24590, pr#22820,
> Tianshan Qu)
> > * rgw: Invalid Access-Control-Request-Request may bypass
> validate_cors_rule_method (issue#24223, pr#22934, Jeegn Chen)
> > * rgw: meta and data notify thread miss stop cr manager (issue#24589,
> pr#22822, Tianshan Qu)
> > * rgw-multisite: endless loop in RGWBucketShardIncrementalSyncCR
> (issue#24603, pr#22817, cfanz)
> > * rgw performance regression for luminous 12.2.4 (issue#23379, pr#22930=
,
> Mark Kogan)
> > * rgw: radogw-admin reshard status command should print text for reshar=
=E2=80=A6
> (issue#23257, pr#23019, Orit Wasserman)
> > * rgw: "radosgw-admin objects expire" always returns ok even if the pro=
=E2=80=A6
> (issue#24592, pr#23000, Zhang Shaowen)
> > * rgw: require --yes-i-really-mean-it to run radosgw-admin orphans find
> (issue#24146, pr#22985, Matt Benjamin)
> > * rgw: REST admin metadata API paging failure bucket & bucket.instance:
> InvalidArgument (issue#23099, pr#22932, Matt Benjamin)
> > * rgw: set cr state if aio_read err return in RGWCloneMetaLogCoroutine
> (issue#24566, pr#22942, Tianshan Qu)
> > * spdk: fix ceph-osd crash when activate SPDK (issue#24371, pr#22686,
> tone-zhang)
> > * tools/ceph-objectstore-tool: split filestore directories offline to
> target hash level (issue#21366, pr#23418, Zhi Zhang)
> >
> > Getting ceph:
> > ------------
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball at http://download.ceph.com/tarballs/ceph-12.2.8.tar.gz
> > * For packages, see
> http://docs.ceph.com/docs/master/install/get-packages/
> > * Release git sha1: ae699615bac534ea496ee965ac6192cb7e0e07c0
> >
> >
> > --
> > Abhishek Lekshmanan
> > SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on,
> > HRB 21284 (AG N=C3=BCrnberg)
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000a34d9c0575222539
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I upgraded my home cephfs/rbd cluster to 12.2.8 during an =
OS upgrade to Ubuntu 18.04 and ProxMox 5.1 (Stretch).=C2=A0 Everything is r=
unning well so far.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On=
 Wed, Sep 5, 2018 at 10:21 AM Dan van der Ster &lt;<a href=3D"mailto:dan@va=
nderster.com">dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Thanks for the release!<br>
<br>
We&#39;ve updated some test clusters (rbd, cephfs) and it looks good so far=
.<br>
<br>
-- dan<br>
<br>
<br>
On Tue, Sep 4, 2018 at 6:30 PM Abhishek Lekshmanan &lt;<a href=3D"mailto:ab=
hishek-IBi9RG/b67k@public.gmane.org" target=3D"_blank">abhishek-IBi9RG/b67k@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; We&#39;re glad to announce the next point release in the Luminous v12.=
2.X<br>
&gt; stable release series. This release contains a range of bugfixes and<b=
r>
&gt; stability improvements across all the components of ceph. For detailed=
<br>
&gt; release notes with links to tracker issues and pull requests, refer to=
<br>
&gt; the blog post at <a href=3D"http://ceph.com/releases/v12-2-8-released/=
" rel=3D"noreferrer" target=3D"_blank">http://ceph.com/releases/v12-2-8-rel=
eased/</a><br>
&gt;<br>
&gt; Upgrade Notes from previous luminous releases<br>
&gt; ---------------------------------------------<br>
&gt;<br>
&gt; When upgrading from v12.2.5 or v12.2.6 please note that upgrade caveat=
s from<br>
&gt; 12.2.5 will apply to any _newer_ luminous version including 12.2.8. Pl=
ease read<br>
&gt; the notes at <a href=3D"https://ceph.com/releases/12-2-7-luminous-rele=
ased/#upgrading-from-v12-2-6" rel=3D"noreferrer" target=3D"_blank">https://=
ceph.com/releases/12-2-7-luminous-released/#upgrading-from-v12-2-6</a><br>
&gt;<br>
&gt; For the cluster that installed the broken 12.2.6 release, 12.2.7 fixed=
 the<br>
&gt; regression and introduced a workaround option `osd distrust data diges=
t =3D true`,<br>
&gt; but 12.2.7 clusters still generated health warnings like ::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0[ERR] 11.288 shard 207: soid<br>
&gt;=C2=A0 =C2=A011:1155c332:::rbd_data.207dce238e1f29.0000000000000527:hea=
d data_digest<br>
&gt;=C2=A0 =C2=A00xc8997a5b !=3D data_digest 0x2ca15853<br>
&gt;<br>
&gt;<br>
&gt; 12.2.8 improves the deep scrub code to automatically repair these<br>
&gt; inconsistencies. Once the entire cluster has been upgraded and then fu=
lly deep<br>
&gt; scrubbed, and all such inconsistencies are resolved; it will be safe t=
o disable<br>
&gt; the `osd distrust data digest =3D true` workaround option.<br>
&gt;<br>
&gt; Changelog<br>
&gt; ---------<br>
&gt; * bluestore: set correctly shard for existed Collection (issue#24761, =
pr#22860, Jianpeng Ma)<br>
&gt; * build/ops: Boost system library is no longer required to compile and=
 link example librados program (issue#25054, pr#23202, Nathan Cutler)<br>
&gt; * build/ops: Bring back diff -y for non-FreeBSD (issue#24396, issue#21=
664, pr#22848, Sage Weil, David Zafman)<br>
&gt; * build/ops: install-deps.sh fails on newest openSUSE Leap (issue#2506=
4, pr#23179, Kyr Shatskyy)<br>
&gt; * build/ops: Mimic build fails with -DWITH_RADOSGW=3D0 (issue#24437, p=
r#22864, Dan Mick)<br>
&gt; * build/ops: order rbdmap.service before remote-fs-pre.target (issue#2=
4713, pr#22844, Ilya Dryomov)<br>
&gt; * build/ops: rpm: silence osd block chown (issue#25152, pr#23313, Dan =
van der Ster)<br>
&gt; * cephfs-journal-tool: Fix purging when importing an zero-length journ=
al (issue#24239, pr#22980, yupeng chen, zhongyan gu)<br>
&gt; * cephfs: MDSMonitor: uncommitted state exposed to clients/mdss (issue=
#23768, pr#23013, Patrick Donnelly)<br>
&gt; * ceph-fuse mount failed because no mds (issue#22205, pr#22895, liyan)=
<br>
&gt; * ceph-volume add a __release__ string, to help version-conditional ca=
lls (issue#25170, pr#23331, Alfredo Deza)<br>
&gt; * ceph-volume: adds test for `ceph-volume lvm list /dev/sda` (issue#24=
784, issue#24957, pr#23350, Andrew Schoen)<br>
&gt; * ceph-volume: do not use stdin in luminous (issue#25173, issue#23260,=
 pr#23367, Alfredo Deza)<br>
&gt; * ceph-volume enable the ceph-osd during lvm activation (issue#24152, =
pr#23394, Dan van der Ster, Alfredo Deza)<br>
&gt; * ceph-volume expand on the LVM API to create multiple LVs at differen=
t sizes (issue#24020, pr#23395, Alfredo Deza)<br>
&gt; * ceph-volume lvm.activate conditional mon-config on prime-osd-dir (is=
sue#25216, pr#23397, Alfredo Deza)<br>
&gt; * ceph-volume lvm.batch remove non-existent sys_api property (issue#34=
310, pr#23811, Alfredo Deza)<br>
&gt; * ceph-volume lvm.listing only include devices if they exist (issue#24=
952, pr#23150, Alfredo Deza)<br>
&gt; * ceph-volume: process.call with stdin in Python 3 fix (issue#24993, p=
r#23238, Alfredo Deza)<br>
&gt; * ceph-volume: PVolumes.get() should return one PV when using name or =
uuid (issue#24784, pr#23329, Andrew Schoen)<br>
&gt; * ceph-volume: refuse to zap mapper devices (issue#24504, pr#23374, An=
drew Schoen)<br>
&gt; * ceph-volume: tests.functional inherit SSH_ARGS from ansible (issue#3=
4311, pr#23813, Alfredo Deza)<br>
&gt; * ceph-volume tests/functional run lvm list after OSD provisioning (is=
sue#24961, pr#23147, Alfredo Deza)<br>
&gt; * ceph-volume: unmount lvs correctly before zapping (issue#24796, pr#2=
3128, Andrew Schoen)<br>
&gt; * ceph-volume: update batch documentation to explain filestore strateg=
ies (issue#34309, pr#23825, Alfredo Deza)<br>
&gt; * change default filestore_merge_threshold to -10 (issue#24686, pr#228=
14, Douglas Fuller)<br>
&gt; * client: add inst to asok status output (issue#24724, pr#23107, Patri=
ck Donnelly)<br>
&gt; * client: fixup parallel calls to ceph_ll_lookup_inode() in NFS FASL (=
issue#22683, pr#23012, huanwen ren)<br>
&gt; * client: increase verbosity level for log messages in helper methods =
(issue#21014, pr#23014, Rishabh Dave)<br>
&gt; * client:=C2=A0 update inode fields according to issued caps (issue#24=
269, pr#22783, &quot;Yan, Zheng&quot;)<br>
&gt; * common: Abort in OSDMap::decode() during qa/standalone/erasure-code/=
test-erasure-eio.sh (issue#23492, pr#23025, Sage Weil)<br>
&gt; * common/DecayCounter: set last_decay to current time when decoding de=
cay counter (issue#24440, pr#22779, Zhi Zhang)<br>
&gt; * doc: ceph-bluestore-tool manpage not getting rendered correctly (iss=
ue#24800, pr#23177, Nathan Cutler)<br>
&gt; * filestore: add pgid in filestore pg dir split log message (issue#248=
78, pr#23454, Vikhyat Umrao)<br>
&gt; * let &quot;ceph status&quot; use base 10 when printing numbers not si=
zes (issue#22095, pr#22680, Jan Fajerski, Kefu Chai)<br>
&gt; * librados: fix buffer overflow for aio_exec python binding (issue#239=
64, pr#22708, Aleksei Gutikov)<br>
&gt; * librbd: force &#39;invalid object map&#39; flag on-disk update (issu=
e#24434, pr#22753, Mykola Golub)<br>
&gt; * librbd: utilize the journal disabled policy when removing images (is=
sue#23512, pr#23595, Jason Dillaman)<br>
&gt; * mds: don&#39;t report slow request for blocked filelock request (iss=
ue#22428, pr#22782, &quot;Yan, Zheng&quot;)<br>
&gt; * mds: dump recent events on respawn (issue#24853, pr#23213, Patrick D=
onnelly)<br>
&gt; * mds: handle discontinuous mdsmap (issue#24856, pr#23169, &quot;Yan, =
Zheng&quot;)<br>
&gt; * mds: increase debug level for dropped client cap msg (issue#24855, p=
r#23214, Patrick Donnelly)<br>
&gt; * mds: low wrlock efficiency due to dirfrags traversal (issue#24467, p=
r#22885, Xuehan Xu)<br>
&gt; * mds: print mdsmap processed at low debug level (issue#24852, pr#2321=
2, Patrick Donnelly)<br>
&gt; * mds: scrub doesn&#39;t always return JSON results (issue#23958, pr#2=
3222, Venky Shankar)<br>
&gt; * mds: unset deleted vars in shutdown_pass (issue#23766, pr#23015, Pat=
rick Donnelly)<br>
&gt; * mgr: add units to performance counters (issue#22747, pr#23266, Ernes=
to Puerta, Rubab Syed)<br>
&gt; * mgr: ceph osd safe-to-destroy crashes the mgr (issue#23249, pr#22806=
, Sage Weil)<br>
&gt; * mgr/MgrClient: Protect daemon_health_metrics (issue#23352, pr#23459,=
 Kjetil Joergensen, Brad Hubbard)<br>
&gt; * mon: Add option to view IP addresses of clients in output of &#39;ce=
ph features&#39; (issue#21315, pr#22773, Paul Emmerich)<br>
&gt; * mon/HealthMonitor: do not send MMonHealthChecks to pre-luminous mon =
(issue#24481, pr#22655, Sage Weil)<br>
&gt; * os/bluestore: fix flush_commit locking (issue#21480, pr#22904, Sage =
Weil)<br>
&gt; * os/bluestore: fix incomplete faulty range marking when doing compres=
sion (issue#21480, pr#22909, Igor Fedotov)<br>
&gt; * os/bluestore: fix races on SharedBlob::coll in ~SharedBlob (issue#24=
859, pr#23064, Radoslaw Zarzynski)<br>
&gt; * osdc: Fix the wrong BufferHead offset (issue#24484, pr#22865, dongdo=
ng tao)<br>
&gt; * osd: do_sparse_read(): Verify checksum earlier so we will try to rep=
air and missed backport (issue#24875, pr#23379, xie xingguo, David Zafman)<=
br>
&gt; * osd: eternal stuck PG in &#39;unfound_recovery&#39; (issue#24373, pr=
#22546, Sage Weil)<br>
&gt; * osd: may get empty info at recovery (issue#24588, pr#22862, Sage Wei=
l)<br>
&gt; * osd/OSDMap: CRUSH_TUNABLES5 added in jewel, not kraken (issue#25057,=
 pr#23227, Sage Weil)<br>
&gt; * osd/Session: fix invalid iterator dereference in Sessoin::have_backo=
ff() (issue#24486, pr#22729, Sage Weil)<br>
&gt; * pjd: cd: too many arguments (issue#24307, pr#22883, Neha Ojha)<br>
&gt; * PurgeQueue sometimes ignores Journaler errors (issue#24533, pr#22811=
, John Spray)<br>
&gt; * pybind: pybind/mgr/mgr_module: make rados handle available to all mo=
dules (issue#24788, issue#25102, pr#23235, Ernesto Puerta, Sage Weil)<br>
&gt; * pybind: Python bindings use iteritems method which is not Python 3 c=
ompatible (issue#24779, pr#22918, Nathan Cutler, Kefu Chai)<br>
&gt; * pybind: rados.pyx: make all exceptions accept keyword arguments (iss=
ue#24033, pr#22979, Rishabh Dave)<br>
&gt; * rbd: fix issues in IEC unit handling (issue#26927, issue#26928, pr#2=
3776, Jason Dillaman)<br>
&gt; * repeated eviction of idle client until some IO happens (issue#24052,=
 pr#22780, &quot;Yan, Zheng&quot;)<br>
&gt; * rgw: add curl_low_speed_limit and curl_low_speed_time config to avoi=
d the thread hangs in data sync (issue#25019, pr#23144, Mark Kogan, Zhang S=
haowen)<br>
&gt; * rgw: add unit test for cls bi list command (issue#24483, pr#22846, O=
rit Wasserman, Xinying Song)<br>
&gt; * rgw: do not ignore EEXIST in RGWPutObj::execute (issue#22790, pr#232=
07, Matt Benjamin)<br>
&gt; * rgw: fail to recover index from crash luminous backport (issue#24640=
, issue#24280, pr#23130, Tianshan Qu)<br>
&gt; * rgw: fix gc may cause a large number of read traffic (issue#24767, p=
r#22984, Xin Liao)<br>
&gt; * rgw: fix the bug of radowgw-admin zonegroup set requires realm (issu=
e#21583, pr#22767, lvshanchun)<br>
&gt; * rgw: have a configurable authentication order (issue#23089, pr#23501=
, Abhishek Lekshmanan)<br>
&gt; * rgw: index complete miss zones_trace set (issue#24590, pr#22820, Tia=
nshan Qu)<br>
&gt; * rgw: Invalid Access-Control-Request-Request may bypass validate_cors=
_rule_method (issue#24223, pr#22934, Jeegn Chen)<br>
&gt; * rgw: meta and data notify thread miss stop cr manager (issue#24589, =
pr#22822, Tianshan Qu)<br>
&gt; * rgw-multisite: endless loop in RGWBucketShardIncrementalSyncCR (issu=
e#24603, pr#22817, cfanz)<br>
&gt; * rgw performance regression for luminous 12.2.4 (issue#23379, pr#2293=
0, Mark Kogan)<br>
&gt; * rgw: radogw-admin reshard status command should print text for resha=
r=E2=80=A6 (issue#23257, pr#23019, Orit Wasserman)<br>
&gt; * rgw: &quot;radosgw-admin objects expire&quot; always returns ok even=
 if the pro=E2=80=A6 (issue#24592, pr#23000, Zhang Shaowen)<br>
&gt; * rgw: require --yes-i-really-mean-it to run radosgw-admin orphans fin=
d (issue#24146, pr#22985, Matt Benjamin)<br>
&gt; * rgw: REST admin metadata API paging failure bucket &amp; bucket.inst=
ance: InvalidArgument (issue#23099, pr#22932, Matt Benjamin)<br>
&gt; * rgw: set cr state if aio_read err return in RGWCloneMetaLogCoroutine=
 (issue#24566, pr#22942, Tianshan Qu)<br>
&gt; * spdk: fix ceph-osd crash when activate SPDK (issue#24371, pr#22686, =
tone-zhang)<br>
&gt; * tools/ceph-objectstore-tool: split filestore directories offline to =
target hash level (issue#21366, pr#23418, Zhi Zhang)<br>
&gt;<br>
&gt; Getting ceph:<br>
&gt; ------------<br>
&gt; * Git at git://<a href=3D"http://github.com/ceph/ceph.git" rel=3D"nore=
ferrer" target=3D"_blank">github.com/ceph/ceph.git</a><br>
&gt; * Tarball at <a href=3D"http://download.ceph.com/tarballs/ceph-12.2.8.=
tar.gz" rel=3D"noreferrer" target=3D"_blank">http://download.ceph.com/tarba=
lls/ceph-12.2.8.tar.gz</a><br>
&gt; * For packages, see <a href=3D"http://docs.ceph.com/docs/master/instal=
l/get-packages/" rel=3D"noreferrer" target=3D"_blank">http://docs.ceph.com/=
docs/master/install/get-packages/</a><br>
&gt; * Release git sha1: ae699615bac534ea496ee965ac6192cb7e0e07c0<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Abhishek Lekshmanan<br>
&gt; SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nor=
ton,<br>
&gt; HRB 21284 (AG N=C3=BCrnberg)<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--000000000000a34d9c0575222539--

--===============7669385190697047187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7669385190697047187==--

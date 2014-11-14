From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: v0.88 released
Date: Fri, 14 Nov 2014 12:54:10 -0700
Message-ID: <CAANLjFq1X--bKJPO4a1AhQsJGKJZi7wzCXugcv=PDbzrnLmupg@mail.gmail.com>
References: <alpine.DEB.2.00.1411111624020.22119@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0097643904=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1411111624020.22119-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0097643904==
Content-Type: multipart/alternative; boundary=f46d04428da817edf90507d6fec9

--f46d04428da817edf90507d6fec9
Content-Type: text/plain; charset=UTF-8

Will there be RPMs built for this release?

Thanks,

On Tue, Nov 11, 2014 at 5:24 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> This is the first development release after Giant.  The two main
> features merged this round are the new AsyncMessenger (an alternative
> implementation of the network layer) from Haomai Wang at UnitedStack,
> and support for POSIX file locks in ceph-fuse and libcephfs from Yan,
> Zheng.  There is also a big pile of smaller items that re merged while
> we were stabilizing Giant, including a range of smaller performance
> and bug fixes and some new tracepoints for LTTNG.
>
> Notable Changes
> ---------------
>
> * ceph-disk: Scientific Linux support (Dan van der Ster)
> * ceph-disk: respect --statedir for keyring (Loic Dachary)
> * ceph-fuse, libcephfs: POSIX file lock support (Yan, Zheng)
> * ceph-fuse, libcephfs: fix cap flush overflow (Greg Farnum, Yan, Zheng)
> * ceph-fuse, libcephfs: fix root inode xattrs (Yan, Zheng)
> * ceph-fuse, libcephfs: preserve dir ordering (#9178 Yan, Zheng)
> * ceph-fuse, libcephfs: trim inodes before reconnecting to MDS (Yan,
>   Zheng)
> * ceph: do not parse injectargs twice (Loic Dachary)
> * ceph: make 'ceph -s' output more readable (Sage Weil)
> * ceph: new 'ceph tell mds.$name_or_rank_or_gid' (John Spray)
> * ceph: test robustness (Joao Eduardo Luis)
> * ceph_objectstore_tool: behave with sharded flag (#9661 David Zafman)
> * cephfs-journal-tool: fix journal import (#10025 John Spray)
> * cephfs-journal-tool: skip up to expire_pos (#9977 John Spray)
> * cleanup rados.h definitions with macros (Ilya Dryomov)
> * common: shared_cache unit tests (Cheng Cheng)
> * config: add $cctid meta variable (Adam Crume)
> * crush: fix buffer overrun for poorly formed rules (#9492 Johnu George)
> * crush: improve constness (Loic Dachary)
> * crushtool: add --location <id> command (Sage Weil, Loic Dachary)
> * default to libnss instead of crypto++ (Federico Gimenez)
> * doc: ceph osd reweight vs crush weight (Laurent Guerby)
> * doc: document the LRC per-layer plugin configuration (Yuan Zhou)
> * doc: erasure code doc updates (Loic Dachary)
> * doc: misc updates (Alfredo Deza, VRan Liu)
> * doc: preflight doc fixes (John Wilkins)
> * doc: update PG count guide (Gerben Meijer, Laurent Guerby, Loic Dachary)
> * keyvaluestore: misc fixes (Haomai Wang)
> * keyvaluestore: performance improvements (Haomai Wang)
> * librados: add rados_pool_get_base_tier() call (Adam Crume)
> * librados: cap buffer length (Loic Dachary)
> * librados: fix objecter races (#9617 Josh Durgin)
> * libradosstriper: misc fixes (Sebastien Ponce)
> * librbd: add missing python docstrings (Jason Dillaman)
> * librbd: add readahead (Adam Crume)
> * librbd: fix cache tiers in list_children and snap_unprotect (Adam Crume)
> * librbd: fix performance regression in ObjectCacher (#9513 Adam Crume)
> * librbd: lttng tracepoints (Adam Crume)
> * librbd: misc fixes (Xinxin Shu, Jason Dillaman)
> * mds: fix sessionmap lifecycle bugs (Yan, Zheng)
> * mds: initialize root inode xattr version (Yan, Zheng)
> * mds: introduce auth caps (John Spray)
> * mds: misc bugs (Greg Farnum, John Spray, Yan, Zheng, Henry Change)
> * misc coverity fixes (Danny Al-Gaaf)
> * mon: add 'ceph osd rename-bucket ...' command (Loic Dachary)
> * mon: clean up auth list output (Loic Dachary)
> * mon: fix 'osd crush link' id resolution (John Spray)
> * mon: fix misc error paths (Joao Eduardo Luis)
> * mon: fix paxos off-by-one corner case (#9301 Sage Weil)
> * mon: new 'ceph pool ls [detail]' command (Sage Weil)
> * mon: wait for writeable before cross-proposing (#9794 Joao Eduardo Luis)
> * msgr: avoid useless new/delete (Haomai Wang)
> * msgr: fix delay injection bug (#9910 Sage Weil, Greg Farnum)
> * msgr: new AsymcMessenger alternative implementation (Haomai Wang)
> * msgr: prefetch data when doing recv (Yehuda Sadeh)
> * osd: add erasure code corpus (Loic Dachary)
> * osd: add misc tests (Loic Dachary, Danny Al-Gaaf)
> * osd: cleanup boost optionals (William Kennington)
> * osd: expose non-journal backends via ceph-osd CLI (Hoamai Wang)
> * osd: fix JSON output for stray OSDs (Loic Dachary)
> * osd: fix ioprio options (Loic Dachary)
> * osd: fix transaction accounting (Jianpeng Ma)
> * osd: misc optimizations (Xinxin Shu, Zhiqiang Wang, Xinze Chi)
> * osd: use FIEMAP_FLAGS_SYNC instead of fsync (Jianpeng Ma)
> * rados: fix put of /dev/null (Loic Dachary)
> * rados: parse command-line arguments more strictly (#8983 Adam Crume)
> * rbd-fuse: fix memory leak (Adam Crume)
> * rbd-replay-many (Adam Crume)
> * rbd-replay: --anonymize flag to rbd-replay-prep (Adam Crume)
> * rbd: fix 'rbd diff' for non-existent objects (Adam Crume)
> * rbd: fix error when striping with format 1 (Sebastien Han)
> * rbd: fix export for image sizes over 2GB (Vicente Cheng)
> * rbd: use rolling average for rbd bench-write throughput (Jason Dillaman)
> * rgw: send explicit HTTP status string (Yehuda Sadeh)
> * rgw: set length for keystone token validation request (#7796 Yehuda
>   Sadeh, Mark Kirkwood)
> * udev: fix rules for CentOS7/RHEL7 (Loic Dachary)
> * use clock_gettime instead of gettimeofday (Jianpeng Ma)
> * vstart.sh: set up environment for s3-tests (Luis Pabon)
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-0.88.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see
> http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--f46d04428da817edf90507d6fec9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Will there be RPMs built for this release?<div><br></div><=
div>Thanks,</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Tue, Nov 11, 2014 at 5:24 PM, Sage Weil <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">This is the first developme=
nt release after Giant.=C2=A0 The two main<br>
features merged this round are the new AsyncMessenger (an alternative<br>
implementation of the network layer) from Haomai Wang at UnitedStack,<br>
and support for POSIX file locks in ceph-fuse and libcephfs from Yan,<br>
Zheng.=C2=A0 There is also a big pile of smaller items that re merged while=
<br>
we were stabilizing Giant, including a range of smaller performance<br>
and bug fixes and some new tracepoints for LTTNG.<br>
<br>
Notable Changes<br>
---------------<br>
<br>
* ceph-disk: Scientific Linux support (Dan van der Ster)<br>
* ceph-disk: respect --statedir for keyring (Loic Dachary)<br>
* ceph-fuse, libcephfs: POSIX file lock support (Yan, Zheng)<br>
* ceph-fuse, libcephfs: fix cap flush overflow (Greg Farnum, Yan, Zheng)<br=
>
* ceph-fuse, libcephfs: fix root inode xattrs (Yan, Zheng)<br>
* ceph-fuse, libcephfs: preserve dir ordering (#9178 Yan, Zheng)<br>
* ceph-fuse, libcephfs: trim inodes before reconnecting to MDS (Yan,<br>
=C2=A0 Zheng)<br>
* ceph: do not parse injectargs twice (Loic Dachary)<br>
* ceph: make &#39;ceph -s&#39; output more readable (Sage Weil)<br>
* ceph: new &#39;ceph tell mds.$name_or_rank_or_gid&#39; (John Spray)<br>
* ceph: test robustness (Joao Eduardo Luis)<br>
* ceph_objectstore_tool: behave with sharded flag (#9661 David Zafman)<br>
* cephfs-journal-tool: fix journal import (#10025 John Spray)<br>
* cephfs-journal-tool: skip up to expire_pos (#9977 John Spray)<br>
* cleanup rados.h definitions with macros (Ilya Dryomov)<br>
* common: shared_cache unit tests (Cheng Cheng)<br>
* config: add $cctid meta variable (Adam Crume)<br>
* crush: fix buffer overrun for poorly formed rules (#9492 Johnu George)<br=
>
* crush: improve constness (Loic Dachary)<br>
* crushtool: add --location &lt;id&gt; command (Sage Weil, Loic Dachary)<br=
>
* default to libnss instead of crypto++ (Federico Gimenez)<br>
* doc: ceph osd reweight vs crush weight (Laurent Guerby)<br>
* doc: document the LRC per-layer plugin configuration (Yuan Zhou)<br>
* doc: erasure code doc updates (Loic Dachary)<br>
* doc: misc updates (Alfredo Deza, VRan Liu)<br>
* doc: preflight doc fixes (John Wilkins)<br>
* doc: update PG count guide (Gerben Meijer, Laurent Guerby, Loic Dachary)<=
br>
* keyvaluestore: misc fixes (Haomai Wang)<br>
* keyvaluestore: performance improvements (Haomai Wang)<br>
* librados: add rados_pool_get_base_tier() call (Adam Crume)<br>
* librados: cap buffer length (Loic Dachary)<br>
* librados: fix objecter races (#9617 Josh Durgin)<br>
* libradosstriper: misc fixes (Sebastien Ponce)<br>
* librbd: add missing python docstrings (Jason Dillaman)<br>
* librbd: add readahead (Adam Crume)<br>
* librbd: fix cache tiers in list_children and snap_unprotect (Adam Crume)<=
br>
* librbd: fix performance regression in ObjectCacher (#9513 Adam Crume)<br>
* librbd: lttng tracepoints (Adam Crume)<br>
* librbd: misc fixes (Xinxin Shu, Jason Dillaman)<br>
* mds: fix sessionmap lifecycle bugs (Yan, Zheng)<br>
* mds: initialize root inode xattr version (Yan, Zheng)<br>
* mds: introduce auth caps (John Spray)<br>
* mds: misc bugs (Greg Farnum, John Spray, Yan, Zheng, Henry Change)<br>
* misc coverity fixes (Danny Al-Gaaf)<br>
* mon: add &#39;ceph osd rename-bucket ...&#39; command (Loic Dachary)<br>
* mon: clean up auth list output (Loic Dachary)<br>
* mon: fix &#39;osd crush link&#39; id resolution (John Spray)<br>
* mon: fix misc error paths (Joao Eduardo Luis)<br>
* mon: fix paxos off-by-one corner case (#9301 Sage Weil)<br>
* mon: new &#39;ceph pool ls [detail]&#39; command (Sage Weil)<br>
* mon: wait for writeable before cross-proposing (#9794 Joao Eduardo Luis)<=
br>
* msgr: avoid useless new/delete (Haomai Wang)<br>
* msgr: fix delay injection bug (#9910 Sage Weil, Greg Farnum)<br>
* msgr: new AsymcMessenger alternative implementation (Haomai Wang)<br>
* msgr: prefetch data when doing recv (Yehuda Sadeh)<br>
* osd: add erasure code corpus (Loic Dachary)<br>
* osd: add misc tests (Loic Dachary, Danny Al-Gaaf)<br>
* osd: cleanup boost optionals (William Kennington)<br>
* osd: expose non-journal backends via ceph-osd CLI (Hoamai Wang)<br>
* osd: fix JSON output for stray OSDs (Loic Dachary)<br>
* osd: fix ioprio options (Loic Dachary)<br>
* osd: fix transaction accounting (Jianpeng Ma)<br>
* osd: misc optimizations (Xinxin Shu, Zhiqiang Wang, Xinze Chi)<br>
* osd: use FIEMAP_FLAGS_SYNC instead of fsync (Jianpeng Ma)<br>
* rados: fix put of /dev/null (Loic Dachary)<br>
* rados: parse command-line arguments more strictly (#8983 Adam Crume)<br>
* rbd-fuse: fix memory leak (Adam Crume)<br>
* rbd-replay-many (Adam Crume)<br>
* rbd-replay: --anonymize flag to rbd-replay-prep (Adam Crume)<br>
* rbd: fix &#39;rbd diff&#39; for non-existent objects (Adam Crume)<br>
* rbd: fix error when striping with format 1 (Sebastien Han)<br>
* rbd: fix export for image sizes over 2GB (Vicente Cheng)<br>
* rbd: use rolling average for rbd bench-write throughput (Jason Dillaman)<=
br>
* rgw: send explicit HTTP status string (Yehuda Sadeh)<br>
* rgw: set length for keystone token validation request (#7796 Yehuda<br>
=C2=A0 Sadeh, Mark Kirkwood)<br>
* udev: fix rules for CentOS7/RHEL7 (Loic Dachary)<br>
* use clock_gettime instead of gettimeofday (Jianpeng Ma)<br>
* vstart.sh: set up environment for s3-tests (Luis Pabon)<br>
<br>
Getting Ceph<br>
------------<br>
<br>
* Git at git://<a href=3D"http://github.com/ceph/ceph.git" target=3D"_blank=
">github.com/ceph/ceph.git</a><br>
* Tarball at <a href=3D"http://ceph.com/download/ceph-0.88.tar.gz" target=
=3D"_blank">http://ceph.com/download/ceph-0.88.tar.gz</a><br>
* For packages, see <a href=3D"http://ceph.com/docs/master/install/get-pack=
ages" target=3D"_blank">http://ceph.com/docs/master/install/get-packages</a=
><br>
* For ceph-deploy, see <a href=3D"http://ceph.com/docs/master/install/insta=
ll-ceph-deploy" target=3D"_blank">http://ceph.com/docs/master/install/insta=
ll-ceph-deploy</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--f46d04428da817edf90507d6fec9--

--===============0097643904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0097643904==--

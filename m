From: =?EUC-KR?B?wMzB1sfl?= <kirrie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.68 released
Date: Thu, 5 Sep 2013 11:12:38 +0900
Message-ID: <CAPvW-GXq5Z85ookp3NnL6MRQOGSg+CaDTS32fGaUdUgxED=QmA@mail.gmail.com>
References: <alpine.DEB.2.00.1309041131130.2327@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0492159629=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1309041131130.2327-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0492159629==
Content-Type: multipart/alternative; boundary=001a1133d526c3a3a104e5997469

--001a1133d526c3a3a104e5997469
Content-Type: text/plain; charset=ISO-8859-1

Debian/Ubuntu packages is still 0.67.2.


I've been watching my every step since 1995.
http://kirrie.pe.kr


2013/9/5 Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>

> Our first development release after Dumpling has arrived! It includes a
> lot of small cleanups and documentation improvements, as well as the first
> blueprint from the Emperor CDS to land (support for ZFS). There are also
> new sample implementations for RADOS classes (cls_hello) and a sample
> librados application (hello_world) to help developers and users get
> started.
>
> Notable changes since v0.67:
>
>  * ceph-fuse: fix problem with readahead vs truncate race (Yan, Zheng)
>  * ceph-post-file: new command to easily share logs or other files with
>    ceph devs
>  * ceph: parse CEPH_ARGS env variable
>  * librados: fix async aio completion wakeup
>  * librados: hello_world example (Greg Farnum)
>  * librados: sync calls now return on commit (instead of ack) (Greg
>    Farnum)
>  * mds: fix mds rejoin with legacy parent backpointer xattrs (Alexandre
>    Oliva)
>  * mds: fix rare restart/failure race during fs creation
>  * mds: notify clients about deleted files (so they can release from their
>    cache) (Yan, Zheng)
>  * mds: several bug fixes with clustered mds (Yan, Zheng)
>  * mon: allow logging level of cluster log (/var/log/ceph/ceph.log) to be
>    adjusted
>  * mon: do not expose uncommitted state from 'osd crush {add,set} ...'
>    (Joao Luis)
>  * mon: fix byte counts (off by factor of 4) (Dan Mick, Joao Luis)
>  * mon: fix paxos corner case
>  * mon: modify 'auth add' semantics to make a bit more sense (Joao Luis)
>  * mon: new 'osd perf' command to dump recent performance information
>    (Samuel Just)
>  * mon: new and improved 'ceph -s' or 'ceph status' command (more info,
>    easier to read)
>  * monc: fix small memory leak
>  * new wireshark patches pulled into the tree (Kevin Jones)
>  * objecter: fix possible hang when cluster is unpaused (Josh Durgin)
>  * osd: 'osd recover clone overlap limit' option to limit cloning during
>    recovery (Samuel Just)
>  * osd: cls_hello OSD class example
>  * osd: experiemental support for ZFS (zfsonlinux.org) (Yan, Zheng)
>  * osd: instrument peering states (David Zafman)
>  * osd: properly enforce RD/WR flags for rados classes
>  * osd: remove old pg log on upgrade (Samuel Just)
>  * rgw: complete in-progress requests before shutting down
>  * rgw: fix S3 auth with response-* query string params (Sylvain Munaut,
>    Yehuda Sadeh)
>  * sysvinit: add condrestart command (Dan van der Ster)
>
> For more information please refer to the complete release notes:
>
>  * http://ceph.com/docs/master/release-notes/#v0-68
>
> Meanwhile, the v0.69 development has just gone into feature freeze and
> includes some preliminary infrastructure and groundwork for the RADOS
> tiering functionality (initially, cache pools).
>
> You can get v0.68 from the usual locations:
>
>  * Git at git://github.com/ceph/ceph.git
>  * Tarball at http://ceph.com/download/ceph-0.68.tar.gz
>  * For Debian/Ubuntu packages, see
> http://ceph.com/docs/master/install/debian
>  * For RPMs, see http://ceph.com/docs/master/install/rpm
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a1133d526c3a3a104e5997469
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Debian/Ubuntu packages is still 0.67.2.<div><br></div></di=
v><div class=3D"gmail_extra"><br clear=3D"all"><div><div dir=3D"ltr">I&#39;=
ve been watching my every step since 1995.<br><a href=3D"http://kirrie.pe.k=
r" target=3D"_blank">http://kirrie.pe.kr</a></div>
</div>
<br><br><div class=3D"gmail_quote">2013/9/5 Sage Weil <span dir=3D"ltr">&lt=
;<a href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>=
&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
Our first development release after Dumpling has arrived! It includes a<br>
lot of small cleanups and documentation improvements, as well as the first<=
br>
blueprint from the Emperor CDS to land (support for ZFS). There are also<br=
>
new sample implementations for RADOS classes (cls_hello) and a sample<br>
librados application (hello_world) to help developers and users get<br>
started.<br>
<br>
Notable changes since v0.67:<br>
<br>
=A0* ceph-fuse: fix problem with readahead vs truncate race (Yan, Zheng)<br=
>
=A0* ceph-post-file: new command to easily share logs or other files with<b=
r>
=A0 =A0ceph devs<br>
=A0* ceph: parse CEPH_ARGS env variable<br>
=A0* librados: fix async aio completion wakeup<br>
=A0* librados: hello_world example (Greg Farnum)<br>
=A0* librados: sync calls now return on commit (instead of ack) (Greg<br>
=A0 =A0Farnum)<br>
=A0* mds: fix mds rejoin with legacy parent backpointer xattrs (Alexandre<b=
r>
=A0 =A0Oliva)<br>
=A0* mds: fix rare restart/failure race during fs creation<br>
=A0* mds: notify clients about deleted files (so they can release from thei=
r<br>
=A0 =A0cache) (Yan, Zheng)<br>
=A0* mds: several bug fixes with clustered mds (Yan, Zheng)<br>
=A0* mon: allow logging level of cluster log (/var/log/ceph/ceph.log) to be=
<br>
=A0 =A0adjusted<br>
=A0* mon: do not expose uncommitted state from &#39;osd crush {add,set} ...=
&#39;<br>
=A0 =A0(Joao Luis)<br>
=A0* mon: fix byte counts (off by factor of 4) (Dan Mick, Joao Luis)<br>
=A0* mon: fix paxos corner case<br>
=A0* mon: modify &#39;auth add&#39; semantics to make a bit more sense (Joa=
o Luis)<br>
=A0* mon: new &#39;osd perf&#39; command to dump recent performance informa=
tion<br>
=A0 =A0(Samuel Just)<br>
=A0* mon: new and improved &#39;ceph -s&#39; or &#39;ceph status&#39; comma=
nd (more info,<br>
=A0 =A0easier to read)<br>
=A0* monc: fix small memory leak<br>
=A0* new wireshark patches pulled into the tree (Kevin Jones)<br>
=A0* objecter: fix possible hang when cluster is unpaused (Josh Durgin)<br>
=A0* osd: &#39;osd recover clone overlap limit&#39; option to limit cloning=
 during<br>
=A0 =A0recovery (Samuel Just)<br>
=A0* osd: cls_hello OSD class example<br>
=A0* osd: experiemental support for ZFS (<a href=3D"http://zfsonlinux.org" =
target=3D"_blank">zfsonlinux.org</a>) (Yan, Zheng)<br>
=A0* osd: instrument peering states (David Zafman)<br>
=A0* osd: properly enforce RD/WR flags for rados classes<br>
=A0* osd: remove old pg log on upgrade (Samuel Just)<br>
=A0* rgw: complete in-progress requests before shutting down<br>
=A0* rgw: fix S3 auth with response-* query string params (Sylvain Munaut,<=
br>
=A0 =A0Yehuda Sadeh)<br>
=A0* sysvinit: add condrestart command (Dan van der Ster)<br>
<br>
For more information please refer to the complete release notes:<br>
<br>
=A0* <a href=3D"http://ceph.com/docs/master/release-notes/#v0-68" target=3D=
"_blank">http://ceph.com/docs/master/release-notes/#v0-68</a><br>
<br>
Meanwhile, the v0.69 development has just gone into feature freeze and<br>
includes some preliminary infrastructure and groundwork for the RADOS<br>
tiering functionality (initially, cache pools).<br>
<br>
You can get v0.68 from the usual locations:<br>
<br>
=A0* Git at git://<a href=3D"http://github.com/ceph/ceph.git" target=3D"_bl=
ank">github.com/ceph/ceph.git</a><br>
=A0* Tarball at <a href=3D"http://ceph.com/download/ceph-0.68.tar.gz" targe=
t=3D"_blank">http://ceph.com/download/ceph-0.68.tar.gz</a><br>
=A0* For Debian/Ubuntu packages, see <a href=3D"http://ceph.com/docs/master=
/install/debian" target=3D"_blank">http://ceph.com/docs/master/install/debi=
an</a><br>
=A0* For RPMs, see <a href=3D"http://ceph.com/docs/master/install/rpm" targ=
et=3D"_blank">http://ceph.com/docs/master/install/rpm</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--001a1133d526c3a3a104e5997469--

--===============0492159629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0492159629==--

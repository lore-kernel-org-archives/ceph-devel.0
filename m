From: Roland Rabben <roland@jotta.no>
Subject: Re: v0.19.1 stable updates
Date: Tue, 9 Mar 2010 14:29:49 +0100
Message-ID: <b418ca0b1003090529l7f27aedes4c92f40e6815ed39@mail.gmail.com>
References: <201003091648.36832.anton.vazir@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0186170686390118144=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <201003091648.36832.anton.vazir@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Anton <anton.vazir@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@lists.sourceforge.net, ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

--===============0186170686390118144==
Content-Type: multipart/alternative; boundary=00032555455e07328104815e2d50

--00032555455e07328104815e2d50
Content-Type: text/plain; charset=UTF-8

Same story with me. Currently a frustrated Gluster user waiting for that
message saying things are safe to store data with CEPH - in production.

Regards,
Roland



2010/3/9 Anton <anton.vazir@gmail.com>

> Sage, do you think CEPH now is ok (stable enough) to be
> atleast sure that uploaded data will not be corrupted, (and
> could be recovered in the case of fault) - for use as simple
> file store - say in the scenario of  "upload/modify rarely,
> read often"?. Right now I use Gluster as clustered FS - but
> overhead of 1+1 replication in Gluster is just HUGE
>
> Regards,
> Anton.
>
> On Wednesday 03 March 2010, Sage Weil wrote:
> > Hi all,
> >
> > We've pushed out some stable updates to master granches
> >  of the git trees and tagged a 0.19.1 stable release.
> >  For the server side, the fixes are minor: mainly a
> >  problem with /etc/init.d/ceph when /bin/sh is dash
> >  (ubuntu) and a rare mds crash.  The kernel client fixes
> >  are a bit more significant: mainly a bad write(2) return
> >  value and a crash when snapshots were deleted.
> >
> > sage
> >
> > -- server side ------------------
> >
> > Sage Weil (8):
> >       debian: mount.ceph in /sbin, not /usr/sbin
> >       Makefile: include debian/
> >       Makefile: fix /sbin hack
> >       mds: fix sessionmap decoding
> >       init-ceph: don't barf on dash when no command
> >       cauthtool: --caps fn alone is a command
> >       debian: new release, push, build, publish scripts
> >       0.19.1
> >
> > Yehuda Sadeh (1):
> >       automake: fix mount sbin dir when configured with
> >  prefix
> >
> >
> > -- kernel client -----------------
> >
> > Alexander Beregalov (1):
> >       ceph: move dereference after NULL test
> >
> > Sage Weil (5):
> >       ceph: fix handle_forward parsing
> >       ceph: reset front len on return to msgpool; BUG on
> >  mismatched front iov ceph: set osd request message front
> >  length correctly ceph: fix osdmap decoding when pools
> >  include (removed) snaps ceph: v0.19.1 stable release
> >
> > Yehuda Sadeh (1):
> >       ceph: don't clobber write return value when using
> >  O_SYNC
> >
> >
> > ---------------------------------------------------------
> > --------------------- Download Intel&#174; Parallel
> >  Studio Eval
> > Try the new software tools for yourself. Speed compiling,
> >  find bugs proactively, and fine-tune applications for
> >  parallel performance. See why Intel Parallel Studio got
> >  high marks during beta. http://p.sf.net/sfu/intel-sw-dev
> > _______________________________________________
> > Ceph-devel mailing list
> > Ceph-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ceph-devel
> >
>
>
>
>
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>



-- 
Roland Rabben
Founder & CEO Jotta AS
Cell: +47 90 85 85 39
Phone: +47 21 04 29 00
Email: roland@jotta.no

--00032555455e07328104815e2d50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Same story with me. Currently a frustrated Gluster user waiting for that me=
ssage saying things are safe to store data with CEPH - in production.<br><b=
r>Regards,<br>Roland<br><br><br><br><div class=3D"gmail_quote">2010/3/9 Ant=
on <span dir=3D"ltr">&lt;<a href=3D"mailto:anton.vazir@gmail.com">anton.vaz=
ir@gmail.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Sage, do you thin=
k CEPH now is ok (stable enough) to be<br>
atleast sure that uploaded data will not be corrupted, (and<br>
could be recovered in the case of fault) - for use as simple<br>
file store - say in the scenario of =C2=A0&quot;upload/modify rarely,<br>
read often&quot;?. Right now I use Gluster as clustered FS - but<br>
overhead of 1+1 replication in Gluster is just HUGE<br>
<br>
Regards,<br>
<font color=3D"#888888">Anton.<br>
</font><div><div></div><div class=3D"h5"><br>
On Wednesday 03 March 2010, Sage Weil wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; We&#39;ve pushed out some stable updates to master granches<br>
&gt; =C2=A0of the git trees and tagged a 0.19.1 stable release.<br>
&gt; =C2=A0For the server side, the fixes are minor: mainly a<br>
&gt; =C2=A0problem with /etc/init.d/ceph when /bin/sh is dash<br>
&gt; =C2=A0(ubuntu) and a rare mds crash. =C2=A0The kernel client fixes<br>
&gt; =C2=A0are a bit more significant: mainly a bad write(2) return<br>
&gt; =C2=A0value and a crash when snapshots were deleted.<br>
&gt;<br>
&gt; sage<br>
&gt;<br>
&gt; -- server side ------------------<br>
&gt;<br>
&gt; Sage Weil (8):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 debian: mount.ceph in /sbin, not /usr/sbin<br>
&gt; =C2=A0 =C2=A0 =C2=A0 Makefile: include debian/<br>
&gt; =C2=A0 =C2=A0 =C2=A0 Makefile: fix /sbin hack<br>
&gt; =C2=A0 =C2=A0 =C2=A0 mds: fix sessionmap decoding<br>
&gt; =C2=A0 =C2=A0 =C2=A0 init-ceph: don&#39;t barf on dash when no command=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 cauthtool: --caps fn alone is a command<br>
&gt; =C2=A0 =C2=A0 =C2=A0 debian: new release, push, build, publish scripts=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 0.19.1<br>
&gt;<br>
&gt; Yehuda Sadeh (1):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 automake: fix mount sbin dir when configured with=
<br>
&gt; =C2=A0prefix<br>
&gt;<br>
&gt;<br>
&gt; -- kernel client -----------------<br>
&gt;<br>
&gt; Alexander Beregalov (1):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ceph: move dereference after NULL test<br>
&gt;<br>
&gt; Sage Weil (5):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ceph: fix handle_forward parsing<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ceph: reset front len on return to msgpool; BUG o=
n<br>
&gt; =C2=A0mismatched front iov ceph: set osd request message front<br>
&gt; =C2=A0length correctly ceph: fix osdmap decoding when pools<br>
&gt; =C2=A0include (removed) snaps ceph: v0.19.1 stable release<br>
&gt;<br>
&gt; Yehuda Sadeh (1):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ceph: don&#39;t clobber write return value when u=
sing<br>
&gt; =C2=A0O_SYNC<br>
&gt;<br>
&gt;<br>
&gt; ---------------------------------------------------------<br>
&gt; --------------------- Download Intel&amp;#174; Parallel<br>
&gt; =C2=A0Studio Eval<br>
&gt; Try the new software tools for yourself. Speed compiling,<br>
&gt; =C2=A0find bugs proactively, and fine-tune applications for<br>
&gt; =C2=A0parallel performance. See why Intel Parallel Studio got<br>
&gt; =C2=A0high marks during beta. <a href=3D"http://p.sf.net/sfu/intel-sw-=
dev" target=3D"_blank">http://p.sf.net/sfu/intel-sw-dev</a><br>
&gt; _______________________________________________<br>
&gt; Ceph-devel mailing list<br>
&gt; <a href=3D"mailto:Ceph-devel@lists.sourceforge.net">Ceph-devel@lists.s=
ourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ceph-devel" ta=
rget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ceph-devel</a>=
<br>
&gt;<br>
<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Download Intel&amp;#174; Parallel Studio Eval<br>
Try the new software tools for yourself. Speed compiling, find bugs<br>
proactively, and fine-tune applications for parallel performance.<br>
See why Intel Parallel Studio got high marks during beta.<br>
<a href=3D"http://p.sf.net/sfu/intel-sw-dev" target=3D"_blank">http://p.sf.=
net/sfu/intel-sw-dev</a><br>
_______________________________________________<br>
Ceph-devel mailing list<br>
<a href=3D"mailto:Ceph-devel@lists.sourceforge.net">Ceph-devel@lists.source=
forge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ceph-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ceph-devel</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Roland Rabb=
en<br>Founder &amp; CEO Jotta AS<br>Cell: +47 90 85 85 39<br>Phone: +47 21 =
04 29 00<br>Email: <a href=3D"mailto:roland@jotta.no">roland@jotta.no</a><b=
r>


--00032555455e07328104815e2d50--


--===============0186170686390118144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============0186170686390118144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============0186170686390118144==--

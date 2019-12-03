From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Revert a CephFS snapshot?
Date: Tue, 3 Dec 2019 07:59:18 -0800
Message-ID: <CAANLjFoHWayCwMi3+n7sGtU_ofeYBVxfqUuJvtOO_NdSMvdRUA@mail.gmail.com>
References: <CAKQB+ftphk7pepLdGEgckLtfj=KBp02cMqdea+R_NTd6Gwn-TA@mail.gmail.com>
 <CA+2bHPaCg4Pq-88hnvnH93QCOfgKv27gDTUjHF5rnDr6Nd2=wQ@mail.gmail.com>
 <CAKQB+fvUCUAeHEHwP06auyK+ZGUHZdRzTT-38xtgsSbQDjyoHQ@mail.gmail.com>
 <CA+2bHPbw3uMLeq77XfjZfhYnYcnF-Gk+Od6UJrTiYkW+g77s4w@mail.gmail.com>
 <alpine.DEB.2.21.1911141900360.17979@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8936586636834747492=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.21.1911141900360.17979-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============8936586636834747492==
Content-Type: multipart/alternative; boundary="00000000000003615f0598cec8a0"

--00000000000003615f0598cec8a0
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 14, 2019 at 11:48 AM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Thu, 14 Nov 2019, Patrick Donnelly wrote:
> > On Wed, Nov 13, 2019 at 6:36 PM Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > >
> > > On Thu, 14 Nov 2019 at 07:07, Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> > > >
> > > > On Wed, Nov 13, 2019 at 2:30 AM Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > > > > Recently, I'm evaluating the snpahsot feature of CephFS from kernel
> > > > > client and everthing works like a charm.  But, it seems that
> reverting
> > > > > a snapshot is not available currently.  Is there some reason or
> > > > > technical limitation that the feature is not provided?  Any
> insights
> > > > > or ideas are appreciated.
> > > >
> > > > Please provide more information about what you tried to do (commands
> > > > run) and how it surprised you.
> > >
> > > The thing I would like to do is to rollback a snapped directory to a
> > > previous version of snapshot.  It looks like the operation can be done
> > > by over-writting all the current version of files/directories from a
> > > previous snapshot via cp.  But cp may take lots of time when there are
> > > many files and directories in the target directory.  Is there any
> > > possibility to achieve the goal much faster from the CephFS internal
> > > via command like "ceph fs <cephfs_name> <dir> snap rollback
> > > <snapname>" (just a example)?  Thank you!
> >
> > RADOS doesn't support rollback of snapshots so it needs to be done
> > manually. The best tool to do this would probably be rsync of the
> > .snap directory with appropriate options including deletion of files
> > that do not exist in the source (snapshot).
>
> rsync is the best bet now, yeah.
>
> RADOS does have a rollback operation that uses clone where it can, but
> it's a per-object operation, so something still needs to walk the
> hierarchy and roll back each file's content.  The MDS could do this more
> efficiently than rsync give what it knows about the snapped inodes
> (skipping untouched inodes or, eventually, entire subtrees) but it's a
> non-trivial amount of work to implement.
>
> Would it make sense to extend CephFS to leverage reflinks for cases like
this? That could be faster than rsync and more space efficient. It would
require some development time though.

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

--00000000000003615f0598cec8a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Nov 14, 2019 at 11:48 AM Sage Wei=
l &lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:=
<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Thu, 14 Nov 2019, Patrick Donnelly wrote:<br>
&gt; On Wed, Nov 13, 2019 at 6:36 PM Jerry Lee &lt;<a href=3D"mailto:leisur=
elysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:=
<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 14 Nov 2019 at 07:07, Patrick Donnelly &lt;<a href=3D"mai=
lto:pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrot=
e:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Nov 13, 2019 at 2:30 AM Jerry Lee &lt;<a href=3D"mai=
lto:leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt; wrote:<br>
&gt; &gt; &gt; &gt; Recently, I&#39;m evaluating the snpahsot feature of Ce=
phFS from kernel<br>
&gt; &gt; &gt; &gt; client and everthing works like a charm.=C2=A0 But, it =
seems that reverting<br>
&gt; &gt; &gt; &gt; a snapshot is not available currently.=C2=A0 Is there s=
ome reason or<br>
&gt; &gt; &gt; &gt; technical limitation that the feature is not provided?=
=C2=A0 Any insights<br>
&gt; &gt; &gt; &gt; or ideas are appreciated.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please provide more information about what you tried to do (=
commands<br>
&gt; &gt; &gt; run) and how it surprised you.<br>
&gt; &gt;<br>
&gt; &gt; The thing I would like to do is to rollback a snapped directory t=
o a<br>
&gt; &gt; previous version of snapshot.=C2=A0 It looks like the operation c=
an be done<br>
&gt; &gt; by over-writting all the current version of files/directories fro=
m a<br>
&gt; &gt; previous snapshot via cp.=C2=A0 But cp may take lots of time when=
 there are<br>
&gt; &gt; many files and directories in the target directory.=C2=A0 Is ther=
e any<br>
&gt; &gt; possibility to achieve the goal much faster from the CephFS inter=
nal<br>
&gt; &gt; via command like &quot;ceph fs &lt;cephfs_name&gt; &lt;dir&gt; sn=
ap rollback<br>
&gt; &gt; &lt;snapname&gt;&quot; (just a example)?=C2=A0 Thank you!<br>
&gt; <br>
&gt; RADOS doesn&#39;t support rollback of snapshots so it needs to be done=
<br>
&gt; manually. The best tool to do this would probably be rsync of the<br>
&gt; .snap directory with appropriate options including deletion of files<b=
r>
&gt; that do not exist in the source (snapshot).<br>
<br>
rsync is the best bet now, yeah.<br>
<br>
RADOS does have a rollback operation that uses clone where it can, but <br>
it&#39;s a per-object operation, so something still needs to walk the <br>
hierarchy and roll back each file&#39;s content.=C2=A0 The MDS could do thi=
s more <br>
efficiently than rsync give what it knows about the snapped inodes <br>
(skipping untouched inodes or, eventually, entire subtrees) but it&#39;s a =
<br>
non-trivial amount of work to implement.<br><br></blockquote><div>Would it =
make sense to extend CephFS to leverage reflinks for cases like this? That =
could be faster than rsync and more space efficient. It would require some =
development time though.</div><div><br></div><div><div dir=3D"ltr" class=3D=
"gmail_signature">----------------<br>Robert LeBlanc<br></div></div><div>PG=
P Fingerprint 79A2 9CA4 6CC4 45DD A904 =C2=A0C70E E654 3BB2 FA62 B9F1=C2=A0=
</div></div></div>

--00000000000003615f0598cec8a0--

--===============8936586636834747492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8936586636834747492==--

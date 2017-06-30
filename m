From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 16:29:43 +0000
Message-ID: <CAN-GepJ=2HC-Q38EEhK7EWF=pe0z7-v2oVPhRnS_gB8opM7y=g@mail.gmail.com>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
	<c4cf8858-6c29-4ec7-7ffa-479781258569@grimmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0262554534=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <c4cf8858-6c29-4ec7-7ffa-479781258569-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0262554534==
Content-Type: multipart/alternative; boundary="f403045c185255be9d05532fed44"

--f403045c185255be9d05532fed44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I actually don't see either of these as issues with just flat out saying
that Btrfs will not be supported in Luminous.  It's a full new release and
it sounds like it is no longer a relevant Filestore backend in Luminous.
People can either plan to migrate their OSDs to Bluestore once they reach
Luminous or just not upgrade to Luminous.  Upgrading is optional and not
mandatory.

On Fri, Jun 30, 2017 at 11:47 AM Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org> wrote:

> Hi Sage,
>
> On 06/30/2017 05:21 AM, Sage Weil wrote:
>
> > The easiest thing is to
> >
> > 1/ Stop testing filestore+btrfs for luminous onward.  We've recommended
> > against btrfs for a long time and are moving toward bluestore anyway.
>
> Searching the documentation for "btrfs" does not really give a user any
> clue that the use of Btrfs is discouraged.
>
> Where exactly has this been recommended?
>
> The documentation currently states:
>
>
> http://docs.ceph.com/docs/master/rados/configuration/ceph-conf/?highlight=
=3Dbtrfs#osds
>
> "We recommend using the xfs file system or the btrfs file system when
> running mkfs."
>
>
> http://docs.ceph.com/docs/master/rados/configuration/filesystem-recommend=
ations/?highlight=3Dbtrfs#filesystems
>
> "btrfs is still supported and has a comparatively compelling set of
> features, but be mindful of its stability and support status in your
> Linux distribution."
>
>
> http://docs.ceph.com/docs/master/start/os-recommendations/?highlight=3Dbt=
rfs#ceph-dependencies
>
> "If you use the btrfs file system with Ceph, we recommend using a recent
> Linux kernel (3.14 or later)."
>
> As an end user, none of these statements would really sound as
> recommendations *against* using Btrfs to me.
>
> I'm therefore concerned about just disabling the tests related to
> filestore on Btrfs while still including and shipping it. This has
> potential to introduce regressions that won't get caught and fixed.
>
> > 2/ Leave btrfs in the mix for jewel, and manually tolerate and filter o=
ut
> > the occasional ENOSPC errors we see.  (They make the test runs noisy bu=
t
> > are pretty easy to identify.)
> >
> > If we don't stop testing filestore on btrfs now, I'm not sure when we
> > would ever be able to stop, and that's pretty clearly not sustainable.
> > Does that seem reasonable?  (Pretty please?)
>
> If you want to get rid of filestore on Btrfs, start a proper deprecation
> process and inform users that support for it it's going to be removed in
> the near future. The documentation must be updated accordingly and it
> must be clearly emphasized in the release notes.
>
> Simply disabling the tests while keeping the code in the distribution is
> setting up users who happen to be using Btrfs for failure.
>
> Just my 0.02=E2=82=AC,
>
> Lenz
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--f403045c185255be9d05532fed44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I actually don&#39;t see either of these as issues with ju=
st flat out saying that Btrfs will not be supported in Luminous.=C2=A0 It&#=
39;s a full new release and it sounds like it is no longer a relevant Files=
tore backend in Luminous.=C2=A0 People can either plan to migrate their OSD=
s to Bluestore once they reach Luminous or just not upgrade to Luminous.=C2=
=A0 Upgrading is optional and not mandatory.<div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr">On Fri, Jun 30, 2017 at 11:47 AM Lenz Grimmer &lt;<a =
href=3D"mailto:lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org">lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Hi Sage,<br>
<br>
On 06/30/2017 05:21 AM, Sage Weil wrote:<br>
<br>
&gt; The easiest thing is to<br>
&gt;<br>
&gt; 1/ Stop testing filestore+btrfs for luminous onward.=C2=A0 We&#39;ve r=
ecommended<br>
&gt; against btrfs for a long time and are moving toward bluestore anyway.<=
br>
<br>
Searching the documentation for &quot;btrfs&quot; does not really give a us=
er any<br>
clue that the use of Btrfs is discouraged.<br>
<br>
Where exactly has this been recommended?<br>
<br>
The documentation currently states:<br>
<br>
<a href=3D"http://docs.ceph.com/docs/master/rados/configuration/ceph-conf/?=
highlight=3Dbtrfs#osds" rel=3D"noreferrer" target=3D"_blank">http://docs.ce=
ph.com/docs/master/rados/configuration/ceph-conf/?highlight=3Dbtrfs#osds</a=
><br>
<br>
&quot;We recommend using the xfs file system or the btrfs file system when<=
br>
running mkfs.&quot;<br>
<br>
<a href=3D"http://docs.ceph.com/docs/master/rados/configuration/filesystem-=
recommendations/?highlight=3Dbtrfs#filesystems" rel=3D"noreferrer" target=
=3D"_blank">http://docs.ceph.com/docs/master/rados/configuration/filesystem=
-recommendations/?highlight=3Dbtrfs#filesystems</a><br>
<br>
&quot;btrfs is still supported and has a comparatively compelling set of<br=
>
features, but be mindful of its stability and support status in your<br>
Linux distribution.&quot;<br>
<br>
<a href=3D"http://docs.ceph.com/docs/master/start/os-recommendations/?highl=
ight=3Dbtrfs#ceph-dependencies" rel=3D"noreferrer" target=3D"_blank">http:/=
/docs.ceph.com/docs/master/start/os-recommendations/?highlight=3Dbtrfs#ceph=
-dependencies</a><br>
<br>
&quot;If you use the btrfs file system with Ceph, we recommend using a rece=
nt<br>
Linux kernel (3.14 or later).&quot;<br>
<br>
As an end user, none of these statements would really sound as<br>
recommendations *against* using Btrfs to me.<br>
<br>
I&#39;m therefore concerned about just disabling the tests related to<br>
filestore on Btrfs while still including and shipping it. This has<br>
potential to introduce regressions that won&#39;t get caught and fixed.<br>
<br>
&gt; 2/ Leave btrfs in the mix for jewel, and manually tolerate and filter =
out<br>
&gt; the occasional ENOSPC errors we see.=C2=A0 (They make the test runs no=
isy but<br>
&gt; are pretty easy to identify.)<br>
&gt;<br>
&gt; If we don&#39;t stop testing filestore on btrfs now, I&#39;m not sure =
when we<br>
&gt; would ever be able to stop, and that&#39;s pretty clearly not sustaina=
ble.<br>
&gt; Does that seem reasonable?=C2=A0 (Pretty please?)<br>
<br>
If you want to get rid of filestore on Btrfs, start a proper deprecation<br=
>
process and inform users that support for it it&#39;s going to be removed i=
n<br>
the near future. The documentation must be updated accordingly and it<br>
must be clearly emphasized in the release notes.<br>
<br>
Simply disabling the tests while keeping the code in the distribution is<br=
>
setting up users who happen to be using Btrfs for failure.<br>
<br>
Just my 0.02=E2=82=AC,<br>
<br>
Lenz<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div></div>

--f403045c185255be9d05532fed44--

--===============0262554534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0262554534==--

From: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 17 Sep 2019 08:58:48 -0500
Message-ID: <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5651273950958816524=="
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============5651273950958816524==
Content-Type: multipart/alternative; boundary="0000000000003efbe50592c01fcd"

--0000000000003efbe50592c01fcd
Content-Type: text/plain; charset="UTF-8"

I have been affected by few issues mentioned by Alfredo.

* Version Pinning:  Had to install several debs of specific version to be
able to pull dependencies of the correct version.  I believe that other
projects resolving it by creating a virtual package that pulls all of the
proper dependencies in.  Not sure if the same done by RPM / Yum.

* Unannounced releases.  I believe it is more of a procedural issue and
unfortunately something will need to be done to enforce the compliance once
rules of packages release are finalized.

* I am bothered with a quality of the releases of a very complex system
that can bring down a whole house and keep it down for a while.  While I
wish the QA would be perfect, I wonder if it would be practical to release
new packages to a testing repo before moving it to a main one.  There is a
chance then someone will detect a problem before it becomes a
production issue.   Let it seat for a couple days or weeks in testing.
People who need new update right away or just want to test will install it
and report the problems.  Others will not be affected.

Just my 2c,

On Tue, Sep 17, 2019, 8:15 AM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Reviving this old thread.
>
> I still think this is something we should consider as users still
> experience problems:
>
> * Impossible to 'pin' to a version. User installs 14.2.0 and 4 months
> later they add other nodes but version moved to 14.2.2
> * Impossible to use a version that is not what the latest is (e.g. if
> someone doesn't need the release from Monday, but wants the one from 6
> months ago), similar to the above
> * When a release is underway, the repository breaks because syncing
> packages takes hours. The operation is not atomic.
> * It is not currently possible to "remove" a bad release, in the past,
> this means cutting a new release as soon as possible, which can take
> days
>
> The latest issue (my fault!) was to cut a release and get the packages
> out without communicating with the release manager, which caused users
> to note there is a new version *as soon as it was up* vs, a
> process that could've not touched the 'latest' url until the
> announcement goes out.
>
> If you have been affected by any of these issues (or others I didn't
> come up with), please let us know in this thread so that we can find
> some common ground and try to improve the process.
>
> Thanks!
>
> On Tue, Jul 24, 2018 at 10:38 AM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > Hi all,
> >
> > After the 12.2.6 release went out, we've been thinking on better ways
> > to remove a version from our repositories to prevent users from
> > upgrading/installing a known bad release.
> >
> > The way our repos are structured today means every single version of
> > the release is included in the repository. That is, for Luminous,
> > every 12.x.x version of the binaries is in the same repo. This is true
> > for both RPM and DEB repositories.
> >
> > However, the DEB repos don't allow pinning to a given version because
> > our tooling (namely reprepro) doesn't construct the repositories in a
> > way that this is allowed. For RPM repos this is fine, and version
> > pinning works.
> >
> > To remove a bad version we have to proposals (and would like to hear
> > ideas on other possibilities), one that would involve symlinks and the
> > other one which purges the known bad version from our repos.
> >
> > *Symlinking*
> > When releasing we would have a "previous" and "latest" symlink that
> > would get updated as versions move forward. It would require
> > separation of versions at the URL level (all versions would no longer
> > be available in one repo).
> >
> > The URL structure would then look like:
> >
> >     debian/luminous/12.2.3/
> >     debian/luminous/previous/  (points to 12.2.5)
> >     debian/luminous/latest/   (points to 12.2.7)
> >
> > Caveats: the url structure would change from debian-luminous/ to
> > prevent breakage, and the versions would be split. For RPMs it would
> > mean a regression if someone is used to pinning, for example pinning
> > to 12.2.2 wouldn't be possible using the same url.
> >
> > Pros: Faster release times, less need to move packages around, and
> > easier to remove a bad version
> >
> >
> > *Single version removal*
> > Our tooling would need to go and remove the known bad version from the
> > repository, which would require to rebuild the repository again, so
> > that the metadata is updated with the difference in the binaries.
> >
> > Caveats: time intensive process, almost like cutting a new release
> > which takes about a day (and sometimes longer). Error prone since the
> > process wouldn't be the same (one off, just when a version needs to be
> > removed)
> >
> > Pros: all urls for download.ceph.com and its structure are kept the
> same.
> _______________________________________________
> ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
> To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
>

--0000000000003efbe50592c01fcd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>I have been affected by few issues mentioned by Alfr=
edo.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">* Version Pin=
ning:=C2=A0 Had to install several debs of specific version to be able to p=
ull dependencies of the correct version.=C2=A0 I believe that other project=
s resolving it by creating a virtual package that pulls all of the proper d=
ependencies in.=C2=A0 Not sure if the same done by RPM / Yum.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">* Unannounced releases.=C2=A0 I belie=
ve it is more of a procedural issue and unfortunately something will need=
=C2=A0to be done to enforce the compliance once rules of packages release a=
re finalized.</div><div dir=3D"auto"><br></div><div dir=3D"auto">* I am bot=
hered with a quality of the releases of a very complex system that can brin=
g down a whole house and keep it down for=C2=A0a while.=C2=A0 While I wish =
the QA would be perfect, I wonder if it would be practical to release new p=
ackages to a testing repo before moving it to a main one.=C2=A0 There is a =
chance then someone will detect a problem before it becomes a production=C2=
=A0issue.=C2=A0 =C2=A0Let it seat for a couple days or weeks in testing.=C2=
=A0 People who need new update right away or just want to test will install=
 it and report the problems.=C2=A0 Others will not be affected.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Just my 2c,</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote" dir=3D"auto"><div di=
r=3D"ltr" class=3D"gmail_attr">On Tue, Sep 17, 2019, 8:15 AM Alfredo Deza &=
lt;<a href=3D"mailto:adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Reviving this old thread.<br>
<br>
I still think this is something we should consider as users still<br>
experience problems:<br>
<br>
* Impossible to &#39;pin&#39; to a version. User installs 14.2.0 and 4 mont=
hs<br>
later they add other nodes but version moved to 14.2.2<br>
* Impossible to use a version that is not what the latest is (e.g. if<br>
someone doesn&#39;t need the release from Monday, but wants the one from 6<=
br>
months ago), similar to the above<br>
* When a release is underway, the repository breaks because syncing<br>
packages takes hours. The operation is not atomic.<br>
* It is not currently possible to &quot;remove&quot; a bad release, in the =
past,<br>
this means cutting a new release as soon as possible, which can take<br>
days<br>
<br>
The latest issue (my fault!) was to cut a release and get the packages<br>
out without communicating with the release manager, which caused users<br>
to note there is a new version *as soon as it was up* vs, a<br>
process that could&#39;ve not touched the &#39;latest&#39; url until the<br=
>
announcement goes out.<br>
<br>
If you have been affected by any of these issues (or others I didn&#39;t<br=
>
come up with), please let us know in this thread so that we can find<br>
some common ground and try to improve the process.<br>
<br>
Thanks!<br>
<br>
On Tue, Jul 24, 2018 at 10:38 AM Alfredo Deza &lt;<a href=3D"mailto:adeza@r=
edhat.com" target=3D"_blank" rel=3D"noreferrer">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; After the 12.2.6 release went out, we&#39;ve been thinking on better w=
ays<br>
&gt; to remove a version from our repositories to prevent users from<br>
&gt; upgrading/installing a known bad release.<br>
&gt;<br>
&gt; The way our repos are structured today means every single version of<b=
r>
&gt; the release is included in the repository. That is, for Luminous,<br>
&gt; every 12.x.x version of the binaries is in the same repo. This is true=
<br>
&gt; for both RPM and DEB repositories.<br>
&gt;<br>
&gt; However, the DEB repos don&#39;t allow pinning to a given version beca=
use<br>
&gt; our tooling (namely reprepro) doesn&#39;t construct the repositories i=
n a<br>
&gt; way that this is allowed. For RPM repos this is fine, and version<br>
&gt; pinning works.<br>
&gt;<br>
&gt; To remove a bad version we have to proposals (and would like to hear<b=
r>
&gt; ideas on other possibilities), one that would involve symlinks and the=
<br>
&gt; other one which purges the known bad version from our repos.<br>
&gt;<br>
&gt; *Symlinking*<br>
&gt; When releasing we would have a &quot;previous&quot; and &quot;latest&q=
uot; symlink that<br>
&gt; would get updated as versions move forward. It would require<br>
&gt; separation of versions at the URL level (all versions would no longer<=
br>
&gt; be available in one repo).<br>
&gt;<br>
&gt; The URL structure would then look like:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0debian/luminous/12.2.3/<br>
&gt;=C2=A0 =C2=A0 =C2=A0debian/luminous/previous/=C2=A0 (points to 12.2.5)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0debian/luminous/latest/=C2=A0 =C2=A0(points to 12.2=
.7)<br>
&gt;<br>
&gt; Caveats: the url structure would change from debian-luminous/ to<br>
&gt; prevent breakage, and the versions would be split. For RPMs it would<b=
r>
&gt; mean a regression if someone is used to pinning, for example pinning<b=
r>
&gt; to 12.2.2 wouldn&#39;t be possible using the same url.<br>
&gt;<br>
&gt; Pros: Faster release times, less need to move packages around, and<br>
&gt; easier to remove a bad version<br>
&gt;<br>
&gt;<br>
&gt; *Single version removal*<br>
&gt; Our tooling would need to go and remove the known bad version from the=
<br>
&gt; repository, which would require to rebuild the repository again, so<br=
>
&gt; that the metadata is updated with the difference in the binaries.<br>
&gt;<br>
&gt; Caveats: time intensive process, almost like cutting a new release<br>
&gt; which takes about a day (and sometimes longer). Error prone since the<=
br>
&gt; process wouldn&#39;t be the same (one off, just when a version needs t=
o be<br>
&gt; removed)<br>
&gt;<br>
&gt; Pros: all urls for <a href=3D"http://download.ceph.com" rel=3D"norefer=
rer noreferrer" target=3D"_blank">download.ceph.com</a> and its structure a=
re kept the same.<br>
_______________________________________________<br>
ceph-users mailing list -- <a href=3D"mailto:ceph-users-a8pt6IJUokc@public.gmane.org" target=3D"=
_blank" rel=3D"noreferrer">ceph-users-a8pt6IJUokc@public.gmane.org</a><br>
To unsubscribe send an email to <a href=3D"mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org"=
 target=3D"_blank" rel=3D"noreferrer">ceph-users-leave-a8pt6IJUokc@public.gmane.org</a><br>
</blockquote></div></div></div>

--0000000000003efbe50592c01fcd--

--===============5651273950958816524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org

--===============5651273950958816524==--

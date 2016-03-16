From: Eric Eastman <eric.eastman-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>
Subject: Re: v10.0.4 released
Date: Wed, 16 Mar 2016 08:01:50 -0600
Message-ID: <CA+9C14bozVMjVS+Z7hp+iqduJWgTwa7gt-vhB7cGBmKC_ORjYQ@mail.gmail.com>
References: <alpine.DEB.2.11.1603081634450.14358@cpach.fuggernut.com>
	<56E95C3C.7080907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0721882967=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <56E95C3C.7080907-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0721882967==
Content-Type: multipart/alternative; boundary=001a113d477a95301e052e2af405

--001a113d477a95301e052e2af405
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you for doing this.  It will make testing 10.0.x easier for all of us
in the field, and will make it easier to report bugs, as we will know that
the problems we find were not caused by our build process.

Eric

On Wed, Mar 16, 2016 at 7:14 AM, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org> wrote:

> Hi,
>
> Because of a tiny mistake preventing deb packages to be built, v10.0.5 wa=
s
> released shortly after v10.0.4 and is now the current development release=
.
> The Stable release team[0] collectively decided to help by publishing
> development packages[1], starting with v10.0.5.
>
> The packages for v10.0.5 are available at
> http://ceph-releases.dachary.org/ which can be used as a replacement for
> http://download.ceph.com/ for both http://download.ceph.com/rpm-testing
> and http://download.ceph.com/debian-testing . The only difference is the
> key used to sign the releases which can be imported with
>
>     wget -q -O- 'http://ceph-releases.dachary.org/release-key.asc' | sudo
> apt-key add -
>
> or
>
>     rpm --import http://ceph-releases.dachary.org/release-key.asc
>
> The instructions to install development packages found at
> http://docs.ceph.com/docs/master/install/get-packages/ can otherwise be
> applied with no change.
>
> Cheers
>
> [0] Stable release team
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Whos-who
> [1] Publishing development releases
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/30126
>
> On 08/03/2016 22:35, Sage Weil wrote:
> > This is the fourth and last development release before Jewel. The next
> > release will be a release candidate with the final set of features. Big
> > items include RGW static website support, librbd journal framework, fix=
ed
> > mon sync of config-key data, C++11 updates, and bluestore/kstore.
> >
> > Note that, due to general developer busyness, we aren=E2=80=99t buildin=
g official
> > release packages for this dev release. You can fetch autobuilt gitbuild=
er
> > packages from the usual location (http://gitbuilder.ceph.com).
> >
> > Notable Changes
> > ---------------
> >
> >         http://ceph.com/releases/v10-0-4-released/
> >
> > Getting Ceph
> > ------------
> >
> > * Git at git://github.com/ceph/ceph.git
> > * For packages, see
> http://ceph.com/docs/master/install/get-packages#add-ceph-development
> > * For ceph-deploy, see
> http://ceph.com/docs/master/install/install-ceph-deploy
> >
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113d477a95301e052e2af405
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for doing this.=C2=A0 It will make testing 10.0.=
x easier for all of us in the field, and will make it easier to report bugs=
, as we will know that the problems we find were not caused by our build pr=
ocess.=C2=A0<div><br></div><div>Eric</div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Wed, Mar 16, 2016 at 7:14 AM, Loic Dachary <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org" target=3D"_blank">loi=
c@dachary.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<b=
r>
<br>
Because of a tiny mistake preventing deb packages to be built, v10.0.5 was =
released shortly after v10.0.4 and is now the current development release. =
The Stable release team[0] collectively decided to help by publishing devel=
opment packages[1], starting with v10.0.5.<br>
<br>
The packages for v10.0.5 are available at <a href=3D"http://ceph-releases.d=
achary.org/" rel=3D"noreferrer" target=3D"_blank">http://ceph-releases.dach=
ary.org/</a> which can be used as a replacement for <a href=3D"http://downl=
oad.ceph.com/" rel=3D"noreferrer" target=3D"_blank">http://download.ceph.co=
m/</a> for both <a href=3D"http://download.ceph.com/rpm-testing" rel=3D"nor=
eferrer" target=3D"_blank">http://download.ceph.com/rpm-testing</a> and <a =
href=3D"http://download.ceph.com/debian-testing" rel=3D"noreferrer" target=
=3D"_blank">http://download.ceph.com/debian-testing</a> . The only differen=
ce is the key used to sign the releases which can be imported with<br>
<br>
=C2=A0 =C2=A0 wget -q -O- &#39;<a href=3D"http://ceph-releases.dachary.org/=
release-key.asc" rel=3D"noreferrer" target=3D"_blank">http://ceph-releases.=
dachary.org/release-key.asc</a>&#39; | sudo apt-key add -<br>
<br>
or<br>
<br>
=C2=A0 =C2=A0 rpm --import <a href=3D"http://ceph-releases.dachary.org/rele=
ase-key.asc" rel=3D"noreferrer" target=3D"_blank">http://ceph-releases.dach=
ary.org/release-key.asc</a><br>
<br>
The instructions to install development packages found at <a href=3D"http:/=
/docs.ceph.com/docs/master/install/get-packages/" rel=3D"noreferrer" target=
=3D"_blank">http://docs.ceph.com/docs/master/install/get-packages/</a> can =
otherwise be applied with no change.<br>
<br>
Cheers<br>
<br>
[0] Stable release team <a href=3D"http://tracker.ceph.com/projects/ceph-re=
leases/wiki/HOWTO#Whos-who" rel=3D"noreferrer" target=3D"_blank">http://tra=
cker.ceph.com/projects/ceph-releases/wiki/HOWTO#Whos-who</a><br>
[1] Publishing development releases <a href=3D"http://comments.gmane.org/gm=
ane.comp.file-systems.ceph.devel/30126" rel=3D"noreferrer" target=3D"_blank=
">http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/30126</a><br=
>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On 08/03/2016 22:35, Sage Weil wrote:<br>
&gt; This is the fourth and last development release before Jewel. The next=
<br>
&gt; release will be a release candidate with the final set of features. Bi=
g<br>
&gt; items include RGW static website support, librbd journal framework, fi=
xed<br>
&gt; mon sync of config-key data, C++11 updates, and bluestore/kstore.<br>
&gt;<br>
&gt; Note that, due to general developer busyness, we aren=E2=80=99t buildi=
ng official<br>
&gt; release packages for this dev release. You can fetch autobuilt gitbuil=
der<br>
&gt; packages from the usual location (<a href=3D"http://gitbuilder.ceph.co=
m" rel=3D"noreferrer" target=3D"_blank">http://gitbuilder.ceph.com</a>).<br=
>
&gt;<br>
&gt; Notable Changes<br>
&gt; ---------------<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://ceph.com/releases/v=
10-0-4-released/" rel=3D"noreferrer" target=3D"_blank">http://ceph.com/rele=
ases/v10-0-4-released/</a><br>
&gt;<br>
&gt; Getting Ceph<br>
&gt; ------------<br>
&gt;<br>
&gt; * Git at git://<a href=3D"http://github.com/ceph/ceph.git" rel=3D"nore=
ferrer" target=3D"_blank">github.com/ceph/ceph.git</a><br>
&gt; * For packages, see <a href=3D"http://ceph.com/docs/master/install/get=
-packages#add-ceph-development" rel=3D"noreferrer" target=3D"_blank">http:/=
/ceph.com/docs/master/install/get-packages#add-ceph-development</a><br>
&gt; * For ceph-deploy, see <a href=3D"http://ceph.com/docs/master/install/=
install-ceph-deploy" rel=3D"noreferrer" target=3D"_blank">http://ceph.com/d=
ocs/master/install/install-ceph-deploy</a><br>
&gt;<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Lo=C3=AFc Dachary, Artisan Logiciel Libre<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</font></span></blockquote></div><br></div></div>

--001a113d477a95301e052e2af405--

--===============0721882967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0721882967==--

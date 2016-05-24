From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: v0.94.7 Hammer released
Date: Tue, 24 May 2016 10:02:23 +0200
Message-ID: <CABZ+qq=bK2HOFoyxYJ=pvcapzy9XUPR2U5HDAATwCUzP_1r31g@mail.gmail.com>
References: <alpine.DEB.2.11.1605131020340.20416@cpach.fuggernut.com>
	<CABZ+qq=PUoA8rObv+TwT_NO9nRJnQA4xXOrKKdCp=5Q42Y9pNg@mail.gmail.com>
	<alpine.DEB.2.11.1605170754590.30956@cpach.fuggernut.com>
	<CABZ+qqn3QdDuvjEmodLnXTkDMK7wJiOq3A_wF7-N2zeGV+hv5A@mail.gmail.com>
	<20160517211435.052df0cb@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1835171519=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20160517211435.052df0cb-9yhXNL7Kh0lSCLKNlHTxZM8NsWr+9BEh@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1835171519==
Content-Type: multipart/alternative; boundary=001a1135e4267ce09c053391fc7f

--001a1135e4267ce09c053391fc7f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm mid-upgrade on a large cluster now. The upgrade is not going smoothly
-- it looks like the ceph-mon's are getting bombarded by so many of these
crc error warnings that they go into elections.

Did anyone upgrade a large cluster from 0.94.6 to 0.94.7 ? If not I'd
advise waiting until this is better understood.

Cheers, Dan


On Tue, May 17, 2016 at 2:14 PM, Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org> wrote:

>
> Hello,
>
> for the record, I did the exact same sequence (no MDS) on my test cluster
> with exactly the same results.
>
> Didn't report it as I assumed it to be a more noisy (but harmless)
> upgrade artifact.
>
> Christian
>
> On Tue, 17 May 2016 14:07:21 +0200 Dan van der Ster wrote:
>
> > On Tue, May 17, 2016 at 1:56 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > On Tue, 17 May 2016, Dan van der Ster wrote:
> > >> Hi Sage et al,
> > >>
> > >> I'm updating our pre-prod cluster from 0.94.6 to 0.94.7 and after
> > >> upgrading the ceph-mon's I'm getting loads of warnings like:
> > >>
> > >> 2016-05-17 10:01:29.314785 osd.76 [WRN] failed to encode map e103116
> > >> with expected crc
> > >>
> > >> I've seen that error is whitelisted in the qa-suite:
> > >> https://github.com/ceph/ceph-qa-suite/pull/602/files
> > >>
> > >> Is it really harmless? (This is the first time I've seen such a
> > >> warning).
> > >
> > > Are you sure you were upgrading from v0.94.6?
> >
> > Absolutely. I first updated the mons, which I restarted into quorum
> > with 0.96.7. Then any changes to the osdmap triggered the failed to
> > encode warning.
> > The upgrade sequence went like this:
> >
> > Update mons 0.94.6 to 0.94.7, restart, quorum. No warnings.
> > Update mds's 0.94.6 to 0.94.7, restart. Warnings from ~all osds.
> > Update osds 0.94.6 to 0.94.7, restart host by host. The 0.94.6 osds
> > printed warnings, the new OSDs did not.
> >
> > > I don't see anything that
> > > would trigger these warnings going from .6 to .7, which is strange.
> >
> > Could the osdmap GMT hitset changes have caused it? Commits Mar 24 here=
:
> >
> >    https://github.com/ceph/ceph/compare/v0.94.6...v0.94.7?expand=3D1
> >
> > > That said, the errors are generally harmless--it just means the
> > > monitors are running a different version of the code and the OSDs are
> > > pulling maps directly from a mon to ensure they are all in sync.  It'=
s
> > > normal during many upgrades, but not expected for this particular
> > > jump...
> >
> > Then I'm curious if others are getting this from 0.94.6 to 0.94.7.
> > For now I'm waiting to update our prod cluster.
> >
> > Thanks!
> >
> > Dan
> >
> >
> > >
> > > sage
> > >
> > >
> > >
> > >
> > >> Thanks in advance!
> > >>
> > >> Dan
> > >>
> > >>
> > >>
> > >>
> > >> On Fri, May 13, 2016 at 4:21 PM, Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > >> > This Hammer point release fixes several minor bugs. It also
> > >> > includes a backport of an improved =E2=80=98ceph osd
> > >> > reweight-by-utilization=E2=80=99 command for handling OSDs with
> > >> > higher-than-average utilizations.
> > >> >
> > >> > We recommend that all hammer v0.94.x users upgrade.
> > >> >
> > >> > For more detailed information, see the release announcement at
> > >> >
> > >> >         http://ceph.com/releases/v0-94-7-hammer-released/
> > >> >
> > >> > or the complete changelog at
> > >> >
> > >> >         http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt
> > >> >
> > >> > Getting Ceph
> > >> > ------------
> > >> >
> > >> > * Git at git://github.com/ceph/ceph.git
> > >> > * Tarball at http://download.ceph.com/tarballs/ceph-0.94.7.tar.gz
> > >> > * For packages, see
> http://ceph.com/docs/master/install/get-packages
> > >> > * For ceph-deploy, see
> > >> > http://ceph.com/docs/master/install/install-ceph-deploy
> > >> > _______________________________________________ ceph-users mailing
> > >> > list ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >> >
> > >>
> > >>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
> --
> Christian Balzer        Network/Systems Engineer
> chibi-FW+hd8ioUD0@public.gmane.org           Global OnLine Japan/Rakuten Communications
> http://www.gol.com/
>

--001a1135e4267ce09c053391fc7f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I&#39;m mid-upgrade on a large =
cluster now. The upgrade is not going smoothly -- it looks like the ceph-mo=
n&#39;s are getting bombarded by so many of these crc error warnings that t=
hey go into elections.</div><div><br></div><div>Did anyone upgrade a large =
cluster from 0.94.6 to 0.94.7 ? If not I&#39;d advise waiting until this is=
 better understood.</div><div><br></div><div>Cheers, Dan</div><div><br></di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, M=
ay 17, 2016 at 2:14 PM, Christian Balzer <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:chibi-FW+hd8ioUD0@public.gmane.org" target=3D"_blank">chibi-FW+hd8ioUD0@public.gmane.org</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><br>
Hello,<br>
<br>
for the record, I did the exact same sequence (no MDS) on my test cluster<b=
r>
with exactly the same results.<br>
<br>
Didn&#39;t report it as I assumed it to be a more noisy (but harmless)<br>
upgrade artifact.<br>
<br>
Christian<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Tue, 17 May 2016 14:07:21 +0200 Dan van der Ster wrote:<br>
<br>
&gt; On Tue, May 17, 2016 at 1:56 PM, Sage Weil &lt;<a href=3D"mailto:sweil=
@redhat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; On Tue, 17 May 2016, Dan van der Ster wrote:<br>
&gt; &gt;&gt; Hi Sage et al,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;m updating our pre-prod cluster from 0.94.6 to 0.94.7 a=
nd after<br>
&gt; &gt;&gt; upgrading the ceph-mon&#39;s I&#39;m getting loads of warning=
s like:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 2016-05-17 10:01:29.314785 osd.76 [WRN] failed to encode map =
e103116<br>
&gt; &gt;&gt; with expected crc<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;ve seen that error is whitelisted in the qa-suite:<br>
&gt; &gt;&gt; <a href=3D"https://github.com/ceph/ceph-qa-suite/pull/602/fil=
es" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/ceph-qa-su=
ite/pull/602/files</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is it really harmless? (This is the first time I&#39;ve seen =
such a<br>
&gt; &gt;&gt; warning).<br>
&gt; &gt;<br>
&gt; &gt; Are you sure you were upgrading from v0.94.6?<br>
&gt;<br>
&gt; Absolutely. I first updated the mons, which I restarted into quorum<br=
>
&gt; with 0.96.7. Then any changes to the osdmap triggered the failed to<br=
>
&gt; encode warning.<br>
&gt; The upgrade sequence went like this:<br>
&gt;<br>
&gt; Update mons 0.94.6 to 0.94.7, restart, quorum. No warnings.<br>
&gt; Update mds&#39;s 0.94.6 to 0.94.7, restart. Warnings from ~all osds.<b=
r>
&gt; Update osds 0.94.6 to 0.94.7, restart host by host. The 0.94.6 osds<br=
>
&gt; printed warnings, the new OSDs did not.<br>
&gt;<br>
&gt; &gt; I don&#39;t see anything that<br>
&gt; &gt; would trigger these warnings going from .6 to .7, which is strang=
e.<br>
&gt;<br>
&gt; Could the osdmap GMT hitset changes have caused it? Commits Mar 24 her=
e:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/ceph/ceph/compare/v0.94.6..=
.v0.94.7?expand=3D1" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/ceph/ceph/compare/v0.94.6...v0.94.7?expand=3D1</a><br>
&gt;<br>
&gt; &gt; That said, the errors are generally harmless--it just means the<b=
r>
&gt; &gt; monitors are running a different version of the code and the OSDs=
 are<br>
&gt; &gt; pulling maps directly from a mon to ensure they are all in sync.=
=C2=A0 It&#39;s<br>
&gt; &gt; normal during many upgrades, but not expected for this particular=
<br>
&gt; &gt; jump...<br>
&gt;<br>
&gt; Then I&#39;m curious if others are getting this from 0.94.6 to 0.94.7.=
<br>
&gt; For now I&#39;m waiting to update our prod cluster.<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
&gt; Dan<br>
&gt;<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; sage<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; Thanks in advance!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Dan<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Fri, May 13, 2016 at 4:21 PM, Sage Weil &lt;<a href=3D"mai=
lto:sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; This Hammer point release fixes several minor bugs. It a=
lso<br>
&gt; &gt;&gt; &gt; includes a backport of an improved =E2=80=98ceph osd<br>
&gt; &gt;&gt; &gt; reweight-by-utilization=E2=80=99 command for handling OS=
Ds with<br>
&gt; &gt;&gt; &gt; higher-than-average utilizations.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; We recommend that all hammer v0.94.x users upgrade.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; For more detailed information, see the release announcem=
ent at<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://ceph.=
com/releases/v0-94-7-hammer-released/" rel=3D"noreferrer" target=3D"_blank"=
>http://ceph.com/releases/v0-94-7-hammer-released/</a><br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; or the complete changelog at<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://docs.=
ceph.com/docs/master/_downloads/v0.94.6.txt" rel=3D"noreferrer" target=3D"_=
blank">http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt</a><br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Getting Ceph<br>
&gt; &gt;&gt; &gt; ------------<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; * Git at git://<a href=3D"http://github.com/ceph/ceph.gi=
t" rel=3D"noreferrer" target=3D"_blank">github.com/ceph/ceph.git</a><br>
&gt; &gt;&gt; &gt; * Tarball at <a href=3D"http://download.ceph.com/tarball=
s/ceph-0.94.7.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://download.=
ceph.com/tarballs/ceph-0.94.7.tar.gz</a><br>
&gt; &gt;&gt; &gt; * For packages, see <a href=3D"http://ceph.com/docs/mast=
er/install/get-packages" rel=3D"noreferrer" target=3D"_blank">http://ceph.c=
om/docs/master/install/get-packages</a><br>
&gt; &gt;&gt; &gt; * For ceph-deploy, see<br>
&gt; &gt;&gt; &gt; <a href=3D"http://ceph.com/docs/master/install/install-c=
eph-deploy" rel=3D"noreferrer" target=3D"_blank">http://ceph.com/docs/maste=
r/install/install-ceph-deploy</a><br>
&gt; &gt;&gt; &gt; _______________________________________________ ceph-use=
rs mailing<br>
&gt; &gt;&gt; &gt; list <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-u=
sers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; &gt;&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users=
-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listi=
nfo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Christian Balzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 Network/Systems Engineer<br>
<a href=3D"mailto:chibi-FW+hd8ioUD0@public.gmane.org">chibi-FW+hd8ioUD0@public.gmane.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Global OnLine Japan/Rakuten Communications<br>
<a href=3D"http://www.gol.com/" rel=3D"noreferrer" target=3D"_blank">http:/=
/www.gol.com/</a><br>
</font></span></blockquote></div><br></div>

--001a1135e4267ce09c053391fc7f--

--===============1835171519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1835171519==--

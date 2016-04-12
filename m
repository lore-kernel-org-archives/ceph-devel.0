From: hp cre <hpcre1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Ceph-maintainers]  Deprecating ext4 support
Date: Tue, 12 Apr 2016 04:05:29 +0200
Message-ID: <CAJwWmWwDYOSLxBEuth5p1g_MYGvHwQR=iPuQ2HB+p6WhxwuV9g@mail.gmail.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<20160412083925.5106311d@batzmaru.gol.ad.jp>
	<alpine.DEB.2.11.1604112046570.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0901439479=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604112046570.29593-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
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

--===============0901439479==
Content-Type: multipart/alternative; boundary=001a113a74d27528ff053040181a

--001a113a74d27528ff053040181a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

As far as i remember,  the documentation did say that either filesystems
(ext4 or xfs) are OK,  except for xattr which was better represented on xfs=
.

I would think the best move would be to make xfs the default osd creation
method and put in a warning about ext4 being deprecated in future
releases.  But leave support for it till all users are weaned off of it in
favour of xfs and later,  btrfs.
On 12 Apr 2016 03:12, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, 12 Apr 2016, Christian Balzer wrote:
> >
> > Hello,
> >
> > What a lovely missive to start off my working day...
> >
> > On Mon, 11 Apr 2016 17:39:37 -0400 (EDT) Sage Weil wrote:
> >
> > > Hi,
> > >
> > > ext4 has never been recommended, but we did test it.
> > Patently wrong, as Shinobu just pointed.
> >
> > Ext4 never was (especially recently) flogged as much as XFS, but it
> always
> > was a recommended, supported filestorage filesystem, unlike the
> > experimental BTRFS of ZFS.
> > And for various reasons people, including me, deployed it instead of XF=
S.
>
> Greg definitely wins the prize for raising this as a major issue, then
> (and for naming you as one of the major ext4 users).
>
> I was not aware that we were recommending ext4 anywhere.  FWIW, here's
> what the docs currently say:
>
>  Ceph OSD Daemons rely heavily upon the stability and performance of the
>  underlying filesystem.
>
>  Note: We currently recommend XFS for production deployments. We recommen=
d
>  btrfs for testing, development, and any non-critical deployments. We
>  believe that btrfs has the correct feature set and roadmap to serve Ceph
>  in the long-term, but XFS and ext4 provide the necessary stability for
>  today=E2=80=99s deployments. btrfs development is proceeding rapidly: us=
ers should
>  be comfortable installing the latest released upstream kernels and be ab=
le
>  to track development activity for critical bug fixes.
>
>  Ceph OSD Daemons depend on the Extended Attributes (XATTRs) of the
>  underlying file system for various forms of internal object state and
>  metadata. The underlying filesystem must provide sufficient capacity for
>  XATTRs. btrfs does not bound the total xattr metadata stored with a file=
.
>  XFS has a relatively large limit (64 KB) that most deployments won=E2=80=
=99t
>  encounter, but the ext4 is too small to be usable.
>
> (
> http://docs.ceph.com/docs/master/rados/configuration/filesystem-recommend=
ations/?highlight=3Dext4
> )
>
> Unfortunately that second paragraph, second sentence indirectly says ext4
> is stable.  :( :(  I'll prepare a PR tomorrow to revise this whole sectio=
n
> based on the new information.
>
> If anyone knows of other docs that recommend ext4, please let me know!
> They need to be updated.
>
> > > After Jewel is out, we would like explicitly recommend *against* ext4
> > > and stop testing it.
> > >
> > Changing your recommendations is fine, stopping testing/supporting it
> > isn't.
> > People deployed Ext4 in good faith and can be expected to use it at lea=
st
> > until their HW is up for replacement (4-5 years).
>
> I agree, which is why I asked.
>
> And part of it depends on what it's being used for.  If there are major
> users using ext4 for RGW then their deployments are at risk and they
> should swap it out for data safety reasons alone.  (Or, we need to figure
> out how to fix long object name support on ext4.)  On the other hand, if
> the only ext4 users are using RBD only, then they can safely continue wit=
h
> lower max object names, and upstream testing is important to let those
> OSDs age out naturally.
>
> Does your cluster support RBD, RGW, or something else?
>
> > > Why:
> > >
> > > Recently we discovered an issue with the long object name handling th=
at
> > > is not fixable without rewriting a significant chunk of FileStores
> > > filename handling.  (There is a limit in the amount of xattr data ext=
4
> > > can store in the inode, which causes problems in LFNIndex.)
> > >
> > Is that also true if the Ext4 inode size is larger than default?
>
> I'm not sure... Sam, do you know?  (It's somewhat academic, though, since
> we can't change the inode size on existing file systems.)
>
> > > We *could* invest a ton of time rewriting this to fix, but it only
> > > affects ext4, which we never recommended, and we plan to deprecate
> > > FileStore once BlueStore is stable anyway, so it seems like a waste o=
f
> > > time that would be better spent elsewhere.
> > >
> > If you (that is RH) is going to declare bluestore stable this year, I
> > would be very surprised.
>
> My hope is that it can be the *default* for L (next spring).  But we'll
> see.
>
> > Either way, dropping support before the successor is truly ready doesn'=
t
> > sit well with me.
>
> Yeah, I misspoke.  Once BlueStore is supported and the default, support
> for FileStore won't be dropped immediately.  But we'll want to communicat=
e
> that eventually it will lose support.  How strongly that is messaged
> probably depends on how confident we are in BlueStore at that point.  And
> I confess I haven't thought much about how long "long enough" is yet.
>
> > Which brings me to the reasons why people would want to migrate (NOT
> > talking about starting freshly) to bluestore.
> >
> > 1. Will it be faster (IOPS) than filestore with SSD journals?
> > Don't think so, but feel free to prove me wrong.
>
> It will absolutely faster on the same hardware.  Whether BlueStore on HDD
> only is faster than FileStore HDD + SSD journal will depend on the
> workload.
>
> > 2. Will it be bit-rot proof? Note the deafening silence from the devs i=
n
> > this thread:
> > http://www.spinics.net/lists/ceph-users/msg26510.html
>
> I missed that thread, sorry.
>
> We (Mirantis, SanDisk, Red Hat) are currently working on checksum support
> in BlueStore.  Part of the reason why BlueStore is the preferred path is
> because we will probably never see full checksumming in ext4 or XFS.
>
> > > Also, by dropping ext4 test coverage in ceph-qa-suite, we can
> > > significantly improve time/coverage for FileStore on XFS and on
> > > BlueStore.
> > >
> > Really, isn't that fully automated?
>
> It is, but hardware and time are finite.  Fewer tests on FileStore+ext4
> means more tests on FileStore+XFS or BlueStore.  But this is a minor
> point.
>
> > > The long file name handling is problematic anytime someone is storing
> > > rados objects with long names.  The primary user that does this is RG=
W,
> > > which means any RGW cluster using ext4 should recreate their OSDs to
> use
> > > XFS.  Other librados users could be affected too, though, like users
> > > with very long rbd image names (e.g., > 100 characters), or custom
> > > librados users.
> > >
> > > How:
> > >
> > > To make this change as visible as possible, the plan is to make
> ceph-osd
> > > refuse to start if the backend is unable to support the configured ma=
x
> > > object name (osd_max_object_name_len).  The OSD will complain that ex=
t4
> > > cannot store such an object and refuse to start.  A user who is only
> > > using RBD might decide they don't need long file names to work and ca=
n
> > > adjust the osd_max_object_name_len setting to something small (say, 6=
4)
> > > and run successfully.  They would be taking a risk, though, because w=
e
> > > would like to stop testing on ext4.
> > >
> > > Is this reasonable?
> > About as reasonable as dropping format 1 support, that is not at all.
> > https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg28070.html
>
> Fortunately nobody (to my knowledge) has suggested dropping format 1
> support.  :)
>
> > I'm officially only allowed to do (preventative) maintenance during
> weekend
> > nights on our main production cluster.
> > That would mean 13 ruined weekends at the realistic rate of 1 OSD per
> > night, so you can see where my lack of enthusiasm for OSD recreation
> comes
> > from.
>
> Yeah.  :(
>
> > > If there significant ext4 users that are unwilling
> > > to recreate their OSDs, now would be the time to speak up.
> > >
> > Consider that done.
>
> Thank you for the feedback!
>
> sage
> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
>
>

--001a113a74d27528ff053040181a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">As far as i remember,=C2=A0 the documentation did say that e=
ither filesystems (ext4 or xfs) are OK,=C2=A0 except for xattr which was be=
tter represented on xfs.</p>
<p dir=3D"ltr">I would think the best move would be to make xfs the default=
 osd creation method and put in a warning about ext4 being deprecated in fu=
ture releases.=C2=A0 But leave support for it till all users are weaned off=
 of it in favour of xfs and later,=C2=A0 btrfs.</p>
<div class=3D"gmail_quote">On 12 Apr 2016 03:12, &quot;Sage Weil&quot; &lt;=
<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, 12 Apr 2016, Christ=
ian Balzer wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; What a lovely missive to start off my working day...<br>
&gt;<br>
&gt; On Mon, 11 Apr 2016 17:39:37 -0400 (EDT) Sage Weil wrote:<br>
&gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; ext4 has never been recommended, but we did test it.<br>
&gt; Patently wrong, as Shinobu just pointed.<br>
&gt;<br>
&gt; Ext4 never was (especially recently) flogged as much as XFS, but it al=
ways<br>
&gt; was a recommended, supported filestorage filesystem, unlike the<br>
&gt; experimental BTRFS of ZFS.<br>
&gt; And for various reasons people, including me, deployed it instead of X=
FS.<br>
<br>
Greg definitely wins the prize for raising this as a major issue, then<br>
(and for naming you as one of the major ext4 users).<br>
<br>
I was not aware that we were recommending ext4 anywhere.=C2=A0 FWIW, here&#=
39;s<br>
what the docs currently say:<br>
<br>
=C2=A0Ceph OSD Daemons rely heavily upon the stability and performance of t=
he<br>
=C2=A0underlying filesystem.<br>
<br>
=C2=A0Note: We currently recommend XFS for production deployments. We recom=
mend<br>
=C2=A0btrfs for testing, development, and any non-critical deployments. We<=
br>
=C2=A0believe that btrfs has the correct feature set and roadmap to serve C=
eph<br>
=C2=A0in the long-term, but XFS and ext4 provide the necessary stability fo=
r<br>
=C2=A0today=E2=80=99s deployments. btrfs development is proceeding rapidly:=
 users should<br>
=C2=A0be comfortable installing the latest released upstream kernels and be=
 able<br>
=C2=A0to track development activity for critical bug fixes.<br>
<br>
=C2=A0Ceph OSD Daemons depend on the Extended Attributes (XATTRs) of the<br=
>
=C2=A0underlying file system for various forms of internal object state and=
<br>
=C2=A0metadata. The underlying filesystem must provide sufficient capacity =
for<br>
=C2=A0XATTRs. btrfs does not bound the total xattr metadata stored with a f=
ile.<br>
=C2=A0XFS has a relatively large limit (64 KB) that most deployments won=E2=
=80=99t<br>
=C2=A0encounter, but the ext4 is too small to be usable.<br>
<br>
(<a href=3D"http://docs.ceph.com/docs/master/rados/configuration/filesystem=
-recommendations/?highlight=3Dext4" rel=3D"noreferrer" target=3D"_blank">ht=
tp://docs.ceph.com/docs/master/rados/configuration/filesystem-recommendatio=
ns/?highlight=3Dext4</a>)<br>
<br>
Unfortunately that second paragraph, second sentence indirectly says ext4<b=
r>
is stable.=C2=A0 :( :(=C2=A0 I&#39;ll prepare a PR tomorrow to revise this =
whole section<br>
based on the new information.<br>
<br>
If anyone knows of other docs that recommend ext4, please let me know!<br>
They need to be updated.<br>
<br>
&gt; &gt; After Jewel is out, we would like explicitly recommend *against* =
ext4<br>
&gt; &gt; and stop testing it.<br>
&gt; &gt;<br>
&gt; Changing your recommendations is fine, stopping testing/supporting it<=
br>
&gt; isn&#39;t.<br>
&gt; People deployed Ext4 in good faith and can be expected to use it at le=
ast<br>
&gt; until their HW is up for replacement (4-5 years).<br>
<br>
I agree, which is why I asked.<br>
<br>
And part of it depends on what it&#39;s being used for.=C2=A0 If there are =
major<br>
users using ext4 for RGW then their deployments are at risk and they<br>
should swap it out for data safety reasons alone.=C2=A0 (Or, we need to fig=
ure<br>
out how to fix long object name support on ext4.)=C2=A0 On the other hand, =
if<br>
the only ext4 users are using RBD only, then they can safely continue with<=
br>
lower max object names, and upstream testing is important to let those<br>
OSDs age out naturally.<br>
<br>
Does your cluster support RBD, RGW, or something else?<br>
<br>
&gt; &gt; Why:<br>
&gt; &gt;<br>
&gt; &gt; Recently we discovered an issue with the long object name handlin=
g that<br>
&gt; &gt; is not fixable without rewriting a significant chunk of FileStore=
s<br>
&gt; &gt; filename handling.=C2=A0 (There is a limit in the amount of xattr=
 data ext4<br>
&gt; &gt; can store in the inode, which causes problems in LFNIndex.)<br>
&gt; &gt;<br>
&gt; Is that also true if the Ext4 inode size is larger than default?<br>
<br>
I&#39;m not sure... Sam, do you know?=C2=A0 (It&#39;s somewhat academic, th=
ough, since<br>
we can&#39;t change the inode size on existing file systems.)<br>
<br>
&gt; &gt; We *could* invest a ton of time rewriting this to fix, but it onl=
y<br>
&gt; &gt; affects ext4, which we never recommended, and we plan to deprecat=
e<br>
&gt; &gt; FileStore once BlueStore is stable anyway, so it seems like a was=
te of<br>
&gt; &gt; time that would be better spent elsewhere.<br>
&gt; &gt;<br>
&gt; If you (that is RH) is going to declare bluestore stable this year, I<=
br>
&gt; would be very surprised.<br>
<br>
My hope is that it can be the *default* for L (next spring).=C2=A0 But we&#=
39;ll<br>
see.<br>
<br>
&gt; Either way, dropping support before the successor is truly ready doesn=
&#39;t<br>
&gt; sit well with me.<br>
<br>
Yeah, I misspoke.=C2=A0 Once BlueStore is supported and the default, suppor=
t<br>
for FileStore won&#39;t be dropped immediately.=C2=A0 But we&#39;ll want to=
 communicate<br>
that eventually it will lose support.=C2=A0 How strongly that is messaged<b=
r>
probably depends on how confident we are in BlueStore at that point.=C2=A0 =
And<br>
I confess I haven&#39;t thought much about how long &quot;long enough&quot;=
 is yet.<br>
<br>
&gt; Which brings me to the reasons why people would want to migrate (NOT<b=
r>
&gt; talking about starting freshly) to bluestore.<br>
&gt;<br>
&gt; 1. Will it be faster (IOPS) than filestore with SSD journals?<br>
&gt; Don&#39;t think so, but feel free to prove me wrong.<br>
<br>
It will absolutely faster on the same hardware.=C2=A0 Whether BlueStore on =
HDD<br>
only is faster than FileStore HDD + SSD journal will depend on the<br>
workload.<br>
<br>
&gt; 2. Will it be bit-rot proof? Note the deafening silence from the devs =
in<br>
&gt; this thread:<br>
&gt; <a href=3D"http://www.spinics.net/lists/ceph-users/msg26510.html" rel=
=3D"noreferrer" target=3D"_blank">http://www.spinics.net/lists/ceph-users/m=
sg26510.html</a><br>
<br>
I missed that thread, sorry.<br>
<br>
We (Mirantis, SanDisk, Red Hat) are currently working on checksum support<b=
r>
in BlueStore.=C2=A0 Part of the reason why BlueStore is the preferred path =
is<br>
because we will probably never see full checksumming in ext4 or XFS.<br>
<br>
&gt; &gt; Also, by dropping ext4 test coverage in ceph-qa-suite, we can<br>
&gt; &gt; significantly improve time/coverage for FileStore on XFS and on<b=
r>
&gt; &gt; BlueStore.<br>
&gt; &gt;<br>
&gt; Really, isn&#39;t that fully automated?<br>
<br>
It is, but hardware and time are finite.=C2=A0 Fewer tests on FileStore+ext=
4<br>
means more tests on FileStore+XFS or BlueStore.=C2=A0 But this is a minor<b=
r>
point.<br>
<br>
&gt; &gt; The long file name handling is problematic anytime someone is sto=
ring<br>
&gt; &gt; rados objects with long names.=C2=A0 The primary user that does t=
his is RGW,<br>
&gt; &gt; which means any RGW cluster using ext4 should recreate their OSDs=
 to use<br>
&gt; &gt; XFS.=C2=A0 Other librados users could be affected too, though, li=
ke users<br>
&gt; &gt; with very long rbd image names (e.g., &gt; 100 characters), or cu=
stom<br>
&gt; &gt; librados users.<br>
&gt; &gt;<br>
&gt; &gt; How:<br>
&gt; &gt;<br>
&gt; &gt; To make this change as visible as possible, the plan is to make c=
eph-osd<br>
&gt; &gt; refuse to start if the backend is unable to support the configure=
d max<br>
&gt; &gt; object name (osd_max_object_name_len).=C2=A0 The OSD will complai=
n that ext4<br>
&gt; &gt; cannot store such an object and refuse to start.=C2=A0 A user who=
 is only<br>
&gt; &gt; using RBD might decide they don&#39;t need long file names to wor=
k and can<br>
&gt; &gt; adjust the osd_max_object_name_len setting to something small (sa=
y, 64)<br>
&gt; &gt; and run successfully.=C2=A0 They would be taking a risk, though, =
because we<br>
&gt; &gt; would like to stop testing on ext4.<br>
&gt; &gt;<br>
&gt; &gt; Is this reasonable?<br>
&gt; About as reasonable as dropping format 1 support, that is not at all.<=
br>
&gt; <a href=3D"https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg2=
8070.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.co=
m/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg28070.html</a><br>
<br>
Fortunately nobody (to my knowledge) has suggested dropping format 1<br>
support.=C2=A0 :)<br>
<br>
&gt; I&#39;m officially only allowed to do (preventative) maintenance durin=
g weekend<br>
&gt; nights on our main production cluster.<br>
&gt; That would mean 13 ruined weekends at the realistic rate of 1 OSD per<=
br>
&gt; night, so you can see where my lack of enthusiasm for OSD recreation c=
omes<br>
&gt; from.<br>
<br>
Yeah.=C2=A0 :(<br>
<br>
&gt; &gt; If there significant ext4 users that are unwilling<br>
&gt; &gt; to recreate their OSDs, now would be the time to speak up.<br>
&gt; &gt;<br>
&gt; Consider that done.<br>
<br>
Thank you for the feedback!<br>
<br>
sage<br>_______________________________________________<br>
Ceph-maintainers mailing list<br>
<a href=3D"mailto:Ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">Ceph-maintainers@lists.c=
eph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com" re=
l=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-=
maintainers-ceph.com</a><br>
<br></blockquote></div>

--001a113a74d27528ff053040181a--

--===============0901439479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0901439479==--

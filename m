From: Scottix <scottix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Discuss: New default recovery config settings
Date: Thu, 04 Jun 2015 23:24:33 +0000
Message-ID: <CANKFHZ_yWaUYoKt3X5RE8BewRqhM_nvfmKwJPRPcFz444q_nWA@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
	<CAC6JEv8LyM1SRsOszDCj6tLxhZ=hvrEkinDARW8BvyQHDCz+LQ@mail.gmail.com>
	<622F4407872BA447A16110F65453358C03DFB21C4B5F@FMSAMAIL.fmsa.local>
	<CAC6JEv-i6tOwPBDjP++EW4FxAKZ_X_prEZ8YZOpLq-RTP1ZguQ@mail.gmail.com>
	<alpine.DEB.2.00.1506031541200.26591@cobra.newdream.net>
	<5570BCAE.5050509@cloudapt.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0722343709=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5570BCAE.5050509-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Von-Stamwitz <PVonStamwitz-gkcJ3tX5bYHQFUHtdCDX3A@public.gmane.org>, "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0722343709==
Content-Type: multipart/alternative; boundary=089e0116197a0eca240517b97b4c

--089e0116197a0eca240517b97b4c
Content-Type: text/plain; charset=UTF-8

From a ease of use standpoint and depending on the situation you are
setting up your environment, the idea is as follow;

It seems like it would be nice to have some easy on demand control where
you don't have to think a whole lot other than knowing how it is going to
affect your cluster in a general sense.

The two extremes and a general limitation would be:
1. Priority data recover
2. Priority client usability
3rd might be hardware related like 1Gb connection

With predefined settings you can setup different levels that have sensible
settings and maybe 1 that is custom for the advanced user.
Example command (Caveat: I don't fully know how your configs work):
ceph osd set priority <low|medium|high|custom>
*With priority set it would lock certain attributes
**With priority unset it would unlock certain attributes

In our use case basically after 8pm the activity goes way down. Here I can
up the priority to medium or high, then at 6 am I can adjust it back to low.

With cron I can easily schedule that or depending on the current situation
I can schedule maintenance and change the priority to fit my needs.



On Thu, Jun 4, 2015 at 2:01 PM Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org> wrote:

> With a write-heavy RBD workload, I add the following to ceph.conf:
>
> osd_max_backfills = 2
> osd_recovery_max_active = 2
>
> If things are going well during recovery (i.e. guests happy and no slow
> requests), I will often bump both up to three:
>
> # ceph tell osd.* injectargs '--osd-max-backfills 3
> --osd-recovery-max-active 3'
>
> If I see slow requests, I drop them down.
>
> The biggest downside to setting either to 1 seems to be the long tail
> issue detailed in:
>
> http://tracker.ceph.com/issues/9566
>
> Thanks,
> Mike Dawson
>
>
> On 6/3/2015 6:44 PM, Sage Weil wrote:
> > On Mon, 1 Jun 2015, Gregory Farnum wrote:
> >> On Mon, Jun 1, 2015 at 6:39 PM, Paul Von-Stamwitz
> >> <PVonStamwitz-gkcJ3tX5bYHQFUHtdCDX3A@public.gmane.org> wrote:
> >>> On Fri, May 29, 2015 at 4:18 PM, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
> wrote:
> >>>> On Fri, May 29, 2015 at 2:47 PM, Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> >>>>> Many people have reported that they need to lower the osd recovery
> config options to minimize the impact of recovery on client io.  We are
> talking about changing the defaults as follows:
> >>>>>
> >>>>> osd_max_backfills to 1 (from 10)
> >>>>> osd_recovery_max_active to 3 (from 15)
> >>>>> osd_recovery_op_priority to 1 (from 10)
> >>>>> osd_recovery_max_single_start to 1 (from 5)
> >>>>
> >>>> I'm under the (possibly erroneous) impression that reducing the
> number of max backfills doesn't actually reduce recovery speed much (but
> will reduce memory use), but that dropping the op priority can. I'd rather
> we make users manually adjust values which can have a material impact on
> their data safety, even if most of them choose to do so.
> >>>>
> >>>> After all, even under our worst behavior we're still doing a lot
> better than a resilvering RAID array. ;) -Greg
> >>>> --
> >>>
> >>>
> >>> Greg,
> >>> When we set...
> >>>
> >>> osd recovery max active = 1
> >>> osd max backfills = 1
> >>>
> >>> We see rebalance times go down by more than half and client write
> performance increase significantly while rebalancing. We initially played
> with these settings to improve client IO expecting recovery time to get
> worse, but we got a 2-for-1.
> >>> This was with firefly using replication, downing an entire node with
> lots of SAS drives. We left osd_recovery_threads, osd_recovery_op_priority,
> and osd_recovery_max_single_start default.
> >>>
> >>> We dropped osd_recovery_max_active and osd_max_backfills together. If
> you're right, do you think osd_recovery_max_active=1 is primary reason for
> the improvement? (higher osd_max_backfills helps recovery time with erasure
> coding.)
> >>
> >> Well, recovery max active and max backfills are similar in many ways.
> >> Both are about moving data into a new or outdated copy of the PG ? the
> >> difference is that recovery refers to our log-based recovery (where we
> >> compare the PG logs and move over the objects which have changed)
> >> whereas backfill requires us to incrementally move through the entire
> >> PG's hash space and compare.
> >> I suspect dropping down max backfills is more important than reducing
> >> max recovery (gathering recovery metadata happens largely in memory)
> >> but I don't really know either way.
> >>
> >> My comment was meant to convey that I'd prefer we not reduce the
> >> recovery op priority levels. :)
> >
> > We could make a less extreme move than to 1, but IMO we have to reduce it
> > one way or another.  Every major operator I've talked to does this, our
> PS
> > folks have been recommending it for years, and I've yet to see a single
> > complaint about recovery times... meanwhile we're drowning in a sea of
> > complaints about the impact on clients.
> >
> > How about
> >
> >   osd_max_backfills to 1 (from 10)
> >   osd_recovery_max_active to 3 (from 15)
> >   osd_recovery_op_priority to 3 (from 10)
> >   osd_recovery_max_single_start to 1 (from 5)
> >
> > (same as above, but 1/3rd the recovery op prio instead of 1/10th)
> > ?
> >
> > sage
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e0116197a0eca240517b97b4c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From a ease of use standpoint and depending on the situati=
on you are setting up your environment, the idea is as follow;<div><br></di=
v><div><span style=3D"font-size:13.1999998092651px;line-height:19.799999237=
0605px">It seems like it would be nice to have some easy on demand control =
where you don&#39;t have to think a whole lot other than knowing how it is =
going to affect your cluster in a general sense.</span><br></div><div><br><=
/div><div>The two extremes and a general limitation would be:</div><div>1. =
Priority data recover</div><div>2. Priority client usability</div><div>3rd =
might be hardware related like 1Gb connection<br><br>With predefined settin=
gs you can setup different levels that have sensible settings and maybe 1 t=
hat is custom for the advanced user.</div><div><div>Example command (Caveat=
: I don&#39;t fully know how your configs work):</div><div>ceph osd set pri=
ority &lt;low|medium|high|custom&gt;</div></div><div>*With priority set it =
would lock certain attributes</div><div>**With priority unset it would unlo=
ck certain attributes</div><div><br></div><div>In our use case basically af=
ter 8pm the activity goes way down. Here I can up the priority to medium or=
 high, then at 6 am I can adjust it back to low.</div><div><br></div><div>W=
ith cron I can easily schedule that or depending on the current situation I=
 can schedule maintenance and change the priority to fit my needs.</div><di=
v><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr">On Thu, Jun 4, 2015 at 2:01 PM Mike Dawson &lt;<a href=3D"mailto:mike=
.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org">mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">With a write-heavy RBD workload, I add the follo=
wing to ceph.conf:<br>
<br>
osd_max_backfills =3D 2<br>
osd_recovery_max_active =3D 2<br>
<br>
If things are going well during recovery (i.e. guests happy and no slow<br>
requests), I will often bump both up to three:<br>
<br>
# ceph tell osd.* injectargs &#39;--osd-max-backfills 3<br>
--osd-recovery-max-active 3&#39;<br>
<br>
If I see slow requests, I drop them down.<br>
<br>
The biggest downside to setting either to 1 seems to be the long tail<br>
issue detailed in:<br>
<br>
<a href=3D"http://tracker.ceph.com/issues/9566" target=3D"_blank">http://tr=
acker.ceph.com/issues/9566</a><br>
<br>
Thanks,<br>
Mike Dawson<br>
<br>
<br>
On 6/3/2015 6:44 PM, Sage Weil wrote:<br>
&gt; On Mon, 1 Jun 2015, Gregory Farnum wrote:<br>
&gt;&gt; On Mon, Jun 1, 2015 at 6:39 PM, Paul Von-Stamwitz<br>
&gt;&gt; &lt;<a href=3D"mailto:PVonStamwitz-gkcJ3tX5bYHQFUHtdCDX3A@public.gmane.org" target=3D"_blan=
k">PVonStamwitz-gkcJ3tX5bYHQFUHtdCDX3A@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt; On Fri, May 29, 2015 at 4:18 PM, Gregory Farnum &lt;<a href=3D=
"mailto:greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:=
<br>
&gt;&gt;&gt;&gt; On Fri, May 29, 2015 at 2:47 PM, Samuel Just &lt;<a href=
=3D"mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wro=
te:<br>
&gt;&gt;&gt;&gt;&gt; Many people have reported that they need to lower the =
osd recovery config options to minimize the impact of recovery on client io=
.=C2=A0 We are talking about changing the defaults as follows:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; osd_max_backfills to 1 (from 10)<br>
&gt;&gt;&gt;&gt;&gt; osd_recovery_max_active to 3 (from 15)<br>
&gt;&gt;&gt;&gt;&gt; osd_recovery_op_priority to 1 (from 10)<br>
&gt;&gt;&gt;&gt;&gt; osd_recovery_max_single_start to 1 (from 5)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I&#39;m under the (possibly erroneous) impression that red=
ucing the number of max backfills doesn&#39;t actually reduce recovery spee=
d much (but will reduce memory use), but that dropping the op priority can.=
 I&#39;d rather we make users manually adjust values which can have a mater=
ial impact on their data safety, even if most of them choose to do so.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; After all, even under our worst behavior we&#39;re still d=
oing a lot better than a resilvering RAID array. ;) -Greg<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Greg,<br>
&gt;&gt;&gt; When we set...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; osd recovery max active =3D 1<br>
&gt;&gt;&gt; osd max backfills =3D 1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We see rebalance times go down by more than half and client wr=
ite performance increase significantly while rebalancing. We initially play=
ed with these settings to improve client IO expecting recovery time to get =
worse, but we got a 2-for-1.<br>
&gt;&gt;&gt; This was with firefly using replication, downing an entire nod=
e with lots of SAS drives. We left osd_recovery_threads, osd_recovery_op_pr=
iority, and osd_recovery_max_single_start default.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We dropped osd_recovery_max_active and osd_max_backfills toget=
her. If you&#39;re right, do you think osd_recovery_max_active=3D1 is prima=
ry reason for the improvement? (higher osd_max_backfills helps recovery tim=
e with erasure coding.)<br>
&gt;&gt;<br>
&gt;&gt; Well, recovery max active and max backfills are similar in many wa=
ys.<br>
&gt;&gt; Both are about moving data into a new or outdated copy of the PG ?=
 the<br>
&gt;&gt; difference is that recovery refers to our log-based recovery (wher=
e we<br>
&gt;&gt; compare the PG logs and move over the objects which have changed)<=
br>
&gt;&gt; whereas backfill requires us to incrementally move through the ent=
ire<br>
&gt;&gt; PG&#39;s hash space and compare.<br>
&gt;&gt; I suspect dropping down max backfills is more important than reduc=
ing<br>
&gt;&gt; max recovery (gathering recovery metadata happens largely in memor=
y)<br>
&gt;&gt; but I don&#39;t really know either way.<br>
&gt;&gt;<br>
&gt;&gt; My comment was meant to convey that I&#39;d prefer we not reduce t=
he<br>
&gt;&gt; recovery op priority levels. :)<br>
&gt;<br>
&gt; We could make a less extreme move than to 1, but IMO we have to reduce=
 it<br>
&gt; one way or another.=C2=A0 Every major operator I&#39;ve talked to does=
 this, our PS<br>
&gt; folks have been recommending it for years, and I&#39;ve yet to see a s=
ingle<br>
&gt; complaint about recovery times... meanwhile we&#39;re drowning in a se=
a of<br>
&gt; complaints about the impact on clients.<br>
&gt;<br>
&gt; How about<br>
&gt;<br>
&gt;=C2=A0 =C2=A0osd_max_backfills to 1 (from 10)<br>
&gt;=C2=A0 =C2=A0osd_recovery_max_active to 3 (from 15)<br>
&gt;=C2=A0 =C2=A0osd_recovery_op_priority to 3 (from 10)<br>
&gt;=C2=A0 =C2=A0osd_recovery_max_single_start to 1 (from 5)<br>
&gt;<br>
&gt; (same as above, but 1/3rd the recovery op prio instead of 1/10th)<br>
&gt; ?<br>
&gt;<br>
&gt; sage<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt;<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div>

--089e0116197a0eca240517b97b4c--

--===============0722343709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0722343709==--

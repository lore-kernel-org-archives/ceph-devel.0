From: zphj1987 <zphj1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: Hammer OSD memory increase when add new
	machine
Date: Tue, 8 Nov 2016 22:48:19 +0800
Message-ID: <CALMEbCLNVTAsyCJUQXr7EgqLtW7gZmgNsSpYAWF29GYwVUrEXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1431364744=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, The Sacred Order of the Squid Cybernetic <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1431364744==
Content-Type: multipart/alternative; boundary=001a1145aebc9c667e0540cb3d55

--001a1145aebc9c667e0540cb3d55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I  remember CERN had a test ceph cluster 30PB  and the osd use more memery
 than usual   ,and thay tune osdmap_epochs ,if it is the osdmap make it use
more memery,ithink  you may have a test use less osdmap_epochs to see if
have some change

default mon_min_osdmap_epochs is 500


zphj1987

2016-11-08 22:08 GMT+08:00 Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>:

> > ---------- Forwarded message ----------
> > From: Dong Wu <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Date: 2016-10-27 18:50 GMT+08:00
> > Subject: Re: [ceph-users] Hammer OSD memory increase when add new machi=
ne
> > To: huang jun <hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > =E6=8A=84=E9=80=81=EF=BC=9A ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >
> >
> > 2016-10-27 17:50 GMT+08:00 huang jun <hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > > how do you add the new machine ?
> > > does it first added to default ruleset and then you add the new rule
> > > for this group?
> > > do you have data pool use the default rule, does these pool contain
> data?
> >
> > we dont use default ruleset, when we add new group machine,
> > crush_location auto generate root and chassis, then we add a new rule
> > for this group.
> >
> >
> > > 2016-10-27 17:34 GMT+08:00 Dong Wu <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > >> Hi all,
> > >>
> > >> We have a ceph cluster only use rbd. The cluster contains several
> > >> group machines, each group contains several machines, then each
> > >> machine has 12 SSDs, each ssd as an OSD (journal and data together).
> > >> eg:
> > >> group1: machine1~machine12
> > >> group2: machine13~machine24
> > >> ......
> > >> each group is separated with other group, which means each group has
> > >> separated pools.
> > >>
> > >> we use Hammer(0.94.6) compiled with jemalloc(4.2).
> > >>
> > >> We have found that when we add a new group machine, the other group
> > >> machine's memory increase 5% more or less (OSDs usage).
> > >>
> > >> each group's data is separated with others, so backfill only in grou=
p,
> > >> not across.
> > >> Why add a group of machine cause others memory increase? Is this
> reasonable?
>
> It could be cached OSDmaps (they get slightly larger when you add OSDs)
> but it's hard to say.  It seems more likely that the pools and crush rule=
s
> aren't configured right and you're adding OSDs to the wrong group.
>
> If you look at the 'ceph daemon osd.NNN perf dump' output you can see,
> among other things, how many PGs are on the OSD.  Can you capture the
> output before and after the change (and 5% memory footprint increase)?
>
> sage
>

--001a1145aebc9c667e0540cb3d55
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I =C2=A0remember CERN had a test ceph cluster 30PB =
=C2=A0and the osd use more memery =C2=A0than usual=C2=A0 =C2=A0,and thay tu=
ne=C2=A0osdmap_epochs ,if it is the osdmap make it use more memery,ithink =
=C2=A0you may have a test use less osdmap_epochs to see if have some change=
=C2=A0<br></div><div><div class=3D"gmail_extra"><br></div><div class=3D"gma=
il_extra">default mon_min_osdmap_epochs is 500=C2=A0<br></div><div class=3D=
"gmail_extra"><br></div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">zphj1987</div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">2016-11-08 22:08 GMT+08:00 Sage Weil <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204=
,204,204);padding-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail=
-h5">&gt; ---------- Forwarded message ----------<br>
&gt; From: Dong Wu &lt;<a href=3D"mailto:archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">archer.wu=
dong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; Date: 2016-10-27 18:50 GMT+08:00<br>
&gt; Subject: Re: [ceph-users] Hammer OSD memory increase when add new mach=
ine<br>
&gt; To: huang jun &lt;<a href=3D"mailto:hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">hjwsm1989@gma=
il.com</a>&gt;<br>
&gt; =E6=8A=84=E9=80=81=EF=BC=9A ceph-users &lt;<a href=3D"mailto:ceph-user=
s@lists.ceph.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; 2016-10-27 17:50 GMT+08:00 huang jun &lt;<a href=3D"mailto:hjwsm1989@g=
mail.com">hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt; &gt; how do you add the new machine ?<br>
&gt; &gt; does it first added to default ruleset and then you add the new r=
ule<br>
&gt; &gt; for this group?<br>
&gt; &gt; do you have data pool use the default rule, does these pool conta=
in data?<br>
&gt;<br>
&gt; we dont use default ruleset, when we add new group machine,<br>
&gt; crush_location auto generate root and chassis, then we add a new rule<=
br>
&gt; for this group.<br>
&gt;<br>
&gt;<br>
&gt; &gt; 2016-10-27 17:34 GMT+08:00 Dong Wu &lt;<a href=3D"mailto:archer.w=
udong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt; &gt;&gt; Hi all,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We have a ceph cluster only use rbd. The cluster contains sev=
eral<br>
&gt; &gt;&gt; group machines, each group contains several machines, then ea=
ch<br>
&gt; &gt;&gt; machine has 12 SSDs, each ssd as an OSD (journal and data tog=
ether).<br>
&gt; &gt;&gt; eg:<br>
&gt; &gt;&gt; group1: machine1~machine12<br>
&gt; &gt;&gt; group2: machine13~machine24<br>
&gt; &gt;&gt; ......<br>
&gt; &gt;&gt; each group is separated with other group, which means each gr=
oup has<br>
&gt; &gt;&gt; separated pools.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; we use Hammer(0.94.6) compiled with jemalloc(4.2).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We have found that when we add a new group machine, the other=
 group<br>
&gt; &gt;&gt; machine&#39;s memory increase 5% more or less (OSDs usage).<b=
r>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; each group&#39;s data is separated with others, so backfill o=
nly in group,<br>
&gt; &gt;&gt; not across.<br>
&gt; &gt;&gt; Why add a group of machine cause others memory increase? Is t=
his reasonable?<br>
<br>
</div></div>It could be cached OSDmaps (they get slightly larger when you a=
dd OSDs)<br>
but it&#39;s hard to say.=C2=A0 It seems more likely that the pools and cru=
sh rules<br>
aren&#39;t configured right and you&#39;re adding OSDs to the wrong group.<=
br>
<br>
If you look at the &#39;ceph daemon osd.NNN perf dump&#39; output you can s=
ee,<br>
among other things, how many PGs are on the OSD.=C2=A0 Can you capture the<=
br>
output before and after the change (and 5% memory footprint increase)?<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
sage<br>
</font></span></blockquote></div><br></div></div></div>

--001a1145aebc9c667e0540cb3d55--

--===============1431364744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1431364744==--

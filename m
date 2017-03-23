From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Recompiling source code - to find exact RPM
Date: Thu, 23 Mar 2017 18:11:55 +0530
Message-ID: <CALWuvY_bR7BZLwE+BzCxdWFm+bw4Xx58C1GnFZMkA0JgQMzwmA@mail.gmail.com>
References: <CALWuvY9kyuZgSHeLFwBw86J=tDzX-xc2FPvAQ8Qq__o3s_oodw@mail.gmail.com>
	<CAF-wwdFNgsq9+Z2Y3JcBxQoWfUtvtfZ0Y8C3WWArX9fPFVzR5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0199286409=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdFNgsq9+Z2Y3JcBxQoWfUtvtfZ0Y8C3WWArX9fPFVzR5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0199286409==
Content-Type: multipart/alternative; boundary=001a113ad706c53310054b6533df

--001a113ad706c53310054b6533df
Content-Type: text/plain; charset=UTF-8

Hey brad,

Thanks for the info.

Yea we know that these are test rpm's.

The idea behind my question is if I made any changes in the ceph source
code, then I recompile it. Then I need to find which is the appropriate rpm
mapped to that changed file. If I find the exact RPM, then apply that RPM
in our existing ceph cluster instead of applying/overwriting  all the
compiled rpms.

I hope this cleared your doubt.

Thanks




On Wed, Mar 22, 2017 at 5:47 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Based solely on the information given the only rpms with this specific
> commit in
> them would be here
> https://shaman.ceph.com/builds/ceph/wip-prune-past-intervals-kraken/
> (specifically
> https://4.chacra.ceph.com/r/ceph/wip-prune-past-intervals-kraken/
> 8263140fe539f9c3241c1c0f6ee9cfadde9178c0/centos/7/flavors/default/x86_64/
> ).
> These are test rpms, not official releases.
>
> Note that the branch "wip-prune-past-intervals-kraken" exists only in the
> ceph-ci repo and *not* the main ceph repo and that the particular commit
> above
> does not seem to have made it into the "ceph" repo.
>
> $ git log -S _simplify_past_intervals
> $ git log --grep="_simplify_past_intervals"
> $
>
> Given this commit is not in the ceph repo I would suggest we have never
> shipped
> an official rpm that contains this commit.
>
> It's not totally clear to me exactly what you are trying to achieve, maybe
> you
> could have another go at describing your objective?
>
> On Wed, Mar 22, 2017 at 12:26 AM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hello,
> >
> > I made some changes in the below file on ceph kraken v11.2.0 source code
> as
> > per this article
> >
> > https://github.com/ceph/ceph-ci/commit/wip-prune-past-intervals-kraken
> >
> > ..src/osd/PG.cc
> > ..src/osd/PG.h
> >
> > Is there any way to find which rpm got affected by these two files. I
> > believe it should be ceph-osd-11.2.0-0.el7.x86_64.rpm . Can you confirm
> > please ?
> >
> > I failed to find it from the ceph.spec file.
> >
> > Could anyone please guide me the right procedure to check this.
> >
> > The main intention is that if we find the exact rpm affected by these
> files,
> > we can simply overwrite it with the old rpm.
> >
> > Awaiting for comments.
> >
> > Thanks
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>
>
>
> --
> Cheers,
> Brad
>

--001a113ad706c53310054b6533df
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey brad,<div><br></div><div>Thanks for the info.=C2=A0</d=
iv><div><br></div><div>Yea we know that these are test rpm&#39;s.=C2=A0</di=
v><div><br></div><div>The idea behind my question is if I made any changes =
in the ceph source code, then I recompile it. Then I need to find which is =
the appropriate rpm mapped to that changed file. If I find the exact RPM, t=
hen apply that RPM in our existing ceph cluster instead of applying/overwri=
ting =C2=A0all the compiled rpms.</div><div><br></div><div>I hope this clea=
red your doubt.</div><div><br></div><div>Thanks</div><div><br></div><div><b=
r></div><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Wed, Mar 22, 2017 at 5:47 AM, Brad Hubbard <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">bhubbard@redh=
at.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Based solely=
 on the information given the only rpms with this specific commit in<br>
them would be here<br>
<a href=3D"https://shaman.ceph.com/builds/ceph/wip-prune-past-intervals-kra=
ken/" rel=3D"noreferrer" target=3D"_blank">https://shaman.ceph.com/<wbr>bui=
lds/ceph/wip-prune-past-<wbr>intervals-kraken/</a><br>
(specifically<br>
<a href=3D"https://4.chacra.ceph.com/r/ceph/wip-prune-past-intervals-kraken=
/8263140fe539f9c3241c1c0f6ee9cfadde9178c0/centos/7/flavors/default/x86_64/"=
 rel=3D"noreferrer" target=3D"_blank">https://4.chacra.ceph.com/r/<wbr>ceph=
/wip-prune-past-intervals-<wbr>kraken/<wbr>8263140fe539f9c3241c1c0f6ee9cf<w=
br>adde9178c0/centos/7/flavors/<wbr>default/x86_64/</a>).<br>
These are test rpms, not official releases.<br>
<br>
Note that the branch &quot;wip-prune-past-intervals-<wbr>kraken&quot; exist=
s only in the<br>
ceph-ci repo and *not* the main ceph repo and that the particular commit ab=
ove<br>
does not seem to have made it into the &quot;ceph&quot; repo.<br>
<br>
$ git log -S _simplify_past_intervals<br>
$ git log --grep=3D&quot;_simplify_past_<wbr>intervals&quot;<br>
$<br>
<br>
Given this commit is not in the ceph repo I would suggest we have never shi=
pped<br>
an official rpm that contains this commit.<br>
<br>
It&#39;s not totally clear to me exactly what you are trying to achieve, ma=
ybe you<br>
could have another go at describing your objective?<br>
<div><div class=3D"h5"><br>
On Wed, Mar 22, 2017 at 12:26 AM, nokia ceph &lt;<a href=3D"mailto:nokiacep=
husers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I made some changes in the below file on ceph kraken v11.2.0 source co=
de as<br>
&gt; per this article<br>
&gt;<br>
&gt; <a href=3D"https://github.com/ceph/ceph-ci/commit/wip-prune-past-inter=
vals-kraken" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/c=
eph-<wbr>ci/commit/wip-prune-past-<wbr>intervals-kraken</a><br>
&gt;<br>
&gt; ..src/osd/PG.cc<br>
&gt; ..src/osd/PG.h<br>
&gt;<br>
&gt; Is there any way to find which rpm got affected by these two files. I<=
br>
&gt; believe it should be ceph-osd-11.2.0-0.el7.x86_64.<wbr>rpm . Can you c=
onfirm<br>
&gt; please ?<br>
&gt;<br>
&gt; I failed to find it from the ceph.spec file.<br>
&gt;<br>
&gt; Could anyone please guide me the right procedure to check this.<br>
&gt;<br>
&gt; The main intention is that if we find the exact rpm affected by these =
files,<br>
&gt; we can simply overwrite it with the old rpm.<br>
&gt;<br>
&gt; Awaiting for comments.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt;<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/c=
eph-users-ceph.<wbr>com</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Cheers,<br>
Brad<br>
</font></span></blockquote></div><br></div>

--001a113ad706c53310054b6533df--

--===============0199286409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0199286409==--

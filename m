From: agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: if ceph tracker says the source was QA,
 what version that I have to checkout?
Date: Mon, 10 Oct 2016 07:25:02 +0700
Message-ID: <CAJ+86MPGt6THcctFH=HmfO+SmYWbj3Ruk7HZ82wn9br8AS_zJw@mail.gmail.com>
References: <CAJ+86MN1GkiO1coWEXeEkKxmijKRL8zEvszeXPpa-Ky4vXfxSA@mail.gmail.com>
	<CAJ+86MOjgonJk-x9CfucTYy-+UTr16qU3J_9Y1hf0SdozZkZUQ@mail.gmail.com>
	<CAF-wwdG8AEqQJZqhpJb74Y5h-T7i_TZBsb+aYstyha3UhmrYmQ@mail.gmail.com>
	<CAJ+86MMy8K+obb-ywoC+a9_gBgqXJkozbzs7hpvquC4bJa=OCA@mail.gmail.com>
	<20161010001800.GA6044@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0264122273=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20161010001800.GA6044-N1T7puQKft1Sq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
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

--===============0264122273==
Content-Type: multipart/alternative; boundary=001a114750687cfe1a053e77ca43

--001a114750687cfe1a053e77ca43
Content-Type: text/plain; charset=UTF-8

Yes you're right.

Sometimes it tested not in a single step back then.
but it also possible to be tested some version steps in the previous
commits.

thanks for helping!


On Mon, Oct 10, 2016 at 7:18 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>
>
> On Mon, Oct 10, 2016 at 9:51 AM, agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > thank you for the answer Brad,
> >
> > so the thing that I have to do is that:
> > - see the commit version
> > - checkout to the commit version
> > - see the log ( git log -p -1)
> > - ultimately, checkout the older one.
> >
> > Am I correct?
>
> Yes, that's pretty much it. The following should be your starting point.
>
> $ git checkout c421b55e8e15ef04ca8aeb47f7d090375eaa8573~1
>
> It's not guaranteed that every commit will build and test successfully so
> you
> may need to move further back from that point or even use the previous tag
> (in
> this case v0.85).
>
> >
> >
> > On Mon, Oct 10, 2016 at 6:28 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> >>
> >> On Mon, Oct 10, 2016 at 9:21 AM, agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> wrote:
> >> >
> >> > Hi All ceph users,
> >> >
> >> > I am interesting to learn ceph bug.
> >> >
> >> > Some bugs that I learned pointing particular ceph version or tags for
> >> > their
> >> > buggy part.
> >> > However I found some bugs put Q/A as the source.
> >> > For instance http://tracker.ceph.com/issues/9301
> >> >
> >> > when I checked out on giant and firefly version, I saw the significant
> >> > different between
> >> > the version and the revision that changed by the developer.
> >> >
> >> > My question is how to have a buggy version( version when the patch has
> >> > not
> >> > been implemented)?
> >>
> >> For this particular commit we can ask git.
> >>
> >>
> >> http://tracker.ceph.com/projects/ceph/repository/revisions/
> c421b55e8e15ef04ca8aeb47f7d090375eaa8573
> >>
> >> $ git describe c421b55e8e15ef04ca8aeb47f7d090375eaa8573
> >> v0.85-884-gc421b55
> >>
> >> So this was the 884th commit after the v0.85 tag and you need to check
> >> out a copy of the source before that.
> >>
> >> >
> >> > Thanks
> >> >
> >> > --
> >> > Cheers,
> >> >
> >> > Agung Laksono
> >> >
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> >
> >>
> >>
> >>
> >> --
> >> Cheers,
> >> Brad
> >
> >
> >
> >
> > --
> > Cheers,
> >
> > Agung Laksono
> >
>
>
>
> --
> Cheers,
> Brad
>



-- 
Cheers,

Agung Laksono

--001a114750687cfe1a053e77ca43
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Yes you&#39;re right.<br><br></div>Sometimes it =
tested not in a single step back then. <br>but it also possible to be teste=
d some version steps in the previous commits.<br><br></div>thanks for helpi=
ng!<br><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Mon, Oct 10, 2016 at 7:18 AM, Brad Hubbard <span dir=3D"ltr">=
&lt;<a href=3D"mailto:bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">bhubbard@redha=
t.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D""><br>
<br>
On Mon, Oct 10, 2016 at 9:51 AM, agung Laksono &lt;<a href=3D"mailto:agung.=
smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; thank you for the answer Brad,<br>
&gt;<br>
&gt; so the thing that I have to do is that:<br>
&gt; - see the commit version<br>
&gt; - checkout to the commit version<br>
&gt; - see the log ( git log -p -1)<br>
&gt; - ultimately, checkout the older one.<br>
&gt;<br>
&gt; Am I correct?<br>
<br>
</span>Yes, that&#39;s pretty much it. The following should be your startin=
g point.<br>
<br>
$ git checkout c421b55e8e15ef04ca8aeb47f7d090<wbr>375eaa8573~1<br>
<br>
It&#39;s not guaranteed that every commit will build and test successfully =
so you<br>
may need to move further back from that point or even use the previous tag =
(in<br>
this case v0.85).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; On Mon, Oct 10, 2016 at 6:28 AM, Brad Hubbard &lt;<a href=3D"mailto:bh=
ubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Oct 10, 2016 at 9:21 AM, agung Laksono &lt;<a href=3D"mail=
to:agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi All ceph users,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am interesting to learn ceph bug.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Some bugs that I learned pointing particular ceph version or =
tags for<br>
&gt;&gt; &gt; their<br>
&gt;&gt; &gt; buggy part.<br>
&gt;&gt; &gt; However I found some bugs put Q/A as the source.<br>
&gt;&gt; &gt; For instance <a href=3D"http://tracker.ceph.com/issues/9301" =
rel=3D"noreferrer" target=3D"_blank">http://tracker.ceph.com/<wbr>issues/93=
01</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; when I checked out on giant and firefly version, I saw the si=
gnificant<br>
&gt;&gt; &gt; different between<br>
&gt;&gt; &gt; the version and the revision that changed by the developer.<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; My question is how to have a buggy version( version when the =
patch has<br>
&gt;&gt; &gt; not<br>
&gt;&gt; &gt; been implemented)?<br>
&gt;&gt;<br>
&gt;&gt; For this particular commit we can ask git.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://tracker.ceph.com/projects/ceph/repository/revisi=
ons/c421b55e8e15ef04ca8aeb47f7d090375eaa8573" rel=3D"noreferrer" target=3D"=
_blank">http://tracker.ceph.com/<wbr>projects/ceph/repository/<wbr>revision=
s/<wbr>c421b55e8e15ef04ca8aeb47f7d090<wbr>375eaa8573</a><br>
&gt;&gt;<br>
&gt;&gt; $ git describe c421b55e8e15ef04ca8aeb47f7d090<wbr>375eaa8573<br>
&gt;&gt; v0.85-884-gc421b55<br>
&gt;&gt;<br>
&gt;&gt; So this was the 884th commit after the v0.85 tag and you need to c=
heck<br>
&gt;&gt; out a copy of the source before that.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; Cheers,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Agung Laksono<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; ceph-users mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists=
.ceph.com</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph=
.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listi=
nfo.cgi/ceph-users-ceph.<wbr>com</a><br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Cheers,<br>
&gt;&gt; Brad<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Agung Laksono<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Cheers,<br>
Brad<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div><div dir=3D"ltr"><div>Cheers,</div><div><br></div>Agung Laksono<br><br>=
</div></div></div></div>
</div>

--001a114750687cfe1a053e77ca43--

--===============0264122273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0264122273==--

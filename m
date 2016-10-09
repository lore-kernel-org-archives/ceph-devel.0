From: agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: if ceph tracker says the source was QA,
 what version that I have to checkout?
Date: Mon, 10 Oct 2016 06:51:26 +0700
Message-ID: <CAJ+86MMy8K+obb-ywoC+a9_gBgqXJkozbzs7hpvquC4bJa=OCA@mail.gmail.com>
References: <CAJ+86MN1GkiO1coWEXeEkKxmijKRL8zEvszeXPpa-Ky4vXfxSA@mail.gmail.com>
	<CAJ+86MOjgonJk-x9CfucTYy-+UTr16qU3J_9Y1hf0SdozZkZUQ@mail.gmail.com>
	<CAF-wwdG8AEqQJZqhpJb74Y5h-T7i_TZBsb+aYstyha3UhmrYmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507913985=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdG8AEqQJZqhpJb74Y5h-T7i_TZBsb+aYstyha3UhmrYmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0507913985==
Content-Type: multipart/alternative; boundary=001a1143840e5ecaf2053e7752f8

--001a1143840e5ecaf2053e7752f8
Content-Type: text/plain; charset=UTF-8

thank you for the answer Brad,

so the thing that I have to do is that:
- see the commit version
- checkout to the commit version
- see the log ( git log -p -1)
- ultimately, checkout the older one.

Am I correct?


On Mon, Oct 10, 2016 at 6:28 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Mon, Oct 10, 2016 at 9:21 AM, agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > Hi All ceph users,
> >
> > I am interesting to learn ceph bug.
> >
> > Some bugs that I learned pointing particular ceph version or tags for
> their
> > buggy part.
> > However I found some bugs put Q/A as the source.
> > For instance http://tracker.ceph.com/issues/9301
> >
> > when I checked out on giant and firefly version, I saw the significant
> > different between
> > the version and the revision that changed by the developer.
> >
> > My question is how to have a buggy version( version when the patch has
> not
> > been implemented)?
>
> For this particular commit we can ask git.
>
> http://tracker.ceph.com/projects/ceph/repository/revisions/
> c421b55e8e15ef04ca8aeb47f7d090375eaa8573
>
> $ git describe c421b55e8e15ef04ca8aeb47f7d090375eaa8573
> v0.85-884-gc421b55
>
> So this was the 884th commit after the v0.85 tag and you need to check
> out a copy of the source before that.
>
> >
> > Thanks
> >
> > --
> > Cheers,
> >
> > Agung Laksono
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



-- 
Cheers,

Agung Laksono

--001a1143840e5ecaf2053e7752f8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>thank you for the answer Bra=
d,<br><br></div>so the thing that I have to do is that:<br></div>- see the =
commit version<br></div>- checkout to the commit version<br></div>- see the=
 log ( git log -p -1)<br></div>- ultimately, checkout the older one.<br><br=
></div>Am I correct?<br><div><br></div></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Mon, Oct 10, 2016 at 6:28 AM, Brad Hubbard <=
span dir=3D"ltr">&lt;<a href=3D"mailto:bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blan=
k">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><span class=3D"">On Mon, Oct 10, 2016 at 9:21 AM, agung Laksono &lt;<a =
href=3D"mailto:agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote=
:<br>
&gt;<br>
&gt; Hi All ceph users,<br>
&gt;<br>
&gt; I am interesting to learn ceph bug.<br>
&gt;<br>
&gt; Some bugs that I learned pointing particular ceph version or tags for =
their<br>
&gt; buggy part.<br>
&gt; However I found some bugs put Q/A as the source.<br>
&gt; For instance <a href=3D"http://tracker.ceph.com/issues/9301" rel=3D"no=
referrer" target=3D"_blank">http://tracker.ceph.com/<wbr>issues/9301</a><br=
>
&gt;<br>
&gt; when I checked out on giant and firefly version, I saw the significant=
<br>
&gt; different between<br>
&gt; the version and the revision that changed by the developer.<br>
&gt;<br>
&gt; My question is how to have a buggy version( version when the patch has=
 not<br>
&gt; been implemented)?<br>
<br>
</span>For this particular commit we can ask git.<br>
<br>
<a href=3D"http://tracker.ceph.com/projects/ceph/repository/revisions/c421b=
55e8e15ef04ca8aeb47f7d090375eaa8573" rel=3D"noreferrer" target=3D"_blank">h=
ttp://tracker.ceph.com/<wbr>projects/ceph/repository/<wbr>revisions/<wbr>c4=
21b55e8e15ef04ca8aeb47f7d090<wbr>375eaa8573</a><br>
<br>
$ git describe c421b55e8e15ef04ca8aeb47f7d090<wbr>375eaa8573<br>
v0.85-884-gc421b55<br>
<br>
So this was the 884th commit after the v0.85 tag and you need to check<br>
out a copy of the source before that.<br>
<span class=3D""><br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; --<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Agung Laksono<br>
&gt;<br>
</span>&gt; ______________________________<wbr>_________________<br>
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
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div><div dir=3D"ltr"><div>Cheers,</div><div><br></div>Agung Laksono<br><br>=
</div></div></div></div>
</div>

--001a1143840e5ecaf2053e7752f8--

--===============0507913985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0507913985==--

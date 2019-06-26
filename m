From: Bob Farrell <bob-9q1mke+DIVG9FHfhHBbuYA@public.gmane.org>
Subject: Re: Changing the release cadence
Date: Wed, 26 Jun 2019 15:56:10 +0100
Message-ID: <CA+X1WqW7eiYa838Vh89Hsq1SE3f8dEXoCbyQNA-JyOJ3Y1mf-g@mail.gmail.com>
References: <alpine.DEB.2.11.1906051556500.987@piezo.novalocal>
 <alpine.DEB.2.11.1906171621000.20504@piezo.novalocal>
 <CAN-Gep+9bxadHMTFQgUFUt_q9Jmfpy3MPU5UTTRNY1jueu7n9w@mail.gmail.com>
 <CAC-Np1zcniBxm84SEGhzYfu55t+fckg1d-Dq0xpab62+ON4K5w@mail.gmail.com>
 <CAE6AcseMEfRjRtA0iUPMwsQPP+ebEqDDHYeWUpXWGeWTggnKRw@mail.gmail.com>
 <alpine.DEB.2.11.1906261255530.17148@piezo.novalocal>
 <alpine.DEB.2.11.1906261437280.17148@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8199267686054462618=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1906261437280.17148-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, dev-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============8199267686054462618==
Content-Type: multipart/alternative; boundary="000000000000943344058c3b3ffd"

--000000000000943344058c3b3ffd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

March seems sensible to me for the reasons you stated. If a release gets
delayed, I'd prefer it to be on the spring side of Christmas (again for the
reasons already mentioned).

That aside, I'm now very impatient to install Octopus on my 8-node cluster.
: )

On Wed, 26 Jun 2019 at 15:46, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi everyone,
>
> We talked a bit about this during the CLT meeting this morning.  How abou=
t
> the following proposal:
>
> - Target release date of Mar 1 each year.
> - Target freeze in Dec.  That will allow us to use the holidays to do a
>   lot of testing when the lab infrastructure tends to be somewhat idle.
>
> If we get an early build out at the point of the freeze (or even earlier)=
,
> perhaps this capture some of the time that the retailers have during thei=
r
> lockdown to identify structural issues with release.  It is probably
> better to do more of this testing at this point in the cycle so that we
> have time to properly fix any big issues (like performance or scaling
> regressions).  It is of course a challenge to motivate testing on
> something that is too far from the final a release, but we can try.
>
> This avoids an abbreviated octopus cycle, and avoids placing August (whic=
h
> also often has people out for vacations) right in the middle of the
> lead-up to the freeze.
>
> Thoughts?
> sage
>
>
>
> On Wed, 26 Jun 2019, Sage Weil wrote:
>
> > On Wed, 26 Jun 2019, Alfonso Martinez Hidalgo wrote:
> > > I think March is a good idea.
> >
> > Spring had a slight edge over fall in the twitter poll (for whatever
> > that's worth).  I see the appeal for fall when it comes to down time
> for
> > retailers, but as a practical matter for Octopus specifically, a target
> of
> > say October means freezing in August, which means we only have 2
> > more months of development time.  I'm worried that will turn Octopus
> > in another weak (aka lightly adopted) release.
> >
> > March would mean freezing in January again, which would give us July to
> > Dec... 6 more months.
> >
> > sage
> >
> >
> >
> > >
> > > On Tue, Jun 25, 2019 at 4:32 PM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
> > >
> > > > On Mon, Jun 17, 2019 at 4:09 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> > > > wrote:
> > > > >
> > > > > This was a little long to respond with on Twitter, so I thought I=
'd
> > > > share my thoughts here. I love the idea of a 12 month cadence. I li=
ke
> > > > October because admins aren't upgrading production within the first
> few
> > > > months of a new release. It gives it plenty of time to be stable fo=
r
> the OS
> > > > distros as well as giving admins something low-key to work on over
> the
> > > > holidays with testing the new releases in stage/QA.
> > > >
> > > > October sounds ideal, but in reality, we haven't been able to relea=
se
> > > > right on time as long as I can remember. Realistically, if we set
> > > > October, we are probably going to get into November/December.
> > > >
> > > > For example, Nautilus was set to release in February and we got it
> out
> > > > late in late March (Almost April)
> > > >
> > > > Would love to see more of a discussion around solving the problem o=
f
> > > > releasing when we say we are going to - so that we can then choose
> > > > what the cadence is.
> > > >
> > > > >
> > > > > On Mon, Jun 17, 2019 at 12:22 PM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> wrote:
> > > > >>
> > > > >> On Wed, 5 Jun 2019, Sage Weil wrote:
> > > > >> > That brings us to an important decision: what time of year
> should we
> > > > >> > release?  Once we pick the timing, we'll be releasing at that
> time
> > > > *every
> > > > >> > year* for each release (barring another schedule shift, which
> we want
> > > > to
> > > > >> > avoid), so let's choose carefully!
> > > > >>
> > > > >> I've put up a twitter poll:
> > > > >>
> > > > >>         https://twitter.com/liewegas/status/1140655233430970369
> > > > >>
> > > > >> Thanks!
> > > > >> sage
> > > > >> _______________________________________________
> > > > >> ceph-users mailing list
> > > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > >
> > > > > _______________________________________________
> > > > > ceph-users mailing list
> > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > >
> > >
> > >
> > > --
> > >
> > > Alfonso Mart=C3=ADnez
> > >
> > > Senior Software Engineer, Ceph Storage
> > >
> > > Red Hat <https://www.redhat.com>
> > > <https://red.ht/sig>
> > > _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000943344058c3b3ffd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">March seems sensible to me for the reasons you stated. If =
a release gets delayed, I&#39;d prefer it to be on the spring side of Chris=
tmas (again for the reasons already mentioned).<div><br></div><div>That asi=
de, I&#39;m now very impatient to install Octopus on my 8-node cluster. : )=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, 26 Jun 2019 at 15:46, Sage Weil &lt;<a href=3D"mailto:sweil@r=
edhat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi everyone,<br>
<br>
We talked a bit about this during the CLT meeting this morning.=C2=A0 How a=
bout <br>
the following proposal:<br>
<br>
- Target release date of Mar 1 each year.<br>
- Target freeze in Dec.=C2=A0 That will allow us to use the holidays to do =
a <br>
=C2=A0 lot of testing when the lab infrastructure tends to be somewhat idle=
.<br>
<br>
If we get an early build out at the point of the freeze (or even earlier), =
<br>
perhaps this capture some of the time that the retailers have during their =
<br>
lockdown to identify structural issues with release.=C2=A0 It is probably <=
br>
better to do more of this testing at this point in the cycle so that we <br=
>
have time to properly fix any big issues (like performance or scaling <br>
regressions).=C2=A0 It is of course a challenge to motivate testing on <br>
something that is too far from the final a release, but we can try.<br>
<br>
This avoids an abbreviated octopus cycle, and avoids placing August (which =
<br>
also often has people out for vacations) right in the middle of the <br>
lead-up to the freeze.<br>
<br>
Thoughts?<br>
sage<br>
<br>
<br>
<br>
On Wed, 26 Jun 2019, Sage Weil wrote:<br>
<br>
&gt; On Wed, 26 Jun 2019, Alfonso Martinez Hidalgo wrote:<br>
&gt; &gt; I think March is a good idea.<br>
&gt; <br>
&gt; Spring had a slight edge over fall in the twitter poll (for whatever <=
br>
&gt; that&#39;s worth).=C2=A0 I see the appeal for fall when it comes to do=
wn time for=C2=A0 <br>
&gt; retailers, but as a practical matter for Octopus specifically, a targe=
t of<br>
&gt; say October means freezing in August, which means we only have 2<br>
&gt; more months of development time.=C2=A0 I&#39;m worried that will turn =
Octopus <br>
&gt; in another weak (aka lightly adopted) release.<br>
&gt; <br>
&gt; March would mean freezing in January again, which would give us July t=
o <br>
&gt; Dec... 6 more months.<br>
&gt; <br>
&gt; sage<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; On Tue, Jun 25, 2019 at 4:32 PM Alfredo Deza &lt;<a href=3D"mailt=
o:adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; On Mon, Jun 17, 2019 at 4:09 PM David Turner &lt;<a href=3D"=
mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This was a little long to respond with on Twitter, so I=
 thought I&#39;d<br>
&gt; &gt; &gt; share my thoughts here. I love the idea of a 12 month cadenc=
e. I like<br>
&gt; &gt; &gt; October because admins aren&#39;t upgrading production withi=
n the first few<br>
&gt; &gt; &gt; months of a new release. It gives it plenty of time to be st=
able for the OS<br>
&gt; &gt; &gt; distros as well as giving admins something low-key to work o=
n over the<br>
&gt; &gt; &gt; holidays with testing the new releases in stage/QA.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; October sounds ideal, but in reality, we haven&#39;t been ab=
le to release<br>
&gt; &gt; &gt; right on time as long as I can remember. Realistically, if w=
e set<br>
&gt; &gt; &gt; October, we are probably going to get into November/December=
.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; For example, Nautilus was set to release in February and we =
got it out<br>
&gt; &gt; &gt; late in late March (Almost April)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Would love to see more of a discussion around solving the pr=
oblem of<br>
&gt; &gt; &gt; releasing when we say we are going to - so that we can then =
choose<br>
&gt; &gt; &gt; what the cadence is.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Mon, Jun 17, 2019 at 12:22 PM Sage Weil &lt;<a href=
=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; w=
rote:<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; On Wed, 5 Jun 2019, Sage Weil wrote:<br>
&gt; &gt; &gt; &gt;&gt; &gt; That brings us to an important decision: what =
time of year should we<br>
&gt; &gt; &gt; &gt;&gt; &gt; release?=C2=A0 Once we pick the timing, we&#39=
;ll be releasing at that time<br>
&gt; &gt; &gt; *every<br>
&gt; &gt; &gt; &gt;&gt; &gt; year* for each release (barring another schedu=
le shift, which we want<br>
&gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt;&gt; &gt; avoid), so let&#39;s choose carefully!<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; I&#39;ve put up a twitter poll:<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https:/=
/twitter.com/liewegas/status/1140655233430970369" rel=3D"noreferrer" target=
=3D"_blank">https://twitter.com/liewegas/status/1140655233430970369</a><br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; Thanks!<br>
&gt; &gt; &gt; &gt;&gt; sage<br>
&gt; &gt; &gt; &gt;&gt; _______________________________________________<br>
&gt; &gt; &gt; &gt;&gt; ceph-users mailing list<br>
&gt; &gt; &gt; &gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=
=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; &gt; &gt; &gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-=
users-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/=
listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; &gt; ceph-users mailing list<br>
&gt; &gt; &gt; &gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"=
_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; &gt; &gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-user=
s-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/list=
info.cgi/ceph-users-ceph.com</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; -- <br>
&gt; &gt; <br>
&gt; &gt; Alfonso Mart=C3=ADnez<br>
&gt; &gt; <br>
&gt; &gt; Senior Software Engineer, Ceph Storage<br>
&gt; &gt; <br>
&gt; &gt; Red Hat &lt;<a href=3D"https://www.redhat.com" rel=3D"noreferrer"=
 target=3D"_blank">https://www.redhat.com</a>&gt;<br>
&gt; &gt; &lt;<a href=3D"https://red.ht/sig" rel=3D"noreferrer" target=3D"_=
blank">https://red.ht/sig</a>&gt;<br>
&gt; &gt; _______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--000000000000943344058c3b3ffd--

--===============8199267686054462618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8199267686054462618==--

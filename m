From: Neil Levine <neil.levine-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Inktank Ceph Enterprise Launch
Date: Wed, 30 Oct 2013 11:59:52 -0700
Message-ID: <CANygib-NWN11BH-DK-E=0_=E9c3+TsZni8N1=Mdm11c94MO6aw@mail.gmail.com>
References: <CAP8Oy=+CfOLQZq3X02zrE6sCLyJ_wKxiLeKX8v=PmpZQ3d_0QA@mail.gmail.com>
	<527141E3.2020601@dachary.org>
	<57ED724085B72141BB091CF1314E471F017A605A@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0660491951=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <57ED724085B72141BB091CF1314E471F017A605A-nsZYYkk5h5Q0nt+34NmQpKBKnGwkPULj@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "Don Talton (dotalton)" <dotalton-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0660491951==
Content-Type: multipart/alternative; boundary=089e013a110230198404e9f9f0f9

--089e013a110230198404e9f9f0f9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Loic, Don,

From an Inktank perspective, we're keen to see a wide variety of ecosystem
tools built around Ceph, especially from developers outside of Inktank. We
welcome open source or other commercial tools that people want to build and
if a more compelling or popular community tool comes along, we'd definitely
look to have our engineers work on it and potentially package it up for our
customers either as a complement or alternative to Calamari. The more
diverse innovation we have in the Ceph community, the better for everyone.

We may very well open source Calamari in the medium term but right now
there are some very specific things that our customers and partners want us
to do with the product, which don't lend themselves well to an open source
project. The most important aspect here is that we are absolutely committed
to ensuring every piece of storage functionality we develop sits in Ceph
and that the tools just provide a specific experience, not a different set
of capabilities.

In terms of a foundation, we definitely acknowledge the benefits this will
bring and share the same vision. We should have a proper community
conversation about what this may look like in practice - perhaps during the
next developer summit?

Neil



On Wed, Oct 30, 2013 at 11:03 AM, Don Talton (dotalton)
<dotalton-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>wrote:

> I actually started a django app (no code pushed yet) for this purpose. I
> guessed that Inktank might come out with a commercial offering and though=
t
> a FOSS dashboard would be a good thing for the community too.
>
> https://github.com/dontalton/kraken
>
> I'd much rather contribute to a Inktank-backed dashboard if it were FOSS,
> than start a new project.
>
>
> > -----Original Message-----
> > From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-
> > bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Loic Dachary
> > Sent: Wednesday, October 30, 2013 10:29 AM
> > To: Patrick McGarry; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; Ceph Devel
> > Subject: Re: [ceph-users] Inktank Ceph Enterprise Launch
> >
> > Hi Patrick,
> >
> > I wish Inktank was able to base its strategy and income on Free Softwar=
e.
> > Like RedHat does, for instance. In addition, as long as Inktank employs
> the
> > majority of Ceph developers, publishing Calamari as a proprietary
> software is
> > a conflict of interest. Should someone from the community bootstrap a
> Free
> > Software alternative to Calamari, it will compete with it. And should
> Inktank
> > employees participate in the development of this alternative, it would =
be
> > against the best interest of Inktank. If that were not true, there woul=
d
> be no
> > reason to publish Calamari as proprietary software in the first place.
> >
> > Please reconsider your decision to publish Calamari as a proprietary
> software.
> >
> > Now is probably the right time to call for the creation of a Ceph
> foundation.
> >
> > Cheers
> >
> > On 30/10/2013 18:01, Patrick McGarry wrote:
> > > Salutations Ceph-ers,
> > >
> > > As many of you have noticed, Inktank has taken the wraps off the
> > > latest and greatest magic for enterprise customers.  Wanted to share =
a
> > > few thoughts from a community perspective on Ceph.com and answer any
> > > questions/concerns folks might have.
> > >
> > > http://ceph.com/community/new-inktank-ceph-enterprise-builds-on-
> > what-m
> > > akes-ceph-great/
> > >
> > > Just to reiterate, there will be no changes/limitations to Ceph.  All
> > > Inktank contributions to Ceph will continue to be open source and
> > > useable.  If you have any questions feel free to direct them my way.
> > > Thanks.
> > >
> > >
> > > Best Regards,
> > >
> > > Patrick McGarry
> > > Director, Community || Inktank
> > > http://ceph.com  ||  http://inktank.com @scuttlemonkey || @ceph ||
> > > @inktank
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More
> > majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> > --
> > Lo=EFc Dachary, Artisan Logiciel Libre
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e013a110230198404e9f9f0f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Loic, Don,<br><br></div>From an Inktank perspect=
ive, we&#39;re keen to=20
see a wide variety of ecosystem tools built around Ceph, especially from
 developers outside of Inktank. We welcome open source or other=20
commercial=20
tools that people want to build and if a more compelling or popular=20
community tool comes along, we&#39;d definitely look to have our engineers=
=20
work on it and potentially package it up for our customers either as a=20
complement or alternative to Calamari. The more diverse innovation we=20
have in the Ceph community, the better for everyone. <br><br>We may very
 well open source Calamari in the medium term but right now there are=20
some very specific things that our customers and partners want us to do=20
with the product, which don&#39;t lend themselves well to an open source=20
project. The most important aspect here is that we are absolutely=20
committed to ensuring every piece of storage functionality we develop sits =
in Ceph=20
and that the tools just provide a specific experience, not a different set =
of capabilities.<br>
<br></div>In terms of a foundation, we definitely acknowledge the benefits =
this will bring and share the same vision. We should have a proper communit=
y conversation about what this may look like in practice - perhaps during t=
he next developer summit?<br>


<br><div><div>Neil<br><br></div></div></div><div class=3D"gmail_extra"><br>=
<br><div class=3D"gmail_quote">On Wed, Oct 30, 2013 at 11:03 AM, Don Talton=
 (dotalton) <span dir=3D"ltr">&lt;<a href=3D"mailto:dotalton-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org" tar=
get=3D"_blank">dotalton-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I actually started a django app (no code pus=
hed yet) for this purpose. I guessed that Inktank might come out with a com=
mercial offering and thought a FOSS dashboard would be a good thing for the=
 community too.<br>

<br>
<a href=3D"https://github.com/dontalton/kraken" target=3D"_blank">https://g=
ithub.com/dontalton/kraken</a><br>
<br>
I&#39;d much rather contribute to a Inktank-backed dashboard if it were FOS=
S, than start a new project.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-=
bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> [mailto:<a href=3D"mailto:ceph-users-">ceph-user=
s-</a><br>
&gt; <a href=3D"mailto:bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>] =
On Behalf Of Loic Dachary<br>
&gt; Sent: Wednesday, October 30, 2013 10:29 AM<br>
&gt; To: Patrick McGarry; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph=
-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>; Ceph Devel<br>
&gt; Subject: Re: [ceph-users] Inktank Ceph Enterprise Launch<br>
&gt;<br>
&gt; Hi Patrick,<br>
&gt;<br>
&gt; I wish Inktank was able to base its strategy and income on Free Softwa=
re.<br>
&gt; Like RedHat does, for instance. In addition, as long as Inktank employ=
s the<br>
&gt; majority of Ceph developers, publishing Calamari as a proprietary soft=
ware is<br>
&gt; a conflict of interest. Should someone from the community bootstrap a =
Free<br>
&gt; Software alternative to Calamari, it will compete with it. And should =
Inktank<br>
&gt; employees participate in the development of this alternative, it would=
 be<br>
&gt; against the best interest of Inktank. If that were not true, there wou=
ld be no<br>
&gt; reason to publish Calamari as proprietary software in the first place.=
<br>
&gt;<br>
&gt; Please reconsider your decision to publish Calamari as a proprietary s=
oftware.<br>
&gt;<br>
&gt; Now is probably the right time to call for the creation of a Ceph foun=
dation.<br>
&gt;<br>
&gt; Cheers<br>
&gt;<br>
&gt; On 30/10/2013 18:01, Patrick McGarry wrote:<br>
&gt; &gt; Salutations Ceph-ers,<br>
&gt; &gt;<br>
&gt; &gt; As many of you have noticed, Inktank has taken the wraps off the<=
br>
&gt; &gt; latest and greatest magic for enterprise customers. =A0Wanted to =
share a<br>
&gt; &gt; few thoughts from a community perspective on Ceph.com and answer =
any<br>
&gt; &gt; questions/concerns folks might have.<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://ceph.com/community/new-inktank-ceph-enterprise-=
builds-on-" target=3D"_blank">http://ceph.com/community/new-inktank-ceph-en=
terprise-builds-on-</a><br>
&gt; what-m<br>
&gt; &gt; akes-ceph-great/<br>
&gt; &gt;<br>
&gt; &gt; Just to reiterate, there will be no changes/limitations to Ceph. =
=A0All<br>
&gt; &gt; Inktank contributions to Ceph will continue to be open source and=
<br>
&gt; &gt; useable. =A0If you have any questions feel free to direct them my=
 way.<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Best Regards,<br>
&gt; &gt;<br>
&gt; &gt; Patrick McGarry<br>
&gt; &gt; Director, Community || Inktank<br>
&gt; &gt; <a href=3D"http://ceph.com" target=3D"_blank">http://ceph.com</a>=
 =A0|| =A0<a href=3D"http://inktank.com" target=3D"_blank">http://inktank.c=
om</a> @scuttlemonkey || @ceph ||<br>
&gt; &gt; @inktank<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe ce=
ph-devel&quot;<br>
&gt; &gt; in the body of a message to <a href=3D"mailto:majordomo-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> More<br>
&gt; majordomo<br>
&gt; &gt; info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.html"=
 target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt;<br>
&gt;<br>
&gt; --<br>
&gt; Lo=EFc Dachary, Artisan Logiciel Libre<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">_______________________=
________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--089e013a110230198404e9f9f0f9--

--===============0660491951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0660491951==--

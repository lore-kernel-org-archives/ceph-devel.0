From: Scottix <scottix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Fri, 08 Sep 2017 15:56:22 +0000
Message-ID: <CANKFHZ_st9ONikkkQ4=-y2mjNfHnZmiZWLP91UJDdkG-WP2KFA@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <f939c8a1-2fca-f66f-51b3-048ae0afce18@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3925463855405062781=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <f939c8a1-2fca-f66f-51b3-048ae0afce18-5fLPn3lgkryFxr2TtlUqVg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============3925463855405062781==
Content-Type: multipart/alternative; boundary="94eb2c0610620c7ce10558af9f1b"

--94eb2c0610620c7ce10558af9f1b
Content-Type: text/plain; charset="UTF-8"

Personally I kind of like the current format and fundamentally we are
talking about Data storage which should be the most tested and scrutinized
piece of software on your computer. Having XYZ feature later than sooner
compared to oh I lost all my data. I am thinking of a recent FS that had a
feature they shouldn't have released. I appreciate the extra time it takes
to release to make it resilient.

Having a LTS version to rely on provides a good assurance the upgrade
process wil be thoroughly tested.
Having a version to do more experimental features keeps the new features at
bay, it follows the Ubuntu model basically.

I feel there were a lot of underpinning features in Luminous that
checkmarked a lot of checkboxes you have been wanting for a while. One
thing to consider possibly a lot of the core features become more
incremental.

I guess from my use case Ceph actually does everything I need it to do atm.
Yes new features and better processes make it better, but more or less I am
pretty content. Maybe I am a small minority in this logic.

On Fri, Sep 8, 2017 at 2:20 AM Matthew Vernon <mv3-5fLPn3lgkryFxr2TtlUqVg@public.gmane.org> wrote:

> Hi,
>
> On 06/09/17 16:23, Sage Weil wrote:
>
> > Traditionally, we have done a major named "stable" release twice a year,
> > and every other such release has been an "LTS" release, with fixes
> > backported for 1-2 years.
>
> We use the ceph version that comes with our distribution (Ubuntu LTS);
> those come out every 2 years (though we won't move to a brand-new
> distribution until we've done some testing!). So from my POV, LTS ceph
> releases that come out such that adjacent ceph LTSs fit neatly into
> adjacent Ubuntu LTSs is the ideal outcome. We're unlikely to ever try
> putting a non-LTS ceph version into production.
>
> I hope this isn't an unusual requirement :)
>
> Matthew
>
>
> --
>  The Wellcome Trust Sanger Institute is operated by Genome Research
>  Limited, a charity registered in England with number 1021457 and a
>  company registered in England with number 2742969, whose registered
>  office is 215 Euston Road, London, NW1 2BE.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c0610620c7ce10558af9f1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Personally I kind of like the current format and fundament=
ally we are talking about Data storage which should be the most tested and =
scrutinized piece of software on your computer. Having XYZ feature later th=
an sooner compared to oh I lost all my data. I am thinking of a recent FS t=
hat had a feature they shouldn&#39;t have released. I appreciate the extra =
time it takes to release to make it resilient.<div><br></div><div><span sty=
le=3D"line-height:1.5">Having a LTS version to rely on provides a good assu=
rance the upgrade process wil be thoroughly tested.=C2=A0</span><br></div><=
div><span style=3D"line-height:1.5">Having a version to do more experimenta=
l features keeps the new features at bay, it follows the Ubuntu model basic=
ally.</span></div><div><span style=3D"line-height:1.5"><br></span></div><di=
v><span style=3D"line-height:1.5">I feel there were a lot of underpinning f=
eatures in Luminous that checkmarked a lot of checkboxes you have been want=
ing for a while. One thing to consider possibly a lot of the core features =
become more incremental.</span></div><div><span style=3D"line-height:1.5"><=
br></span></div><div><span style=3D"line-height:1.5">I guess from my use ca=
se Ceph actually does everything I need it to do atm. Yes new features and =
better processes make it better, but more or less I am pretty content. Mayb=
e I am a small minority in this logic.</span></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr">On Fri, Sep 8, 2017 at 2:20 AM Matthew Vernon &lt;<=
a href=3D"mailto:mv3-5fLPn3lgkryFxr2TtlUqVg@public.gmane.org">mv3-5fLPn3lgkryFxr2TtlUqVg@public.gmane.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 06/09/17 16:23, Sage Weil wrote:<br>
<br>
&gt; Traditionally, we have done a major named &quot;stable&quot; release t=
wice a year,<br>
&gt; and every other such release has been an &quot;LTS&quot; release, with=
 fixes<br>
&gt; backported for 1-2 years.<br>
<br>
We use the ceph version that comes with our distribution (Ubuntu LTS);<br>
those come out every 2 years (though we won&#39;t move to a brand-new<br>
distribution until we&#39;ve done some testing!). So from my POV, LTS ceph<=
br>
releases that come out such that adjacent ceph LTSs fit neatly into<br>
adjacent Ubuntu LTSs is the ideal outcome. We&#39;re unlikely to ever try<b=
r>
putting a non-LTS ceph version into production.<br>
<br>
I hope this isn&#39;t an unusual requirement :)<br>
<br>
Matthew<br>
<br>
<br>
--<br>
=C2=A0The Wellcome Trust Sanger Institute is operated by Genome Research<br=
>
=C2=A0Limited, a charity registered in England with number 1021457 and a<br=
>
=C2=A0company registered in England with number 2742969, whose registered<b=
r>
=C2=A0office is 215 Euston Road, London, NW1 2BE.<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div>

--94eb2c0610620c7ce10558af9f1b--

--===============3925463855405062781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3925463855405062781==--

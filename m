From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 24 Sep 2019 17:35:18 -0400
Message-ID: <CAN-GepKyROe6CRmKFjFyMvH8b5AGPomh96Q6gRVzQS-Zv-iDtQ@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
 <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ@mail.gmail.com> <CALqRxCygXUzA0+4sY6meMO9Smq2rouei7ay0BqJD9+-du7RCYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6979016456704826185=="
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CALqRxCygXUzA0+4sY6meMO9Smq2rouei7ay0BqJD9+-du7RCYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6979016456704826185==
Content-Type: multipart/alternative; boundary="000000000000c1a45905935350f3"

--000000000000c1a45905935350f3
Content-Type: text/plain; charset="UTF-8"

IRT a testing/cutting edge repo, the non-LTS versions of Ceph have been
removed because very few people ever used them and tested them. The
majority of people that would be using the testing repo would be people
needing a bug fix ASAP. Very few people would actually use this regularly
and its effectiveness would be almost zero in preventing problems slipping
through.

At work I haven't had a problem with which version of Ceph is being
installed because we always have local mirrors of the repo that we only
update with the upstream repos when we're ready to test a new version in
our QA environments long before we promote the version for production use.
That said, I've been bit by this multiple times in my home environment
where I've accidentally updated a server or reinstalled a server and needed
to upgrade my Ceph cluster before I could finish because it installed a
newer version of Ceph. I have had to download the entire copy of a version
from online, put it into a folder on disk, and set up a repo feeding from
that local folder to install a specific version. This would be very handy
to just use the ability in apt or yum to just specify a different version
of a package in the repo.

Problem releases have become more problematic than needed because the
packages were left the default packages after a bug was known because there
was no way to remove them from the repo. People continue to see the upgrade
and grabbing it not realizing it's a busted release. I've only seen that
happen on the ML here, but I personally will not touch a new release for at
least 2 weeks after it's been released even in my testing clusters.

On Tue, Sep 24, 2019 at 4:06 PM Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, Sep 17, 2019 at 8:03 AM Sasha Litvak
> <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > * I am bothered with a quality of the releases of a very complex system
> that
> > can bring down a whole house and keep it down for a while.  While I wish
> the
> > QA would be perfect, I wonder if it would be practical to release new
> > packages to a testing repo before moving it to a main one.  There is a
> > chance then someone will detect a problem before it becomes a production
> > issue.  Let it seat for a couple days or weeks in testing.  People who
> need
> > new update right away or just want to test will install it and report the
> > problems.  Others will not be affected.
>
> I think it would be a good step forward to have a separate "testing"
> repository. This repository would be a little more cutting-edge, and we'd
> copy
> all the binaries over to the "main" repository location after 48 hours or
> something.
>
> This would let us all publicly test the candidate GPG-signed packages, for
> example.
>
> - Ken
> _______________________________________________
> ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
> To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
>

--000000000000c1a45905935350f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">IRT a testing/cutting edge repo, the non-LTS versions of C=
eph have been removed because very few people ever used them and tested the=
m. The majority of people that would be using the testing repo would be peo=
ple needing a bug fix ASAP. Very few people would actually use this regular=
ly and its effectiveness would be almost zero in preventing problems slippi=
ng through.<div><br></div><div>At work I haven&#39;t had a problem with whi=
ch version of Ceph is being installed because we always have local mirrors =
of the repo that we only update with the upstream repos when we&#39;re read=
y to test a new version in our QA environments long before we promote the v=
ersion for production use. That said, I&#39;ve been bit by this multiple ti=
mes in my home environment where I&#39;ve accidentally updated a server or =
reinstalled a server and needed to upgrade my Ceph cluster before I could f=
inish because it installed a newer version of Ceph. I have had to download =
the entire copy of a version from online, put it into a folder on disk, and=
 set up a repo feeding from that local folder to install a specific version=
. This would be very handy to just use the ability in apt or yum to just sp=
ecify a different version of a package in the repo.</div><div><br></div><di=
v>Problem releases have become more problematic than needed because the pac=
kages were left the default packages after a bug was known because there wa=
s no way to remove them from the repo. People continue to see the upgrade a=
nd grabbing it not realizing it&#39;s a busted release. I&#39;ve only seen =
that happen on the ML here, but I personally will not touch a new release f=
or at least 2 weeks after it&#39;s been released even in my testing cluster=
s.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, Sep 24, 2019 at 4:06 PM Ken Dreyer &lt;<a href=3D"mailto:kd=
reyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, Sep 17, 2019 at 8:03 AM Sasha L=
itvak<br>
&lt;<a href=3D"mailto:alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexa=
nder.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; * I am bothered with a quality of the releases of a very complex syste=
m that<br>
&gt; can bring down a whole house and keep it down for a while.=C2=A0 While=
 I wish the<br>
&gt; QA would be perfect, I wonder if it would be practical to release new<=
br>
&gt; packages to a testing repo before moving it to a main one.=C2=A0 There=
 is a<br>
&gt; chance then someone will detect a problem before it becomes a producti=
on<br>
&gt; issue.=C2=A0 Let it seat for a couple days or weeks in testing.=C2=A0 =
People who need<br>
&gt; new update right away or just want to test will install it and report =
the<br>
&gt; problems.=C2=A0 Others will not be affected.<br>
<br>
I think it would be a good step forward to have a separate &quot;testing&qu=
ot;<br>
repository. This repository would be a little more cutting-edge, and we&#39=
;d copy<br>
all the binaries over to the &quot;main&quot; repository location after 48 =
hours or<br>
something.<br>
<br>
This would let us all publicly test the candidate GPG-signed packages, for<=
br>
example.<br>
<br>
- Ken<br>
_______________________________________________<br>
ceph-users mailing list -- <a href=3D"mailto:ceph-users-a8pt6IJUokc@public.gmane.org" target=3D"=
_blank">ceph-users-a8pt6IJUokc@public.gmane.org</a><br>
To unsubscribe send an email to <a href=3D"mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org"=
 target=3D"_blank">ceph-users-leave-a8pt6IJUokc@public.gmane.org</a><br>
</blockquote></div>

--000000000000c1a45905935350f3--

--===============6979016456704826185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org

--===============6979016456704826185==--

From: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Wed, 25 Sep 2019 07:40:49 +0200
Message-ID: <CAA6-MF_OwcHjDTM=48_pbPbp8BPf0Dd+iLTWZ+06E8akKoMxGA@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
 <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ@mail.gmail.com>
 <CALqRxCygXUzA0+4sY6meMO9Smq2rouei7ay0BqJD9+-du7RCYQ@mail.gmail.com> <CAN-GepKyROe6CRmKFjFyMvH8b5AGPomh96Q6gRVzQS-Zv-iDtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8756936160427714237=="
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CAN-GepKyROe6CRmKFjFyMvH8b5AGPomh96Q6gRVzQS-Zv-iDtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============8756936160427714237==
Content-Type: multipart/alternative; boundary="000000000000190bd405935a19ff"

--000000000000190bd405935a19ff
Content-Type: text/plain; charset="UTF-8"

Den tis 24 sep. 2019 kl 23:35 skrev David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

>
> At work I haven't had a problem with which version of Ceph is being
> installed because we always have local mirrors of the repo that we only
> update with the upstream repos when we're ready to test a new version in
> our QA environments long before we promote the version for production use.
>
> Problem releases have become more problematic than needed because the
> packages were left the default packages after a bug was known because there
> was no way to remove them from the repo. People continue to see the upgrade
> and grabbing it not realizing it's a busted release. I've only seen that
> happen on the ML here, but I personally will not touch a new release for at
> least 2 weeks after it's been released even in my testing clusters.
>

So this solution (having a mirror of your own) then becomes "when should I
run mirror sync" instead of "when should I make an install that pulls
whatever is deemed current in the repo" which might help you but still
would be prone to falling into the same trap, "bad" pgks gets listed as the
latest and hence get installed, regardless of if bad means "has bugs" or
just "installed before announcement is out or before announcement+2 weeks".
The window gets smaller but not zero. 8-/

-- 
May the most significant bit of your life be positive.

--000000000000190bd405935a19ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Den tis 24 sep. 2019 kl 23:35 skrev David=
 Turner &lt;<a href=3D"mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt;:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div><br></div><div>At work I haven&#3=
9;t had a problem with which version of Ceph is being installed because we =
always have local mirrors of the repo that we only update with the upstream=
 repos when we&#39;re ready to test a new version in our QA environments lo=
ng before we promote the version for production use.</div><div><br></div><d=
iv>Problem releases have become more problematic than needed because the pa=
ckages were left the default packages after a bug was known because there w=
as no way to remove them from the repo. People continue to see the upgrade =
and grabbing it not realizing it&#39;s a busted release. I&#39;ve only seen=
 that happen on the ML here, but I personally will not touch a new release =
for at least 2 weeks after it&#39;s been released even in my testing cluste=
rs.</div></div></blockquote></div><div><br></div>So this solution (having a=
 mirror of your own) then becomes &quot;when should I run mirror sync&quot;=
 instead of &quot;when should I make an install that pulls whatever is deem=
ed current in the repo&quot; which might help you but still would be prone =
to falling into the same trap, &quot;bad&quot; pgks gets listed as the late=
st and hence get installed, regardless of if bad means &quot;has bugs&quot;=
 or just &quot;installed before announcement is out or before announcement+=
2 weeks&quot;. The window gets smaller but not zero. 8-/<br clear=3D"all"><=
div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">May the mos=
t significant bit of your life be positive.<br></div></div>

--000000000000190bd405935a19ff--

--===============8756936160427714237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org

--===============8756936160427714237==--

From: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Wed, 25 Sep 2019 14:55:18 -0500
Message-ID: <CALi_L4-QGFaKhRSNUMcC+CfNnh8rBR_A8PBkVqDydSEX5ho7Ag@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
 <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ@mail.gmail.com>
 <CALqRxCygXUzA0+4sY6meMO9Smq2rouei7ay0BqJD9+-du7RCYQ@mail.gmail.com>
 <CAN-GepKyROe6CRmKFjFyMvH8b5AGPomh96Q6gRVzQS-Zv-iDtQ@mail.gmail.com> <CAA6-MF_OwcHjDTM=48_pbPbp8BPf0Dd+iLTWZ+06E8akKoMxGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3159748477051378923=="
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CAA6-MF_OwcHjDTM=48_pbPbp8BPf0Dd+iLTWZ+06E8akKoMxGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Unknown <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3159748477051378923==
Content-Type: multipart/alternative; boundary="00000000000071cce30593660a0f"

--00000000000071cce30593660a0f
Content-Type: text/plain; charset="UTF-8"

I guess for me the more crucial  questions should be answered:

1.  How can a busted release be taken out of repos (some metadata update I
hope)?
2.  Can some fix(es) be added into a test release so they can be accessed
by community and tested  / used before next general release is avaialble.
I was thinking about trying to pick some critical backports for internal
build / testing but it is not very simple for everyone.  It seems that
shaman has some test builds going on, so may be if a track issue will
mention that build xxxyz contains fixes for ticket 9999 "for testing
purposes only use at your peril", it will allow the community to test the
build and for someone who in need to get to the higher ground quickly.



On Wed, Sep 25, 2019 at 12:41 AM Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Den tis 24 sep. 2019 kl 23:35 skrev David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
>>
>> At work I haven't had a problem with which version of Ceph is being
>> installed because we always have local mirrors of the repo that we only
>> update with the upstream repos when we're ready to test a new version in
>> our QA environments long before we promote the version for production use.
>>
>> Problem releases have become more problematic than needed because the
>> packages were left the default packages after a bug was known because there
>> was no way to remove them from the repo. People continue to see the upgrade
>> and grabbing it not realizing it's a busted release. I've only seen that
>> happen on the ML here, but I personally will not touch a new release for at
>> least 2 weeks after it's been released even in my testing clusters.
>>
>
> So this solution (having a mirror of your own) then becomes "when should I
> run mirror sync" instead of "when should I make an install that pulls
> whatever is deemed current in the repo" which might help you but still
> would be prone to falling into the same trap, "bad" pgks gets listed as the
> latest and hence get installed, regardless of if bad means "has bugs" or
> just "installed before announcement is out or before announcement+2 weeks".
> The window gets smaller but not zero. 8-/
>
> --
> May the most significant bit of your life be positive.
> _______________________________________________
> ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
> To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
>

--00000000000071cce30593660a0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I guess for me the more crucial=C2=A0 questions should be =
answered:<div><br></div><div>1.=C2=A0 How can a busted release be taken out=
 of repos (some metadata update I hope)?</div><div>2.=C2=A0 Can some fix(es=
) be added into a test release so they can be accessed by community and tes=
ted=C2=A0 / used before next general release is avaialble.=C2=A0 I was thin=
king about trying to pick some critical backports for internal build / test=
ing but it is not very simple for everyone.=C2=A0 It seems that shaman has =
some test builds going on, so may be if a track issue will mention that bui=
ld xxxyz contains fixes for ticket 9999 &quot;for testing purposes only use=
 at your peril&quot;, it will allow the community to test the build and for=
 someone who in need to get to the higher ground quickly.</div><div><br></d=
iv><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Wed, Sep 25, 2019 at 12:41 AM Janne Johansson &lt;<a h=
ref=3D"mailto:icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr">Den tis 24 sep. 2019 kl 23:35 skrev David Turner &lt;<a href=
=3D"mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a>&gt;:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div><br></div><div>At work I haven&#39=
;t had a problem with which version of Ceph is being installed because we a=
lways have local mirrors of the repo that we only update with the upstream =
repos when we&#39;re ready to test a new version in our QA environments lon=
g before we promote the version for production use.</div><div><br></div><di=
v>Problem releases have become more problematic than needed because the pac=
kages were left the default packages after a bug was known because there wa=
s no way to remove them from the repo. People continue to see the upgrade a=
nd grabbing it not realizing it&#39;s a busted release. I&#39;ve only seen =
that happen on the ML here, but I personally will not touch a new release f=
or at least 2 weeks after it&#39;s been released even in my testing cluster=
s.</div></div></blockquote></div><div><br></div>So this solution (having a =
mirror of your own) then becomes &quot;when should I run mirror sync&quot; =
instead of &quot;when should I make an install that pulls whatever is deeme=
d current in the repo&quot; which might help you but still would be prone t=
o falling into the same trap, &quot;bad&quot; pgks gets listed as the lates=
t and hence get installed, regardless of if bad means &quot;has bugs&quot; =
or just &quot;installed before announcement is out or before announcement+2=
 weeks&quot;. The window gets smaller but not zero. 8-/<br clear=3D"all"><d=
iv><br></div>-- <br><div dir=3D"ltr">May the most significant bit of your l=
ife be positive.<br></div></div>
_______________________________________________<br>
ceph-users mailing list -- <a href=3D"mailto:ceph-users-a8pt6IJUokc@public.gmane.org" target=3D"=
_blank">ceph-users-a8pt6IJUokc@public.gmane.org</a><br>
To unsubscribe send an email to <a href=3D"mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org"=
 target=3D"_blank">ceph-users-leave-a8pt6IJUokc@public.gmane.org</a><br>
</blockquote></div>

--00000000000071cce30593660a0f--

--===============3159748477051378923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org

--===============3159748477051378923==--

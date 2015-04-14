From: shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 14 Apr 2015 07:53:54 -0500
Message-ID: <CAPntomCr-gMsHCz=86f88ei7b8hCpFUqZ02pTVSZwz+t9tjnGA@mail.gmail.com>
References: <alpine.DEB.2.00.1503031512270.25972@cobra.newdream.net>
	<54F64382.7060308@redhat.com> <54F762C3.2030608@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684256704=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54F762C3.2030608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1684256704==
Content-Type: multipart/alternative; boundary=001a1140a4fa1b7a460513aeb91c

--001a1140a4fa1b7a460513aeb91c
Content-Type: text/plain; charset=UTF-8

Hi Josh,

We are using firefly 0.80.9 and see both cinder create/delete numbers slow
down compared 0.80.7.
I don't see any specific tuning requirements and our cluster is run pretty
much on default configuration.
Do you recommend any tuning or can you please suggest some log signatures
we need to be looking at?

Thanks
shiva

On Wed, Mar 4, 2015 at 1:53 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On 03/03/2015 03:28 PM, Ken Dreyer wrote:
>
>> On 03/03/2015 04:19 PM, Sage Weil wrote:
>>
>>> Hi,
>>>
>>> This is just a heads up that we've identified a performance regression in
>>> v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way
>>> through QA and should be out in a few days.  If you haven't upgraded yet
>>> you may want to wait.
>>>
>>> Thanks!
>>> sage
>>>
>>
>> Hi Sage,
>>
>> I've seen a couple Redmine tickets on this (eg
>> http://tracker.ceph.com/issues/9854 ,
>> http://tracker.ceph.com/issues/10956). It's not totally clear to me
>> which of the 70+ unreleased commits on the firefly branch fix this
>> librbd issue.  Is it only the three commits in
>> https://github.com/ceph/ceph/pull/3410 , or are there more?
>>
>
> Those are the only ones needed to fix the librbd performance
> regression, yes.
>
> Josh
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a1140a4fa1b7a460513aeb91c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Josh,<div><br></div><div>We are using firefly 0.80.9 an=
d see both cinder create/delete numbers slow down compared 0.80.7.</div><di=
v>I don&#39;t see any specific tuning requirements and our cluster is run p=
retty much on default configuration.</div><div>Do you recommend any tuning =
or can you please suggest some log signatures we need to be looking at?</di=
v><div><br></div><div>Thanks</div><div>shiva</div></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Wed, Mar 4, 2015 at 1:53 PM, Josh=
 Durgin <span dir=3D"ltr">&lt;<a href=3D"mailto:jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=
=3D"_blank">jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On 03/03/2015 03:28 PM, Ken Dreyer wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 03/03/2015 04:19 PM, Sage Weil wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
This is just a heads up that we&#39;ve identified a performance regression =
in<br>
v0.80.8 from previous firefly releases.=C2=A0 A v0.80.9 is working it&#39;s=
 way<br>
through QA and should be out in a few days.=C2=A0 If you haven&#39;t upgrad=
ed yet<br>
you may want to wait.<br>
<br>
Thanks!<br>
sage<br>
</blockquote>
<br>
Hi Sage,<br>
<br>
I&#39;ve seen a couple Redmine tickets on this (eg<br>
<a href=3D"http://tracker.ceph.com/issues/9854" target=3D"_blank">http://tr=
acker.ceph.com/<u></u>issues/9854</a> ,<br>
<a href=3D"http://tracker.ceph.com/issues/10956" target=3D"_blank">http://t=
racker.ceph.com/<u></u>issues/10956</a>). It&#39;s not totally clear to me<=
br>
which of the 70+ unreleased commits on the firefly branch fix this<br>
librbd issue.=C2=A0 Is it only the three commits in<br>
<a href=3D"https://github.com/ceph/ceph/pull/3410" target=3D"_blank">https:=
//github.com/ceph/ceph/<u></u>pull/3410</a> , or are there more?<br>
</blockquote>
<br></span>
Those are the only ones needed to fix the librbd performance<br>
regression, yes.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Josh</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.htm=
l</a><br>
</div></div></blockquote></div><br></div>

--001a1140a4fa1b7a460513aeb91c--

--===============1684256704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1684256704==--

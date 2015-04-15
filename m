From: shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 14 Apr 2015 22:01:18 -0500
Message-ID: <CAPntomB=AiCtx2ypTi+fUFUCUDtkyURb=d-RgwX3ft2mrAibEA@mail.gmail.com>
References: <bb7a4f02-e495-4d69-961f-b0f970b407d1@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1586584730=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <bb7a4f02-e495-4d69-961f-b0f970b407d1-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

--===============1586584730==
Content-Type: multipart/alternative; boundary=20cf303dd3eaa34dca0513ba8f37

--20cf303dd3eaa34dca0513ba8f37
Content-Type: text/plain; charset=UTF-8

The clusters are in test environment, so its a new deployment of 0.80.9. OS
on the cluster nodes is reinstalled as well, so there shouldn't be any fs
aging unless the disks are slowing down.

The perf measurement is done initiating multiple cinder create/delete
commands and tracking the volume to be in available or completely gone from
"cinder list" output.

Even running  "rbd rm " command from cinder node results in similar
behaviour.

I'll try with  increasing  rbd_concurrent_management in ceph.conf.
 Is the param name rbd_concurrent_management or rbd-concurrent-management ?


On Tue, Apr 14, 2015 at 12:36 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> I don't see any commits that would be likely to affect that between 0.80.7
> and 0.80.9.
>
> Is this after upgrading an existing cluster?
> Could this be due to fs aging beneath your osds?
>
> How are you measuring create/delete performance?
>
> You can try increasing rbd concurrent management ops in ceph.conf on the
> cinder node. This affects delete speed, since rbd tries to delete each
> object in a volume.
>
> Josh
>
> *From:* shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Apr 14, 2015 5:53 AM
> *To:* Josh Durgin
> *Cc:* Ken Dreyer; Sage Weil; Ceph Development; ceph-users-Qp0mS5GaXlQ@public.gmane.org
> *Subject:* Re: v0.80.8 and librbd performance
>
> Hi Josh,
>
> We are using firefly 0.80.9 and see both cinder create/delete numbers slow
> down compared 0.80.7.
> I don't see any specific tuning requirements and our cluster is run pretty
> much on default configuration.
> Do you recommend any tuning or can you please suggest some log signatures
> we need to be looking at?
>
> Thanks
> shiva
>
> On Wed, Mar 4, 2015 at 1:53 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>> On 03/03/2015 03:28 PM, Ken Dreyer wrote:
>>
>>> On 03/03/2015 04:19 PM, Sage Weil wrote:
>>>
>>>> Hi,
>>>>
>>>> This is just a heads up that we've identified a performance regression
>>>> in
>>>> v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way
>>>> through QA and should be out in a few days.  If you haven't upgraded yet
>>>> you may want to wait.
>>>>
>>>> Thanks!
>>>> sage
>>>>
>>>
>>> Hi Sage,
>>>
>>> I've seen a couple Redmine tickets on this (eg
>>> http://tracker.ceph.com/issues/9854 ,
>>> http://tracker.ceph.com/issues/10956). It's not totally clear to me
>>> which of the 70+ unreleased commits on the firefly branch fix this
>>> librbd issue.  Is it only the three commits in
>>> https://github.com/ceph/ceph/pull/3410 , or are there more?
>>>
>>
>> Those are the only ones needed to fix the librbd performance
>> regression, yes.
>>
>> Josh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>

--20cf303dd3eaa34dca0513ba8f37
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>The clusters are in test environm=
ent, so its a new deployment of 0.80.9. OS on the cluster nodes is reinstal=
led as well, so there shouldn&#39;t be any fs aging unless the disks are sl=
owing down.<br><br></div>The perf measurement is done initiating multiple c=
inder create/delete commands and tracking the volume to be in available or =
completely gone from &quot;cinder list&quot; output.<br></div><br></div>Eve=
n running=C2=A0 &quot;rbd rm &quot; command from cinder node results in sim=
ilar behaviour.<br><br></div><div>I&#39;ll try with=C2=A0 increasing=C2=A0 =
rbd_concurrent_management in ceph.conf.<br>=C2=A0Is the param name rbd_conc=
urrent_management or rbd-concurrent-management ?<br></div></div><div><div><=
br><div><div><div><div><div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Tue, Apr 14, 2015 at 12:36 PM, Josh Durgin <span dir=3D"ltr">=
&lt;<a href=3D"mailto:jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">jdurgin@redhat.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:=
12pt;color:rgb(0,0,0)"><p dir=3D"ltr">I don&#39;t see any commits that woul=
d be likely to affect that between 0.80.7 and 0.80.9.</p>
<p dir=3D"ltr">Is this after upgrading an existing cluster?<br>
Could this be due to fs aging beneath your osds?</p>
<p dir=3D"ltr">How are you measuring create/delete performance?</p>
<p dir=3D"ltr">You can try increasing rbd concurrent management ops in ceph=
.conf on the cinder node. This affects delete speed, since rbd tries to del=
ete each object in a volume.</p>
<p dir=3D"ltr">Josh</p>
</div><div style=3D"clear:both"><br><div style=3D"border-width:1pt medium m=
edium;border-style:solid none none;border-color:rgb(225,225,225) -moz-use-t=
ext-color -moz-use-text-color;padding:3pt 0cm 0cm"><span style=3D"font-size=
:11pt;font-family:Calibri,Arial,Helvetica,sans-serif"><b>From:</b> shiva rk=
reddy &lt;<a href=3D"mailto:shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">shiv=
a.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br><b>Sent:</b> Apr 14, 2015 5:53 AM<br><b>To:<=
/b> Josh Durgin<br><b>Cc:</b> Ken Dreyer; Sage Weil; Ceph Development; <a h=
ref=3D"mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org" target=3D"_blank">ceph-users-Qp0mS5GaXlQ@public.gmane.org</a=
><span class=3D""><br><b>Subject:</b> Re: v0.80.8 and librbd performance<br=
></span></span></div></div><div class=3D""><div class=3D"h5"><br type=3D"at=
tribution"><div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Josh,<div><=
br></div><div>We are using firefly 0.80.9 and see both cinder create/delete=
 numbers slow down compared 0.80.7.</div><div>I don&#39;t see any specific =
tuning requirements and our cluster is run pretty much on default configura=
tion.</div><div>Do you recommend any tuning or can you please suggest some =
log signatures we need to be looking at?</div><div><br></div><div>Thanks</d=
iv><div>shiva</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Wed, Mar 4, 2015 at 1:53 PM, Josh Durgin <span dir=3D"ltr">&lt;<=
a href=3D"mailto:jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
span>On 03/03/2015 03:28 PM, Ken Dreyer wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 03/03/2015 04:19 PM, Sage Weil wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
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
regression, yes.<span><font color=3D"#888888"><br>
<br>
Josh</font></span><div><div><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.htm=
l</a><br>
</div></div></blockquote></div><br></div>
</blockquote></div></div></div></blockquote></div><br></div></div></div></d=
iv></div></div></div></div></div>

--20cf303dd3eaa34dca0513ba8f37--

--===============1586584730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1586584730==--

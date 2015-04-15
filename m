From: shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 14 Apr 2015 23:27:24 -0500
Message-ID: <CAPntomDT90q48xsk=FSr-Va-aSJdZk5j9iALoZeCvOVb1djTKA@mail.gmail.com>
References: <bb7a4f02-e495-4d69-961f-b0f970b407d1@redhat.com>
	<CAPntomB=AiCtx2ypTi+fUFUCUDtkyURb=d-RgwX3ft2mrAibEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1151855416=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPntomB=AiCtx2ypTi+fUFUCUDtkyURb=d-RgwX3ft2mrAibEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1151855416==
Content-Type: multipart/alternative; boundary=001a113f3d1c908bcd0513bbc3fc

--001a113f3d1c908bcd0513bbc3fc
Content-Type: text/plain; charset=UTF-8

Retried the test with by setting: rbd_concurrent_management_ops and
rbd-concurrent-management-ops to 20 (default 10?) and didn't see any
difference in the delete time.

Steps:
1. Create 20, 500GB volumes
2. run : rbd -n clientkey -p cindervols rbd rm $volumeId &
3. run rbd ls command in with 1 second sleep and capture output  : rbd -n
clientkey -p cindervols rbd ls

It took the same amount of time to remove all entries in the pool when the
ops setting was default.

Thanks

On Tue, Apr 14, 2015 at 10:01 PM, shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> The clusters are in test environment, so its a new deployment of 0.80.9.
> OS on the cluster nodes is reinstalled as well, so there shouldn't be any
> fs aging unless the disks are slowing down.
>
> The perf measurement is done initiating multiple cinder create/delete
> commands and tracking the volume to be in available or completely gone from
> "cinder list" output.
> Even running  "rbd rm " command from cinder node results in similar
> behaviour.
>
> I'll try with  increasing  rbd_concurrent_management in ceph.conf.
>  Is the param name rbd_concurrent_management or rbd-concurrent-management ?
>
>
> On Tue, Apr 14, 2015 at 12:36 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>> I don't see any commits that would be likely to affect that between
>> 0.80.7 and 0.80.9.
>>
>> Is this after upgrading an existing cluster?
>> Could this be due to fs aging beneath your osds?
>>
>> How are you measuring create/delete performance?
>>
>> You can try increasing rbd concurrent management ops in ceph.conf on the
>> cinder node. This affects delete speed, since rbd tries to delete each
>> object in a volume.
>>
>> Josh
>>
>> *From:* shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> *Sent:* Apr 14, 2015 5:53 AM
>> *To:* Josh Durgin
>> *Cc:* Ken Dreyer; Sage Weil; Ceph Development; ceph-users-Qp0mS5GaXlQ@public.gmane.org
>> *Subject:* Re: v0.80.8 and librbd performance
>>
>> Hi Josh,
>>
>> We are using firefly 0.80.9 and see both cinder create/delete numbers
>> slow down compared 0.80.7.
>> I don't see any specific tuning requirements and our cluster is run
>> pretty much on default configuration.
>> Do you recommend any tuning or can you please suggest some log signatures
>> we need to be looking at?
>>
>> Thanks
>> shiva
>>
>> On Wed, Mar 4, 2015 at 1:53 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>>> On 03/03/2015 03:28 PM, Ken Dreyer wrote:
>>>
>>>> On 03/03/2015 04:19 PM, Sage Weil wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> This is just a heads up that we've identified a performance regression
>>>>> in
>>>>> v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way
>>>>> through QA and should be out in a few days.  If you haven't upgraded
>>>>> yet
>>>>> you may want to wait.
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>>
>>>> Hi Sage,
>>>>
>>>> I've seen a couple Redmine tickets on this (eg
>>>> http://tracker.ceph.com/issues/9854 ,
>>>> http://tracker.ceph.com/issues/10956). It's not totally clear to me
>>>> which of the 70+ unreleased commits on the firefly branch fix this
>>>> librbd issue.  Is it only the three commits in
>>>> https://github.com/ceph/ceph/pull/3410 , or are there more?
>>>>
>>>
>>> Those are the only ones needed to fix the librbd performance
>>> regression, yes.
>>>
>>> Josh
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>

--001a113f3d1c908bcd0513bbc3fc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Retried the test with by setting: rbd_=
concurrent_management_ops and rbd-concurrent-management-ops to 20 (default =
10?) and didn&#39;t see any difference in the delete time.<br><br></div>Ste=
ps:<br></div>1. Create 20, 500GB volumes<br></div>2. run : rbd -n clientkey=
 -p cindervols rbd rm $volumeId &amp;<br></div>3. run rbd ls command in wit=
h 1 second sleep and capture output=C2=A0 : rbd -n clientkey -p cindervols =
rbd ls <br><div><br></div><div>It took the same amount of time to remove al=
l entries in the pool when the ops setting was default.<br><br></div><div>T=
hanks</div><div><div><div><div><div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Tue, Apr 14, 2015 at 10:01 PM, shiva rkreddy <span di=
r=3D"ltr">&lt;<a href=3D"mailto:shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">=
shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div><div><div><div><div>The clust=
ers are in test environment, so its a new deployment of 0.80.9. OS on the c=
luster nodes is reinstalled as well, so there shouldn&#39;t be any fs aging=
 unless the disks are slowing down.<br><br></div>The perf measurement is do=
ne initiating multiple cinder create/delete commands and tracking the volum=
e to be in available or completely gone from &quot;cinder list&quot; output=
.<br></div></div>Even running=C2=A0 &quot;rbd rm &quot; command from cinder=
 node results in similar behaviour.<br><br></div><div>I&#39;ll try with=C2=
=A0 increasing=C2=A0 rbd_concurrent_management in ceph.conf.<br>=C2=A0Is th=
e param name rbd_concurrent_management or rbd-concurrent-management ?<br></=
div></div><div><div class=3D"h5"><div><div><br><div><div><div><div><div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Apr 14, 2015=
 at 12:36 PM, Josh Durgin <span dir=3D"ltr">&lt;<a href=3D"mailto:jdurgin@r=
edhat.com" target=3D"_blank">jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D"font-family:C=
alibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p dir=
=3D"ltr">I don&#39;t see any commits that would be likely to affect that be=
tween 0.80.7 and 0.80.9.</p>
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
><span><br><b>Subject:</b> Re: v0.80.8 and librbd performance<br></span></s=
pan></div></div><div><div><br type=3D"attribution"><div><blockquote style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">Hi Josh,<div><br></div><div>We are using firefl=
y 0.80.9 and see both cinder create/delete numbers slow down compared 0.80.=
7.</div><div>I don&#39;t see any specific tuning requirements and our clust=
er is run pretty much on default configuration.</div><div>Do you recommend =
any tuning or can you please suggest some log signatures we need to be look=
ing at?</div><div><br></div><div>Thanks</div><div>shiva</div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Mar 4, 2015 at 1:=
53 PM, Josh Durgin <span dir=3D"ltr">&lt;<a href=3D"mailto:jdurgin@redhat.c=
om" target=3D"_blank">jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><span>On 03/03/2015 03:28 PM, Ken =
Dreyer wrote:<br>
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
iv></div></div></div></div></div></div></div>
</blockquote></div><br></div></div></div></div></div></div></div>

--001a113f3d1c908bcd0513bbc3fc--

--===============1151855416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1151855416==--

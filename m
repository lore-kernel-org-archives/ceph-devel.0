From: Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: stalls caused by scrub on jewel
Date: Thu, 1 Dec 2016 09:25:03 -0800
Message-ID: <CAKPXa=bpf6v8JbrZ_Aq_hSpOSQmPtcRNR5kOONLLM7cJ-j26vw@mail.gmail.com>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
	<67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0508398023=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <67e859f3-1aa6-e4b5-06b5-664583f668f1-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0508398023==
Content-Type: multipart/alternative; boundary=001a113cdbc01bbda805429c1ae4

--001a113cdbc01bbda805429c1ae4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 1, 2016 at 7:24 AM, Fr=C3=A9d=C3=A9ric Nass <
frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org> wrote:

>
> Hi Sage, Sam,
>
> We're impacted by this bug (case 01725311). Our cluster is running RHCS
> 2.0 and is no more capable to scrub neither deep-scrub.
>
> [1] http://tracker.ceph.com/issues/17859
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1394007
> [3] https://github.com/ceph/ceph/pull/11898
>
> I'm worried we'll have to live with a cluster that can't scrub/deep-scrub
> until March 2017 (ETA for RHCS 2.2 running Jewel 10.2.4).
>
> Can we have this fix any sooner ?
>

Since this is merged in master and pending backport to jewel, I dont think
you will have to wait for 2.2 to get that, It should be in a hotfix much
sooner.



>
> Regards
>
> Fr=C3=A9d=C3=A9ric.
>
>
> Le 15/11/2016 =C3=A0 23:35, Sage Weil a =C3=A9crit :
>
>> Hi everyone,
>>
>> There was a regression in jewel that can trigger long OSD stalls during
>> scrub.  How long the stalls are depends on how many objects are in your
>> PGs, how fast your storage device is, and what is cached, but in at leas=
t
>> one case they were long enough that the OSD internal heartbeat check
>> failed and it committed suicide (120 seconds).
>>
>> The workaround for now is to simply
>>
>>   ceph osd set noscrub
>>
>> as the bug is only triggered by scrub.  A fix is being tested and will b=
e
>> available shortly.
>>
>> If you've seen any kind of weird latencies or slow requests on jewel, I
>> suggest setting noscrub and seeing if they go away!
>>
>> The tracker bug is
>>
>>   http://tracker.ceph.com/issues/17859
>>
>> Big thanks to Yoann Moulin for helping track this down!
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113cdbc01bbda805429c1ae4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Dec 1, 2016 at 7:24 AM, Fr=C3=A9d=C3=A9ric Nass <span dir=3D"lt=
r">&lt;<a href=3D"mailto:frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org" target=3D"_blank">=
frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
Hi Sage, Sam,<br>
<br>
We&#39;re impacted by this bug (case 01725311). Our cluster is running RHCS=
 2.0 and is no more capable to scrub neither deep-scrub.<br>
<br>
[1] <a href=3D"http://tracker.ceph.com/issues/17859" rel=3D"noreferrer" tar=
get=3D"_blank">http://tracker.ceph.com/issues<wbr>/17859</a><br>
[2] <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1394007" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/sh<wbr>ow_bug=
.cgi?id=3D1394007</a><br>
[3] <a href=3D"https://github.com/ceph/ceph/pull/11898" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/ceph/ceph/p<wbr>ull/11898</a><br>
<br>
I&#39;m worried we&#39;ll have to live with a cluster that can&#39;t scrub/=
deep-scrub until March 2017 (ETA for RHCS 2.2 running Jewel 10.2.4).<br>
<br>
Can we have this fix any sooner ?<br></blockquote><div><br></div><div>Since=
 this is merged in master and pending backport to jewel, I dont think you w=
ill have to wait for 2.2 to get that, It should be in a hotfix much sooner.=
<br></div><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Regards<br>
<br>
Fr=C3=A9d=C3=A9ric.<div><div class=3D"h5"><br>
<br>
Le 15/11/2016 =C3=A0 23:35, Sage Weil a =C3=A9crit :<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi everyone,<br>
<br>
There was a regression in jewel that can trigger long OSD stalls during<br>
scrub.=C2=A0 How long the stalls are depends on how many objects are in you=
r<br>
PGs, how fast your storage device is, and what is cached, but in at least<b=
r>
one case they were long enough that the OSD internal heartbeat check<br>
failed and it committed suicide (120 seconds).<br>
<br>
The workaround for now is to simply<br>
<br>
=C2=A0 ceph osd set noscrub<br>
<br>
as the bug is only triggered by scrub.=C2=A0 A fix is being tested and will=
 be<br>
available shortly.<br>
<br>
If you&#39;ve seen any kind of weird latencies or slow requests on jewel, I=
<br>
suggest setting noscrub and seeing if they go away!<br>
<br>
The tracker bug is<br>
<br>
=C2=A0 <a href=3D"http://tracker.ceph.com/issues/17859" rel=3D"noreferrer" =
target=3D"_blank">http://tracker.ceph.com/issues<wbr>/17859</a><br>
<br>
Big thanks to Yoann Moulin for helping track this down!<br>
<br>
sage<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
o<wbr>mo-info.html</a><br>
</blockquote>
<br></div></div>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div><br></div></div>

--001a113cdbc01bbda805429c1ae4--

--===============0508398023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0508398023==--

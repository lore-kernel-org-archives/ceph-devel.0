From: "Stillwell, Bryan" <bryan.stillwell-nsCYeiwbiy9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Discuss: New default recovery config settings
Date: Fri, 29 May 2015 18:56:33 -0400
Message-ID: <D18E470A.6229%bryan.stillwell@twcable.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
	<CAOnYue-zF1driSi1oxGCQ8Vh1UcG=viT5P8AeHA3R1NCca1o6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687108916=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOnYue-zF1driSi1oxGCQ8Vh1UcG=viT5P8AeHA3R1NCca1o6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org'
	(ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0687108916==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D18E470A6229bryanstillwelltwcablecom_"

--_000_D18E470A6229bryanstillwelltwcablecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I like the idea of turning the defaults down.  During the ceph operators se=
ssion at the OpenStack conference last week Warren described the behavior p=
retty accurately as "Ceph basically DOSes itself unless you reduce those se=
ttings."  Maybe this is more of a problem when the clusters are small?

Another idea would be to have a better way to prioritize recovery traffic t=
o an even lower priority level by setting the ionice value to 'Idle' in the=
 CFQ scheduler?

Bryan

From: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Date: Friday, May 29, 2015 at 4:16 PM
To: Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org<mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>, ceph-devel <ce=
ph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>>, "'ceph-users@=
lists.ceph.com<mailto:'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>' (ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ce=
ph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>>
Subject: Re: [ceph-users] Discuss: New default recovery config settings


Hi,

We did it the other way around instead, defining a period where the load is=
 lighter and turn off/on backfill/recover. Then you want the backfill value=
s to be the what is default right now.

Also, someone said that (think it was Greg?) If you have problems with back=
fill, your cluster backing store is not fast enough/too much load.
If 10 osds goes down at the same time you want those values to be high to m=
inimize the downtime.

/Josef

fre 29 maj 2015 23:47 Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org<mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org=
>> skrev:
Many people have reported that they need to lower the osd recovery config o=
ptions to minimize the impact of recovery on client io.  We are talking abo=
ut changing the defaults as follows:

osd_max_backfills to 1 (from 10)
osd_recovery_max_active to 3 (from 15)
osd_recovery_op_priority to 1 (from 10)
osd_recovery_max_single_start to 1 (from 5)

We'd like a bit of feedback first though.  Is anyone happy with the current=
 configs?  Is anyone using something between these values and the current d=
efaults?  What kind of workload?  I'd guess that lowering osd_max_backfills=
 to 1 is probably a good idea, but I wonder whether lowering osd_recovery_m=
ax_active and osd_recovery_max_single_start will cause small objects to rec=
over unacceptably slowly.

Thoughts?
-Sam
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

________________________________
This E-mail and any of its attachments may contain Time Warner Cable propri=
etary information, which is privileged, confidential, or subject to copyrig=
ht belonging to Time Warner Cable. This E-mail is intended solely for the u=
se of the individual or entity to which it is addressed. If you are not the=
 intended recipient of this E-mail, you are hereby notified that any dissem=
ination, distribution, copying, or action taken in relation to the contents=
 of and attachments to this E-mail is strictly prohibited and may be unlawf=
ul. If you have received this E-mail in error, please notify the sender imm=
ediately and permanently delete the original and any copy of this E-mail an=
d any printout.

--_000_D18E470A6229bryanstillwelltwcablecom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif;">
<div>I like the idea of turning the defaults down. &nbsp;During the ceph op=
erators session at the OpenStack conference last week Warren described the =
behavior pretty accurately as &quot;Ceph basically DOSes itself unless you =
reduce those settings.&quot; &nbsp;Maybe this is more
 of a problem when the clusters are small?</div>
<div><br>
</div>
<div>Another idea would be to have a better way to prioritize recovery traf=
fic to an even lower priority level by setting the ionice value to 'Idle' i=
n the CFQ scheduler?</div>
<div><br>
</div>
<div>Bryan</div>
<div><br>
</div>
<span id=3D"OLK_SRC_BODY_SECTION">
<div style=3D"font-family:Calibri; font-size:11pt; text-align:left; color:b=
lack; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM:=
 0in; PADDING-LEFT: 0in; PADDING-RIGHT: 0in; BORDER-TOP: #b5c4df 1pt solid;=
 BORDER-RIGHT: medium none; PADDING-TOP: 3pt">
<span style=3D"font-weight:bold">From: </span>Josef Johansson &lt;<a href=
=3D"mailto:josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Date: </span>Friday, May 29, 2015 at 4:16 =
PM<br>
<span style=3D"font-weight:bold">To: </span>Samuel Just &lt;<a href=3D"mail=
to:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;, ceph-devel &lt;<a href=3D"ma=
ilto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;=
<a href=3D"mailto:'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a=
>'
 (<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a=
>)&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists.=
ceph.com</a>&gt;<br>
<span style=3D"font-weight:bold">Subject: </span>Re: [ceph-users] Discuss: =
New default recovery config settings<br>
</div>
<div><br>
</div>
<blockquote id=3D"MAC_OUTLOOK_ATTRIBUTION_BLOCKQUOTE" style=3D"BORDER-LEFT:=
 #b5c4df 5 solid; PADDING:0 0 0 5; MARGIN:0 0 0 5;">
<p dir=3D"ltr"><br>
Hi,</p>
<p dir=3D"ltr">We did it the other way around instead, defining a period wh=
ere the load is lighter and turn off/on backfill/recover. Then you want the=
 backfill values to be the what is default right now.
</p>
<p dir=3D"ltr">Also, someone said that (think it was Greg?) If you have pro=
blems with backfill, your cluster backing store is not fast enough/too much=
 load.<br>
If 10 osds goes down at the same time you want those values to be high to m=
inimize the downtime.</p>
<p dir=3D"ltr">/Josef</p>
<br>
<div class=3D"gmail_quote">fre 29 maj 2015 23:47&nbsp;Samuel Just &lt;<a hr=
ef=3D"mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; skrev:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Many people have reported that they need to lower the osd recovery config o=
ptions to minimize the impact of recovery on client io.&nbsp; We are talkin=
g about changing the defaults as follows:<br>
<br>
osd_max_backfills to 1 (from 10)<br>
osd_recovery_max_active to 3 (from 15)<br>
osd_recovery_op_priority to 1 (from 10)<br>
osd_recovery_max_single_start to 1 (from 5)<br>
<br>
We'd like a bit of feedback first though.&nbsp; Is anyone happy with the cu=
rrent configs?&nbsp; Is anyone using something between these values and the=
 current defaults?&nbsp; What kind of workload?&nbsp; I'd guess that loweri=
ng osd_max_backfills to 1 is probably a good idea, but
 I wonder whether lowering osd_recovery_max_active and osd_recovery_max_sin=
gle_start will cause small objects to recover unacceptably slowly.<br>
<br>
Thoughts?<br>
-Sam<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote>
</div>
</blockquote>
</span><br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This E-mail and any of its a=
ttachments may contain Time Warner Cable proprietary information, which is =
privileged, confidential, or subject to copyright belonging to Time Warner =
Cable. This E-mail is intended solely
 for the use of the individual or entity to which it is addressed. If you a=
re not the intended recipient of this E-mail, you are hereby notified that =
any dissemination, distribution, copying, or action taken in relation to th=
e contents of and attachments to
 this E-mail is strictly prohibited and may be unlawful. If you have receiv=
ed this E-mail in error, please notify the sender immediately and permanent=
ly delete the original and any copy of this E-mail and any printout.<br>
</font>
</body>
</html>

--_000_D18E470A6229bryanstillwelltwcablecom_--

--===============0687108916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0687108916==--

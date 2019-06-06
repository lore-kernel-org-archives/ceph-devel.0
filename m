From: Linh Vu <vul-keaFvQtjc6i7NGdpmJTKYQ@public.gmane.org>
Subject: Re: Changing the release cadence
Date: Thu, 6 Jun 2019 00:31:53 +0000
Message-ID: <ME1PR01MB070645B4EDCB63853433D02A81170@ME1PR01MB0706.ausprd01.prod.outlook.com>
References: <alpine.DEB.2.11.1906051556500.987@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324290320169728562=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1906051556500.987-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
Content-Language: en-AU
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dev-a8pt6IJUokc@public.gmane.org" <dev-a8pt6IJUokc@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0324290320169728562==
Content-Language: en-AU
Content-Type: multipart/alternative;
	boundary="_000_ME1PR01MB070645B4EDCB63853433D02A81170ME1PR01MB0706ausp_"

--_000_ME1PR01MB070645B4EDCB63853433D02A81170ME1PR01MB0706ausp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

I think 12 months cycle is much better from the cluster operations perspect=
ive. I also like March as a release month as well.
________________________________
From: ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> on behalf of Sage Weil=
 <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Sent: Thursday, 6 June 2019 1:57 AM
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dev-a8pt6IJUokc@public.gmane.org
Subject: [ceph-users] Changing the release cadence

Hi everyone,

Since luminous, we have had the follow release cadence and policy:
 - release every 9 months
 - maintain backports for the last two releases
 - enable upgrades to move either 1 or 2 releases heads
   (e.g., luminous -> mimic or nautilus; mimic -> nautilus or octopus; ...)

This has mostly worked out well, except that the mimic release received
less attention that we wanted due to the fact that multiple downstream
Ceph products (from Red Has and SUSE) decided to based their next release
on nautilus.  Even though upstream every release is an "LTS" release, as a
practical matter mimic got less attention than luminous or nautilus.

We've had several requests/proposals to shift to a 12 month cadence. This
has several advantages:

 - Stable/conservative clusters only have to be upgraded every 2 years
   (instead of every 18 months)
 - Yearly releases are more likely to intersect with downstream
   distribution release (e.g., Debian).  In the past there have been
   problems where the Ceph releases included in consecutive releases of a
   distro weren't easily upgradeable.
 - Vendors that make downstream Ceph distributions/products tend to
   release yearly.  Aligning with those vendors means they are more likely
   to productize *every* Ceph release.  This will help make every Ceph
   release an "LTS" release (not just in name but also in terms of
   maintenance attention).

So far the balance of opinion seems to favor a shift to a 12 month
cycle[1], especially among developers, so it seems pretty likely we'll
make that shift.  (If you do have strong concerns about such a move, now
is the time to raise them.)

That brings us to an important decision: what time of year should we
release?  Once we pick the timing, we'll be releasing at that time *every
year* for each release (barring another schedule shift, which we want to
avoid), so let's choose carefully!

A few options:

 - November: If we release Octopus 9 months from the Nautilus release
   (planned for Feb, released in Mar) then we'd target this November.  We
   could shift to a 12 months candence after that.
 - February: That's 12 months from the Nautilus target.
 - March: That's 12 months from when Nautilus was *actually* released.

November is nice in the sense that we'd wrap things up before the
holidays.  It's less good in that users may not be inclined to install the
new release when many developers will be less available in December.

February kind of sucked in that the scramble to get the last few things
done happened during the holidays.  OTOH, we should be doing what we can
to avoid such scrambles, so that might not be something we should factor
in.  March may be a bit more balanced, with a solid 3 months before when
people are productive, and 3 months after before they disappear on holiday
to address any post-release issues.

People tend to be somewhat less available over the summer months due to
holidays etc, so an early or late summer release might also be less than
ideal.

Thoughts?  If we can narrow it down to a few options maybe we could do a
poll to gauge user preferences.

Thanks!
sage


[1] https://twitter.com/larsmb/status/1130010208971952129

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--_000_ME1PR01MB070645B4EDCB63853433D02A81170ME1PR01MB0706ausp_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I think 12 months cycle is much better from the cluster operations perspect=
ive. I also like March as a release month as well.&nbsp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> ceph-users &lt;ceph-u=
sers-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt; on behalf of Sage Weil &lt;sage-BnTBU8nroG6DGRHsOpWV0g@public.gmane.org=
t&gt;<br>
<b>Sent:</b> Thursday, 6 June 2019 1:57 AM<br>
<b>To:</b> ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dev-a8pt6IJUokc@public.gmane.org<br>
<b>Subject:</b> [ceph-users] Changing the release cadence</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi everyone,<br>
<br>
Since luminous, we have had the follow release cadence and policy:&nbsp;&nb=
sp; <br>
&nbsp;- release every 9 months<br>
&nbsp;- maintain backports for the last two releases<br>
&nbsp;- enable upgrades to move either 1 or 2 releases heads<br>
&nbsp;&nbsp; (e.g., luminous -&gt; mimic or nautilus; mimic -&gt; nautilus =
or octopus; ...)<br>
<br>
This has mostly worked out well, except that the mimic release received <br=
>
less attention that we wanted due to the fact that multiple downstream <br>
Ceph products (from Red Has and SUSE) decided to based their next release <=
br>
on nautilus.&nbsp; Even though upstream every release is an &quot;LTS&quot;=
 release, as a <br>
practical matter mimic got less attention than luminous or nautilus.<br>
<br>
We've had several requests/proposals to shift to a 12 month cadence. This <=
br>
has several advantages:<br>
<br>
&nbsp;- Stable/conservative clusters only have to be upgraded every 2 years=
<br>
&nbsp;&nbsp; (instead of every 18 months)<br>
&nbsp;- Yearly releases are more likely to intersect with downstream<br>
&nbsp;&nbsp; distribution release (e.g., Debian).&nbsp; In the past there h=
ave been <br>
&nbsp;&nbsp; problems where the Ceph releases included in consecutive relea=
ses of a <br>
&nbsp;&nbsp; distro weren't easily upgradeable.<br>
&nbsp;- Vendors that make downstream Ceph distributions/products tend to<br=
>
&nbsp;&nbsp; release yearly.&nbsp; Aligning with those vendors means they a=
re more likely <br>
&nbsp;&nbsp; to productize *every* Ceph release.&nbsp; This will help make =
every Ceph <br>
&nbsp;&nbsp; release an &quot;LTS&quot; release (not just in name but also =
in terms of <br>
&nbsp;&nbsp; maintenance attention).<br>
<br>
So far the balance of opinion seems to favor a shift to a 12 month <br>
cycle[1], especially among developers, so it seems pretty likely we'll <br>
make that shift.&nbsp; (If you do have strong concerns about such a move, n=
ow <br>
is the time to raise them.)<br>
<br>
That brings us to an important decision: what time of year should we <br>
release?&nbsp; Once we pick the timing, we'll be releasing at that time *ev=
ery <br>
year* for each release (barring another schedule shift, which we want to <b=
r>
avoid), so let's choose carefully!<br>
<br>
A few options:<br>
<br>
&nbsp;- November: If we release Octopus 9 months from the Nautilus release<=
br>
&nbsp;&nbsp; (planned for Feb, released in Mar) then we'd target this Novem=
ber.&nbsp; We <br>
&nbsp;&nbsp; could shift to a 12 months candence after that.<br>
&nbsp;- February: That's 12 months from the Nautilus target.<br>
&nbsp;- March: That's 12 months from when Nautilus was *actually* released.=
<br>
<br>
November is nice in the sense that we'd wrap things up before the <br>
holidays.&nbsp; It's less good in that users may not be inclined to install=
 the <br>
new release when many developers will be less available in December.<br>
<br>
February kind of sucked in that the scramble to get the last few things<br>
done happened during the holidays.&nbsp; OTOH, we should be doing what we c=
an<br>
to avoid such scrambles, so that might not be something we should factor<br=
>
in.&nbsp; March may be a bit more balanced, with a solid 3 months before wh=
en<br>
people are productive, and 3 months after before they disappear on holiday<=
br>
to address any post-release issues.<br>
<br>
People tend to be somewhat less available over the summer months due to<br>
holidays etc, so an early or late summer release might also be less than<br=
>
ideal.<br>
<br>
Thoughts?&nbsp; If we can narrow it down to a few options maybe we could do=
 a<br>
poll to gauge user preferences.<br>
<br>
Thanks!<br>
sage<br>
<br>
<br>
[1] <a href=3D"https://twitter.com/larsmb/status/1130010208971952129">
https://protect-au.mimecast.com/s/N1l6CROAEns1RN1Zu9Jwts?domain=3Dtwitter.c=
om</a><br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://l=
ists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_ME1PR01MB070645B4EDCB63853433D02A81170ME1PR01MB0706ausp_--


--===============0324290320169728562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0324290320169728562==--

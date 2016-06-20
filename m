From: Warren Wang - ISD <Warren.Wang-dFwxUrggiyBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
 objects in pool
Date: Mon, 20 Jun 2016 20:47:32 +0000
Message-ID: <D38DCB57.131AE%warren.wang@walmart.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
	<CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1387028080=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1387028080==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D38DCB57131AEwarrenwangwalmartcom_"

--_000_D38DCB57131AEwarrenwangwalmartcom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Sorry, late to the party here. I agree, up the merge and split thresholds. =
We're as high as 50/12. I chimed in on an RH ticket here. One of those thin=
gs you just have to find out as an operator since it's not well documented =
:(

https://bugzilla.redhat.com/show_bug.cgi?id=3D1219974

We have over 200 million objects in this cluster, and it's still doing over=
 15000 write IOPS all day long with 302 spinning drives + SATA SSD journals=
. Having enough memory and dropping your vfs_cache_pressure should also hel=
p.

Keep in mind that if you change the values, it won't take effect immediatel=
y. It only merges them back if the directory is under the calculated thresh=
old and a write occurs (maybe a read, I forget).

Warren


From: ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-bounc=
es-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>> on behalf of Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:=
wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Date: Monday, June 20, 2016 at 2:48 PM
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:blair.bethwaite@gmail=
.com>>, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org<mailto:wido-fspyXLx8qC4@public.gmane.org>>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-u79uwXL29TY@public.gmane.org=
nel.org>>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>" <c=
eph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of ob=
jects in pool

Thanks everyone for your replies.  I sincerely appreciate it. We are testin=
g with different pg_num and filestore_split_multiple settings.  Early indic=
ations are .... well not great. Regardless it is nice to understand the sym=
ptoms better so we try to design around it.

Best Regards,
Wade


On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
On 20 June 2016 at 09:21, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto=
:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> slow request issues). If you watch your xfs stats you'll likely get
> further confirmation. In my experience xs_dir_lookups balloons (which
> means directory lookups are missing cache and going to disk).

Murphy's a bitch. Today we upgraded a cluster to latest Hammer in
preparation for Jewel/RHCS2. Turns out when we last hit this very
problem we had only ephemerally set the new filestore merge/split
values - oops. Here's what started happening when we upgraded and
restarted a bunch of OSDs:
https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-xs_dir_looku=
p.png

Seemed to cause lots of slow requests :-/. We corrected it about
12:30, then still took a while to settle.

--
Cheers,
~Blairo

This email and any files transmitted with it are confidential and intended =
solely for the individual or entity to whom they are addressed. If you have=
 received this email in error destroy it immediately. *** Walmart Confident=
ial ***

--_000_D38DCB57131AEwarrenwangwalmartcom_
Content-ID: <9FAFC6F835AEF043AA937AD199E58AEA-Q5+yaeBwhZL9SOyiPdwG7kEZadJ+ESx9@public.gmane.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif;">
<div>
<div>Sorry, late to the party here. I agree, up the merge and split thresho=
lds. We&#8217;re as high as 50/12. I chimed in on an RH ticket here. One of=
 those things you just have to find out as an operator since it&#8217;s not=
 well documented :(</div>
<div><br>
</div>
<div><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1219974">http=
s://bugzilla.redhat.com/show_bug.cgi?id=3D1219974</a></div>
<div><br>
</div>
<div>We have over 200 million objects in this cluster, and it&#8217;s still=
 doing over 15000 write IOPS all day long with 302 spinning drives &#43; SA=
TA SSD journals. Having enough memory and dropping your vfs_cache_pressure =
should also help.</div>
<div><br>
</div>
<div>Keep in mind that if you change the values, it won&#8217;t take effect=
 immediately. It only merges them back if the directory is under the calcul=
ated threshold and a write occurs (maybe a read, I forget).</div>
<div><br>
</div>
<div>Warren</div>
<div>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; =
font-family: 'Times New Roman', serif;">
<br>
</p>
</div>
</div>
<div><br>
</div>
<span id=3D"OLK_SRC_BODY_SECTION">
<div style=3D"font-family:Calibri; font-size:11pt; text-align:left; color:b=
lack; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM:=
 0in; PADDING-LEFT: 0in; PADDING-RIGHT: 0in; BORDER-TOP: #b5c4df 1pt solid;=
 BORDER-RIGHT: medium none; PADDING-TOP: 3pt">
<span style=3D"font-weight:bold">From: </span>ceph-users &lt;<a href=3D"mai=
lto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a=
>&gt; on behalf of Wade Holler &lt;<a href=3D"mailto:wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
>wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Date: </span>Monday, June 20, 2016 at 2:48=
 PM<br>
<span style=3D"font-weight:bold">To: </span>Blair Bethwaite &lt;<a href=3D"=
mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;, Wido d=
en Hollander &lt;<a href=3D"mailto:wido-fspyXLx8qC4@public.gmane.org">wido-fspyXLx8qC4@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Cc: </span>Ceph Development &lt;<a href=3D=
"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &qu=
ot;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</=
a>&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists.=
ceph.com</a>&gt;<br>
<span style=3D"font-weight:bold">Subject: </span>Re: [ceph-users] Dramatic =
performance drop at certain number of objects in pool<br>
</div>
<div><br>
</div>
<div>
<div>
<div dir=3D"ltr">Thanks everyone for your replies.&nbsp; I sincerely apprec=
iate it. We are testing with different pg_num and filestore_split_multiple =
settings.&nbsp; Early indications are .... well not great. Regardless it is=
 nice to understand the symptoms better so we
 try to design around it.
<div><br>
</div>
<div>Best Regards,</div>
<div>Wade</div>
<div><br>
</div>
</div>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite &lt;<a hre=
f=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wr=
ote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 20 June 2016 at 09:21, Blair Bethwaite &lt;<a href=3D"mailto:blair.bethw=
aite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<=
br>
&gt; slow request issues). If you watch your xfs stats you'll likely get<br>
&gt; further confirmation. In my experience xs_dir_lookups balloons (which<=
br>
&gt; means directory lookups are missing cache and going to disk).<br>
<br>
Murphy's a bitch. Today we upgraded a cluster to latest Hammer in<br>
preparation for Jewel/RHCS2. Turns out when we last hit this very<br>
problem we had only ephemerally set the new filestore merge/split<br>
values - oops. Here's what started happening when we upgraded and<br>
restarted a bunch of OSDs:<br>
<a href=3D"https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-x=
s_dir_lookup.png" rel=3D"noreferrer" target=3D"_blank">https://au-east.erc.=
monash.edu.au/swift/v1/public/grafana-ceph-xs_dir_lookup.png</a><br>
<br>
Seemed to cause lots of slow requests :-/. We corrected it about<br>
12:30, then still took a while to settle.<br>
<br>
--<br>
Cheers,<br>
~Blairo<br>
</blockquote>
</div>
</div>
</div>
</span>

<DIV>
This email and any files transmitted with it are confidential and intended =
solely for the individual or entity to whom they are addressed. If you have=
 received this email in error destroy it immediately. *** Walmart Confident=
ial ***<BR>
</DIV></body>
</html>

--_000_D38DCB57131AEwarrenwangwalmartcom_--

--===============1387028080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1387028080==--

From: Linh Vu <vul-keaFvQtjc6i7NGdpmJTKYQ@public.gmane.org>
Subject: Re: [Ceph-maintainers]  v12.2.7 Luminous released
Date: Thu, 19 Jul 2018 00:36:54 +0000
Message-ID: <MEAPR01MB3333E0DC203C775AF18A3FEE81520@MEAPR01MB3333.ausprd01.prod.outlook.com>
References: <87tvox968t.fsf@suse.com> <20180717182419.GA1559@shell.dmz.bit.nl>,
 <alpine.DEB.2.11.1807171838180.15696@piezo.novalocal>
 <MEAPR01MB3333E2C456B441629674B2BE81530@MEAPR01MB3333.ausprd01.prod.outlook.com>,
 <alpine.DEB.2.11.1807182333190.17411@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6751128812411004222=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1807182333190.17411-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, "ceph-announce-Qp0mS5GaXlQ@public.gmane.org" <ceph-announce-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6751128812411004222==
Content-Language: en-AU
Content-Type: multipart/alternative;
	boundary="_000_MEAPR01MB3333E0DC203C775AF18A3FEE81520MEAPR01MB3333ausp_"

--_000_MEAPR01MB3333E0DC203C775AF18A3FEE81520MEAPR01MB3333ausp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Awesome, thank you Sage! With that explanation, it's actually a lot easier =
and less impacting than I thought. :)


Cheers,

Linh

________________________________
From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Sent: Thursday, 19 July 2018 9:35:33 AM
To: Linh Vu
Cc: Stefan Kooman; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-ma=
intainers-Qp0mS5GaXlQ@public.gmane.org; ceph-announce-Qp0mS5GaXlQ@public.gmane.org
Subject: Re: [Ceph-maintainers] [ceph-users] v12.2.7 Luminous released

On Wed, 18 Jul 2018, Linh Vu wrote:
> Thanks for all your hard work in putting out the fixes so quickly! :)
>
> We have a cluster on 12.2.5 with Bluestore and EC pool but for CephFS,
> not RGW. In the release notes, it says RGW is a risk especially the
> garbage collection, and the recommendation is to either pause IO or
> disable RGW garbage collection.
>
> In our case with CephFS, not RGW, is it a lot less risky to perform the
> upgrade to 12.2.7 without the need to pause IO?

It is hard to quantify.  I think we only saw the problem with RGW, but
CephFS also sends deletes to non-existent objects when deleting or
truncating sparse files.  Those are probably not too common in most
environments...

> What does pause IO do? Do current sessions just get queued up and IO
> resume normally with no problem after unpausing?

Exactly.  As long as the application doesn't have some timeout coded where
it gives up when a read or write is taking to long, everything will just
pause.

> If we have to pause IO, is it better to do something like: pause IO,
> restart OSDs on one node, unpause IO - repeated for all the nodes
> involved in the EC pool?

Yes, that sounds like a great way to proceed!

sage


--_000_MEAPR01MB3333E0DC203C775AF18A3FEE81520MEAPR01MB3333ausp_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Awesome, thank you Sage! With tha=
t explanation, it's actually a lot easier and less impacting than I thought=
. :)&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Cheers,</p>
<p style=3D"margin-top:0;margin-bottom:0">Linh</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sage Weil &lt;sage@ne=
wdream.net&gt;<br>
<b>Sent:</b> Thursday, 19 July 2018 9:35:33 AM<br>
<b>To:</b> Linh Vu<br>
<b>Cc:</b> Stefan Kooman; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org; =
ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org; ceph-announce-Qp0mS5GaXlQ@public.gmane.org<br>
<b>Subject:</b> Re: [Ceph-maintainers] [ceph-users] v12.2.7 Luminous releas=
ed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, 18 Jul 2018, Linh Vu wrote:<br>
&gt; Thanks for all your hard work in putting out the fixes so quickly! :)<=
br>
&gt; <br>
&gt; We have a cluster on 12.2.5 with Bluestore and EC pool but for CephFS,=
 <br>
&gt; not RGW. In the release notes, it says RGW is a risk especially the <b=
r>
&gt; garbage collection, and the recommendation is to either pause IO or <b=
r>
&gt; disable RGW garbage collection.<br>
&gt; <br>
&gt; In our case with CephFS, not RGW, is it a lot less risky to perform th=
e <br>
&gt; upgrade to 12.2.7 without the need to pause IO?<br>
<br>
It is hard to quantify.&nbsp; I think we only saw the problem with RGW, but=
 <br>
CephFS also sends deletes to non-existent objects when deleting or <br>
truncating sparse files.&nbsp; Those are probably not too common in most <b=
r>
environments...<br>
<br>
&gt; What does pause IO do? Do current sessions just get queued up and IO <=
br>
&gt; resume normally with no problem after unpausing?<br>
<br>
Exactly.&nbsp; As long as the application doesn't have some timeout coded w=
here <br>
it gives up when a read or write is taking to long, everything will just <b=
r>
pause.<br>
<br>
&gt; If we have to pause IO, is it better to do something like: pause IO, <=
br>
&gt; restart OSDs on one node, unpause IO - repeated for all the nodes <br>
&gt; involved in the EC pool?<br>
<br>
Yes, that sounds like a great way to proceed!<br>
<br>
sage<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MEAPR01MB3333E0DC203C775AF18A3FEE81520MEAPR01MB3333ausp_--


--===============6751128812411004222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6751128812411004222==--

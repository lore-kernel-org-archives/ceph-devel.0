From: Linh Vu <vul-keaFvQtjc6i7NGdpmJTKYQ@public.gmane.org>
Subject: Re: v12.2.7 Luminous released
Date: Wed, 18 Jul 2018 01:04:07 +0000
Message-ID: <MEAPR01MB3333E2C456B441629674B2BE81530@MEAPR01MB3333.ausprd01.prod.outlook.com>
References: <87tvox968t.fsf@suse.com> <20180717182419.GA1559@shell.dmz.bit.nl>,
 <alpine.DEB.2.11.1807171838180.15696@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3905571275988941799=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1807171838180.15696-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, "ceph-announce-Qp0mS5GaXlQ@public.gmane.org" <ceph-announce-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3905571275988941799==
Content-Language: en-AU
Content-Type: multipart/alternative;
	boundary="_000_MEAPR01MB3333E2C456B441629674B2BE81530MEAPR01MB3333ausp_"

--_000_MEAPR01MB3333E2C456B441629674B2BE81530MEAPR01MB3333ausp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Thanks for all your hard work in putting out the fixes so quickly! :)

We have a cluster on 12.2.5 with Bluestore and EC pool but for CephFS, not =
RGW. In the release notes, it says RGW is a risk especially the garbage col=
lection, and the recommendation is to either pause IO or disable RGW garbag=
e collection.


In our case with CephFS, not RGW, is it a lot less risky to perform the upg=
rade to 12.2.7 without the need to pause IO?


What does pause IO do? Do current sessions just get queued up and IO resume=
 normally with no problem after unpausing?


If we have to pause IO, is it better to do something like: pause IO, restar=
t OSDs on one node, unpause IO - repeated for all the nodes involved in the=
 EC pool?


Regards,

Linh

________________________________
From: ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> on behalf of Sage Weil=
 <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Sent: Wednesday, 18 July 2018 4:42:41 AM
To: Stefan Kooman
Cc: ceph-announce-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-maintainers@ce=
ph.com; ceph-users-Qp0mS5GaXlQ@public.gmane.org
Subject: Re: [ceph-users] v12.2.7 Luminous released

On Tue, 17 Jul 2018, Stefan Kooman wrote:
> Quoting Abhishek Lekshmanan (abhishek-IBi9RG/b67k@public.gmane.org):
>
> > *NOTE* The v12.2.5 release has a potential data corruption issue with
> > erasure coded pools. If you ran v12.2.5 with erasure coding, please see
^^^^^^^^^^^^^^^^^^^
> > below.
>
> < snip >
>
> > Upgrading from v12.2.5 or v12.2.6
> > ---------------------------------
> >
> > If you used v12.2.5 or v12.2.6 in combination with erasure coded
^^^^^^^^^^^^^
> > pools, there is a small risk of corruption under certain workloads.
> > Specifically, when:
>
> < snip >
>
> One section mentions Luminous clusters _with_ EC pools specifically, the =
other
> section mentions Luminous clusters running 12.2.5.

I think they both do?

> I might be misreading this, but to make things clear for current Ceph
> Luminous 12.2.5 users. Is the following statement correct?
>
> If you do _NOT_ use EC in your 12.2.5 cluster (only replicated pools), th=
ere is
> no need to quiesce IO (ceph osd pause).

Correct.

> http://docs.ceph.com/docs/master/releases/luminous/#upgrading-from-other-=
versions<http://docs.ceph.com/docs/master/releases/luminous/#upgrading-from=
-other-versions>
> If your cluster did not run v12.2.5 or v12.2.6 then none of the above
> issues apply to you and you should upgrade normally.
>
> ^^ Above section would indicate all 12.2.5 luminous clusters.

The intent here is to clarify that any cluster running 12.2.4 or
older can upgrade without reading carefully. If the cluster
does/did run 12.2.5 or .6, then read carefully because it may (or may not)
be affected.

Does that help? Any suggested revisions to the wording in the release
notes that make it clearer are welcome!

Thanks-
sage


>
> Please clarify,
>
> Thanks,
>
> Stefan
>
> --
> | BIT BV http://www.bit.nl/<http://www.bit.nl/> Kamer van Koophandel 0909=
0351
> | GPG: 0xD14839C6 +31 318 648 688 / info-68+x73Hep80@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html<http://=
vger.kernel.org/majordomo-info.html>
>
>
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<http://lists.ceph.co=
m/listinfo.cgi/ceph-users-ceph.com>

--_000_MEAPR01MB3333E2C456B441629674B2BE81530MEAPR01MB3333ausp_
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
<p style=3D"margin-top:0;margin-bottom:0">Thanks for all your hard work in =
putting out the fixes so quickly! :)<br>
<br>
We have a cluster on 12.2.5 with Bluestore and EC pool but for CephFS, not =
RGW. In the release notes, it says RGW is a risk especially the garbage col=
lection, and the recommendation is to either pause IO or disable RGW garbag=
e collection.&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">In our case with CephFS, not RGW,=
 is it a lot less risky to perform the upgrade to 12.2.7 without the need t=
o pause IO?&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">What does pause IO do? Do current=
 sessions just get queued up and IO resume normally with no problem after u=
npausing?&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">If we have to pause IO, is it bet=
ter to do&nbsp;something like: pause IO, restart OSDs on one node, unpause =
IO - repeated for all the nodes involved in the EC pool?&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Linh</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> ceph-users &lt;ceph-u=
sers-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt; on behalf of Sage Weil &lt;sage-BnTBU8nroG6DGRHsOpWV0g@public.gmane.org=
t&gt;<br>
<b>Sent:</b> Wednesday, 18 July 2018 4:42:41 AM<br>
<b>To:</b> Stefan Kooman<br>
<b>Cc:</b> ceph-announce-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-maintai=
ners-Qp0mS5GaXlQ@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org<br>
<b>Subject:</b> Re: [ceph-users] v12.2.7 Luminous released</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div>On Tue, 17 Jul 2018, Stefan Kooman wrote:<br>
&gt; Quoting Abhishek Lekshmanan (abhishek-IBi9RG/b67k@public.gmane.org):<br>
&gt; <br>
&gt; &gt; *NOTE* The v12.2.5 release has a potential data corruption issue =
with<br>
&gt; &gt; erasure coded pools. If you ran v12.2.5 with erasure coding, plea=
se see<br>
^^^^^^^^^^^^^^^^^^^<br>
&gt; &gt; below.<br>
&gt; <br>
&gt; &lt; snip &gt;<br>
&gt; <br>
&gt; &gt; Upgrading from v12.2.5 or v12.2.6<br>
&gt; &gt; ---------------------------------<br>
&gt; &gt; <br>
&gt; &gt; If you used v12.2.5 or v12.2.6 in combination with erasure coded<=
br>
^^^^^^^^^^^^^<br>
&gt; &gt; pools, there is a small risk of corruption under certain workload=
s.<br>
&gt; &gt; Specifically, when:<br>
&gt; <br>
&gt; &lt; snip &gt;<br>
&gt; <br>
&gt; One section mentions Luminous clusters _with_ EC pools specifically, t=
he other<br>
&gt; section mentions Luminous clusters running 12.2.5.<br>
<br>
I think they both do?<br>
<br>
&gt; I might be misreading this, but to make things clear for current Ceph =
<br>
&gt; Luminous 12.2.5 users. Is the following statement correct?<br>
&gt; <br>
&gt; If you do _NOT_ use EC in your 12.2.5 cluster (only replicated pools),=
 there is<br>
&gt; no need to quiesce IO (ceph osd pause).<br>
<br>
Correct.<br>
<br>
&gt; <a href=3D"http://docs.ceph.com/docs/master/releases/luminous/#upgradi=
ng-from-other-versions">
http://docs.ceph.com/docs/master/releases/luminous/#upgrading-from-other-ve=
rsions</a><br>
&gt; If your cluster did not run v12.2.5 or v12.2.6 then none of the above<=
br>
&gt; issues apply to you and you should upgrade normally.<br>
&gt; <br>
&gt; ^^ Above section would indicate all 12.2.5 luminous clusters.<br>
<br>
The intent here is to clarify that any cluster running 12.2.4 or <br>
older can upgrade without reading carefully. If the cluster <br>
does/did run 12.2.5 or .6, then read carefully because it may (or may not) =
<br>
be affected.<br>
<br>
Does that help? Any suggested revisions to the wording in the release <br>
notes that make it clearer are welcome!<br>
<br>
Thanks-<br>
sage<br>
<br>
<br>
&gt; <br>
&gt; Please clarify,<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Stefan<br>
&gt; <br>
&gt; -- <br>
&gt; | BIT BV <a href=3D"http://www.bit.nl/">
http://www.bit.nl/</a> Kamer van Koophandel 09090351<br>
&gt; | GPG: 0xD14839C6 +31 318 648 688 / info-68+x73Hep80@public.gmane.org<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
&gt; More majordomo info at <a href=3D"http://vger.kernel.org/majordomo-inf=
o.html">
http://vger.kernel.org/majordomo-info.html</a><br>
&gt; <br>
&gt; <br>
_______________________________________________<br>
ceph-users mailing list<br>
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://l=
ists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div>
</body>
</html>

--_000_MEAPR01MB3333E2C456B441629674B2BE81530MEAPR01MB3333ausp_--


--===============3905571275988941799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3905571275988941799==--

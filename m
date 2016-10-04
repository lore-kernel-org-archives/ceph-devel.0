From: "McFarland, Bruce" <Bruce.McFarland-Iz5qeGvAONRWk0Htik3J/w@public.gmane.org>
Subject: Bug 14396 Calamari Dashboard :: can't connect to the
	cluster??
Date: Tue, 4 Oct 2016 20:45:54 +0000
Message-ID: <D4196108.2A3E%bruce.mcfarland@teradata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1642994078=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
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
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1642994078==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D41961082A3Ebrucemcfarlandteradatacom_"

--_000_D41961082A3Ebrucemcfarlandteradatacom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I am attempting to bring up Calamari using SuSE rpms. I am able to connect =
to all salt minions, execute ceph.get_heartbeats from all minions on the ma=
ster, see the whisper DB getting populated from diamond data passed to the =
master,  and initialize calamari. When I open the Calamari Dashboard GUI it=
 reports that it recognizes the ceph nodes, but it doesn=92t recognize the =
cluster and displays the "use ceph-deploy to create the cluster=94 comment =
(we don=92t use or install ceph-deploy).

Everything I can find online points to a salt versioning issue specially 20=
15 and above versions of salt, but SuSE rpms ship with salt 2014.1.10 (Hydr=
ogen). I see an open bug in Ceph Calamari tracker that appears to be the sa=
me issue:
Bug #14396: Calamari dashboard :: can't connect to the cluster<http://track=
er.ceph.com/issues/14396#change-78335>

Has anyone been able to work around this issue with Calamari Dashboard? It =
appears to be a, somewhat, common problem so any pointers or workarounds wo=
uld be greatly appreciated.

Thanks,
Bruce

--_000_D41961082A3Ebrucemcfarlandteradatacom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <8EB8857EEAA25B42AE77A2C030A149A6-4zKsZ4M6+sdEKMMhf/gKZA@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif;">
<div>I am attempting to bring up Calamari using SuSE rpms. I am able to con=
nect to all salt minions, execute ceph.get_heartbeats from all minions on t=
he master, see the whisper DB getting populated from diamond data passed to=
 the master, &nbsp;and initialize calamari.
 When I open the Calamari Dashboard GUI it reports that it recognizes the c=
eph nodes, but it doesn=92t recognize the cluster and displays the &quot;us=
e ceph-deploy to create the cluster=94 comment (we don=92t use or install c=
eph-deploy).&nbsp;</div>
<div><br>
</div>
<div>Everything I can find online points to a salt versioning issue special=
ly 2015 and above versions of salt, but SuSE rpms ship with salt 2014.1.10 =
(Hydrogen). I see an open bug in Ceph Calamari tracker that appears to be t=
he same issue:</div>
<div><a href=3D"http://tracker.ceph.com/issues/14396#change-78335" style=3D=
"color: rgb(240, 92, 86); font-family: Helvetica, Arial, sans-serif; font-s=
ize: 12px;">Bug #14396: Calamari dashboard :: can't connect to the cluster<=
/a></div>
<div><br>
</div>
<div>Has anyone been able to work around this issue with Calamari Dashboard=
? It appears to be a, somewhat, common problem so any pointers or workaroun=
ds would be greatly appreciated.</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Bruce</div>
</body>
</html>

--_000_D41961082A3Ebrucemcfarlandteradatacom_--


--===============1642994078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1642994078==--

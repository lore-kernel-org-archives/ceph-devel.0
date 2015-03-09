From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Ceph BIG outage : 200+ OSD are down ,
	OSD cannot create thread
Date: Mon, 9 Mar 2015 12:41:40 +0200
Message-ID: <465F1943-32F1-4759-A713-3A5EB8B88E91@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/mixed; boundary="===============0957261629=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0957261629==
Content-Type: multipart/signed; boundary="Apple-Mail=_1BBC0C03-6065-47D5-A66A-D90BAA4B0B59"; protocol="application/pkcs7-signature"; micalg=sha1


--Apple-Mail=_1BBC0C03-6065-47D5-A66A-D90BAA4B0B59
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_7380DCBB-5F1D-407C-BB95-07E588950338"


--Apple-Mail=_7380DCBB-5F1D-407C-BB95-07E588950338
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Community need help to fix a long going Ceph problem.

Cluster is unhealthy , Multiple OSDs are DOWN. When i am trying to =
restart OSD=E2=80=99s i am getting this error=20


2015-03-09 12:22:16.312774 7f760dac9700 -1 common/Thread.cc: In function =
'void Thread::create(size_t)' thread 7f760dac9700 time 2015-03-09 =
12:22:16.311970
common/Thread.cc: 129: FAILED assert(ret =3D=3D 0)


Environment :  4 Nodes , OSD+Monitor , Firefly latest , CentOS6.5 , =
3.17.2-1.el6.elrepo.x86_64

Tried upgrading from 0.80.7 to 0.80.8  but no Luck

Tried centOS stock kernel 2.6.32  but no Luck

Memory is not a problem more then 150+GB is free=20


Did any one every faced this problem ??

Cluster status=20

   cluster 2bd3283d-67ef-4316-8b7e-d8f4747eae33
     health HEALTH_WARN 7334 pgs degraded; 1185 pgs down; 1 pgs =
incomplete; 1735 pgs peering; 8938 pgs stale; 1
736 pgs stuck inactive; 8938 pgs stuck stale; 10320 pgs stuck unclean; =
recovery 6061/31080 objects degraded (19
.501%); 111/196 in osds are down; clock skew detected on mon.pouta-s02, =
mon.pouta-s03
     monmap e3: 3 mons at =
{pouta-s01=3D10.XXX.50.1:6789/0,pouta-s02=3D10.XXX.50.2:6789/0,pouta-s03=3D=
10.XXX.50.3:6789
/0}, election epoch 1312, quorum 0,1,2 pouta-s01,pouta-s02,pouta-s03
     osdmap e26633: 239 osds: 85 up, 196 in
      pgmap v60389: 17408 pgs, 13 pools, 42345 MB data, 10360 objects
            4699 GB used, 707 TB / 711 TB avail
            6061/31080 objects degraded (19.501%)
                  14 down+remapped+peering
                  39 active
                3289 active+clean
                 547 peering
                 663 stale+down+peering
                 705 stale+active+remapped
                   1 active+degraded+remapped
                   1 stale+down+incomplete
                 484 down+peering
                 455 active+remapped
                3696 stale+active+degraded
                   4 remapped+peering
                  23 stale+down+remapped+peering
                  51 stale+active
                3637 active+degraded
                3799 stale+active+clean

OSD :  Logs=20

2015-03-09 12:22:16.312774 7f760dac9700 -1 common/Thread.cc: In function =
'void Thread::create(size_t)' thread 7f760dac9700 time 2015-03-09 =
12:22:16.311970
common/Thread.cc: 129: FAILED assert(ret =3D=3D 0)

 ceph version 0.80.8 (69eaad7f8308f21573c604f121956e64679a52a7)
 1: (Thread::create(unsigned long)+0x8a) [0xaf41da]
 2: (SimpleMessenger::add_accept_pipe(int)+0x6a) [0xae84fa]
 3: (Accepter::entry()+0x265) [0xb5c635]
 4: /lib64/libpthread.so.0() [0x3c8a6079d1]
 5: (clone()+0x6d) [0x3c8a2e89dd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.


More information at Ceph Tracker Issue :  =
http://tracker.ceph.com/issues/10988#change-49018 =
<http://tracker.ceph.com/issues/10988#change-49018>


****************************************************************
Karan Singh=20
Systems Specialist , Storage Platforms
CSC - IT Center for Science,
Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
mobile: +358 503 812758
tel. +358 9 4572001
fax +358 9 4572302
http://www.csc.fi/
****************************************************************


--Apple-Mail=_7380DCBB-5F1D-407C-BB95-07E588950338
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">Hello Community need help to fix a long going =
Ceph problem.</div><div class=3D""><br class=3D""></div><div =
class=3D"">Cluster is unhealthy , Multiple OSDs are DOWN. When i am =
trying to restart OSD=E2=80=99s i am getting this error&nbsp;</div><div =
class=3D""><br class=3D""></div><div class=3D""><div class=3D""><br =
class=3D""></div><div class=3D""><i class=3D"">2015-03-09 =
12:22:16.312774 7f760dac9700 -1 common/<a href=3D"http://Thread.cc" =
class=3D"">Thread.cc</a>: In function 'void Thread::create(size_t)' =
thread 7f760dac9700 time 2015-03-09 12:22:16.311970</i></div><div =
class=3D""><i class=3D"">common/<a href=3D"http://Thread.cc" =
class=3D"">Thread.cc</a>: 129: FAILED assert(ret =3D=3D =
0)</i></div></div><div class=3D""><br class=3D""></div><div class=3D""><br=
 class=3D""></div><div class=3D""><b class=3D"">Environment </b>: =
&nbsp;4 Nodes , OSD+Monitor , Firefly latest , CentOS6.5 ,&nbsp;<span =
style=3D"color: rgb(55, 66, 74); font-family: Helvetica, Arial, =
sans-serif; line-height: 9.59999942779541px; widows: 1; =
background-color: rgb(255, 255, 240);" =
class=3D"">3.17.2-1.el6.elrepo.x86_64</span></div><div class=3D""><span =
style=3D"color: rgb(55, 66, 74); font-family: Helvetica, Arial, =
sans-serif; line-height: 9.59999942779541px; widows: 1; =
background-color: rgb(255, 255, 240);" class=3D""><br =
class=3D""></span></div><div style=3D"widows: 1;" class=3D""><font =
color=3D"#37424a" face=3D"Helvetica, Arial, sans-serif" class=3D""><span =
style=3D"line-height: 9.59999942779541px; background-color: rgb(255, =
255, 240);" class=3D"">Tried upgrading from 0.80.7 to 0.80.8 &nbsp;but =
no Luck</span></font></div><div style=3D"widows: 1;" class=3D""><font =
color=3D"#37424a" face=3D"Helvetica, Arial, sans-serif" class=3D""><span =
style=3D"line-height: 9.59999942779541px; background-color: rgb(255, =
255, 240);" class=3D""><br class=3D""></span></font></div><div =
style=3D"widows: 1;" class=3D""><font color=3D"#37424a" face=3D"Helvetica,=
 Arial, sans-serif" class=3D""><span style=3D"line-height: =
9.59999942779541px; background-color: rgb(255, 255, 240);" =
class=3D"">Tried centOS stock kernel 2.6.32 &nbsp;but no =
Luck</span></font></div><div style=3D"widows: 1;" class=3D""><font =
color=3D"#37424a" face=3D"Helvetica, Arial, sans-serif" class=3D""><span =
style=3D"line-height: 9.59999942779541px; background-color: rgb(255, =
255, 240);" class=3D""><br class=3D""></span></font></div><div =
style=3D"widows: 1;" class=3D""><font color=3D"#37424a" face=3D"Helvetica,=
 Arial, sans-serif" class=3D""><span style=3D"line-height: =
9.59999942779541px; background-color: rgb(255, 255, 240);" =
class=3D"">Memory is not a problem more then 150+GB is =
free&nbsp;</span></font></div><div style=3D"widows: 1;" class=3D""><font =
color=3D"#37424a" face=3D"Helvetica, Arial, sans-serif" class=3D""><span =
style=3D"line-height: 9.59999942779541px; background-color: rgb(255, =
255, 240);" class=3D""><br class=3D""></span></font></div><div =
style=3D"widows: 1;" class=3D""><font color=3D"#37424a" face=3D"Helvetica,=
 Arial, sans-serif" class=3D""><span style=3D"line-height: =
9.59999942779541px; background-color: rgb(255, 255, 240);" class=3D""><br =
class=3D""></span></font></div><div style=3D"font-size: 14px;" =
class=3D"">Did any one every faced this problem ??</div><div =
class=3D""><br class=3D""></div><div class=3D""><font size=3D"3" =
class=3D""><b class=3D"">Cluster status&nbsp;</b></font></div><div =
class=3D""><font size=3D"3" class=3D""><b class=3D""><br =
class=3D""></b></font></div><div class=3D""><div class=3D"">&nbsp;<i =
class=3D""> &nbsp;cluster =
2bd3283d-67ef-4316-8b7e-d8f4747eae33</i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp;health HEALTH_WARN 7334 pgs degraded; =
1185 pgs down; 1 pgs incomplete; 1735 pgs peering; 8938 pgs stale; =
1</i></div><div class=3D""><i class=3D"">736 pgs stuck inactive; 8938 =
pgs stuck stale; 10320 pgs stuck unclean; recovery 6061/31080 objects =
degraded (19</i></div><div class=3D""><i class=3D"">.501%); 111/196 in =
osds are down; clock skew detected on mon.pouta-s02, =
mon.pouta-s03</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; =
&nbsp;monmap e3: 3 mons at =
{pouta-s01=3D10.XXX.50.1:6789/0,pouta-s02=3D10.XXX.50.2:6789/0,pouta-s03=3D=
10.XXX.50.3:6789</i></div><div class=3D""><i class=3D"">/0}, election =
epoch 1312, quorum 0,1,2 pouta-s01,pouta-s02,pouta-s03</i></div><div =
class=3D""><i class=3D"">&nbsp; &nbsp;<b class=3D""> &nbsp;osdmap =
e26633: 239 osds: 85 up, 196 in</b></i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp; pgmap v60389: 17408 pgs, 13 pools, 42345 =
MB data, 10360 objects</i></div><div class=3D""><i class=3D"">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4699 GB used, 707 TB / 711 TB =
avail</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 6061/31080 objects degraded (19.501%)</i></div><div =
class=3D""><i class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 14 down+remapped+peering</i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; 39 active</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3289 =
active+clean</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;547 peering</i></div><div =
class=3D""><i class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;663 stale+down+peering</i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;705 stale+active+remapped</i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;1 active+degraded+remapped</i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;1 stale+down+incomplete</i></div><div class=3D""><i =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;484 down+peering</i></div><div class=3D""><i class=3D"">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;455 =
active+remapped</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3696 =
stale+active+degraded</i></div><div class=3D""><i class=3D"">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;4 =
remapped+peering</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 23 =
stale+down+remapped+peering</i></div><div class=3D""><i class=3D"">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 51 =
stale+active</i></div><div class=3D""><i class=3D"">&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3637 active+degraded</i></div><div =
class=3D""><i class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 3799 stale+active+clean</i></div></div><div class=3D""><br =
class=3D""></div><div style=3D"font-size: 16px;" class=3D""><b =
class=3D"">OSD : &nbsp;Logs&nbsp;</b></div><div class=3D""><br =
class=3D""></div><div class=3D""><i class=3D"">2015-03-09 =
12:22:16.312774 7f760dac9700 -1 common/<a href=3D"http://Thread.cc" =
class=3D"">Thread.cc</a>: In function 'void Thread::create(size_t)' =
thread 7f760dac9700 time 2015-03-09 12:22:16.311970</i></div><div =
class=3D""><i class=3D"">common/<a href=3D"http://Thread.cc" =
class=3D"">Thread.cc</a>: 129: FAILED assert(ret =3D=3D 0)</i></div><div =
class=3D""><i class=3D""><br class=3D""></i></div><div class=3D""><i =
class=3D"">&nbsp;ceph version 0.80.8 =
(69eaad7f8308f21573c604f121956e64679a52a7)</i></div><div class=3D""><i =
class=3D"">&nbsp;1: (Thread::create(unsigned long)+0x8a) =
[0xaf41da]</i></div><div class=3D""><i class=3D"">&nbsp;2: =
(SimpleMessenger::add_accept_pipe(int)+0x6a) [0xae84fa]</i></div><div =
class=3D""><i class=3D"">&nbsp;3: (Accepter::entry()+0x265) =
[0xb5c635]</i></div><div class=3D""><i class=3D"">&nbsp;4: =
/lib64/libpthread.so.0() [0x3c8a6079d1]</i></div><div class=3D""><i =
class=3D"">&nbsp;5: (clone()+0x6d) [0x3c8a2e89dd]</i></div><div =
class=3D""><i class=3D"">&nbsp;NOTE: a copy of the executable, or =
`objdump -rdS &lt;executable&gt;` is needed to interpret =
this.</i></div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""></div><div class=3D""><font size=3D"3" class=3D""><b =
class=3D"">More information at Ceph Tracker Issue : &nbsp;</b></font><a =
href=3D"http://tracker.ceph.com/issues/10988#change-49018" =
class=3D"">http://tracker.ceph.com/issues/10988#change-49018</a></div><div=
 class=3D""><br class=3D"webkit-block-placeholder"></div><div =
apple-content-edited=3D"true" class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><br =
class=3D"Apple-interchange-newline">**************************************=
**************************</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Karan Singh&nbsp;</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Systems Specialist ,&nbsp;Storage Platforms</div><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">CSC - IT Center for Science,</div><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">Keilaranta 14, P. O. Box 405, FIN-02101 =
Espoo, Finland<br class=3D"">mobile: +358 503 812758<br class=3D"">tel. =
+358 9 4572001<br class=3D"">fax +358 9 4572302<br class=3D""><a =
href=3D"http://www.csc.fi/" class=3D"">http://www.csc.fi/</a></div><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" =
class=3D"">***************************************************************=
*</div></div></div>
</div>
<br class=3D""></body></html>=

--Apple-Mail=_7380DCBB-5F1D-407C-BB95-07E588950338--

--Apple-Mail=_1BBC0C03-6065-47D5-A66A-D90BAA4B0B59
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOYjCCBJ0w
ggOFoAMCAQICEDQ96SusJzT/j8s0lPvMcFQwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0wNTA2MDcwODA5MTBa
Fw0yMDA1MzAxMDQ4MzhaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNh
bHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNVBAsTGGh0
dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVTRVJGaXJzdC1DbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmF
pPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVNNRm5pELlzkniii8efNIxB8dOtINknS4p1aJk
xIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQylbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2q
L+usobNqqrcuZzWLeeEeaYji5kbNoKXqvgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAs
vIKKjqQOpdeJQ/wWWq8dcdcRWdq6hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMe
oYV+9Udly/hNVyh00jT/MLbu9mIwFIws6wIDAQABo4H0MIHxMB8GA1UdIwQYMBaAFK29mHo0tCb3
+sQmVO8DveAky1QaMB0GA1UdDgQWBBSJgmd9xJ0mcABLtFBIfN49rgRufTAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwRAYDVR0fBD0wOzA5oDegNYYz
aHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMDUGCCsG
AQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG
9w0BAQUFAAOCAQEAAbyc42MosPMxAcLfe91ioAGdIzEPnJJzU1HqH0z61p/Eyi9nfngzD3QWuZGH
kfWKJvpkcADYHvkLBGJQh5OB1Nr1I9s0u4VWtHA0bniDNx6FHMURFZJfhxe9rGr98cLRzIlfsXzw
PlHyNfN87GCYazor4O/fs32G67Ub9VvsonyYE9cAULnRLXPeA3h04QWFMV7LmrmdlMa5lDd1ctxE
+2fo8PolHlKn2iXpR+CgxzygTrEKNvt3SJ/vl4r7tP7jlBSog7xcLT/SYHFg7sJxggzpiDbj2iC0
o6BsqpZLuICOdcpJB/Y7FLrf3AXZn9vgsuZNoHgm5+ctbn9fxh6IFTCCBNowggPCoAMCAQICEF3/
UOr+D1NGiJ+AQY/nQsgwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJV
VDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29y
azEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZp
cnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMDkwNTE4MDAwMDAwWhcNMjgx
MjMxMjM1OTU5WjBEMQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMSQwIgYDVQQDExtURVJF
TkEgZVNjaWVuY2UgUGVyc29uYWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE
vCV9ze9ZBKt0Jym2Y4rvxDVwoUYIr25QmxtxeJcChcA1/5AYEWb6MzkUnqQS9z3uBSyB5/ctLjZ4
Qw45tn96dMPLVT8vs8vDN2rhlQMjG7MimBODWDBfrDyRRdNtCy7L0ZFhsspx+sKJDHsJ1pK/o4EX
EVUg3zeBnx4mCR3SFxlDy4uZJXRBW+YyKtCnU9zSIY3Nkc97bPTJ/tDl0gZrGmFCG4CRB9wUSSc7
Coqy4jtpCITLgZnXuhQf2H6SY732LTH6lU7NNg2Z7xG6rUr7qMR4uXxaPsj1CDLAqQXHjBoojzC6
F6PxueIHp7j7Vb+fYlrVFA8ItBOZ0hJ5WvD9AgMBAAGjggFbMIIBVzAfBgNVHSMEGDAWgBSJgmd9
xJ0mcABLtFBIfN49rgRufTAdBgNVHQ4EFgQUyIlzmaddURZTRVR8o8I5fMvXqoEwDgYDVR0PAQH/
BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwJgYDVR0gBB8wHTANBgsrBgEEAbIxAQICHTAMBgoq
hkiG90wFAgIFMFgGA1UdHwRRME8wTaBLoEmGR2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4t
VVNFUkZpcnN0LUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kRW1haWwuY3JsMG8GCCsGAQUFBwEBBGMw
YTA4BggrBgEFBQcwAoYsaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VUTkFBQUNsaWVudF9DQS5j
cnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQAD
ggEBAAgXpBz5FWuwGWFvoEjjeiTvQVWaoFBw2CPVU4ZKZ47o2lYWGCwbGCGJupgk7lY04xeGJr0h
WtQZk0rqYXRNtsSEjUfuyi5lbTaTmLHikmaI4k57dcdeRGkh3BJqMPxhgP4P8J3S3H6u5cJTTQtw
g2FWRfs933L2AkJ164iKmFdg9Z+ickmxej5BZzXDVSsNBzXoxivVuod5gHTnkja9RoF6Liniar7h
FxM1fBakJTMvYe7OyVLgQNvTvjlaz89MFOV/xUNXi025Wo7CDwZN3shJnYFzuuQ/mKWTPFlO25s1
3/5Nv1Wh6WTDRXysj3xH0TrxTnXZkGdA6LEvnhcvXDUwggTfMIIDx6ADAgECAhB37ILErqxVSnc1
ePJuNvJXMA0GCSqGSIb3DQEBBQUAMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJFTkExJDAi
BgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQTAeFw0xNDEwMzEwMDAwMDBaFw0xNTEx
MzAyMzU5NTlaMIGBMRMwEQYKCZImiZPyLGQBGRYDb3JnMRYwFAYKCZImiZPyLGQBGRYGdGVyZW5h
MRMwEQYKCZImiZPyLGQBGRYDdGNzMQswCQYDVQQGEwJGSTEMMAoGA1UEChMDQ1NDMSIwIAYDVQQD
FBlLYXJhbiBTaW5naCBrc2luZ2hAY3NjLmZpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAua9GMiJ0pEMcMKOmNjldVeaFJyc34XPDGw3hYcBicv68bX7Ov+7XP0+s1zA4vw7M/oK9GXWn
nojVY7jR30saS4Z+DpS/7gY3yp/tGLCXZAhtn8ehOwx32pgsMQVUV55L7U7AEcJ4cunuU9Gqf25z
yqN4y6yeTYw1k5+ny+a9qBJjQMSAWatYnNBBN7BFawzL1a9/VnPvy7IkhKzQfAS6lCiuvxDZvG/z
tr1RgDXyX0JVya0B8XHO2wU3xVrJtF3K4g2I9DSYR05X2sjHa6wiXFvItZriQz2AjE6dOmvRW53E
4U5AyQRaY06oy5HlN9IaINKJ3WVf+5il9JoAZN68gwIDAQABo4IBjTCCAYkwHwYDVR0jBBgwFoAU
yIlzmaddURZTRVR8o8I5fMvXqoEwHQYDVR0OBBYEFMz+qQQcnAbKsqYs4UdOaFeQVxyYMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAm
BgNVHSAEHzAdMA0GCysGAQQBsjEBAgIdMAwGCiqGSIb3TAUCAgUwRwYDVR0fBEAwPjA8oDqgOIY2
aHR0cDovL2NybC50Y3MudGVyZW5hLm9yZy9URVJFTkFlU2NpZW5jZVBlcnNvbmFsQ0EuY3JsMHoG
CCsGAQUFBwEBBG4wbDBCBggrBgEFBQcwAoY2aHR0cDovL2NydC50Y3MudGVyZW5hLm9yZy9URVJF
TkFlU2NpZW5jZVBlcnNvbmFsQ0EuY3J0MCYGCCsGAQUFBzABhhpodHRwOi8vb2NzcC50Y3MudGVy
ZW5hLm9yZzAdBgNVHREEFjAUgRJrYXJhbi5zaW5naEBjc2MuZmkwDQYJKoZIhvcNAQEFBQADggEB
AKCP9egRCcShcjER4mSD0ziLoVVML8PF/NxEAG3x05LBSB/dSORR4qOz4RSQLRFOYCikc2RFjPrA
eQysx0KDp41tatPwmYgOrhcOaBVRhlvM4XpLLaqtDGTPzMrQQBDwAMaxIit2c4WtJ7EJippoWC8y
f/Xfs/ltDhD3FWsu+WSROHKRh1Cilix/03kk0f7qFjNZsEutSyo2tTeJgZwBUCLiWFMUBnqXESBJ
ZEnAPae4cKlpoTK+ib7njo5ePf7FFZBiLJgmCO3rGDU4NKgxCr25JmNVtxbaBz9jvag6eNoBsz7t
reCdKGTaqRvCK4fvpG1QhP3/73Ao0ZkqsDznIXoxggK0MIICsAIBATBYMEQxCzAJBgNVBAYTAk5M
MQ8wDQYDVQQKEwZURVJFTkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQQIQ
d+yCxK6sVUp3NXjybjbyVzAJBgUrDgMCGgUAoIIBMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0xNTAzMDkxMDQxNDFaMCMGCSqGSIb3DQEJBDEWBBQc1FelCbh3MbZW
W7sL/bIKN3Dn8TBnBgkrBgEEAYI3EAQxWjBYMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJF
TkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQQIQd+yCxK6sVUp3NXjybjby
VzBpBgsqhkiG9w0BCRACCzFaoFgwRDELMAkGA1UEBhMCTkwxDzANBgNVBAoTBlRFUkVOQTEkMCIG
A1UEAxMbVEVSRU5BIGVTY2llbmNlIFBlcnNvbmFsIENBAhB37ILErqxVSnc1ePJuNvJXMA0GCSqG
SIb3DQEBAQUABIIBAA5QDTRHnrcUL/UGxyuk1t91JpL3CbtpcJqvlOyVDfhdSRZryIa6L3nyOHKo
T8xAUDl3al67u6gd8taJHmCQacgA8cmPrUN/n6RHIGGNRbqHhy1XhNoFY4f2QgAWbtKvTuWJDfnH
s9y0cRZpvV7BXd6EP0DzEIkQTG3pc7iA86N29Y4wi0DMi+aPZLoSEex3vsNMkIepTvgbC4iPw3tI
kn4bQvQmJodEieTdsipHSvnrVjow5ziiPzvTOkeBlMjXMkPq/eSz+CviAtKjyN/ZteSuCxwuEWU8
qL1ed8Fqe6fy4tOxdE/9y7XPwv0KBuoOZ1nt5oiJLMbloxM/4LyIdYkAAAAAAAA=
--Apple-Mail=_1BBC0C03-6065-47D5-A66A-D90BAA4B0B59--

--===============0957261629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0957261629==--

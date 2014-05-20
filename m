From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: 70+  OSD are DOWN and not coming up
Date: Tue, 20 May 2014 12:02:18 +0300
Message-ID: <5396D45F-E87E-4F53-85D8-B4DC1F630B78@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: multipart/mixed; boundary="===============1490488133=="
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1490488133==
Content-Type: multipart/alternative; boundary="Apple-Mail=_86F58BF8-CFB2-4235-A74A-0059FC9058E5"


--Apple-Mail=_86F58BF8-CFB2-4235-A74A-0059FC9058E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello Cephers , need your suggestion for troubleshooting.

My cluster is terribly struggling , 70+ osd are down out of 165

Problem =97> OSD are getting marked out of cluster and are down. The =
cluster is degraded. On checking logs of failed OSD we are getting wired =
entries that are continuously getting generated.

Osd Debug logs ::  http://pastebin.com/agTKh6zB


2014-05-20 10:19:03.699886 7f2328e237a0  0 osd.158 357532 done with =
init, starting boot process
2014-05-20 10:19:03.700093 7f22ff621700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x83018c0).connect claims to be =
192.168.1.109:6802/63896 not 192.168.1.109:6802/910005982 - wrong node!
2014-05-20 10:19:03.700152 7f22ff621700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x83018c0).fault with nothing to send, going to standby
2014-05-20 10:19:09.551269 7f22fdd12700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x533fd20).connect claims to be =
192.168.1.109:6803/63896 not 192.168.1.109:6803/1176009454 - wrong node!
2014-05-20 10:19:09.551347 7f22fdd12700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x533fd20).fault with nothing to send, going to standby
2014-05-20 10:19:09.703901 7f22fd80d700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 :42889 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8302aa0).connect claims to be =
192.168.1.113:6802/24612 not 192.168.1.113:6802/13870 - wrong node!
2014-05-20 10:19:09.704039 7f22fd80d700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 :42889 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8302aa0).fault with nothing to send, going to standby
2014-05-20 10:19:10.243139 7f22fd005700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 =
not 192.168.1.112:6800/14114 - wrong node!
2014-05-20 10:19:10.243190 7f22fd005700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).fault with nothing to send, going to standby
2014-05-20 10:19:10.349693 7f22fc7fd700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 cs=3D0 =
l=3D0 c=3D0x83070c0).fault with nothing to send, going to standby


ceph -v
ceph version 0.80-469-g991f7f1 =
(991f7f15a6e107b33a24bbef1169f21eb7fcce2c) #
ceph osd stat
osdmap e357073: 165 osds: 91 up, 165 in
flags noout #
I have tried doing :

1. Restarting the problematic OSDs , but no luck
2.  i restarted entire host but no luck, still osds are down and getting =
the same mesage

2014-05-20 10:19:10.243139 7f22fd005700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 =
not 192.168.1.112:6800/14114 - wrong node!
2014-05-20 10:19:10.243190 7f22fd005700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).fault with nothing to send, going to standby
2014-05-20 10:19:10.349693 7f22fc7fd700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 cs=3D0 =
l=3D0 c=3D0x83070c0).fault with nothing to send, going to standby
2014-05-20 10:22:23.312473 7f2307e61700  0 osd.158 357781 do_command r=3D0=

2014-05-20 10:22:23.326110 7f2307e61700  0 osd.158 357781 do_command r=3D0=
 debug_osd=3D0/5
2014-05-20 10:22:23.326123 7f2307e61700  0 log [INF] : debug_osd=3D0/5
2014-05-20 10:34:08.161864 7f230224d700  0 -- 192.168.1.112:6802/3807 >> =
192.168.1.102:6808/13276 pipe(0x8698280 sd=3D22 :41078 s=3D2 pgs=3D603 =
cs=3D1 l=3D0 c=3D0x8301600).fault with nothing to send, going to standby

3. Disks do not have errors , no message in dmesg and /var/log/messages

4. there was a bug in the past http://tracker.ceph.com/issues/4006 , =
dont know it again came bacin in Firefly

5. Recently no activity performed on cluster , except some pool and keys =
creation for cinder /glance integration

6. Nodes have enough free resources for osds.

7. No issues with network , osds are down on all cluster nodes. not from =
a single node.


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


--Apple-Mail=_86F58BF8-CFB2-4235-A74A-0059FC9058E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Hello Cephers , need your suggestion for =
troubleshooting.</div><div><br></div><div>My cluster is terribly =
struggling , 70+ osd are down out of 165</div><div><br></div><div><p =
style=3D"color: rgb(55, 66, 74); font-family: Helvetica, Arial, =
sans-serif; font-size: 11.818181991577148px; line-height: =
13.09090805053711px; background-color: rgb(255, 255, 240);">Problem =
=97&gt; OSD are getting marked out of cluster and are down. The cluster =
is degraded. On checking logs of failed OSD we are getting wired entries =
that are continuously getting generated.</p><p style=3D"color: rgb(55, =
66, 74); font-family: Helvetica, Arial, sans-serif; font-size: =
11.818181991577148px; line-height: 13.09090805053711px; =
background-color: rgb(255, 255, 240);">Osd Debug logs :: &nbsp;<a =
href=3D"http://pastebin.com/agTKh6zB">http://pastebin.com/agTKh6zB</a></p>=
</div><div><br></div><div><ol style=3D"margin: 0px; padding: 0px 0px 0px =
48px; color: rgb(172, 172, 172); font-family: Consolas, Menlo, Monaco, =
'Lucida Console', 'Liberation Mono', 'DejaVu Sans Mono', 'Bitstream Vera =
Sans Mono', monospace, serif; line-height: 21px; background-color: =
rgb(248, 248, 248);"><li class=3D"li2" style=3D"-webkit-user-select: =
none;"><div class=3D"de2" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:19:03.699886 7f2328e237a0 &nbsp;0 osd.158 =
357532 done with init, starting boot process</div></li><li class=3D"li1" =
style=3D"-webkit-user-select: none;"><div class=3D"de1" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:19:03.700093 7f22ff621700 &nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; =
192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x83018c0).connect claims to be =
192.168.1.109:6802/63896 not 192.168.1.109:6802/910005982 - wrong =
node!</div></li><li class=3D"li2" style=3D"-webkit-user-select: =
none;"><div class=3D"de2" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:19:03.700152 7f22ff621700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt; 192.168.1.109:6802/910005982 =
pipe(0x8698500 sd=3D35 :33500 s=3D1 pgs=3D0 cs=3D0 l=3D0 =
c=3D0x83018c0).fault with nothing to send, going to =
standby</div></li><li class=3D"li1" style=3D"-webkit-user-select: =
none;"><div class=3D"de1" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:19:09.551269 7f22fdd12700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt; 192.168.1.109:6803/1176009454 =
pipe(0x56aee00 sd=3D53 :40060 s=3D1 pgs=3D0 cs=3D0 l=3D0 =
c=3D0x533fd20).connect claims to be 192.168.1.109:6803/63896 not =
192.168.1.109:6803/1176009454 - wrong node!</div></li><li class=3D"li2" =
style=3D"-webkit-user-select: none;"><div class=3D"de2" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:19:09.551347 7f22fdd12700 &nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; =
192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x533fd20).fault with nothing to send, going to =
standby</div></li><li class=3D"li1" style=3D"-webkit-user-select: =
none;"><div class=3D"de1" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:19:09.703901 7f22fd80d700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt; 192.168.1.113:6802/13870 pipe(0x56adf00 =
sd=3D137 :42889 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x8302aa0).connect claims =
to be 192.168.1.113:6802/24612 not 192.168.1.113:6802/13870 - wrong =
node!</div></li><li class=3D"li2" style=3D"-webkit-user-select: =
none;"><div class=3D"de2" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:19:09.704039 7f22fd80d700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt; 192.168.1.113:6802/13870 pipe(0x56adf00 =
sd=3D137 :42889 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x8302aa0).fault with =
nothing to send, going to standby</div></li><li class=3D"li1" =
style=3D"-webkit-user-select: none;"><div class=3D"de1" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:19:10.243139 7f22fd005700 &nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 =
not 192.168.1.112:6800/14114 - wrong node!</div></li><li class=3D"li2" =
style=3D"-webkit-user-select: none;"><div class=3D"de2" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:19:10.243190 7f22fd005700 &nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).fault with nothing to send, going to =
standby</div></li><li class=3D"li1" style=3D"-webkit-user-select: =
none;"><div class=3D"de1" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255); z-index: auto;">2014-05-20 10:19:10.349693 7f22fc7fd700 =
&nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; 192.168.1.109:6800/13492 =
pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x83070c0).fault=
 with nothing to send, going to =
standby</div></li></ol><div><br></div></div><div><br></div><div><ol =
style=3D"margin-top: 0px; margin-bottom: 1em; color: rgb(55, 66, 74); =
font-family: Helvetica, Arial, sans-serif; font-size: =
11.818181991577148px; line-height: 13.09090805053711px; =
background-color: rgb(255, 255, 240);"><li>ceph -v<br>ceph version =
0.80-469-g991f7f1 (991f7f15a6e107b33a24bbef1169f21eb7fcce2c) =
#</li></ol><ol style=3D"margin-top: 0px; margin-bottom: 1em; color: =
rgb(55, 66, 74); font-family: Helvetica, Arial, sans-serif; font-size: =
11.818181991577148px; line-height: 13.09090805053711px; =
background-color: rgb(255, 255, 240);"><li>ceph osd stat<br>osdmap =
e357073: 165 osds: 91 up, 165 in<br>flags noout #</li></ol><p =
style=3D"color: rgb(55, 66, 74); font-family: Helvetica, Arial, =
sans-serif; font-size: 11.818181991577148px; line-height: =
13.09090805053711px; background-color: rgb(255, 255, 240);">I have tried =
doing :</p><p style=3D"color: rgb(55, 66, 74); font-family: Helvetica, =
Arial, sans-serif; font-size: 11.818181991577148px; line-height: =
13.09090805053711px; background-color: rgb(255, 255, 240); position: =
static; z-index: auto;">1. Restarting the problematic OSDs , but no =
luck<br>2. &nbsp;i restarted entire host but no luck, still osds are =
down and getting the same mesage</p><ol style=3D"margin: 0px; padding: =
0px 0px 0px 48px; color: rgb(172, 172, 172); font-family: Consolas, =
Menlo, Monaco, 'Lucida Console', 'Liberation Mono', 'DejaVu Sans Mono', =
'Bitstream Vera Sans Mono', monospace, serif; line-height: 21px; =
background-color: rgb(248, 248, 248);"><li class=3D"li1" =
style=3D"-webkit-user-select: none;"><div class=3D"de1" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:19:10.243139 7f22fd005700 &nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 =
not 192.168.1.112:6800/14114 - wrong node!</div></li><li class=3D"li2" =
style=3D"-webkit-user-select: none;"><div class=3D"de2" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:19:10.243190 7f22fd005700 &nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt; =
192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D0 =
cs=3D0 l=3D0 c=3D0x8304780).fault with nothing to send, going to =
standby</div></li><li class=3D"li1" style=3D"-webkit-user-select: =
none;"><div class=3D"de1" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:19:10.349693 7f22fc7fd700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt; 192.168.1.109:6800/13492 pipe(0x8698c80 =
sd=3D156 :0 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x83070c0).fault with nothing =
to send, going to standby</div></li><li class=3D"li2" =
style=3D"-webkit-user-select: none;"><div class=3D"de2" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:22:23.312473 7f2307e61700 &nbsp;0 osd.158 357781 do_command =
r=3D0</div></li><li class=3D"li1" style=3D"-webkit-user-select: =
none;"><div class=3D"de1" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:22:23.326110 7f2307e61700 &nbsp;0 osd.158 =
357781 do_command r=3D0 debug_osd=3D0/5</div></li><li class=3D"li2" =
style=3D"-webkit-user-select: none;"><div class=3D"de2" =
style=3D"-webkit-user-select: text; padding: 0px 5px; vertical-align: =
top; color: rgb(0, 0, 0); border-left-width: 1px; border-left-style: =
solid; border-left-color: rgb(204, 204, 204); margin: 0px 0px 0px -7px; =
position: relative; background-color: rgb(255, 255, 255);">2014-05-20 =
10:22:23.326123 7f2307e61700 &nbsp;0 log [INF] : =
debug_osd=3D0/5</div></li><li class=3D"li1" style=3D"-webkit-user-select: =
none;"><div class=3D"de1" style=3D"-webkit-user-select: text; padding: =
0px 5px; vertical-align: top; color: rgb(0, 0, 0); border-left-width: =
1px; border-left-style: solid; border-left-color: rgb(204, 204, 204); =
margin: 0px 0px 0px -7px; position: relative; background-color: rgb(255, =
255, 255);">2014-05-20 10:34:08.161864 7f230224d700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt; 192.168.1.102:6808/13276 pipe(0x8698280 =
sd=3D22 :41078 s=3D2 pgs=3D603 cs=3D1 l=3D0 c=3D0x8301600).fault with =
nothing to send, going to standby</div></li></ol><div><br></div><p =
style=3D"color: rgb(55, 66, 74); font-family: Helvetica, Arial, =
sans-serif; font-size: 11.818181991577148px; line-height: =
13.09090805053711px; background-color: rgb(255, 255, 240); position: =
static; z-index: auto;"><span style=3D"font-size: 11.818181991577148px; =
line-height: 13.09090805053711px;">3. Disks do not have errors , no =
message in dmesg and /var/log/messages</span></p><p style=3D"color: =
rgb(55, 66, 74); font-family: Helvetica, Arial, sans-serif; font-size: =
11.818181991577148px; line-height: 13.09090805053711px; =
background-color: rgb(255, 255, 240);">4. there was a bug in the =
past&nbsp;<a class=3D"external" =
href=3D"http://tracker.ceph.com/issues/4006" style=3D"color: rgb(19, 71, =
118) !important; text-decoration: none; padding-left: 12px; =
background-image: url(http://tracker.ceph.com/images/external.png); =
background-position: 0% 60%; background-repeat: no-repeat =
no-repeat;">http://tracker.ceph.com/issues/4006</a>&nbsp;, dont know it =
again came bacin in Firefly</p><p style=3D"color: rgb(55, 66, 74); =
font-family: Helvetica, Arial, sans-serif; font-size: =
11.818181991577148px; line-height: 13.09090805053711px; =
background-color: rgb(255, 255, 240);">5. Recently no activity performed =
on cluster , except some pool and keys creation for cinder /glance =
integration</p><p style=3D"color: rgb(55, 66, 74); font-family: =
Helvetica, Arial, sans-serif; font-size: 11.818181991577148px; =
line-height: 13.09090805053711px; background-color: rgb(255, 255, =
240);">6. Nodes have enough free resources for osds.</p><div>7. No =
issues with network , osds are down on all cluster nodes. not from a =
single node.</div></div><br><div apple-content-edited=3D"true">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><br =
class=3D"Apple-interchange-newline">**************************************=
**************************</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Karan =
Singh&nbsp;</div><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Systems Specialist ,&nbsp;Storage =
Platforms</div><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">CSC - =
IT Center for Science,</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, =
Finland<br>mobile: +358 503 812758<br>tel. +358 9 4572001<br>fax +358 9 =
4572302<br><a href=3D"http://www.csc.fi/">http://www.csc.fi/</a></div><div=
 style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">******************************************************=
**********</div></div></div>
</div>
<br></body></html>=

--Apple-Mail=_86F58BF8-CFB2-4235-A74A-0059FC9058E5--

--===============1490488133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1490488133==--

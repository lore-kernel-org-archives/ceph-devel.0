From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: 70+  OSD are DOWN and not coming up
Date: Wed, 21 May 2014 15:37:50 +0300
Message-ID: <C79BC6B3-43E1-4A8D-BAED-86A43B879CD3@csc.fi>
References: <5396D45F-E87E-4F53-85D8-B4DC1F630B78@csc.fi>
	<alpine.DEB.2.00.1405200815570.1689@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: multipart/mixed; boundary="===============0811789534=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1405200815570.1689-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0811789534==
Content-Type: multipart/alternative; boundary="Apple-Mail=_3BE6E7BB-E58E-4B23-A2F7-5C1948B1BB7A"


--Apple-Mail=_3BE6E7BB-E58E-4B23-A2F7-5C1948B1BB7A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello Sage

nodown, noout set on cluster

# ceph status
    cluster 009d3518-e60d-4f74-a26d-c08c1976263c
     health HEALTH_WARN 1133 pgs degraded; 44 pgs incomplete; 42 pgs =
stale; 45 pgs stuck inactive; 42 pgs stuck stale; 2602 pgs stuck =
unclean; recovery 206/2199 objects degraded (9.368%); 40/165 in osds are =
down; nodown,noout flag(s) set
     monmap e4: 4 mons at =
{storage0101-ib=3D192.168.100.101:6789/0,storage0110-ib=3D192.168.100.110:=
6789/0,storage0114-ib=3D192.168.100.114:6789/0,storage0115-ib=3D192.168.10=
0.115:6789/0}, election epoch 18, quorum 0,1,2,3 =
storage0101-ib,storage0110-ib,storage0114-ib,storage0115-ib
     osdmap e358031: 165 osds: 125 up, 165 in
            flags nodown,noout
      pgmap v604305: 4544 pgs, 6 pools, 4309 MB data, 733 objects
            3582 GB used, 357 TB / 361 TB avail
            206/2199 objects degraded (9.368%)
                   1 inactive
                   5 stale+active+degraded+remapped
                1931 active+clean
                   2 stale+incomplete
                  21 stale+active+remapped
                 380 active+degraded+remapped
                  38 incomplete
                1403 active+remapped
                   2 stale+active+degraded
                   1 stale+remapped+incomplete
                 746 active+degraded
                  11 stale+active+clean
                   3 remapped+incomplete


 Here is my ceph.conf  http://pastebin.com/KZdgPJm7  (debus osd , ms set =
)
I tried restarting all OSD services of  node-13 , services came up after =
several attempts of =93service ceph restart=94   =
http://pastebin.com/yMk86YHh
For Node : 14
All services are up

[root@storage0114-ib ~]# service ceph status
=3D=3D=3D osd.142 =3D=3D=3D
osd.142: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.36 =3D=3D=3D
osd.36: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.83 =3D=3D=3D
osd.83: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.107 =3D=3D=3D
osd.107: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.47 =3D=3D=3D
osd.47: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.130 =3D=3D=3D
osd.130: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.155 =3D=3D=3D
osd.155: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.60 =3D=3D=3D
osd.60: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.118 =3D=3D=3D
osd.118: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.98 =3D=3D=3D
osd.98: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D osd.70 =3D=3D=3D
osd.70: running {"version":"0.80-475-g9e80c29"}
=3D=3D=3D mon.storage0114-ib =3D=3D=3D
mon.storage0114-ib: running {"version":"0.80-475-g9e80c29"}
[root@storage0114-ib ~]#

		=97 But ceph osd tree says , osd.118  is down

-10	29.93		host storage0114-ib
36	2.63			osd.36	up	1
47	2.73			osd.47	up	1
60	2.73			osd.60	up	1
70	2.73			osd.70	up	1
83	2.73			osd.83	up	1
98	2.73			osd.98	up	1
107	2.73			osd.107	up	1
118	2.73			osd.118	down	1
130	2.73			osd.130	up	1
142	2.73			osd.142	up	1
155	2.73			osd.155	up	1

=97 I restarted osd.118 service and it was successful , But still its =
showing as down in ceph osd tree . I waited for 30 minutes to get it =
stable but still not showing UP in ceph osd tree.=20
Moreover its generating HUGE logs http://pastebin.com/mDYnjAni



The problem now is if i manually visit every host and check for =93service=
 ceph status =93 all services are running on all 15 hosts. But this is =
not getting reflected to ceph osd tree and ceph -s and they continue to =
show as OSD DOWN.

My irc id is ksingh , let me know by email once you are available on IRC =
(my time zone is Finland +2)



- Karan Singh -=20

On 20 May 2014, at 18:18, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, 20 May 2014, Karan Singh wrote:
>> Hello Cephers , need your suggestion for troubleshooting.
>>=20
>> My cluster is terribly struggling , 70+ osd are down out of 165
>>=20
>> Problem ?>OSD are getting marked out of cluster and are down. The =
cluster is
>> degraded. On checking logs of failed OSD we are getting wired entries =
that
>> are continuously getting generated.
>=20
> Tracking this at http://tracker.ceph.com/issues/8387
>=20
> The most recent bits you posted in the ticket don't quite make sense: =
the=20
> OSD is trying to connect to an address for an OSD that is currently =
marked=20
> down.  I suspect this is just timing between when the logs were =
captured=20
> and when teh ceph osd dump was captured.  To get a complete pictures,=20=

> please:
>=20
> 1) add
>=20
> debug osd =3D 20
> debug ms =3D 1
>=20
> in [osd] and restart all osds
>=20
> 2) ceph osd set nodown
>=20
> (to prevent flapping)
>=20
> 3) find some OSD that is showing these messages
>=20
> 4) capture a 'ceph osd dump' output.
>=20
> Also happy to debug this interactively over IRC; that will likely be=20=

> faster!
>=20
> Thanks-
> sage
>=20
>=20
>=20
>>=20
>> Osd Debug logs ::  http://pastebin.com/agTKh6zB
>>=20
>>=20
>> 1. 2014-05-20 10:19:03.699886 7f2328e237a0  0 osd.158 357532 done =
with
>>    init, starting boot process
>> 2. 2014-05-20 10:19:03.700093 7f22ff621700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 =
pgs=3D0 cs=3D0
>>    l=3D0 c=3D0x83018c0).connect claims to be 192.168.1.109:6802/63896 =
not
>>    192.168.1.109:6802/910005982 - wrong node!
>> 3. 2014-05-20 10:19:03.700152 7f22ff621700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 =
pgs=3D0 cs=3D0
>>    l=3D0 c=3D0x83018c0).fault with nothing to send, going to standby
>> 4. 2014-05-20 10:19:09.551269 7f22fdd12700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 =
pgs=3D0 cs=3D0
>>    l=3D0 c=3D0x533fd20).connect claims to be 192.168.1.109:6803/63896 =
not
>>    192.168.1.109:6803/1176009454 - wrong node!
>> 5. 2014-05-20 10:19:09.551347 7f22fdd12700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 =
pgs=3D0 cs=3D0
>>    l=3D0 c=3D0x533fd20).fault with nothing to send, going to standby
>> 6. 2014-05-20 10:19:09.703901 7f22fd80d700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 :42889 s=3D1 =
pgs=3D0 cs=3D0 l=3D0
>>    c=3D0x8302aa0).connect claims to be 192.168.1.113:6802/24612 not
>>    192.168.1.113:6802/13870 - wrong node!
>> 7. 2014-05-20 10:19:09.704039 7f22fd80d700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 :42889 s=3D1 =
pgs=3D0 cs=3D0 l=3D0
>>    c=3D0x8302aa0).fault with nothing to send, going to standby
>> 8. 2014-05-20 10:19:10.243139 7f22fd005700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 =
pgs=3D0 cs=3D0 l=3D0
>>    c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 not
>>    192.168.1.112:6800/14114 - wrong node!
>> 9. 2014-05-20 10:19:10.243190 7f22fd005700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 =
pgs=3D0 cs=3D0 l=3D0
>>    c=3D0x8304780).fault with nothing to send, going to standby
>> 10. 2014-05-20 10:19:10.349693 7f22fc7fd700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 =
cs=3D0 l=3D0
>>    c=3D0x83070c0).fault with nothing to send, going to standby
>>=20
>>=20
>> 1. ceph -v
>>    ceph version 0.80-469-g991f7f1
>>    (991f7f15a6e107b33a24bbef1169f21eb7fcce2c) #
>> 1. ceph osd stat
>>    osdmap e357073: 165 osds: 91 up, 165 in
>>    flags noout #
>>=20
>> I have tried doing :
>>=20
>> 1. Restarting the problematic OSDs , but no luck
>> 2.  i restarted entire host but no luck, still osds are down and =
getting the
>> same mesage
>>=20
>> 1. 2014-05-20 10:19:10.243139 7f22fd005700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 =
pgs=3D0 cs=3D0 l=3D0
>>    c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 not
>>    192.168.1.112:6800/14114 - wrong node!
>> 2. 2014-05-20 10:19:10.243190 7f22fd005700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 =
pgs=3D0 cs=3D0 l=3D0
>>    c=3D0x8304780).fault with nothing to send, going to standby
>> 3. 2014-05-20 10:19:10.349693 7f22fc7fd700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 =
cs=3D0 l=3D0
>>    c=3D0x83070c0).fault with nothing to send, going to standby
>> 4. 2014-05-20 10:22:23.312473 7f2307e61700  0 osd.158 357781 =
do_command r=3D0
>> 5. 2014-05-20 10:22:23.326110 7f2307e61700  0 osd.158 357781 =
do_command r=3D0
>>    debug_osd=3D0/5
>> 6. 2014-05-20 10:22:23.326123 7f2307e61700  0 log [INF] : =
debug_osd=3D0/5
>> 7. 2014-05-20 10:34:08.161864 7f230224d700  0 -- =
192.168.1.112:6802/3807 >>
>>    192.168.1.102:6808/13276 pipe(0x8698280 sd=3D22 :41078 s=3D2 =
pgs=3D603 cs=3D1
>>    l=3D0 c=3D0x8301600).fault with nothing to send, going to standby
>>=20
>> 3. Disks do not have errors , no message in dmesg and =
/var/log/messages
>>=20
>> 4. there was a bug in the past http://tracker.ceph.com/issues/4006 , =
dont
>> know it again came bacin in Firefly
>>=20
>> 5. Recently no activity performed on cluster , except some pool and =
keys
>> creation for cinder /glance integration
>>=20
>> 6. Nodes have enough free resources for osds.
>>=20
>> 7. No issues with network , osds are down on all cluster nodes. not =
from a
>> single node.
>>=20
>>=20
>> ****************************************************************
>> Karan Singh=20
>> Systems Specialist , Storage Platforms
>> CSC - IT Center for Science,
>> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
>> mobile: +358 503 812758
>> tel. +358 9 4572001
>> fax +358 9 4572302
>> http://www.csc.fi/
>> ****************************************************************
>>=20
>>=20


--Apple-Mail=_3BE6E7BB-E58E-4B23-A2F7-5C1948B1BB7A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Hello Sage</div><div><br></div><div><ul =
class=3D"MailOutline"><li>nodown, noout set on =
cluster</li></ul></div><div><br></div><div><div># ceph =
status</div><div>&nbsp; &nbsp; cluster =
009d3518-e60d-4f74-a26d-c08c1976263c</div><div>&nbsp; &nbsp; =
&nbsp;health HEALTH_WARN 1133 pgs degraded; 44 pgs incomplete; 42 pgs =
stale; 45 pgs stuck inactive; 42 pgs stuck stale; 2602 pgs stuck =
unclean; recovery 206/2199 objects degraded (9.368%); 40/165 in osds are =
down; nodown,noout flag(s) set</div><div>&nbsp; &nbsp; &nbsp;monmap e4: =
4 mons at =
{storage0101-ib=3D192.168.100.101:6789/0,storage0110-ib=3D192.168.100.110:=
6789/0,storage0114-ib=3D192.168.100.114:6789/0,storage0115-ib=3D192.168.10=
0.115:6789/0}, election epoch 18, quorum 0,1,2,3 =
storage0101-ib,storage0110-ib,storage0114-ib,storage0115-ib</div><div>&nbs=
p; &nbsp; &nbsp;osdmap e358031: 165 osds: 125 up, 165 =
in</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b> flags =
nodown,noout</b></div><div>&nbsp; &nbsp; &nbsp; pgmap v604305: 4544 pgs, =
6 pools, 4309 MB data, 733 objects</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 3582 GB used, 357 TB / 361 TB avail</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 206/2199 objects degraded =
(9.368%)</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;1 inactive</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;5 =
stale+active+degraded+remapped</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 1931 active+clean</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2 =
stale+incomplete</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 21 stale+active+remapped</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;380 =
active+degraded+remapped</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 38 incomplete</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1403 active+remapped</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2 =
stale+active+degraded</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1 =
stale+remapped+incomplete</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;746 active+degraded</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 11 =
stale+active+clean</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;3 =
remapped+incomplete</div><div><br></div></div><div><br></div><div><ul =
class=3D"MailOutline"><li>&nbsp;Here is my ceph.conf &nbsp;<a =
href=3D"http://pastebin.com/KZdgPJm7">http://pastebin.com/KZdgPJm7</a>&nbs=
p; (debus osd , ms set )</li><li>I tried restarting all OSD services of =
&nbsp;node-13 , services came up after several attempts of =93service =
ceph restart=94 &nbsp;&nbsp;<a =
href=3D"http://pastebin.com/yMk86YHh">http://pastebin.com/yMk86YHh</a></li=
><li>For Node : 14</li><ul><li>All services are =
up</li></ul></ul><div><br></div><div><div>[root@storage0114-ib ~]# =
service ceph status</div><div>=3D=3D=3D osd.142 =3D=3D=3D</div><div>osd.14=
2: running {"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.36 =
=3D=3D=3D</div><div>osd.36: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.83 =
=3D=3D=3D</div><div>osd.83: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.107 =
=3D=3D=3D</div><div>osd.107: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.47 =
=3D=3D=3D</div><div>osd.47: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.130 =
=3D=3D=3D</div><div>osd.130: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.155 =
=3D=3D=3D</div><div>osd.155: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.60 =
=3D=3D=3D</div><div>osd.60: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.118 =
=3D=3D=3D</div><div>osd.118: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.98 =
=3D=3D=3D</div><div>osd.98: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D osd.70 =
=3D=3D=3D</div><div>osd.70: running =
{"version":"0.80-475-g9e80c29"}</div><div>=3D=3D=3D mon.storage0114-ib =
=3D=3D=3D</div><div>mon.storage0114-ib: running =
{"version":"0.80-475-g9e80c29"}</div><div>[root@storage0114-ib =
~]#</div></div></div><div><br></div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>=97 But ceph osd tree =
says , osd.118 &nbsp;is down</div><div><br></div><div><div>-10<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>29.93<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>host storage0114-ib</div><div>36<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.63<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.36<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>47<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.47<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>60<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.60<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>70<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.70<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>83<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.83<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>98<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.98<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>107<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.107<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>118<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.118<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>down<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>130<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.130<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>142<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.142<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div><div>155<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2.73<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>osd.155<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>up<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1</div></div><div><br></div><div>=97 I restarted osd.118 service =
and it was successful , But still its showing as down in ceph osd tree . =
I waited for 30 minutes to get it stable but still not showing UP in =
ceph osd tree.&nbsp;</div><div>Moreover its generating HUGE logs&nbsp;<a =
href=3D"http://pastebin.com/mDYnjAni">http://pastebin.com/mDYnjAni</a></di=
v><div><br></div><div><br></div><div><br></div><div>The problem now is =
if i manually visit every host and check for =93service ceph status =93 =
all services are running on all 15 hosts. But this is not getting =
reflected to ceph osd tree and ceph -s and they continue to show as OSD =
DOWN.</div><div><br></div><div>My irc id is ksingh , let me know by =
email once you are available on IRC (my time zone is Finland =
+2)</div><div><br></div><br><div apple-content-edited=3D"true">
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
class=3D"Apple-interchange-newline">- Karan Singh =
-&nbsp;</div></div></div>
</div>
<br><div><div>On 20 May 2014, at 18:18, Sage Weil &lt;<a =
href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">On Tue, 20 May 2014, Karan Singh wrote:<br><blockquote =
type=3D"cite">Hello Cephers , need your suggestion for =
troubleshooting.<br><br>My cluster is terribly struggling , 70+ osd are =
down out of 165<br><br>Problem ?&gt;OSD are getting marked out of =
cluster and are down. The cluster is<br>degraded. On checking logs of =
failed OSD we are getting wired entries that<br>are continuously getting =
generated.<br></blockquote><br>Tracking this at <a =
href=3D"http://tracker.ceph.com/issues/8387">http://tracker.ceph.com/issue=
s/8387</a><br><br>The most recent bits you posted in the ticket don't =
quite make sense: the <br>OSD is trying to connect to an address for an =
OSD that is currently marked <br>down. &nbsp;I suspect this is just =
timing between when the logs were captured <br>and when teh ceph osd =
dump was captured. &nbsp;To get a complete pictures, =
<br>please:<br><br>1) add<br><br> debug osd =3D 20<br> debug ms =3D =
1<br><br>in [osd] and restart all osds<br><br>2) ceph osd set =
nodown<br><br>(to prevent flapping)<br><br>3) find some OSD that is =
showing these messages<br><br>4) capture a 'ceph osd dump' =
output.<br><br>Also happy to debug this interactively over IRC; that =
will likely be =
<br>faster!<br><br>Thanks-<br>sage<br><br><br><br><blockquote =
type=3D"cite"><br>Osd Debug logs :: &nbsp;<a =
href=3D"http://pastebin.com/agTKh6zB">http://pastebin.com/agTKh6zB</a><br>=
<br><br> 1. 2014-05-20 10:19:03.699886 7f2328e237a0 &nbsp;0 osd.158 =
357532 done with<br> &nbsp;&nbsp;&nbsp;init, starting boot process<br> =
2. 2014-05-20 10:19:03.700093 7f22ff621700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 =
:33500 s=3D1 pgs=3D0 cs=3D0<br> &nbsp;&nbsp;&nbsp;l=3D0 =
c=3D0x83018c0).connect claims to be 192.168.1.109:6802/63896 not<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6802/910005982 - wrong node!<br> 3. =
2014-05-20 10:19:03.700152 7f22ff621700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 =
:33500 s=3D1 pgs=3D0 cs=3D0<br> &nbsp;&nbsp;&nbsp;l=3D0 =
c=3D0x83018c0).fault with nothing to send, going to standby<br> 4. =
2014-05-20 10:19:09.551269 7f22fdd12700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 =
:40060 s=3D1 pgs=3D0 cs=3D0<br> &nbsp;&nbsp;&nbsp;l=3D0 =
c=3D0x533fd20).connect claims to be 192.168.1.109:6803/63896 not<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6803/1176009454 - wrong node!<br> 5. =
2014-05-20 10:19:09.551347 7f22fdd12700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 =
:40060 s=3D1 pgs=3D0 cs=3D0<br> &nbsp;&nbsp;&nbsp;l=3D0 =
c=3D0x533fd20).fault with nothing to send, going to standby<br> 6. =
2014-05-20 10:19:09.703901 7f22fd80d700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 =
:42889 s=3D1 pgs=3D0 cs=3D0 l=3D0<br> =
&nbsp;&nbsp;&nbsp;c=3D0x8302aa0).connect claims to be =
192.168.1.113:6802/24612 not<br> =
&nbsp;&nbsp;&nbsp;192.168.1.113:6802/13870 - wrong node!<br> 7. =
2014-05-20 10:19:09.704039 7f22fd80d700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 =
:42889 s=3D1 pgs=3D0 cs=3D0 l=3D0<br> =
&nbsp;&nbsp;&nbsp;c=3D0x8302aa0).fault with nothing to send, going to =
standby<br> 8. 2014-05-20 10:19:10.243139 7f22fd005700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 =
:43726 s=3D1 pgs=3D0 cs=3D0 l=3D0<br> =
&nbsp;&nbsp;&nbsp;c=3D0x8304780).connect claims to be =
192.168.1.112:6800/2852 not<br> =
&nbsp;&nbsp;&nbsp;192.168.1.112:6800/14114 - wrong node!<br> 9. =
2014-05-20 10:19:10.243190 7f22fd005700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 =
:43726 s=3D1 pgs=3D0 cs=3D0 l=3D0<br> =
&nbsp;&nbsp;&nbsp;c=3D0x8304780).fault with nothing to send, going to =
standby<br>10. 2014-05-20 10:19:10.349693 7f22fc7fd700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 =
s=3D1 pgs=3D0 cs=3D0 l=3D0<br> &nbsp;&nbsp;&nbsp;c=3D0x83070c0).fault =
with nothing to send, going to standby<br><br><br> 1. ceph -v<br> =
&nbsp;&nbsp;&nbsp;ceph version 0.80-469-g991f7f1<br> =
&nbsp;&nbsp;&nbsp;(991f7f15a6e107b33a24bbef1169f21eb7fcce2c) #<br> 1. =
ceph osd stat<br> &nbsp;&nbsp;&nbsp;osdmap e357073: 165 osds: 91 up, 165 =
in<br> &nbsp;&nbsp;&nbsp;flags noout #<br><br>I have tried doing =
:<br><br>1. Restarting the problematic OSDs , but no luck<br>2. &nbsp;i =
restarted entire host but no luck, still osds are down and getting =
the<br>same mesage<br><br> 1. 2014-05-20 10:19:10.243139 7f22fd005700 =
&nbsp;0 -- 192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 =
:43726 s=3D1 pgs=3D0 cs=3D0 l=3D0<br> =
&nbsp;&nbsp;&nbsp;c=3D0x8304780).connect claims to be =
192.168.1.112:6800/2852 not<br> =
&nbsp;&nbsp;&nbsp;192.168.1.112:6800/14114 - wrong node!<br> 2. =
2014-05-20 10:19:10.243190 7f22fd005700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 =
:43726 s=3D1 pgs=3D0 cs=3D0 l=3D0<br> =
&nbsp;&nbsp;&nbsp;c=3D0x8304780).fault with nothing to send, going to =
standby<br> 3. 2014-05-20 10:19:10.349693 7f22fc7fd700 &nbsp;0 -- =
192.168.1.112:6802/3807 &gt;&gt;<br> =
&nbsp;&nbsp;&nbsp;192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 =
s=3D1 pgs=3D0 cs=3D0 l=3D0<br> &nbsp;&nbsp;&nbsp;c=3D0x83070c0).fault =
with nothing to send, going to standby<br> 4. 2014-05-20 10:22:23.312473 =
7f2307e61700 &nbsp;0 osd.158 357781 do_command r=3D0<br> 5. 2014-05-20 =
10:22:23.326110 7f2307e61700 &nbsp;0 osd.158 357781 do_command r=3D0<br> =
&nbsp;&nbsp;&nbsp;debug_osd=3D0/5<br> 6. 2014-05-20 10:22:23.326123 =
7f2307e61700 &nbsp;0 log [INF] : debug_osd=3D0/5<br> 7. 2014-05-20 =
10:34:08.161864 7f230224d700 &nbsp;0 -- 192.168.1.112:6802/3807 =
&gt;&gt;<br> &nbsp;&nbsp;&nbsp;192.168.1.102:6808/13276 pipe(0x8698280 =
sd=3D22 :41078 s=3D2 pgs=3D603 cs=3D1<br> &nbsp;&nbsp;&nbsp;l=3D0 =
c=3D0x8301600).fault with nothing to send, going to standby<br><br>3. =
Disks do not have errors , no message in dmesg and =
/var/log/messages<br><br>4. there was a bug in the past&nbsp;<a =
href=3D"http://tracker.ceph.com/issues/4006">http://tracker.ceph.com/issue=
s/4006</a>&nbsp;, dont<br>know it again came bacin in Firefly<br><br>5. =
Recently no activity performed on cluster , except some pool and =
keys<br>creation for cinder /glance integration<br><br>6. Nodes have =
enough free resources for osds.<br><br>7. No issues with network , osds =
are down on all cluster nodes. not from a<br>single =
node.<br><br><br>*********************************************************=
*******<br>Karan Singh&nbsp;<br>Systems Specialist ,&nbsp;Storage =
Platforms<br>CSC - IT Center for Science,<br>Keilaranta 14, P. O. Box =
405, FIN-02101 Espoo, Finland<br>mobile: +358 503 812758<br>tel. +358 9 =
4572001<br>fax +358 9 4572302<br><a =
href=3D"http://www.csc.fi/">http://www.csc.fi/</a><br>********************=
********************************************<br><br><br></blockquote></blo=
ckquote></div><br></body></html>=

--Apple-Mail=_3BE6E7BB-E58E-4B23-A2F7-5C1948B1BB7A--

--===============0811789534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0811789534==--

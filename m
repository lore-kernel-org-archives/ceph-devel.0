From: min fang <louisfang2013-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: can not create rbd image
Date: Thu, 12 Nov 2015 23:05:34 +0800
Message-ID: <CAO9PA9=nKTRyCMH8ReibUmOhOvqMG80A6Fi2ydj1+uQOoQ_GAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0626184000=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0626184000==
Content-Type: multipart/alternative; boundary=001a11c3229c599df305245946fa

--001a11c3229c599df305245946fa
Content-Type: text/plain; charset=UTF-8

Hi cepher, I tried to use the following command to create a img, but
unfortunately, the command hung for a long time until I broken it by
crtl-z.

rbd -p hello create img-003 --size 512

so I checked the cluster status, and showed:

    cluster 0379cebd-b546-4954-b5d6-e13d08b7d2f1
     health HEALTH_WARN
            2 near full osd(s)
            too many PGs per OSD (320 > max 300)
     monmap e2: 1 mons at {vl=192.168.90.253:6789/0}
            election epoch 1, quorum 0 vl
     osdmap e37: 2 osds: 2 up, 2 in
      pgmap v19544: 320 pgs, 3 pools, 12054 MB data, 3588 objects
            657 GB used, 21867 MB / 714 GB avail
                 320 active+clean

I did not see error message here could cause rbd create hang.

I opened the client log and see:

2015-11-12 22:52:44.687491 7f89eced9780 20 librbd: create 0x7fff8f7b7800
name = img-003 size = 536870912 old_format = 1 features = 0 order = 22
stripe_unit = 0 stripe_count = 0
2015-11-12 22:52:44.687653 7f89eced9780  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6800/5472 -- osd_op(client.34321.0:1 img-003.rbd [stat]
2.8a047315 ack+read+known_if_redirected e37) v5 -- ?+0 0x28513d0 con
0x2850000
2015-11-12 22:52:44.688928 7f89e066b700  1 -- 192.168.90.253:0/1006121 <==
osd.1 192.168.90.253:6800/5472 1 ==== osd_op_reply(1 img-003.rbd [stat]
v0'0 uv0 ack = -2 ((2) No such file or directory)) v6 ==== 178+0+0
(3550830125 0 0) 0x7f89c0000ae0 con 0x2850000
2015-11-12 22:52:44.689090 7f89eced9780  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- osd_op(client.34321.0:2 rbd_id.img-003 [stat]
2.638c75a8 ack+read+known_if_redirected e37) v5 -- ?+0 0x2858330 con
0x2856f50
2015-11-12 22:52:44.690425 7f89e0469700  1 -- 192.168.90.253:0/1006121 <==
osd.0 192.168.90.253:6801/5344 1 ==== osd_op_reply(2 rbd_id.img-003 [stat]
v0'0 uv0 ack = -2 ((2) No such file or directory)) v6 ==== 181+0+0
(1202435393 0 0) 0x7f89b8000ae0 con 0x2856f50
2015-11-12 22:52:44.690494 7f89eced9780  2 librbd: adding rbd image to
directory...
2015-11-12 22:52:44.690544 7f89eced9780  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- osd_op(client.34321.0:3 rbd_directory [tmapup
0~0] 2.30a98c1c ondisk+write+known_if_redirected e37) v5 -- ?+0 0x2858920
con 0x2856f50
2015-11-12 22:52:59.687447 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6789/0 -- mon_subscribe({monmap=3+,osdmap=38}) v2 -- ?+0
0x7f89b0000ab0 con 0x2843b90
2015-11-12 22:52:59.687472 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000f40 con
0x2856f50
2015-11-12 22:52:59.687887 7f89e3873700  1 -- 192.168.90.253:0/1006121 <==
mon.0 192.168.90.253:6789/0 11 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(2867606018 0 0) 0x7f89d8001160 con 0x2843b90
2015-11-12 22:53:04.687593 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:09.687731 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:14.687844 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:19.687978 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:24.688116 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:29.688253 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:34.688389 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:39.688512 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50
2015-11-12 22:53:44.688636 7f89e4074700  1 -- 192.168.90.253:0/1006121 -->
192.168.90.253:6801/5344 -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con
0x2856f50


Looks to me, we are keeping ping magic process, and no completed.

my ceph version is "ceph version 0.94.5
(9764da52395923e0b32908d83a9f7304401fee43)"

somebody can help me on this? Or still me to collect more debug information
for analyzing.

Thanks.

--001a11c3229c599df305245946fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi cepher, I tried to u=
se the following command to create a img, but unfortunately, the command hu=
ng for a long time until I broken it by crtl-z.=C2=A0 <br><br>rbd -p hello =
create img-003 --size 512<br><br></div>so I checked the cluster status, and=
 showed:<br><br>=C2=A0=C2=A0=C2=A0 cluster 0379cebd-b546-4954-b5d6-e13d08b7=
d2f1<br>=C2=A0=C2=A0=C2=A0=C2=A0 health HEALTH_WARN<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 near full osd(s)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 too many PG=
s per OSD (320 &gt; max 300)<br>=C2=A0=C2=A0=C2=A0=C2=A0 monmap e2: 1 mons =
at {vl=3D<a href=3D"http://192.168.90.253:6789/0">192.168.90.253:6789/0</a>=
}<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ele=
ction epoch 1, quorum 0 vl<br>=C2=A0=C2=A0=C2=A0=C2=A0 osdmap e37: 2 osds: =
2 up, 2 in<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgmap v19544: 320 pgs, 3 pools=
, 12054 MB data, 3588 objects<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 657 GB used, 21867 MB / 714 GB avail<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 320 active+clean<br><br></div>I did not see error message here=
 could cause rbd create hang. <br><br></div>I opened the client log and see=
:<br><br>2015-11-12 22:52:44.687491 7f89eced9780 20 librbd: create 0x7fff8f=
7b7800 name =3D img-003 size =3D 536870912 old_format =3D 1 features =3D 0 =
order =3D 22 stripe_unit =3D 0 stripe_count =3D 0<br>2015-11-12 22:52:44.68=
7653 7f89eced9780=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">19=
2.168.90.253:0/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6800/547=
2">192.168.90.253:6800/5472</a> -- osd_op(client.34321.0:1 img-003.rbd [sta=
t] 2.8a047315 ack+read+known_if_redirected e37) v5 -- ?+0 0x28513d0 con 0x2=
850000<br>2015-11-12 22:52:44.688928 7f89e066b700=C2=A0 1 -- <a href=3D"htt=
p://192.168.90.253:0/1006121">192.168.90.253:0/1006121</a> &lt;=3D=3D osd.1=
 <a href=3D"http://192.168.90.253:6800/5472">192.168.90.253:6800/5472</a> 1=
 =3D=3D=3D=3D osd_op_reply(1 img-003.rbd [stat] v0&#39;0 uv0 ack =3D -2 ((2=
) No such file or directory)) v6 =3D=3D=3D=3D 178+0+0 (3550830125 0 0) 0x7f=
89c0000ae0 con 0x2850000<br>2015-11-12 22:52:44.689090 7f89eced9780=C2=A0 1=
 -- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.253:0/1006121</a=
> --&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168.90.253:6801/53=
44</a> -- osd_op(client.34321.0:2 rbd_id.img-003 [stat] 2.638c75a8 ack+read=
+known_if_redirected e37) v5 -- ?+0 0x2858330 con 0x2856f50<br>2015-11-12 2=
2:52:44.690425 7f89e0469700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1=
006121">192.168.90.253:0/1006121</a> &lt;=3D=3D osd.0 <a href=3D"http://192=
.168.90.253:6801/5344">192.168.90.253:6801/5344</a> 1 =3D=3D=3D=3D osd_op_r=
eply(2 rbd_id.img-003 [stat] v0&#39;0 uv0 ack =3D -2 ((2) No such file or d=
irectory)) v6 =3D=3D=3D=3D 181+0+0 (1202435393 0 0) 0x7f89b8000ae0 con 0x28=
56f50<br>2015-11-12 22:52:44.690494 7f89eced9780=C2=A0 2 librbd: adding rbd=
 image to directory...<br>2015-11-12 22:52:44.690544 7f89eced9780=C2=A0 1 -=
- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.253:0/1006121</a> =
--&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168.90.253:6801/5344=
</a> -- osd_op(client.34321.0:3 rbd_directory [tmapup 0~0] 2.30a98c1c ondis=
k+write+known_if_redirected e37) v5 -- ?+0 0x2858920 con 0x2856f50<br>2015-=
11-12 22:52:59.687447 7f89e4074700=C2=A0 1 -- <a href=3D"http://192.168.90.=
253:0/1006121">192.168.90.253:0/1006121</a> --&gt; <a href=3D"http://192.16=
8.90.253:6789/0">192.168.90.253:6789/0</a> -- mon_subscribe({monmap=3D3+,os=
dmap=3D38}) v2 -- ?+0 0x7f89b0000ab0 con 0x2843b90<br>2015-11-12 22:52:59.6=
87472 7f89e4074700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">1=
92.168.90.253:0/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6801/53=
44">192.168.90.253:6801/5344</a> -- ping magic: 0 v1 -- ?+0 0x7f89b0000f40 =
con 0x2856f50<br>2015-11-12 22:52:59.687887 7f89e3873700=C2=A0 1 -- <a href=
=3D"http://192.168.90.253:0/1006121">192.168.90.253:0/1006121</a> &lt;=3D=
=3D mon.0 <a href=3D"http://192.168.90.253:6789/0">192.168.90.253:6789/0</a=
> 11 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (286760601=
8 0 0) 0x7f89d8001160 con 0x2843b90<br>2015-11-12 22:53:04.687593 7f89e4074=
700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.253:0=
/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168.90.=
253:6801/5344</a> -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con 0x2856f50<b=
r>2015-11-12 22:53:09.687731 7f89e4074700=C2=A0 1 -- <a href=3D"http://192.=
168.90.253:0/1006121">192.168.90.253:0/1006121</a> --&gt; <a href=3D"http:/=
/192.168.90.253:6801/5344">192.168.90.253:6801/5344</a> -- ping magic: 0 v1=
 -- ?+0 0x7f89b0000ab0 con 0x2856f50<br>2015-11-12 22:53:14.687844 7f89e407=
4700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.253:=
0/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168.90=
.253:6801/5344</a> -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con 0x2856f50<=
br>2015-11-12 22:53:19.687978 7f89e4074700=C2=A0 1 -- <a href=3D"http://192=
.168.90.253:0/1006121">192.168.90.253:0/1006121</a> --&gt; <a href=3D"http:=
//192.168.90.253:6801/5344">192.168.90.253:6801/5344</a> -- ping magic: 0 v=
1 -- ?+0 0x7f89b0000ab0 con 0x2856f50<br>2015-11-12 22:53:24.688116 7f89e40=
74700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.253=
:0/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168.9=
0.253:6801/5344</a> -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con 0x2856f50=
<br>2015-11-12 22:53:29.688253 7f89e4074700=C2=A0 1 -- <a href=3D"http://19=
2.168.90.253:0/1006121">192.168.90.253:0/1006121</a> --&gt; <a href=3D"http=
://192.168.90.253:6801/5344">192.168.90.253:6801/5344</a> -- ping magic: 0 =
v1 -- ?+0 0x7f89b0000ab0 con 0x2856f50<br>2015-11-12 22:53:34.688389 7f89e4=
074700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.25=
3:0/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168.=
90.253:6801/5344</a> -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con 0x2856f5=
0<br>2015-11-12 22:53:39.688512 7f89e4074700=C2=A0 1 -- <a href=3D"http://1=
92.168.90.253:0/1006121">192.168.90.253:0/1006121</a> --&gt; <a href=3D"htt=
p://192.168.90.253:6801/5344">192.168.90.253:6801/5344</a> -- ping magic: 0=
 v1 -- ?+0 0x7f89b0000ab0 con 0x2856f50<br>2015-11-12 22:53:44.688636 7f89e=
4074700=C2=A0 1 -- <a href=3D"http://192.168.90.253:0/1006121">192.168.90.2=
53:0/1006121</a> --&gt; <a href=3D"http://192.168.90.253:6801/5344">192.168=
.90.253:6801/5344</a> -- ping magic: 0 v1 -- ?+0 0x7f89b0000ab0 con 0x2856f=
50<br><br><br></div>Looks to me, we are keeping ping magic process, and no =
completed. <br><br></div>my ceph version is &quot;ceph version 0.94.5 (9764=
da52395923e0b32908d83a9f7304401fee43)&quot;<br><br></div>somebody can help =
me on this? Or still me to collect more debug information for analyzing. <b=
r><br></div>Thanks.<br><div><div><div><br><br></div></div></div></div>

--001a11c3229c599df305245946fa--

--===============0626184000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0626184000==--

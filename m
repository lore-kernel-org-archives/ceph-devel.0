From: lin zhou <hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: object unfound before backfill
Date: Mon, 21 Mar 2016 16:13:41 +0800
Message-ID: <CAKO+7k0W4iO8=EnkFxBRtWhQ8iPMyn7pNj2wPV71aLj000qKUQ@mail.gmail.com>
References: <CAKO+7k0iobAVpMwpu21VEhqtk=3eWf1+5Q4rKOvjt4gui9NCNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1014650794=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKO+7k0iobAVpMwpu21VEhqtk=3eWf1+5Q4rKOvjt4gui9NCNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1014650794==
Content-Type: multipart/alternative; boundary=001a113d21c4b35e97052e8aaca7

--001a113d21c4b35e97052e8aaca7
Content-Type: text/plain; charset=UTF-8

Hi,guys

my cluster face a network problem so it occur some error.after solve
network problem.

latency of some osds in one node is high,using ceph osd perf,which come to
3000+

so I delete this osd from cluster,keep osd data device.
after recover and backfill,then I face the problem describe in title.ceph
health detail is :

pg 4.438 is active+recovering+degraded+remapped, acting [7,11], 1 unfound
pg 4.438 is stuck unclean for 135368.626141, current state
active+recovering+degraded+remapped, last acting [7,11]
recovery 1062/4842087 objects degraded (0.022%); 1/2028378 unfound (0.000%)

root@node-67:~# ceph pg map 4.438
osdmap e42522 pg 4.438 (4.438) -> up [34,20,30] acting [7,11]

I can  see the pg data in deleted osd.6,which have some different with the
existing osd.7 and osd.11
can I copy the pg data to the new up set? ignore acting set?

some info is below,the output of pg query is the attachment.


root@node-67:~# ceph pg 4.438 list_missing
{ "offset": { "oid": "",
      "key": "",
      "snapid": 0,
      "hash": 0,
      "max": 0,
      "pool": -1,
      "namespace": ""},
  "num_missing": 1,
  "num_unfound": 1,
  "objects": [
        { "oid": { "oid": "rbd_data.188b9163c78e9.00000000000015f2",
              "key": "",
              "snapid": -2,
              "hash": 2427198520,
              "max": 0,
              "pool": 4,
              "namespace": ""},
          "need": "39188'2314230",
          "have": "39174'2314229",
          "locations": []}],

rootceph pg 4.438 mark_unfound_lost revert
Error EINVAL: pg has 1 unfound objects but we haven't probed all sources,
not marking lost

root@node-67:~# ceph pg 4.438 mark_unfound_lost delete
Error EINVAL: pg has 1 unfound objects but we haven't probed all sources,
not marking lost

pg query output is :
https://drive.google.com/file/d/0B08hG89CXoPbb2p0ZFc2OGRRQmpkcGVuZnoxNFJnQS05UDlv/view
-------------------------
hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <hnuzhoulin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--001a113d21c4b35e97052e8aaca7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">Hi,guys<br><br=
>my cluster face a network problem so it occur some error.after solve netwo=
rk problem.<br><br>latency of some osds in one node is high,using ceph osd =
perf,which come to 3000+<br><br>so I delete this osd from cluster,keep osd =
data device.<br>after recover and backfill,then I face the problem describe=
 in title.ceph health detail is :<br><br>pg 4.438 is active+recovering+degr=
aded+remapped, acting [7,11], 1 unfound<br>pg 4.438 is stuck unclean for 13=
5368.626141, current state active+recovering+degraded+remapped, last acting=
 [7,11]<br>recovery 1062/4842087 objects degraded (0.022%); 1/2028378 unfou=
nd (0.000%)<br><br>root@node-67:~# ceph pg map 4.438<br>osdmap e42522 pg 4.=
438 (4.438) -&gt; up [34,20,30] acting [7,11]<br><br>I can=C2=A0 see the pg=
 data in deleted osd.6,which have some different with the existing osd.7 an=
d osd.11<br>can I copy the pg data to the new up set? ignore acting set?<br=
><br>some info is below,the output of pg query is the attachment.<br><br><b=
r>root@node-67:~# ceph pg 4.438 list_missing<br>{ &quot;offset&quot;: { &qu=
ot;oid&quot;: &quot;&quot;,<br>=C2=A0 =C2=A0 =C2=A0 &quot;key&quot;: &quot;=
&quot;,<br>=C2=A0 =C2=A0 =C2=A0 &quot;snapid&quot;: 0,<br>=C2=A0 =C2=A0 =C2=
=A0 &quot;hash&quot;: 0,<br>=C2=A0 =C2=A0 =C2=A0 &quot;max&quot;: 0,<br>=C2=
=A0 =C2=A0 =C2=A0 &quot;pool&quot;: -1,<br>=C2=A0 =C2=A0 =C2=A0 &quot;names=
pace&quot;: &quot;&quot;},<br>=C2=A0 &quot;num_missing&quot;: 1,<br>=C2=A0 =
&quot;num_unfound&quot;: 1,<br>=C2=A0 &quot;objects&quot;: [<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 { &quot;oid&quot;: { &quot;oid&quot;: &quot;rbd_data.188b=
9163c78e9.00000000000015f2&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;key&quot;: &quot;&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;snapid&quot;: -2,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;hash&quot;: 2427198520,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max&quot;: 0,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pool&quot;: 4,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;namespace&quot;: &quot;&quot;},<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;need&quot;: &quot;39188&#39;2314230&quot=
;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;have&quot;: &quot;39174&#39;=
2314229&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;locations&quot;:=
 []}],<br><br>rootceph pg 4.438 mark_unfound_lost revert<br>Error EINVAL: p=
g has 1 unfound objects but we haven&#39;t probed all sources, not marking =
lost<br><br>root@node-67:~# ceph pg 4.438 mark_unfound_lost delete<br>Error=
 EINVAL: pg has 1 unfound objects but we haven&#39;t probed all sources, no=
t marking lost<br><br>pg query output is :<a href=3D"https://drive.google.c=
om/file/d/0B08hG89CXoPbb2p0ZFc2OGRRQmpkcGVuZnoxNFJnQS05UDlv/view" target=3D=
"_blank">https://drive.google.com/file/d/0B08hG89CXoPbb2p0ZFc2OGRRQmpkcGVuZ=
noxNFJnQS05UDlv/view</a><br>-------------------------<br><a href=3D"mailto:=
hnuzhoulin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br><div><=
br></div></div>
</div><br></div>

--001a113d21c4b35e97052e8aaca7--

--===============1014650794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1014650794==--

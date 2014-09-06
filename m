From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph osd unexpected error
Date: Sat, 6 Sep 2014 22:41:20 +0800
Message-ID: <CACJqLyZPjcY4dd8MNRr=1VXuHR0F5OwOtOaqzbkQDeLD6SowiA@mail.gmail.com>
References: <2014090515165684227715@f-club.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1888153941=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <2014090515165684227715-GpCVenMC5M3/PtFMR13I2A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?5buW5bu66ZSL?= <Derek-GpCVenMC5M3/PtFMR13I2A@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1888153941==
Content-Type: multipart/alternative; boundary=089e013d16f03b6401050266947d

--089e013d16f03b6401050266947d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Could you give some more detail infos such as operation before occur errors=
?

And what's your ceph version?


On Fri, Sep 5, 2014 at 3:16 PM, =E5=BB=96=E5=BB=BA=E9=94=8B <Derek@f-club.c=
n> wrote:

>       Dear CEPH ,
>         Urgent question, I met a "FAILED assert(0 =3D=3D "unexpected erro=
r")"
>  yesterday , Now i have not way to start this OSDS
> I have attached my logs in the attachment, and some  ceph configurations
>  as below
>
>
>  osd_pool_default_pgp_num =3D 300
> osd_pool_default_size =3D 2
> osd_pool_default_min_size =3D 1
> osd_pool_default_pg_num =3D 300
> mon_host =3D 10.1.0.213,10.1.0.214
> osd_crush_chooseleaf_type =3D 1
> mds_cache_size =3D 500000
> osd objectstore =3D keyvaluestore-dev
>
>
>
>  Detailed error information :
>
>
>     -13> 2014-09-05 15:07:35.279863 7f4d988b9700 2 waiting 51 > 50 ops ||
> 11642907 > 104857600
> -12> 2014-09-05 15:07:35.279899 7f4d978b7700 2 waiting 51 > 50 ops ||
> 11642899 > 104857600
> -11> 2014-09-05 15:07:35.279919 7f4d990ba700 2 waiting 51 > 50 ops ||
> 11642901 > 104857600
> -10> 2014-09-05 15:07:35.326803 7f4d9a8bd700 10 monclient: tick
> -9> 2014-09-05 15:07:35.326837 7f4d9a8bd700 10 monclient:
> _check_auth_rotating have uptodate secrets (they expire after 2014-09-05
> 15:07:05.326835)
> -8> 2014-09-05 15:07:35.326871 7f4d9a8bd700 10 monclient: renew subs?
> (now: 2014-09-05 15:07:35.326871; renew after: 2014-09-05 15:10:02.464341=
)
> -- no
> -7> 2014-09-05 15:07:35.343657 7f4d978b7700 2 waiting 51 > 50 ops ||
> 11044551 > 104857600
> -6> 2014-09-05 15:07:35.343654 7f4e1ee72700 1 -- 10.1.0.221:6801/4013 -->
> osd.12 10.1.0.219:6810/32654 -- pg_info(1 pgs e1267:0.f1) v4 -- ?+0
> 0x18dcf000
> -5> 2014-09-05 15:07:35.343680 7f4d990ba700 2 waiting 51 > 50 ops ||
> 11044553 > 104857600
> -4> 2014-09-05 15:07:35.343686 7f4d988b9700 2 waiting 51 > 50 ops ||
> 11044579 > 104857600
> -3> 2014-09-05 15:07:35.344875 7f4e1fe74700 0 error (22) Invalid argument
> not handled on operation 9 (336.0.3, or op 3, counting from 0)
> -2> 2014-09-05 15:07:35.344902 7f4e1fe74700 0 unexpected error code
> -1> 2014-09-05 15:07:35.344903 7f4e1fe74700 0 transaction dump:
> { "ops": [
> { "op_num": 0,
> "op_name": "remove",
> "collection": "0.a9_head",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0"},
> { "op_num": 1,
> "op_name": "mkcoll",
> "collection": "0.a9_TEMP"},
> { "op_num": 2,
> "op_name": "remove",
> "collection": "0.a9_TEMP",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0"},
> { "op_num": 3,
> "op_name": "touch",
> "collection": "0.a9_head",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0"},
> { "op_num": 4,
> "op_name": "omap_setheader",
> "collection": "0.a9_head",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0",
> "header_length": "0"},
> { "op_num": 5,
> "op_name": "write",
> "collection": "0.a9_head",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0",
> "length": 1160,
> "offset": 0,
> "bufferlist length": 1160},
> { "op_num": 6,
> "op_name": "omap_setkeys",
> "collection": "0.a9_head",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0",
> "attr_lens": {}},
> { "op_num": 7,
> "op_name": "setattrs",
> "collection": "0.a9_head",
> "oid": "4b0fea9\/1000053b885.00000000\/head\/\/0",
> "attr_lens": { "_": 239,
> "_parent": 250,
> "snapset": 31}},
> { "op_num": 8,
> "op_name": "omap_setkeys",
> "collection": "meta",
> "oid": "16ef7597\/infos\/head\/\/-1",
> "attr_lens": { "0.a9_epoch": 4,
> "0.a9_info": 684}},
> { "op_num": 9,
> "op_name": "remove",
> "collection": "0.a9_head",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0"},
> { "op_num": 10,
> "op_name": "remove",
> "collection": "0.a9_TEMP",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0"},
> { "op_num": 11,
> "op_name": "touch",
> "collection": "0.a9_head",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0"},
> { "op_num": 12,
> "op_name": "omap_setheader",
> "collection": "0.a9_head",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0",
> "header_length": "0"},
> { "op_num": 13,
> "op_name": "write",
> "collection": "0.a9_head",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0",
> "length": 507284,
> "offset": 0,
> "bufferlist length": 507284},
> { "op_num": 14,
> "op_name": "omap_setkeys",
> "collection": "0.a9_head",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0",
> "attr_lens": {}},
> { "op_num": 15,
> "op_name": "setattrs",
> "collection": "0.a9_head",
> "oid": "4c56f2a9\/10000c04096.00000000\/head\/\/0",
> "attr_lens": { "_": 239,
> "snapset": 31}},
> { "op_num": 16,
> "op_name": "omap_setkeys",
> "collection": "meta",
> "oid": "16ef7597\/infos\/head\/\/-1",
> "attr_lens": { "0.a9_epoch": 4,
> "0.a9_info": 684}},
> { "op_num": 17,
> "op_name": "remove",
> "collection": "0.a9_head",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0"},
> { "op_num": 18,
> "op_name": "remove",
> "collection": "0.a9_TEMP",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0"},
> { "op_num": 19,
> "op_name": "touch",
> "collection": "0.a9_head",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0"},
> { "op_num": 20,
> "op_name": "omap_setheader",
> "collection": "0.a9_head",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0",
> "header_length": "0"},
> { "op_num": 21,
> "op_name": "write",
> "collection": "0.a9_head",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0",
> "length": 3495,
> "offset": 0,
> "bufferlist length": 3495},
> { "op_num": 22,
> "op_name": "omap_setkeys",
> "collection": "0.a9_head",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0",
> "attr_lens": {}},
> { "op_num": 23,
> "op_name": "setattrs",
> "collection": "0.a9_head",
> "oid": "794064a9\/10000c040e0.00000000\/head\/\/0",
> "attr_lens": { "_": 239,
> "snapset": 31}},
> { "op_num": 24,
> "op_name": "omap_setkeys",
> "collection": "meta",
> "oid": "16ef7597\/infos\/head\/\/-1",
> "attr_lens": { "0.a9_epoch": 4,
> "0.a9_info": 684}},
> { "op_num": 25,
> "op_name": "remove",
> "collection": "0.a9_head",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0"},
> { "op_num": 26,
> "op_name": "remove",
> "collection": "0.a9_TEMP",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0"},
> { "op_num": 27,
> "op_name": "touch",
> "collection": "0.a9_head",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0"},
> { "op_num": 28,
> "op_name": "omap_setheader",
> "collection": "0.a9_head",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0",
> "header_length": "0"},
> { "op_num": 29,
> "op_name": "write",
> "collection": "0.a9_head",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0",
> "length": 21502,
> "offset": 0,
> "bufferlist length": 21502},
> { "op_num": 30,
> "op_name": "omap_setkeys",
> "collection": "0.a9_head",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0",
> "attr_lens": {}},
> { "op_num": 31,
> "op_name": "setattrs",
> "collection": "0.a9_head",
> "oid": "b4f73ea9\/10000c04209.00000000\/head\/\/0",
> "attr_lens": { "_": 239,
> "snapset": 31}},
> { "op_num": 32,
> "op_name": "omap_setkeys",
> "collection": "meta",
> "oid": "16ef7597\/infos\/head\/\/-1",
> "attr_lens": { "0.a9_epoch": 4,
> "0.a9_info": 684}},
> { "op_num": 33,
> "op_name": "remove",
> "collection": "0.a9_head",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0"},
> { "op_num": 34,
> "op_name": "remove",
> "collection": "0.a9_TEMP",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0"},
> { "op_num": 35,
> "op_name": "touch",
> "collection": "0.a9_head",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0"},
> { "op_num": 36,
> "op_name": "omap_setheader",
> "collection": "0.a9_head",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0",
> "header_length": "0"},
> { "op_num": 37,
> "op_name": "write",
> "collection": "0.a9_head",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0",
> "length": 456155,
> "offset": 0,
> "bufferlist length": 456155},
> { "op_num": 38,
> "op_name": "omap_setkeys",
> "collection": "0.a9_head",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0",
> "attr_lens": {}},
> { "op_num": 39,
> "op_name": "setattrs",
> "collection": "0.a9_head",
> "oid": "f6ea1ea9\/10000c04238.00000000\/head\/\/0",
> "attr_lens": { "_": 239,
> "snapset": 31}},
> { "op_num": 40,
> "op_name": "omap_setkeys",
> "collection": "meta",
> "oid": "16ef7597\/infos\/head\/\/-1",
> "attr_lens": { "0.a9_epoch": 4,
> "0.a9_info": 684}}]}
> 0> 2014-09-05 15:07:35.346659 7f4e1fe74700 -1 os/KeyValueStore.cc: In
> function 'unsigned int
> KeyValueStore::_do_transaction(ObjectStore::Transaction&,
> KeyValueStore::BufferTransaction&, SequencerPosition&,
> ThreadPool::TPHandle*)' thread 7f4e1fe74700 time 2014-09-05 15:07:35.3452=
73
> os/KeyValueStore.cc: 1500: FAILED assert(0 =3D=3D "unexpected error")
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


--=20

Best Regards,

Wheat

--089e013d16f03b6401050266947d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Could you give some more detail inf=
os such as operation before occur errors?</div><div><br></div><div>And what=
&#39;s your ceph version?</div></div><div class=3D"gmail_extra"><br><br><di=
v class=3D"gmail_quote">On Fri, Sep 5, 2014 at 3:16 PM, =E5=BB=96=E5=BB=BA=
=E9=94=8B <span dir=3D"ltr">&lt;<a href=3D"mailto:Derek-GpCVenMC5M3/PtFMR13I2A@public.gmane.org" target=
=3D"_blank">Derek-GpCVenMC5M3/PtFMR13I2A@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">




<div>
<div><span></span></div>
<blockquote style=3D"margin-top:0px;margin-bottom:0px;margin-left:0.5em">
<div>
<div>
<blockquote style=3D"margin-top:0px;margin-bottom:0px;margin-left:0.5em">
<div>
<div>
<blockquote style=3D"margin-top:0px;margin-bottom:0px;margin-left:0.5em">
<div>
<div>
<div>Dear CEPH ,</div>
<div><span></span><span style=3D"background-color:rgba(0,0,0,0);font-size:1=
0.5pt;line-height:1.5">=C2=A0 =C2=A0=C2=A0</span><span style=3D"background-=
color:rgba(0,0,0,0);font-size:10.5pt;line-height:1.5">=C2=A0 =C2=A0=C2=A0</=
span><span style=3D"font-size:10.5pt;line-height:1.5;background-color:windo=
w">Urgent
 question, I met a <font color=3D"#ff0000">&quot;</font></span><span style=
=3D"font-size:10.5pt;line-height:1.5;background-color:window"><font color=
=3D"#ff0000">FAILED assert(0 =3D=3D &quot;unexpected error&quot;)</font></s=
pan><span style=3D"background-color:window;font-size:10.5pt;line-height:1.5=
"><font color=3D"#ff0000">&quot;</font>
 =C2=A0yesterday , Now i have not way to start this OSDS</span></div>
<div><span style=3D"background-color:window;font-size:10.5pt;line-height:1.=
5">I have attached my logs in the attachment, and some =C2=A0ceph configura=
tions =C2=A0as below</span></div>
<div><span>
<div style=3D"MARGIN-TOP:10px;MARGIN-LEFT:10px;MARGIN-RIGHT:10px">
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
<span style=3D"background-color:rgba(0,0,0,0)"><br>
</span></p>
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
<span style=3D"background-color:rgba(0,0,0,0)">osd_pool_default_pgp_num =3D=
 300 <br>
osd_pool_default_size =3D 2 <br>
osd_pool_default_min_size =3D 1 <br>
osd_pool_default_pg_num =3D 300 <br>
mon_host =3D 10.1.0.213,10.1.0.214 <br>
osd_crush_chooseleaf_type =3D 1 <br>
mds_cache_size =3D 500000 <br>
osd objectstore =3D keyvaluestore-dev</span></p>
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
<span style=3D"background-color:rgba(0,0,0,0)"><br>
</span></p>
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
<br>
</p>
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
Detailed error information :</p>
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
<br>
</p>
<p style=3D"text-align:left;line-height:14pt;margin-top:0px;margin-bottom:0=
px" class=3D"MsoNormal" align=3D"left">
<span style=3D"background-color:rgba(0,0,0,0)">=C2=A0 =C2=A0-13&gt; 2014-09=
-05 15:07:35.279863 7f4d988b9700 2 waiting 51 &gt; 50 ops || 11642907 &gt; =
104857600
<br>
-12&gt; 2014-09-05 15:07:35.279899 7f4d978b7700 2 waiting 51 &gt; 50 ops ||=
 11642899 &gt; 104857600
<br>
-11&gt; 2014-09-05 15:07:35.279919 7f4d990ba700 2 waiting 51 &gt; 50 ops ||=
 11642901 &gt; 104857600
<br>
-10&gt; 2014-09-05 15:07:35.326803 7f4d9a8bd700 10 monclient: tick <br>
-9&gt; 2014-09-05 15:07:35.326837 7f4d9a8bd700 10 monclient: _check_auth_ro=
tating have uptodate secrets (they expire after 2014-09-05 15:07:05.326835)
<br>
-8&gt; 2014-09-05 15:07:35.326871 7f4d9a8bd700 10 monclient: renew subs? (n=
ow: 2014-09-05 15:07:35.326871; renew after: 2014-09-05 15:10:02.464341) --=
 no
<br>
-7&gt; 2014-09-05 15:07:35.343657 7f4d978b7700 2 waiting 51 &gt; 50 ops || =
11044551 &gt; 104857600
<br>
-6&gt; 2014-09-05 15:07:35.343654 7f4e1ee72700 1 -- <a href=3D"http://10.1.=
0.221:6801/4013" target=3D"_blank">10.1.0.221:6801/4013</a> --&gt; osd.12 <=
a href=3D"http://10.1.0.219:6810/32654" target=3D"_blank">10.1.0.219:6810/3=
2654</a> -- pg_info(1 pgs e1267:0.f1) v4 -- ?+0 0x18dcf000
<br>
-5&gt; 2014-09-05 15:07:35.343680 7f4d990ba700 2 waiting 51 &gt; 50 ops || =
11044553 &gt; 104857600
<br>
-4&gt; 2014-09-05 15:07:35.343686 7f4d988b9700 2 waiting 51 &gt; 50 ops || =
11044579 &gt; 104857600
<br>
-3&gt; 2014-09-05 15:07:35.344875 7f4e1fe74700 0 error (22) Invalid argumen=
t not handled on operation 9 (336.0.3, or op 3, counting from 0)
<br>
-2&gt; 2014-09-05 15:07:35.344902 7f4e1fe74700 0 unexpected error code <br>
-1&gt; 2014-09-05 15:07:35.344903 7f4e1fe74700 0 transaction dump: <br>
{ &quot;ops&quot;: [ <br>
{ &quot;op_num&quot;: 0, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;}, <br=
>
{ &quot;op_num&quot;: 1, <br>
&quot;op_name&quot;: &quot;mkcoll&quot;, <br>
&quot;collection&quot;: &quot;0.a9_TEMP&quot;}, <br>
{ &quot;op_num&quot;: 2, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_TEMP&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;}, <br=
>
{ &quot;op_num&quot;: 3, <br>
&quot;op_name&quot;: &quot;touch&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;}, <br=
>
{ &quot;op_num&quot;: 4, <br>
&quot;op_name&quot;: &quot;omap_setheader&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;, <br>
&quot;header_length&quot;: &quot;0&quot;}, <br>
{ &quot;op_num&quot;: 5, <br>
&quot;op_name&quot;: &quot;write&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;, <br>
&quot;length&quot;: 1160, <br>
&quot;offset&quot;: 0, <br>
&quot;bufferlist length&quot;: 1160}, <br>
{ &quot;op_num&quot;: 6, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;, <br>
&quot;attr_lens&quot;: {}}, <br>
{ &quot;op_num&quot;: 7, <br>
&quot;op_name&quot;: &quot;setattrs&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4b0fea9\/1000053b885.00000000\/head\/\/0&quot;, <br>
&quot;attr_lens&quot;: { &quot;_&quot;: 239, <br>
&quot;_parent&quot;: 250, <br>
&quot;snapset&quot;: 31}}, <br>
{ &quot;op_num&quot;: 8, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;meta&quot;, <br>
&quot;oid&quot;: &quot;16ef7597\/infos\/head\/\/-1&quot;, <br>
&quot;attr_lens&quot;: { &quot;0.a9_epoch&quot;: 4, <br>
&quot;0.a9_info&quot;: 684}}, <br>
{ &quot;op_num&quot;: 9, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 10, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_TEMP&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 11, <br>
&quot;op_name&quot;: &quot;touch&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 12, <br>
&quot;op_name&quot;: &quot;omap_setheader&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;, <br=
>
&quot;header_length&quot;: &quot;0&quot;}, <br>
{ &quot;op_num&quot;: 13, <br>
&quot;op_name&quot;: &quot;write&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;, <br=
>
&quot;length&quot;: 507284, <br>
&quot;offset&quot;: 0, <br>
&quot;bufferlist length&quot;: 507284}, <br>
{ &quot;op_num&quot;: 14, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: {}}, <br>
{ &quot;op_num&quot;: 15, <br>
&quot;op_name&quot;: &quot;setattrs&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;4c56f2a9\/10000c04096.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: { &quot;_&quot;: 239, <br>
&quot;snapset&quot;: 31}}, <br>
{ &quot;op_num&quot;: 16, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;meta&quot;, <br>
&quot;oid&quot;: &quot;16ef7597\/infos\/head\/\/-1&quot;, <br>
&quot;attr_lens&quot;: { &quot;0.a9_epoch&quot;: 4, <br>
&quot;0.a9_info&quot;: 684}}, <br>
{ &quot;op_num&quot;: 17, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 18, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_TEMP&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 19, <br>
&quot;op_name&quot;: &quot;touch&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 20, <br>
&quot;op_name&quot;: &quot;omap_setheader&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;, <br=
>
&quot;header_length&quot;: &quot;0&quot;}, <br>
{ &quot;op_num&quot;: 21, <br>
&quot;op_name&quot;: &quot;write&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;, <br=
>
&quot;length&quot;: 3495, <br>
&quot;offset&quot;: 0, <br>
&quot;bufferlist length&quot;: 3495}, <br>
{ &quot;op_num&quot;: 22, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: {}}, <br>
{ &quot;op_num&quot;: 23, <br>
&quot;op_name&quot;: &quot;setattrs&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;794064a9\/10000c040e0.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: { &quot;_&quot;: 239, <br>
&quot;snapset&quot;: 31}}, <br>
{ &quot;op_num&quot;: 24, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;meta&quot;, <br>
&quot;oid&quot;: &quot;16ef7597\/infos\/head\/\/-1&quot;, <br>
&quot;attr_lens&quot;: { &quot;0.a9_epoch&quot;: 4, <br>
&quot;0.a9_info&quot;: 684}}, <br>
{ &quot;op_num&quot;: 25, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 26, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_TEMP&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 27, <br>
&quot;op_name&quot;: &quot;touch&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 28, <br>
&quot;op_name&quot;: &quot;omap_setheader&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;, <br=
>
&quot;header_length&quot;: &quot;0&quot;}, <br>
{ &quot;op_num&quot;: 29, <br>
&quot;op_name&quot;: &quot;write&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;, <br=
>
&quot;length&quot;: 21502, <br>
&quot;offset&quot;: 0, <br>
&quot;bufferlist length&quot;: 21502}, <br>
{ &quot;op_num&quot;: 30, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: {}}, <br>
{ &quot;op_num&quot;: 31, <br>
&quot;op_name&quot;: &quot;setattrs&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;b4f73ea9\/10000c04209.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: { &quot;_&quot;: 239, <br>
&quot;snapset&quot;: 31}}, <br>
{ &quot;op_num&quot;: 32, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;meta&quot;, <br>
&quot;oid&quot;: &quot;16ef7597\/infos\/head\/\/-1&quot;, <br>
&quot;attr_lens&quot;: { &quot;0.a9_epoch&quot;: 4, <br>
&quot;0.a9_info&quot;: 684}}, <br>
{ &quot;op_num&quot;: 33, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 34, <br>
&quot;op_name&quot;: &quot;remove&quot;, <br>
&quot;collection&quot;: &quot;0.a9_TEMP&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 35, <br>
&quot;op_name&quot;: &quot;touch&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;}, <b=
r>
{ &quot;op_num&quot;: 36, <br>
&quot;op_name&quot;: &quot;omap_setheader&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;, <br=
>
&quot;header_length&quot;: &quot;0&quot;}, <br>
{ &quot;op_num&quot;: 37, <br>
&quot;op_name&quot;: &quot;write&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;, <br=
>
&quot;length&quot;: 456155, <br>
&quot;offset&quot;: 0, <br>
&quot;bufferlist length&quot;: 456155}, <br>
{ &quot;op_num&quot;: 38, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: {}}, <br>
{ &quot;op_num&quot;: 39, <br>
&quot;op_name&quot;: &quot;setattrs&quot;, <br>
&quot;collection&quot;: &quot;0.a9_head&quot;, <br>
&quot;oid&quot;: &quot;f6ea1ea9\/10000c04238.00000000\/head\/\/0&quot;, <br=
>
&quot;attr_lens&quot;: { &quot;_&quot;: 239, <br>
&quot;snapset&quot;: 31}}, <br>
{ &quot;op_num&quot;: 40, <br>
&quot;op_name&quot;: &quot;omap_setkeys&quot;, <br>
&quot;collection&quot;: &quot;meta&quot;, <br>
&quot;oid&quot;: &quot;16ef7597\/infos\/head\/\/-1&quot;, <br>
&quot;attr_lens&quot;: { &quot;0.a9_epoch&quot;: 4, <br>
&quot;0.a9_info&quot;: 684}}]} <br>
0&gt; 2014-09-05 15:07:35.346659 7f4e1fe74700 -1 os/KeyValueStore.cc: In fu=
nction &#39;unsigned int KeyValueStore::_do_transaction(ObjectStore::Transa=
ction&amp;, KeyValueStore::BufferTransaction&amp;, SequencerPosition&amp;, =
ThreadPool::TPHandle*)&#39; thread 7f4e1fe74700 time 2014-09-05
 15:07:35.345273 <br>
os/KeyValueStore.cc: 1500: FAILED assert(0 =3D=3D &quot;unexpected error&qu=
ot;)</span></p>
</div>
</span></div>
</div>
</div>
</blockquote>
</div>
</div>
</blockquote>
</div>
</div>
</blockquote>
</div>

<br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>







<p>Best Regards,</p><p>Wheat</p>
</div>

--089e013d16f03b6401050266947d--

--===============1888153941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1888153941==--

From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] ceph osd unexpected error
Date: Sat, 6 Sep 2014 22:43:43 +0800
Message-ID: <CACJqLyZL9A+fcf+SCtvHvW3iv3CQOu2M8T1iM9MeEj2XScVWng@mail.gmail.com>
References: <2014090515165684227715@f-club.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:43057 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaIFOnp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Sep 2014 10:43:45 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so461871wes.21
        for <ceph-devel@vger.kernel.org>; Sat, 06 Sep 2014 07:43:43 -0700 (PDT)
In-Reply-To: <2014090515165684227715@f-club.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5buW5bu66ZSL?= <Derek@f-club.cn>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Could you give some more detail infos such as operation before occur er=
rors?

And what's your ceph version?

On Fri, Sep 5, 2014 at 3:16 PM, =E5=BB=96=E5=BB=BA=E9=94=8B <Derek@f-cl=
ub.cn> wrote:
> Dear CEPH ,
>         Urgent question, I met a "FAILED assert(0 =3D=3D "unexpected =
error")"
> yesterday , Now i have not way to start this OSDS
> I have attached my logs in the attachment, and some  ceph configurati=
ons  as
> below
>
>
> osd_pool_default_pgp_num =3D 300
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
> Detailed error information :
>
>
>    -13> 2014-09-05 15:07:35.279863 7f4d988b9700 2 waiting 51 > 50 ops=
 ||
> 11642907 > 104857600
> -12> 2014-09-05 15:07:35.279899 7f4d978b7700 2 waiting 51 > 50 ops ||
> 11642899 > 104857600
> -11> 2014-09-05 15:07:35.279919 7f4d990ba700 2 waiting 51 > 50 ops ||
> 11642901 > 104857600
> -10> 2014-09-05 15:07:35.326803 7f4d9a8bd700 10 monclient: tick
> -9> 2014-09-05 15:07:35.326837 7f4d9a8bd700 10 monclient:
> _check_auth_rotating have uptodate secrets (they expire after 2014-09=
-05
> 15:07:05.326835)
> -8> 2014-09-05 15:07:35.326871 7f4d9a8bd700 10 monclient: renew subs?=
 (now:
> 2014-09-05 15:07:35.326871; renew after: 2014-09-05 15:10:02.464341) =
-- no
> -7> 2014-09-05 15:07:35.343657 7f4d978b7700 2 waiting 51 > 50 ops ||
> 11044551 > 104857600
> -6> 2014-09-05 15:07:35.343654 7f4e1ee72700 1 -- 10.1.0.221:6801/4013=
 -->
> osd.12 10.1.0.219:6810/32654 -- pg_info(1 pgs e1267:0.f1) v4 -- ?+0
> 0x18dcf000
> -5> 2014-09-05 15:07:35.343680 7f4d990ba700 2 waiting 51 > 50 ops ||
> 11044553 > 104857600
> -4> 2014-09-05 15:07:35.343686 7f4d988b9700 2 waiting 51 > 50 ops ||
> 11044579 > 104857600
> -3> 2014-09-05 15:07:35.344875 7f4e1fe74700 0 error (22) Invalid argu=
ment
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
> ThreadPool::TPHandle*)' thread 7f4e1fe74700 time 2014-09-05 15:07:35.=
345273
> os/KeyValueStore.cc: 1500: FAILED assert(0 =3D=3D "unexpected error")
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

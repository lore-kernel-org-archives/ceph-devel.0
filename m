From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Reproducing allocator performance differences
Date: Fri, 2 Oct 2015 08:10:55 +0200 (CEST)
Message-ID: <1468593976.129281907.1443766255165.JavaMail.zimbra@oxygem.tv>
References: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56388 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbJBGK6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 02:10:58 -0400
In-Reply-To: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Curley, Matthew" <matthew.curley@hpe.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I was able reproduce it with this config a lot of time,4k randread,

intel s3610 ssd, testing with a small rbd which can be keep in buffer m=
emory.

I think around 150-200k iops by osd, I was able to trigger it easily.



auth_cluster_required =3D none
auth_service_required =3D none
auth_client_required =3D none
filestore_xattr_use_omap =3D true
osd_pool_default_min_size =3D 1
debug_lockdep =3D 0/0
debug_context =3D 0/0
debug_crush =3D 0/0
debug_buffer =3D 0/0
debug_timer =3D 0/0
debug_journaler =3D 0/0
debug_osd =3D 0/0
debug_optracker =3D 0/0
debug_objclass =3D 0/0
debug_filestore =3D 0/0
debug_journal =3D 0/0
debug_ms =3D 0/0
debug_monc =3D 0/0
debug_tp =3D 0/0
debug_auth =3D 0/0
debug_finisher =3D 0/0
debug_heartbeatmap =3D 0/0
debug_perfcounter =3D 0/0
debug_asok =3D 0/0
debug_throttle =3D 0/0
osd_op_threads =3D 5
filestore_op_threads =3D 4
osd_op_num_threads_per_shard =3D 2
osd_op_num_shards =3D 10
filestore_fd_cache_size =3D 64
filestore_fd_cache_shards =3D 32
ms_nocrc =3D true
ms_dispatch_throttle_bytes =3D 0
cephx_sign_messages =3D false
cephx_require_signatures =3D false
throttler_perf_counter =3D false
ms_crc_header =3D false
ms_crc_data =3D false

[osd]
osd_client_message_size_cap =3D 0
osd_client_message_cap =3D 0
osd_enable_op_tracker =3D false




----- Mail original -----
De: "Curley, Matthew" <matthew.curley@hpe.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 1 Octobre 2015 17:32:49
Objet: Reproducing allocator performance differences

We've been trying to reproduce the allocator performance impact on 4K r=
andom reads seen in the Hackathon (and more recent tests). At this poin=
t though, we're not seeing any significant difference between tcmalloc =
and jemalloc so we're looking for thoughts on what we're doing wrong. O=
r at least some suggestions to try out.=20

More detail here:=20
https://drive.google.com/file/d/0B2kp18maR7axTmU5WG9WclNKQlU/view?usp=3D=
sharing=20

Thanks for any input!=20

--MC=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

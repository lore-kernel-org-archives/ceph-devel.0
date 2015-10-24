From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Really slow cache-evict
Date: Fri, 23 Oct 2015 18:47:10 -0600
Message-ID: <CAANLjFq5e3oKPbrmip13KdKpvKwhTYNKzHARgdAVBBCtZ4NrmQ@mail.gmail.com>
References: <CAANLjFrhX4TTJ_a-E8vZp-2jf878orY1sH3e33dt4TNixxYdvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35432 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbJXArM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 20:47:12 -0400
Received: by vkfw189 with SMTP id w189so72682820vkf.2
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 17:47:11 -0700 (PDT)
In-Reply-To: <CAANLjFrhX4TTJ_a-E8vZp-2jf878orY1sH3e33dt4TNixxYdvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

There might be something deeper here. We have four copies min_size 2,
if I take down half of the cluster, it evicts at the rate I expect. If
all OSDs are in, it slows and blocks for a long time.

I also have 15 PGs that are inconsistent. I deep scrub them and they
become healthy. I stop and restart all the OSDs and they come back.
Only one of those PGs are in the base tier. I tried taking out two of
the OSDs for that PG and it doesn't really do much  to help the
progress of the eviction.

Reducing the pools size and min-size to 1 didn't help at all. It is
really weird.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Oct 23, 2015 at 5:13 PM, Robert LeBlanc  wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> We are testing out cache tiering, but when evicting the cache on an
> idle cluster it is extremely slow (10 objects per minutes). Looking at
> top some of the OSD processes are busy, but the disks are idle across
> the cluster. I upped debug_osd to 20/20 and saw millions of messages
> per object like:
>
> 2015-10-23 16:52:15.952561 7fa42a1fd700 20 osd.169 39454
> should_share_map client.329656 10.208.16.31:0/1012854 39454
> 2015-10-23 16:52:15.952605 7fa42a1fd700 15 osd.169 39454 enqueue_op
> 0x287ba400 prio 63 cost 450560 latency 0.000999
> osd_op(client.329656.0:165865996
> rbd_data.14143b5faf8a00.000000000000041f [stat,set-alloc-hint
> object_size 8388608 write_size 8388608,write 860160~450560]
> 12.549948fa ack+ondisk+wr
> ite+known_if_redirected e39454) v5
> 2015-10-23 16:52:15.952642 7fa43fbeb700 10 osd.169 39454 dequeue_op
> 0x287ba400 prio 63 cost 450560 latency 0.001036
> osd_op(client.329656.0:165865996
> rbd_data.14143b5faf8a00.000000000000041f [stat,set-alloc-hint
> object_size 8388608 write_size 8388608,write 860160~450560]
> 12.549948fa ack+ondisk+wr
> ite+known_if_redirected e39454) v5 pg pg[12.fa( v 39422'12054
> (39253'9006,39422'12054] local-les=39453 n=284 ec=31174 les/c
> 39453/39453 39452/39452/39442) [169,186,153,136] r=0 lpr=39452
> crt=39422'12051 lcod 0'0 mlcod 0'0 active+clean]
> 2015-10-23 16:52:15.952676 7fa43fbeb700 20 osd.169 pg_epoch: 39454
> pg[12.fa( v 39422'12054 (39253'9006,39422'12054] local-les=39453 n=284
> ec=31174 les/c 39453/39453 39452/39452/39442) [169,186,153,136] r=0
> lpr=39452 crt=39422'12051 lcod 0'0 mlcod 0'0 active+clean]
> op_has_sufficient_caps pool=12
> (ssd-pool ) owner=0 need_read_cap=1 need_write_cap=1
> need_class_read_cap=0 need_class_write_cap=0 -> NO
> 2015-10-23 16:52:15.952688 7fa42a1fd700 20 osd.169 39454
> should_share_map client.329656 10.208.16.31:0/1012854 39454
> 2015-10-23 16:52:15.952701 7fa43fbeb700 10 osd.169 39454 dequeue_op
> 0x287ba400 finish
> 2015-10-23 16:52:15.952729 7fa42a1fd700 15 osd.169 39454 enqueue_op
> 0x287c7500 prio 63 cost 4096 latency 0.000092
> osd_op(client.329656.0:165866002
> rbd_data.14143b5faf8a00.000000000000041f [stat,set-alloc-hint
> object_size 8388608 write_size 8388608,write 6369280~4096] 12.549948fa
> ack+ondisk+write
> +known_if_redirected e39454) v5
> 2015-10-23 16:52:15.952762 7fa43d3e6700 10 osd.169 39454 dequeue_op
> 0x287c7500 prio 63 cost 4096 latency 0.000125
> osd_op(client.329656.0:165866002
> rbd_data.14143b5faf8a00.000000000000041f [stat,set-alloc-hint
> object_size 8388608 write_size 8388608,write 6369280~4096] 12.549948fa
> ack+ondisk+write
> +known_if_redirected e39454) v5 pg pg[12.fa( v 39422'12054
> (39253'9006,39422'12054] local-les=39453 n=284 ec=31174 les/c
> 39453/39453 39452/39452/39442) [169,186,153,136] r=0 lpr=39452
> crt=39422'12051 lcod 0'0 mlcod 0'0 active+clean]
> 2015-10-23 16:52:15.952787 7fa43d3e6700 20 osd.169 pg_epoch: 39454
> pg[12.fa( v 39422'12054 (39253'9006,39422'12054] local-les=39453 n=284
> ec=31174 les/c 39453/39453 39452/39452/39442) [169,186,153,136] r=0
> lpr=39452 crt=39422'12051 lcod 0'0 mlcod 0'0 active+clean]
> op_has_sufficient_caps pool=12
> (ssd-pool ) owner=0 need_read_cap=1 need_write_cap=1
> need_class_read_cap=0 need_class_write_cap=0 -> NO
> 2015-10-23 16:52:15.952832 7fa43d3e6700 10 osd.169 39454 dequeue_op
> 0x287c7500 finish
>
> It looks like maybe the OP is bouncing between threads or something
> like that and never getting dispatched correctly. This is on
> ceph version 0.94.4 (95292699291242794510b39ffde3f4df67898d3a)
>
> I followed the directions at [1] in the writeback section for
> disabling the cache tier. I did this on another cluster recently and
> didn't see this problem (only took an hour or two to evict 700GB of
> data). I saw a very slow evict a while back, but just chalked it up to
> btrfs being dumb.
>
> [1] http://docs.ceph.com/docs/master/rados/operations/cache-tiering/#removing-a-writeback-cache
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.2
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWKr8iCRDmVDuy+mK58QAAl7oP/2bfWT/DUxjxkEGIXOnW
> x2dk7hlTAkTAts7bRQn+vL31bcHAEoN+nJH5J39nt98Kh4rpZyHcVtJammYM
> hYNsc97Hah+O2iqDYWxr4Vu27eyq5icCw0oFo9hbsA6lGPcrgeVSGbnXaFk0
> +4u6OCovRDb6Rgfc6IAJoHrkulnPaWGaKWa1sfofdlMDJoA2U5cnX7ZvkRnM
> unnKKtAjmeVCFbt/QmwFJVEjdNh0yZXN2qLSJUVwf4APgB4G2trupQ6kuisn
> oGZdJP1DRtFn5IgoZQzB4ZA1FNydrVoQmrPNTAkCGQoUWegbmhxrXxsrfLV9
> jTky2inv8NLdP46VyEVyvOqFD3WVRYIP+KvVcaNnL2awMClOgZ4uish+rLK/
> Uyhcm9dfXgBz1Fm+PzdzpMwK8/lvk/UcfnBs6s5rELgjCQ/WPLMu7y1ZP9FY
> DzLsrtMdbMGZA7MTt9CKAe9fZ+sPC3Se8slh6mN7M7Tm2Knsv6uyKLJ06imW
> M7DMGVMi2A3I+qTE/DEA/D5MLcx+vJtLD57/a2j3dWaEiiBqaAsMA18UiwEX
> bMaHAbFMWBrlhIVytP4IaA7dbiEaO6C90pyHHtyVf1etKDfP+erNRtHVW4JI
> 8wpG87Z34o6r92fkbb0LRH/TvD+WQFU4Q0OiL5JqclJKJP6TNUUhMmstad62
> vmqk
> =dO6U
> -----END PGP SIGNATURE-----

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWKtUKCRDmVDuy+mK58QAAXMkQALsPsesb5+GuaY3uESQ/
y3DP+V3wAQPycZRHWPCSavgXHqvteQsYPigSxXlDsomompsvwtGcFU0Ube2w
lfM050e2ZnaQQ9IKMLfAyZHu7vnbiVoVd3bEfHpjT/WZfPMaVpO6dl9UCpMq
3AwPtpw2+DbTo6JGD4C0nB0Qug9k1fjiS3utGDtbTm54acsU7pDrlBDFWIBt
r5Ix7nd4ZGNdKvCIvberciw173QyKz5jLIp0VPJnl22oB7iGn4QcP6E6MN8M
ILe+S+Gqz1Hld7O+mqshOYwiBlkiefgOoaEQGzLIuG8SJPfls9eWD5ufmjh1
SUx+jEkZDit8dGz7a7TIUoIkRuBCBlR+m6zn/XYlSjgx6OkRxsLeF3EZcnfn
twQqxCi1QwsD0VtvODL/UwVa+uN9ZwUQ/OCxDulOUmKUybVSdM3GwSFs7yvJ
aVLMLar7kqRcDC5jsWk/xGA8clMaHHOo87aqCSQFVtDpFBLaVvDDcGkIlw0q
c46fQI6X343IUrDQyjMawUteE5M5osspBsaK8uS27XuU+8KOTciIRUprZG16
K0DxL8zlW7mG72fsi8UM5xdRifyEGVhbmNSohLfca7A/pORBp6rbRnZOvoqX
HtQc74qsfxqgIX7fZF3aV/lM5wqOoPZd426F9BsRuqryA61CtiVYnTLryzOW
w9vt
=hQQ4
-----END PGP SIGNATURE-----

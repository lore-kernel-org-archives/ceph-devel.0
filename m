From: Ning Yao <zay11022@gmail.com>
Subject: Re: Specify omap path for filestore
Date: Wed, 4 Nov 2015 15:08:54 +0800
Message-ID: <CALZt5jxkbA8OBe1zxxo9F1xjaJ8m+wSydzn_UQ4V=vBT2gty7A@mail.gmail.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B322002AB8@SHSMSX101.ccr.corp.intel.com>
	<C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com>
	<C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34023 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbKDHIz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 02:08:55 -0500
Received: by wmff134 with SMTP id f134so102538370wmf.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Nov 2015 23:08:54 -0800 (PST)
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Chendi,
I don't think it will be a big improvement compared with normal way to
using FileStore (enable filestore_max_inline_xattr_xfs and tune
filestore_fd_cache_size,osd_pg_object_context_cache_count,
filestore_omap_header_cache_size properly to achieve a high hit
rate).Do you enable  filestore_max_inline_xattr in the first test? If
not, it may be reasonable. In my previous test, I remember just about
20%~30% improvement.
And can you also provide cpu cost per Op on osd node?
Regards
Ning Yao


2015-10-30 10:04 GMT+08:00 Xue, Chendi <chendi.xue@intel.com>:
> Hi, Sam
>
> Last week I introduced about how we saw the benefit of moving omap to a separate device.
>
> And here is the pull request:
> https://github.com/ceph/ceph/pull/6421
>
> I had tested redeploy and restart ceph cluster at my setup, the codes works fine.
> one problem is do you think I should *DELETE* all the files under the omap_path firstly? Because I notice if old pg data leaves there, osd daemon may run into chaos. But I am not sure if it should leave to users to DELETE.
>
> Any thoughts?
>
> Also I paste some data I talked , which is about the rbd and osd write iops ratio when doing randwrite to a rbd device.
>
> ======Here is some data=====
> We uses 4 clients , 35 vm each to test on rbd randwrite.
> 4 osd physical nodes, each has 10 HDD as osd and 2 ssd as journal
> 2 replica
> filestore_max_inline_xattr_xfs=0
> filestore_max_inline_xattr_size_xfs=0
>
> Before moving omap to separate ssd, we saw a frontend and backend iops ratio of 1:5.8, rbd side total iops 1206, hdd total iops 7034
> Like we talked, 5.8 consists of 2 replica write, inode and omap writes
> runid         op_size    op_type             QD             engine               serverNum       clientNum         rbdNum   runtime             fio_iops         fio_bw               fio_latency                 osd_iops           osd_bw             osd_latency
> 332            4k              randwrite         qd8            qemurbd           4                          4                          140            400 sec              1206.000         4.987 MB/s      884.617 msec           7034.975          47.407 MB/s    242.620 msec
>
> And after moving omap to a separate ssd, we saw a frontend vs. backend ratio drops to 1:2.6, rbd side total iops 5006, hdd total iops 13089
> runid         op_size    op_type             QD             engine               serverNum       clientNum         rbdNum   runtime             fio_iops         fio_bw               fio_latency                 osd_iops           osd_bw             osd_latency
> 326            4k              randwrite         qd8            qemurbd           4                          4                          140            400 sec              5006.000         19.822 MB/s    222.296 msec           13089.020        82.897 MB/s    482.203 msec
>
>
> Best regards,
> Chendi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

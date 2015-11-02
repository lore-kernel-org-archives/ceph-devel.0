From: Samuel Just <sjust@redhat.com>
Subject: Re: Specify omap path for filestore
Date: Mon, 2 Nov 2015 10:29:24 -0800
Message-ID: <CAN=+7FUJ=aRx+oNA84KDo5Ch3oK5P7PWsLF0bufLzdJrF6qNjw@mail.gmail.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B322002AB8@SHSMSX101.ccr.corp.intel.com>
	<C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com>
	<C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
	<6F3FA899187F0043BA1827A69DA2F7CC0363820F@shsmsx102.ccr.corp.intel.com>
	<CAN=+7FV=ZVj_HwE0+7mJququOSJxt0JHXBjwDp=6Xj3ukAmntA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36704 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbbKBS3Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 13:29:25 -0500
Received: by ioll68 with SMTP id l68so154220345iol.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 10:29:25 -0800 (PST)
In-Reply-To: <CAN=+7FV=ZVj_HwE0+7mJququOSJxt0JHXBjwDp=6Xj3ukAmntA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "Xue, Chendi" <chendi.xue@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The osd keeps some metadata in the leveldb store, so you don't want to
delete it.  I'm still not clear on why pg data being there causes
trouble.
-Sam

On Mon, Nov 2, 2015 at 10:26 AM, Samuel Just <sjust@redhat.com> wrote:
> Maybe, I figured that the call to DBObjectMap::sync in FileStore::sync
> should take care of it though?
> -Sam
>
> On Sat, Oct 31, 2015 at 11:41 PM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
>> As we use submit_transaction(instead of submit_transaction_sync) in DBObjectmap, and we also don't  use a kv_sync_thread for DB. Seems we need to rely on the syncfs(2) at commit time for persist everything?
>>
>> If that is the case, moving db out of the same FS as Data  may cause issue?
>>
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Xue, Chendi
>>> Sent: Friday, October 30, 2015 10:05 AM
>>> To: 'Samuel Just'
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Specify omap path for filestore
>>>
>>> Hi, Sam
>>>
>>> Last week I introduced about how we saw the benefit of moving omap to a
>>> separate device.
>>>
>>> And here is the pull request:
>>> https://github.com/ceph/ceph/pull/6421
>>>
>>> I had tested redeploy and restart ceph cluster at my setup, the codes works
>>> fine.
>>> one problem is do you think I should *DELETE* all the files under the
>>> omap_path firstly? Because I notice if old pg data leaves there, osd daemon
>>> may run into chaos. But I am not sure if it should leave to users to DELETE.
>>>
>>> Any thoughts?
>>>
>>> Also I paste some data I talked , which is about the rbd and osd write iops
>>> ratio when doing randwrite to a rbd device.
>>>
>>> ======Here is some data=====
>>> We uses 4 clients , 35 vm each to test on rbd randwrite.
>>> 4 osd physical nodes, each has 10 HDD as osd and 2 ssd as journal
>>> 2 replica
>>> filestore_max_inline_xattr_xfs=0
>>> filestore_max_inline_xattr_size_xfs=0
>>>
>>> Before moving omap to separate ssd, we saw a frontend and backend iops
>>> ratio of 1:5.8, rbd side total iops 1206, hdd total iops 7034 Like we talked, 5.8
>>> consists of 2 replica write, inode and omap writes
>>> runid         op_size    op_type             QD             engine               serverNum       clie
>>> ntNum         rbdNum   runtime             fio_iops         fio_bw               fio_latency
>>>            osd_iops           osd_bw             osd_latency
>>> 332            4k              randwrite         qd8            qemurbd           4                          4
>>>                  140            400 sec              1206.000         4.987 MB/s      884.617
>>> msec           7034.975          47.407 MB/s    242.620 msec
>>>
>>> And after moving omap to a separate ssd, we saw a frontend vs. backend
>>> ratio drops to 1:2.6, rbd side total iops 5006, hdd total iops 13089
>>> runid         op_size    op_type             QD             engine               serverNum       clie
>>> ntNum         rbdNum   runtime             fio_iops         fio_bw               fio_latency
>>>            osd_iops           osd_bw             osd_latency
>>> 326            4k              randwrite         qd8            qemurbd           4                          4
>>>                  140            400 sec              5006.000         19.822 MB/s    222.296
>>> msec           13089.020        82.897 MB/s    482.203 msec
>>>
>>>
>>> Best regards,
>>> Chendi
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html

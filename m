From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Wed, 29 Apr 2015 08:11:24 -0500
Message-ID: <5540D87C.9080005@redhat.com>
References: <554016E2.3000104@redhat.com> <CAKKTCLX31EBc8oOs6tVVRu4c5prUYD=3G=8fK3pMvLQTM+1iSQ@mail.gmail.com> <554020DC.6020009@redhat.com> <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com> <364863347.772740036.1430281910806.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422997AbbD2NLd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 09:11:33 -0400
In-Reply-To: <364863347.772740036.1430281910806.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, kernel neophyte <neophyte.hacker001@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/28/2015 11:31 PM, Alexandre DERUMIER wrote:
> Hi,
>
>>> I am trying to measure 4k RW performance on Newstore, and I am not
>>> anywhere close to the numbers you are getting!
>>>
>>> Could you share your ceph.conf for these test ?
>
> I'll try also to help testing newstore with my ssd cluster.
>
> what is used for benchmark ? rados bench ?
> any command line to reproduce the same bechmark ?

Hi Alexandre,

I used fio with the librbd engine via cbt (a tool to build ceph clusters 
and run benchmarks / monitoring / valgrind / etc)

You can see how fio gets invoked here:

https://github.com/ceph/cbt/blob/master/benchmark/librbdfio.py

The settings for these tests are:

benchmarks:
   librbdfio:
     time: 300
     vol_size: 16384
     mode: [write, randwrite]
     op_size: [4194304, 2097152, 1048576, 524288, 262144, 131072, 65536, 
32768, 16384, 8192, 4096]
     concurrent_procs: [1]
     iodepth: [64]
     osd_ra: [4096]
     cmd_path: '/home/nhm/src/fio/fio'
     pool_profile: 'rbd'


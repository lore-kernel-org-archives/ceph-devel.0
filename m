From: Dan Mick <dan.mick@inktank.com>
Subject: Re: librbd bug?
Date: Thu, 07 Mar 2013 21:14:25 -0800
Message-ID: <513973B1.9080509@inktank.com>
References: <51386912.3020507@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47920 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab3CHFO3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Mar 2013 00:14:29 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so1034162pab.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 21:14:29 -0800 (PST)
In-Reply-To: <51386912.3020507@risc-software.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Cc: ceph-devel@vger.kernel.org



On 03/07/2013 02:16 AM, Wolfgang Hennerbichler wrote:
> Hi,
>
> I've a libvirt-VM that gets format 2 rbd-childs 'fed' by the superhost.
> It crashed recently with this in the logs:
>
> osdc/ObjectCacher.cc: In function 'void
> ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
> tid_t, int)' thread 7f0cab5fd700 time 2013-03-01 22:02:37.374410
> osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
>   ceph version 0.56.3 (6eb7e15a4783b122e9b0c85ea9ba064145958aa5)
>   1: (ObjectCacher::bh_write_commit(long, sobject_t, long, unsigned long,
> unsigned long, int)+0xd68) [0x7f0d087cda28]
>   2: (ObjectCacher::C_WriteCommit::finish(int)+0x6b) [0x7f0d087d460b]
>   3: (Context::complete(int)+0xa) [0x7f0d0878c9fa]
>   4: (librbd::C_Request::finish(int)+0x85) [0x7f0d087bc325]
>   5: (Context::complete(int)+0xa) [0x7f0d0878c9fa]
>   6: (librbd::rados_req_cb(void*, void*)+0x47) [0x7f0d087a1387]
>   7: (librados::C_AioSafe::finish(int)+0x1d) [0x7f0d07b5834d]
>   8: (Finisher::finisher_thread_entry()+0x1c0) [0x7f0d07bc20d0]
>   9: (()+0x7e9a) [0x7f0d0546be9a]
>   10: (clone()+0x6d) [0x7f0d05198cbd]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
>
> Any clue why that happened?
>

This looks like

http://tracker.ceph.com/issues/4271

-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs

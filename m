From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: Memstore issue on v0.91
Date: Thu, 22 Jan 2015 08:38:48 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC02133938@shsmsx102.ccr.corp.intel.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB3CD9F@FMSMSX106.amr.corp.intel.com>
 <54BFB3EF.1030800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63336 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbbAVIkL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 03:40:11 -0500
In-Reply-To: <54BFB3EF.1030800@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "mnelson@redhat.com" <mnelson@redhat.com>, "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is due to the implicit type cast in the compiler,  when
                st->f_blocks     <    (used_bytes/st->f_bsize),
   the minus should be a negative ,but the compiler take it as an unsigned value


Fix is proposed in https://github.com/ceph/ceph/pull/3451

				Xiaoxi

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
Sent: Wednesday, January 21, 2015 10:13 PM
To: Blinick, Stephen L; Ceph Development
Subject: Re: Memstore issue on v0.91

On 01/21/2015 01:48 AM, Blinick, Stephen L wrote:
> Moved to 0.91 yesterday and ran into some issues, with a Memstore OSD of default size.  After a few hundred K OPS client gets a FULL message and the avail space looks like:
>
> [root@cephtestnode0 bmpa]# rados df
> pool name                 KB      objects       clones     degraded     unfound           rd        rd KB           wr        wr KB
> rbd                        0            0            0            0          0            0            0            0            0
> testmemstore         1505052       376263            0            0          0            0            0       376263      1505052
>    total used         1494247       376263
>    total avail   18014398508987737
>    total space        1000000
>
> I was looking at pull request #2836 and found a case where there could be an unsigned int underflow in MemStore.cc:statfs:
>
>     st->f_bfree = st->f_bavail = MAX((st->f_blocks - used_bytes / 
> st->f_bsize), 0);
>
> But that wasn't the final issue.. I put some asserts where used_bytes could underflow as well and didn't catch anything.  I will keep digging but wanted to find out if anyone else was seeing the issue as well.

FWIW, I hit this yesterday too.  I hadn't started debugging it yet though.  Looks like you are farther along than I am, thanks Stephen! :)

>
> Thanks,
>
> Stephen
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

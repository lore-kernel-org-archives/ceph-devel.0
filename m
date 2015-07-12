From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Ceph-mon crashing FAILED assert(addr_name.count(p->second) ==
 0)
Date: Sun, 12 Jul 2015 09:25:24 +0100
Message-ID: <55A22474.2040501@suse.de>
References: <CAFkUHxe8Qw4-5ggCm51shQdp8aYzdvEp9Bt9Fq11sur2vUf5oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53800 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbbGLIZ0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 12 Jul 2015 04:25:26 -0400
In-Reply-To: <CAFkUHxe8Qw4-5ggCm51shQdp8aYzdvEp9Bt9Fq11sur2vUf5oQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/10/2015 11:31 PM, kernel neophyte wrote:
> Hi,
> 
> I am seeing the following error every time I am trying to manually
> deploy ceph cluster and do a ceph -s :
> 
> mon/MonMap.h: In function 'void MonMap::calc_ranks()' thread
> 7fb3ccfb6700 time 2015-07-10 15:27:56.004148
> 
> mon/MonMap.h: 47: FAILED assert(addr_name.count(p->second) == 0)

Please send us a copy of your monmap and ceph.conf.

You should also open a ticket on the tracker.

Thanks!

  -Joao

> 
>  ceph version 9.0.1-1445-g4a179ee (4a179eea527f7cbcf45eed4a63ad0fa8f744fc4a)
> 
>  1: (()+0x12716b) [0x7fb3d53ec16b]
> 
>  2: (()+0x1c0a6d) [0x7fb3d5485a6d]
> 
>  3: (()+0x1b7909) [0x7fb3d547c909]
> 
>  4: (()+0x1b8377) [0x7fb3d547d377]
> 
>  5: (()+0x2fbbe7) [0x7fb3d55c0be7]
> 
>  6: (()+0x310f1d) [0x7fb3d55d5f1d]
> 
>  7: (()+0x3112a0) [0x7fb3d55d62a0]
> 
>  8: (()+0x8182) [0x7fb3d9e05182]
> 
>  9: (clone()+0x6d) [0x7fb3d9b3247d]
> 
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> 
> Aborted (core dumped)
> 
> Any help greatly appreciated :-)
> 
> -Neo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


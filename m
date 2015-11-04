From: Sage Weil <sage@newdream.net>
Subject: Re: ceph encoding optimization
Date: Wed, 4 Nov 2015 07:05:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511040702380.18099@cobra.newdream.net>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51743 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030349AbbKDPFw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 10:05:52 -0500
In-Reply-To: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, jdurgin@redhat.com

On Wed, 4 Nov 2015, ??? wrote:
> hi, all:
> 
>      I am focus on the cpu usage of ceph now. I find the struct (such
> as pg_info_t , transaction and so on) encode and decode exhaust too
> much cpu resource.
> 
>      For now, we should encode every member variable one by one which
> calling encode_raw finally. When there are many members, we should
> encode it many times. But I think, we could reduce some in some cases.
> 
>      For example , struct A { int a; int b; int c }; ceph would
> encoding int a , and then encode int b , finally int c. But for this
> case , we could calling bufferlist.append((char *)(&a), sizeof(A))
> because there are not padding bytes in this struct.
> 
>      I use the above optimization, the cpu usage of object_stat_sum_t
> encoding decrease from 0.5% to 0% (I could not see any using perf
> tools).
> 
>      This is only a case, so I think we could do similar optimization
> other struct. I think we should pay attention to the padding in
> struct.

We have to be careful because we need to ensure that the encoding 
is little-endian.  I think teh way to do this is to define a struct like

struct foo_t {
  __le64 a;
  __le64 b;
  __le64 c;
  ...
};

and just make a foo_t *p that points into the buffer.  There were some 
patches that did this that came out of the Portland ahckathon, but I'm not 
sure where they are... Josh, do you remember?

FWIW I think pg_stat_t (and friends) is a good first start since it is 
expensive and part of the MOSDOp and MOSDRepOp.

sage

From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Re: Assertion error in librados
Date: Fri, 28 Mar 2014 11:54:44 +0200
Message-ID: <20140328095443.GZ28819@philipgian-mac>
References: <20140225144900.GA30739@philipgian-mac>
 <CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
 <20140225155838.GB30739@philipgian-mac>
 <CA+Hcz59dVj1CPiV6Xzo8_Z4WzhehNRiHyef_DE+MPBT19FHd4Q@mail.gmail.com>
 <530CD824.2000107@inktank.com>
 <CA+Hcz59FC07EfPgPSo2TT6=oUQjEMmfDYLROB1p2QG7CxRLLWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:3019 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbaC1Jys (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Mar 2014 05:54:48 -0400
Content-Disposition: inline
In-Reply-To: <CA+Hcz59FC07EfPgPSo2TT6=oUQjEMmfDYLROB1p2QG7CxRLLWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>, Gregory Farnum <greg@inktank.com>, Noah Watkins <noah.watkins@inktank.com>, synnefo-devel@googlegroups.com

Hello,

We recently bumped again into the same assertion error.
Do you have any indications or update regarding the cause ?

On Tue, Feb 25, 2014 at 11:26:15AM -0800, Noah Watkins wrote:
> On Tue, Feb 25, 2014 at 9:51 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> > That's a good idea. This particular assert in a Mutex is almost always
> > a use-after-free of the Mutex or structure containing it though.
> 
> I think that a use-after-free will also throw an EINVAL (assuming it
> isn't a pathalogical case) as pthread_mutex_lock checks an
> initialization magic variable. I think that particular mutex isn't
> initialized with flags that would cause any of the other possible
> return values.

Kind regards,
-- 
Filippos
<philipgian@grnet.gr>

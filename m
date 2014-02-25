From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Assertion error in librados
Date: Tue, 25 Feb 2014 11:26:15 -0800
Message-ID: <CA+Hcz59FC07EfPgPSo2TT6=oUQjEMmfDYLROB1p2QG7CxRLLWQ@mail.gmail.com>
References: <20140225144900.GA30739@philipgian-mac>
	<CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
	<20140225155838.GB30739@philipgian-mac>
	<CA+Hcz59dVj1CPiV6Xzo8_Z4WzhehNRiHyef_DE+MPBT19FHd4Q@mail.gmail.com>
	<530CD824.2000107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:35189 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbaBYT0Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 14:26:16 -0500
Received: by mail-qc0-f172.google.com with SMTP id w7so9336726qcr.31
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 11:26:15 -0800 (PST)
In-Reply-To: <530CD824.2000107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Filippos Giannakos <philipgian@grnet.gr>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

On Tue, Feb 25, 2014 at 9:51 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> That's a good idea. This particular assert in a Mutex is almost always
> a use-after-free of the Mutex or structure containing it though.

I think that a use-after-free will also throw an EINVAL (assuming it
isn't a pathalogical case) as pthread_mutex_lock checks an
initialization magic variable. I think that particular mutex isn't
initialized with flags that would cause any of the other possible
return values.

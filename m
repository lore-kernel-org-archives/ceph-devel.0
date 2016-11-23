From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Static analysis
Date: Wed, 23 Nov 2016 08:25:24 +0100
Message-ID: <20161123072524.GE26997@predictor>
References: <20161123070637.GF26846@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:39168 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbcKWHcG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Nov 2016 02:32:06 -0500
Content-Disposition: inline
In-Reply-To: <20161123070637.GF26846@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Nov 23, 2016 at 05:06:37PM +1000, Brad Hubbard wrote:
> I did a run of the Clang Static Analyzer and it turned up multiple issues which
> Kefu gobbled up :) The reports are quite detailed and walk you through how the
> issue can present.
> 
> See https://github.com/ceph/ceph/pull/12145 and
> https://github.com/ceph/ceph/pull/12148
> 
> Given how easy it is to run [1] (although slow) would it be a good idea to be
> running this regulary, perhaps in addition to coverity scans?
> 
> [1] mkdir build && cd build && scan-build cmake .. && scan-build make -jX

+1. Certainly this will help finding out obscure bugs that show up later in
unexpected places.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl

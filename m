From: Andrew Shewmaker <agshew@gmail.com>
Subject: Re: =?utf-8?Q?=CE=99nstrumentin?= =?utf-8?Q?g?= RADOS with Zipkin +
 LTTng
Date: Thu, 30 Oct 2014 12:49:38 -0600
Message-ID: <20141030184938.GA10197@radon.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64367 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758974AbaJ3Stl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 14:49:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so6031393pad.11
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 11:49:41 -0700 (PDT)
Received: from radon.localdomain (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id uw6sm7844931pac.41.2014.10.30.11.49.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2014 11:49:40 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

I'm Andrew, a new Ceph intern, and I'll be working to get Marios'
Zipkin + LTTng repo into a merge-able state, as Sam asked about
(http://www.spinics.net/lists/ceph-devel/msg20024.html).

I've exchanged email with Marios, and he is interested in 
helping me with it in his spare time. One of the important 
things he mentioned is that his blkin library only works 
with LTTng 2.4. Other versions experience deadlocks, and 
he'll work to resolve them in 2.5.

I'm still working on getting a ceph development environment 
set up, so I haven't tested the tracepoints Marios added.
I have built an RPM spec file for blkin, tested it against 
lttng-ust 2.3 and 2.4, and built (but not tested) Marios'
ceph branch.

Should I put effort into adding a "--with-blkin" or "--with-zipkin"
option to autoconf?

I've made a first attempt at dividing the changes into
logically grouped patches: common blkin infrastructure, 
osd, and rados. Does that sound reasonable? Or should 
I not bother separating osd and rados changes?

I saw a couple instances of extraneous whitespace/newlines
I'll clean up. What other issues should I look for?

After they're cleaned up, would it be best for me to submit these 
patches to the list, or just point to a github repo?

Thanks,

Andrew Shewmaker

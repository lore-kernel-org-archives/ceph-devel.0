From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 18:56:06 +0300
Message-ID: <56041D16.6060805@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
 <5604131E.2030408@mirantis.com>
 <alpine.DEB.2.00.1509240829540.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36026 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbbIXP4L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 11:56:11 -0400
Received: by lacao8 with SMTP id ao8so68726782lac.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 08:56:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509240829540.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 24.09.2015 18:34, Sage Weil wrote:
> I was also assuming each stripe unit would be independently 
> compressed, but I didn't think about the efficiency. This approach 
> implies that you'd want a relatively large stripe size (100s of KB or 
> more). Hmm, a quick google search suggests the zlib compression window 
> is only 32KB anyway, which isn't so big. The more aggressive 
> algorithms probably aren't what people would reach for anyway for CPU 
> utilization reasons... I guess? sage 

There is probably no need in strict alignment with the stripe size. We 
can use block sizes that client provides on write dynamically. If some 
client writes in stripes - then we compress that block. If others use 
larger blocks ( e.g. caching agent on flush) - we can use that size or 
split the provided block into several smaller chunks ( e.g. up to max 
N*stripe_size ) for overhead reduction on random read. Even if client 
uses dynamic block sizes ( low level RADOS use?) we can rely on them 
some way without static bind to stripe size.
Surely this is much easier when appends are permitted only.  General 
"random writes" case will be more complex.

Thanks,
Igor

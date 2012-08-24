From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ideal hardware spec?
Date: Fri, 24 Aug 2012 09:12:23 -0700
Message-ID: <CADvuQRGovEd3vewn95QmeyRyrkxEV59=tm9-xv8KSRKx=xytkw@mail.gmail.com>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl>
 <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63917 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab2HXQMo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:12:44 -0400
Received: by vcbfk26 with SMTP id fk26so2311137vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 09:12:44 -0700 (PDT)
In-Reply-To: <005b01cd8203$43f6e860$cbe4b920$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Fri, Aug 24, 2012 at 7:17 AM, Stephen Perkins <perkins@netmass.com> wrote:
> Adding three machines at once is what I was trying to avoid (I believe that
> I need 3 replicas to make things reasonably redundant).  From first glance,

You need 3 machines to *start with*, to have 3 truly independent
replicas. After that point, there's nothing preventing you from
growing one machine -- or one disk -- at a time.

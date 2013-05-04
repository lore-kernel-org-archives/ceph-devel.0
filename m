From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Erasure encoding as a storage backend
Date: Sat, 4 May 2013 11:27:10 -0700
Message-ID: <C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu>
References: <5185428B.6070109@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:40610 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392Ab3EDS1J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 May 2013 14:27:09 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so1260548dae.2
        for <ceph-devel@vger.kernel.org>; Sat, 04 May 2013 11:27:08 -0700 (PDT)
In-Reply-To: <5185428B.6070109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


On May 4, 2013, at 10:16 AM, Loic Dachary <loic@dachary.org> wrote:

> it would be great to get feedback before the ceph summit to address the most prominent issues.

One thing that has been in the back of my mind is how this proposal is influenced (if at all) by a future that includes declustered per-file raid in CephFS. I realize that may be a distant future, but it seems as though there could be a lot of overlap for the (non-client driven) rebuild/recovery component of such an architecture.

-Noah


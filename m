From: Sage Weil <sage@newdream.net>
Subject: Re: Rados bench with a failed node
Date: Tue, 1 Aug 2017 13:21:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708011319590.20435@piezo.novalocal>
References: <CAODUPsHkC153vq5O7TKjt+ZTgMofsyR7m7hdKdi2ASbKTMWpRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49114 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdHANVK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Aug 2017 09:21:10 -0400
In-Reply-To: <CAODUPsHkC153vq5O7TKjt+ZTgMofsyR7m7hdKdi2ASbKTMWpRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 1 Aug 2017, Oleg Kolosov wrote:
> Hi
> I'm developing my own erasure code and I'm trying to run rados
> benchmark on it. My experiment consists of writing objects, then while
> reading them I stop an OSD and see how it affects latency.
> While running this experiment with 'rados bench' I get an error after
> stopping the osd:
> 
> benchmark_data_adm-1_3806_object8 is not correct!
> read got -5
> error during benchmark: -5
> error 5: (5) Input/output error
> 
> Is it expected to fail like this?

It's hard to say what's happening without logs, but my guess would be that 
your erasure code isn't correctly reconstructing the stripe when a 
shard is missing.

> Is there a way to bypass it or somehow perform my experiment?

If it's what I'm guessing, not really... nor would you want to.  I would 
enable osd logging to see where the EIO is coming from.

sage

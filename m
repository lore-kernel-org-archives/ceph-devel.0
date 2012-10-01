From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Mon, 1 Oct 2012 09:47:24 -0700
Message-ID: <CADvuQRFS8VBt9aCtAMB_NADd0b3RGyuY5FMcyVRx5heksKQB_Q@mail.gmail.com>
References: <50631E97.5050100@inktank.com> <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
 <CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54263 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab2JAQrp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 12:47:45 -0400
Received: by qaas11 with SMTP id s11so1689761qaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 09:47:44 -0700 (PDT)
In-Reply-To: <CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: bryan@virginia.edu, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Sep 27, 2012 at 11:04 AM, Gregory Farnum <greg@inktank.com> wrote:
> However, my suspicion is that you're limited by metadata throughput
> here. How large are your files? There might be some MDS or client
> tunables we can adjust, but rsync's workload is a known weak spot for
> CephFS.

I feel like people are missing this part of Greg's message. Everyone
is so busy benchmarking RADOS small I/O, but what if it's currently
bottlenecked by all the file-level access operations that interact
with the MDS? Rsync causes a ton of those.

If you want to benchmark just the small IO, you can't compare rsync to rsync.

If you want to benchmark just the metadata part, rsync with 0-size
files might actually be an interesting workload.

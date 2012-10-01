From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Mon, 01 Oct 2012 12:03:59 -0500
Message-ID: <5069CCFF.5040701@inktank.com>
References: <50631E97.5050100@inktank.com> <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu> <CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com> <CADvuQRFS8VBt9aCtAMB_NADd0b3RGyuY5FMcyVRx5heksKQB_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38954 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab2JAREB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 13:04:01 -0400
Received: by ieak13 with SMTP id k13so12642286iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 10:04:00 -0700 (PDT)
In-Reply-To: <CADvuQRFS8VBt9aCtAMB_NADd0b3RGyuY5FMcyVRx5heksKQB_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, bryan@virginia.edu, ceph-devel@vger.kernel.org

On 10/01/2012 11:47 AM, Tommi Virtanen wrote:
> On Thu, Sep 27, 2012 at 11:04 AM, Gregory Farnum<greg@inktank.com>  wrote:
>> However, my suspicion is that you're limited by metadata throughput
>> here. How large are your files? There might be some MDS or client
>> tunables we can adjust, but rsync's workload is a known weak spot for
>> CephFS.
>
> I feel like people are missing this part of Greg's message. Everyone
> is so busy benchmarking RADOS small I/O, but what if it's currently
> bottlenecked by all the file-level access operations that interact
> with the MDS? Rsync causes a ton of those.
>
> If you want to benchmark just the small IO, you can't compare rsync to rsync.
>
> If you want to benchmark just the metadata part, rsync with 0-size
> files might actually be an interesting workload.

I guess most of the small IO testing we've seen/done has been without 
CephFS at all.  It's entirely possible that the MDS is slowing things 
down with an rsync workload like this on a fresh filesystem though. 
Having said that, I don't like the way that our small IO performance 
behaves (especially over time) when doing something like RADOS Bench. 
It definitely seems like there is some pretty nasty underlying 
filesystem metadata fragmentation or something going on after a while.

Mark

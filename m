From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Mon, 1 Oct 2012 10:00:15 -0700
Message-ID: <CAPYLRzh8UggCDRfiMv2fzQ4=h2cdm9P1FejMpAntfRrq6nY_GQ@mail.gmail.com>
References: <50631E97.5050100@inktank.com>
	<201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
	<CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
	<CADvuQRFS8VBt9aCtAMB_NADd0b3RGyuY5FMcyVRx5heksKQB_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52456 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab2JARAQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 13:00:16 -0400
Received: by ieak13 with SMTP id k13so12631245iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 10:00:15 -0700 (PDT)
In-Reply-To: <CADvuQRFS8VBt9aCtAMB_NADd0b3RGyuY5FMcyVRx5heksKQB_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: bryan@virginia.edu, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On Mon, Oct 1, 2012 at 9:47 AM, Tommi Virtanen <tv@inktank.com> wrote:
> On Thu, Sep 27, 2012 at 11:04 AM, Gregory Farnum <greg@inktank.com> w=
rote:
>> However, my suspicion is that you're limited by metadata throughput
>> here. How large are your files? There might be some MDS or client
>> tunables we can adjust, but rsync's workload is a known weak spot fo=
r
>> CephFS.
>
> I feel like people are missing this part of Greg's message. Everyone
> is so busy benchmarking RADOS small I/O, but what if it's currently
> bottlenecked by all the file-level access operations that interact
> with the MDS? Rsync causes a ton of those.

Yes. Bryan, you mentioned that you didn't see a lot of resource usage
=97 was it perhaps flatlined at (100 * 1 / num_cpus)? The MDS is
multi-threaded in theory, but in practice it has the equivalent of a
Big Kernel Lock so it's not going to get much past one cpu core of
time...
The rados bench results do indicate some pretty bad small-file write
performance as well though, so I guess it's possible your testing is
running long enough that the page cache isn't absorbing that hit. Did
performance start out higher or has it been flat?

> If you want to benchmark just the small IO, you can't compare rsync t=
o rsync.
>
> If you want to benchmark just the metadata part, rsync with 0-size
> files might actually be an interesting workload.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

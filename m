From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Thu, 27 Sep 2012 11:04:45 -0700
Message-ID: <CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
References: <50631E97.5050100@inktank.com>
	<201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60951 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2I0SEq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 14:04:46 -0400
Received: by ieak13 with SMTP id k13so5187238iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 11:04:45 -0700 (PDT)
In-Reply-To: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@virginia.edu
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Sep 26, 2012 at 1:54 PM, Bryan K. Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
> Hi Mark,
>
>         Thanks for your help.  Some answers to your questions
> are below.
>
> mark.nelson@inktank.com said:
>> On 09/26/2012 09:50 AM, Bryan K. Wright wrote:
>> Hi folks,
>> Hi Bryan!
>> >
>>       I'm seeing reasonable performance when I run rados
>> benchmarks, but really slow I/O when reading or writing
>> from a mounted ceph filesystem.  The rados benchmarks
>> show about 150 MB/s for both read and write, but when I
>> go to a client machine with a mounted ceph filesystem
>> and try to rsync a large (60 GB) directory tree onto
>> the ceph fs, I'm getting rates of only 2-5 MB/s.
>> Was the rados benchmark run from the same client machine that the  filesystem
>> is being mounted on?  Also, what object size did you use for  rados bench?
>> Does the directory tree have a lot of small files or a few  very large ones?
>
>         The rados benchmark was run on one of the OSD
> machines.  Read and write results looked like this (the
> objects size was just the default, which seems to be 4kB):

Actually, that's 4MB. ;) Can you run
# rados bench -p pbench 900 write -t 256 -b 4096
and see what that gets? It'll run 256 simultaneous 4KB writes. (You
can also vary the number of simultaneous writes and see if that
impacts it.)

However, my suspicion is that you're limited by metadata throughput
here. How large are your files? There might be some MDS or client
tunables we can adjust, but rsync's workload is a known weak spot for
CephFS.
-Greg

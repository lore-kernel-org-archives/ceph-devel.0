From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Measuring lock conention
Date: Thu, 13 Apr 2017 14:02:50 -0400
Message-ID: <6481e2a7-0913-de41-2f35-40e44043bb0a@suse.com>
References: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
 <61444443-9337-c5ce-76ba-7e8a7a765232@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60060 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdDMSDY (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 13 Apr 2017 14:03:24 -0400
In-Reply-To: <61444443-9337-c5ce-76ba-7e8a7a765232@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


On 04/13/2017 01:20 PM, Mark Nelson wrote:
> Nice!  I will give it a try and see how it goes. Specifically I want 
> to compare it to what I ended up working on yesterday.  After the 
> meeting I ended up doing major surgery on an existing gdb based 
> wallclock profiler and modified it to a) work b) be thread aware c) 
> print inverse call-graphs.  The code is still pretty rough but you can 
> see it here:
>
> https://github.com/markhpc/gdbprof
Very neat, thank you for this. Please let me know what happens, I'm 
interested to see which tool ends up working best for this use case. 
Also, could you share some information about what you're trying to find out?

If I'm not mistaken, there's work being done to add the call stack of a 
process within the context of LTTng events. That way we could have this 
information when a process blocks in sys_futex.

PS: found it, it's still in RFC - 
https://lists.lttng.org/pipermail/lttng-dev/2017-March/026985.html

Mohamad

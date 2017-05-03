From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Tracing Ceph results
Date: Tue, 2 May 2017 19:49:38 -0500
Message-ID: <871b2d01-6da2-0e8b-c034-d375e719aeed@redhat.com>
References: <3b0fde47-4325-6c5c-f121-7a250fedb195@suse.com>
 <alpine.DEB.2.11.1705022044070.32730@piezo.novalocal>
 <51909d0c-e1de-d349-1515-80a85427aebf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbdECAtk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 2 May 2017 20:49:40 -0400
In-Reply-To: <51909d0c-e1de-d349-1515-80a85427aebf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.com>, Sage Weil <sage@newdream.net>
Cc: anjaneya.chagam@intel.com, ceph-devel <ceph-devel@vger.kernel.org>

On 05/02/2017 04:05 PM, Mohamad Gebai wrote:
> On 05/02/2017 04:47 PM, Sage Weil wrote:
>> On Tue, 2 May 2017, Mohamad Gebai wrote:
>>> Image [2] shows a better image of the call stack view, and Image [3]
>>> shows a
>>> better one of the critical path.
>>>
>>> The code is in branch [4].
>> These are awesome! What is the tool you're screenshotting to visualize?
> Sorry, I forgot to mention that part. The viewing tool is TraceCompass
> (use with an SSD because the traces are quite big).
>> It would be great to apply the build options based on an option passed to
>> cmake (e.g, -DWITH_INSTRUMENT_FUNCTIONS).
> That's definitely an option, I'll submit a patch. The thing is that it
> also needs -no-pie in order to resolve the function addresses at
> analysis time.
>> Also, I wonder if these are a better/simpler alternative to the
>> FUNCTRACE() macro in src/common/EventTrace.h.  What kind of overhead is
>> introduced?  LTTNG lets you enable on specific tracepoints, right?
> Indeed, but these are all the same tracepoint (function_entry and
> function_exit, with different payloads depending on the function that is
> called). We could also limit the stack depth to stop tracing after a
> certain number of nested function calls.
>
> I've done some benchmarking of LTTng in the past. On average, a kernel
> tracepoint costs less than 100ns and a userspace one is around 150ns. It
> also hits the disk to periodically flush the tracing buffers. The
> overhead is definitely non negligeable. I'll write a how-to as there are
> quite a few steps to get all of this running.

Awesome job Mohamad!  It'd be sweet if we could automate the tracing and 
geneation of plots like this.  Some time I'd like to be able to include 
tracing like this during CBT benchmark runs.

Mark

>
> Mohamad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

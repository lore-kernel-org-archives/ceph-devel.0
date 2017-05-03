From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Tracing Ceph results
Date: Wed, 3 May 2017 09:45:54 -0400
Message-ID: <2a7dbb76-8eb1-0c31-dd0d-bf8a3594de73@suse.com>
References: <3b0fde47-4325-6c5c-f121-7a250fedb195@suse.com>
 <alpine.DEB.2.11.1705022044070.32730@piezo.novalocal>
 <51909d0c-e1de-d349-1515-80a85427aebf@suse.com>
 <871b2d01-6da2-0e8b-c034-d375e719aeed@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57009 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdECNqa (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 3 May 2017 09:46:30 -0400
In-Reply-To: <871b2d01-6da2-0e8b-c034-d375e719aeed@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>
Cc: anjaneya.chagam@intel.com, ceph-devel <ceph-devel@vger.kernel.org>

On 05/02/2017 08:49 PM, Mark Nelson wrote:
> On 05/02/2017 04:05 PM, Mohamad Gebai wrote:
>>
>> I've done some benchmarking of LTTng in the past. On average, a kernel
>> tracepoint costs less than 100ns and a userspace one is around 150ns. It
>> also hits the disk to periodically flush the tracing buffers. The
>> overhead is definitely non negligeable. I'll write a how-to as there are
>> quite a few steps to get all of this running.
>
> Awesome job Mohamad!  It'd be sweet if we could automate the tracing 
> and geneation of plots like this.  Some time I'd like to be able to 
> include tracing like this during CBT benchmark runs.
>
Thanks Mark! I'll try to play with CBT and tracing automation, and I'll 
let you know if I find anything interesting.

Mohamad

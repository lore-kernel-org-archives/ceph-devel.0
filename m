From: Artur Molchanov <artur.molchanov@synesis.ru>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Sat, 11 Feb 2017 23:30:02 +0300
Message-ID: <000f7e99-d074-d2a6-5e8a-f115106a913d@synesis.ru>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
 <1486726280.4233.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35587 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdBKUaF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Feb 2017 15:30:05 -0500
Received: by mail-lf0-f68.google.com with SMTP id v186so5465792lfa.2
        for <ceph-devel@vger.kernel.org>; Sat, 11 Feb 2017 12:30:04 -0800 (PST)
In-Reply-To: <1486726280.4233.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Jef,

On Fri, 2017-02-10 at 14:31, Jeff Layton wrote:
> On Thu, 2017-02-09 at 16:04 +0300, Artur Molchanov wrote:
>> From: Artur Molchanov <artur.molchanov@synesis.ru>
>>
>> Complete stuck requests to OSD with error EIO after osd_request_timeout expired.
>> If osd_request_timeout equals to 0 (default value) then do nothing with
>> hung requests (keep default behavior).
>>
>> Create RBD map option osd_request_timeout to set timeout in seconds. Set
>> osd_request_timeout to 0 by default.
>>
> Also, what exactly are the requests blocked on when this occurs? Is the
> ceph_osd_request_target ending up paused? I wonder if we might be better
> off with something that returns a hard error under the circumstances
> where you're hanging, rather than depending on timeouts.

I wonder that it is better to complete requests only after timeout expired, just 
because a request can fail due to temporary network issues (e.g. router 
restarted) or restarting machine/services.

> Having a job that has to wake up every second or so isn't ideal. Perhaps
> you would be better off scheduling the delayed work in the request
> submission codepath, and only rearm it when the tree isn't empty after
> calling complete_osd_stuck_requests?

Would you please tell me more about rearming work only if the tree is not empty 
after calling complete_osd_stuck_requests? From what code we should call 
complete_osd_stuck_requests?

As I understood, there are two primary cases:
1 - Requests to OSD failed, but monitors do not return new osdmap (because all 
monitors are offline or monitors did not update osdmap yet).
In this case requests are retried by cyclic calling ceph_con_workfn -> con_fault 
-> ceph_con_workfn. We can check request timestamp and does not call con_fault 
but complete it.

2 - Monitors return new osdmap which does not have any OSD for RBD.
In this case all requests to the last ready OSD will be linked on "homeless" OSD 
and will not be retried until new osdmap with appropriate OSD received. I think 
that we need additional periodic checking timestamp such requests.

Yes, there is already existing job handle_timeout. But the responsibility of 
this job is to sending keepalive requests to slow OSD. I'm not sure that it is a 
good idea to perform additional actions inside this job.
I decided that creating specific job handle_osd_request_timeout is more applicable.

This job will be run only once with a default value of osd_request_timeout (0).
At the same time, I think that user will not use too small value for this 
parameter. I wonder that typical value will be about 1 minute or greater.

> Also, I don't see where this job is ever cancelled when the osdc is torn
> down. That needs to occur or you'll cause a use-after-free oops...

It is my fault, thanks for the correction.

-- 
Artur

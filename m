From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: REST APIs
Date: Sat, 16 Sep 2017 11:51:48 +0300
Message-ID: <9b92fe4b-cafa-a293-d4be-12b9e455b132@redhat.com>
References: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
 <1505396014.391.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:45398 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdIPIvy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Sep 2017 04:51:54 -0400
Received: by mail-wm0-f49.google.com with SMTP id g206so12846507wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 16 Sep 2017 01:51:54 -0700 (PDT)
In-Reply-To: <1505396014.391.8.camel@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Ranto <branto@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mailing list for the contributors to the Tendrl project <tendrl-devel@redhat.com>, Jeff Brown <jefbrown@redhat.com>

On 09/14/2017 04:33 PM, Boris Ranto wrote:
> Hi,
>
> I still plan to port the v1 endpoints from calamari to the restful
> module so that it provides a full replacement for calamari rest api and
> so that it could be used by projects like tendlr.
>
> We do document the restful module in the RHCEPH product and several
> people are/were interested in it. I did not hear of any product/app
> being built on top of it yet though.
>
> We can extend the pass through method in the restful module so that it
> is more user friendly for a more robust/useful replacement of the ceph-
> rest-api.
>
> Regards,
> Boris

This sounds very useful to me - have REST API's let us plug into various 
frameworks in a standard way.

thanks!

Ric

>
>
> On Wed, 2017-09-13 at 14:43 +0100, John Spray wrote:
>> Hi all,
>>
>> This message is prompted by: https://github.com/ceph/ceph/pull/17530
>>
>> Questions:
>>   - Is anyone using either ceph-rest-api or the restful module?
>>   - Is anyone planning on doing any work on either?
>>   - Is the CLI pass through of the restful module a sufficient
>> replacement for ceph-rest-api for anyone that was using it?
>>
>> John


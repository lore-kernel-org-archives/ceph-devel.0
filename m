From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Wed, 7 Sep 2016 17:05:34 -0400
Message-ID: <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36004 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbcIGVFh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2016 17:05:37 -0400
Received: by mail-yb0-f179.google.com with SMTP id u125so10266419ybg.3
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2016 14:05:36 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id f203sm9461454ywb.52.2016.09.07.14.05.34
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 14:05:35 -0700 (PDT)
In-Reply-To: <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 09/07/2016 01:19 PM, Radoslaw Zarzynski wrote:
> Anyway, before we start discussing the whole
> auth stuff further, I guess it would be helpful to
> write in one place all requirements/plans that
> might affect this area. For instance, the idea of
> RGWHandler rework can have such impact.
>
> Let me start the requirements with an item found
> after a session with Swift's FormPost middleware:
>
> * the auth infrastructure must allow for easy-adoption
>    of new AuthEngines as even FormPost would need
>    one :-).

Some specific requirements that I recall from our past discussions include:

- don't heap allocate auth state per request
- don't construct or call into AuthEngines that shouldn't be enabled for 
the given handler

I'll add some of the other refactoring goals we've discussed, but I 
don't think they place any strict requirements on the auth subsystem:

- RGWHandler: being able to reuse handler instances, instead of 
allocating a new one for each request
- req_state: contains too many unrelated fields, some of which are 
transformed in confusing ways over the lifetime of the request. needs to 
be broken up into smaller, better encapsulated sub-objects
- concurrency: move away from a synchronous process_request() to build 
on asio frontend work

From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Wed, 7 Sep 2016 17:09:58 -0400
Message-ID: <45ac8340-c6eb-8cdc-9c83-3db6f7f3fcd6@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34563 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcIGVKB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2016 17:10:01 -0400
Received: by mail-yb0-f175.google.com with SMTP id x93so10357033ybh.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2016 14:10:00 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id b9sm15586920ywh.45.2016.09.07.14.09.59
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 14:09:59 -0700 (PDT)
In-Reply-To: <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 09/07/2016 01:19 PM, Radoslaw Zarzynski wrote:
> Where I see problems is AWS Auth v4. It's truly
> state-full. And when it comes to handling state,
> I would prefer to use the language assistance for
> it (non-static class members) instead of letting
> internals (context) leak to req_state.
AWS v4 is a good example to look at, yeah. It's a special case, because 
there's a separate 'complete' step after reading the body of the 
request, so we need to track auth state between the calls to authorize() 
and complete(). The current implementation stores this stuff in a 
'struct rgw_aws4_auth' member of req_state.

So far, all of the AuthEngine instances have been constructed on the 
stack in their handler's authorize() method, so their state has been 
limited to that scope. If a new AWS4AuthEngine were to encapsulate v4 
auth this state, the engine would have to live somewhere outside of the 
authorize() method - most likely in req_state. But we could just as 
easily have a stateless AWS4AuthEngine that accessed the existing 
rgw_aws4_auth via req_state. Encapsulation of rgw_aws4_auth could be 
improved by making everything private except for a complete() method 
(and call it  AWS4AuthCompletion, for example).

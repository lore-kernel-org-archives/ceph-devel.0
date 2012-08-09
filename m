From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 3.6-rc1] libceph: ensure banner is written on client
 connect before feature negotiation starts
Date: Thu, 9 Aug 2012 11:12:45 -0600
Message-ID: <5023EF8D.90100@sandia.gov>
References: <1344449378-304-1-git-send-email-jaschut@sandia.gov>
 <50230EB9.1070302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:41110 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2HIRNO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 13:13:14 -0400
In-Reply-To: <50230EB9.1070302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/08/2012 07:13 PM, Alex Elder wrote:
> On 08/08/2012 11:09 AM, Jim Schutt wrote:
>> Because the Ceph client messenger uses a non-blocking connect, it is possible
>> for the sending of the client banner to race with the arrival of the banner
>> sent by the peer.
>
> This is possible because the server-side messenger immediately sends
> its banner and addresses after accepting a connect request, *before*
> actually attempting to read or verify the banner from the client.

It just occurred to me this really should be added to the commit
message if you take the patch.  I can resend with it added, or
you can add it when you commit the patch.

Thanks for verifying this aspect of what's happening.

>
>> When ceph_sock_state_change() notices the connect has completed, it schedules
>> work to process the socket via con_work().  During this time the peer is
>> writing its banner, and arrival of the peer banner races with con_work().
>>
>> If con_work() calls try_read() before the peer banner arrives, there is
>> nothing for it to do, after which con_work() calls try_write() to send the
>> client's banner.  In this case Ceph's protocol negotiation can complete
>> succesfully.
>>
>> If, however, the peer's banner arrives before con_work() calls try_read(),
>> then try_read() will read the banner and prepare protocol negotiation info via
>> prepare_write_connect().  prepare_write_connect() calls con_out_kvec_reset(),
>> which discards the as-yet-unsent client banner.  Next, con_work() calls
>> try_write(), which sends the protocol negotiation info rather than the banner
>> that the peer is expecting.
>
> I believe your analysis is correct.  And I think your solution sounds
> good as well.  I think Sage was going to take a look at this also, and
> I'll wait for him to have a chance to comment.  But in any case, your
> fix looks good.  Nice job.

Thanks for taking a look.

-- Jim



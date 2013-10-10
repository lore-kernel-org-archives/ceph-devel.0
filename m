From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: mds stuck in clientreplay state after failover
Date: Thu, 10 Oct 2013 09:00:29 +0800
Message-ID: <CAAM7YAnAue2y9anrdUMPmY1z4XoiUggXgaP5Zf8+UaYt+QKzuw@mail.gmail.com>
References: <CAMm-wcKj8nOHj739wMy07=hi2-6hqW77FSauT9ObgrsMPuGn1w@mail.gmail.com>
	<CAPYLRzhOME-xn5Da35YhmSYKDJwDHNqWo2+fe++7obnqRkDuZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38401 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab3JJBAb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Oct 2013 21:00:31 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so1487858lbd.16
        for <ceph-devel@vger.kernel.org>; Wed, 09 Oct 2013 18:00:30 -0700 (PDT)
In-Reply-To: <CAPYLRzhOME-xn5Da35YhmSYKDJwDHNqWo2+fe++7obnqRkDuZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Dong Yuan <yuandong1222@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 10, 2013 at 1:31 AM, Gregory Farnum <greg@inktank.com> wrote:
> Right now the best way to deal with this is unfortunately to get logs
> and figure out what operation got blocked. Can you add
>
> debug mds = 20
> debug ms = 1
> debug journaler = 20
>
> to your mds config, restart, and then search through/post that log
> somewhere we can check it out? (It will be large.)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
> On Tue, Oct 8, 2013 at 10:21 PM, Dong Yuan <yuandong1222@gmail.com> wrote:
>> I think I found a bug about the clientreply of mds. (different from #4742)
>>
>> After failover, the standby mds begin to recover and enter the
>> clientreply state and never moves to the next state(Active).
>>
>> I gdbed the mds process by gcore and found that the main thread
>> (dispatch thread) is idle and  mdcache->active_request is empty, but
>> mds->replay_queue still has one element, that is strange.
>>
>> From the code, replay_queue has all requests which need to be
>> replayed. When the mds enters clientreplay state,
>> MDS::queue_one_replay will be called to pick a requect from the
>> replay_queue and put the request into finished_queue. So the replay
>> operation begins to work.
>>
>> After the first replay request has finished,  MDS::queue_one_replay
>> should be called again to deal with the next replay request. There are
>> three paths to do this:
>> 1) Server::journal_and_reply
>> 2) MDCache::reqeust_cleanup
>> 3) Server::handle_client_request
>>
>> But it seems that no path called the MDS::queue_one_replay method. As
>> a result,  the mds stuck in clientreplay state.
>>
>> Maybe there is a request process path which will never use the above
>> three methed. But I can't find the previous request while it seems to
>> completed and cleaned up from the MDCache.
>>
>> There is any one has some idea about these problem?

could you please check if MDCache::open is true?

Regards
Yan, Zheng

>>
>> I can give more details if needed. I have the core dump but it is too
>> big (300MB+) to upload.
>>
>> Thanks for any help.
>>
>> --
>> Dong Yuan
>> Email:yuandong1222@gmail.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

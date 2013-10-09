From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds stuck in clientreplay state after failover
Date: Wed, 9 Oct 2013 10:31:42 -0700
Message-ID: <CAPYLRzhOME-xn5Da35YhmSYKDJwDHNqWo2+fe++7obnqRkDuZQ@mail.gmail.com>
References: <CAMm-wcKj8nOHj739wMy07=hi2-6hqW77FSauT9ObgrsMPuGn1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:46849 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab3JIRbo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Oct 2013 13:31:44 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1016369lab.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Oct 2013 10:31:43 -0700 (PDT)
In-Reply-To: <CAMm-wcKj8nOHj739wMy07=hi2-6hqW77FSauT9ObgrsMPuGn1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Right now the best way to deal with this is unfortunately to get logs
and figure out what operation got blocked. Can you add

debug mds = 20
debug ms = 1
debug journaler = 20

to your mds config, restart, and then search through/post that log
somewhere we can check it out? (It will be large.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

On Tue, Oct 8, 2013 at 10:21 PM, Dong Yuan <yuandong1222@gmail.com> wrote:
> I think I found a bug about the clientreply of mds. (different from #4742)
>
> After failover, the standby mds begin to recover and enter the
> clientreply state and never moves to the next state(Active).
>
> I gdbed the mds process by gcore and found that the main thread
> (dispatch thread) is idle and  mdcache->active_request is empty, but
> mds->replay_queue still has one element, that is strange.
>
> From the code, replay_queue has all requests which need to be
> replayed. When the mds enters clientreplay state,
> MDS::queue_one_replay will be called to pick a requect from the
> replay_queue and put the request into finished_queue. So the replay
> operation begins to work.
>
> After the first replay request has finished,  MDS::queue_one_replay
> should be called again to deal with the next replay request. There are
> three paths to do this:
> 1) Server::journal_and_reply
> 2) MDCache::reqeust_cleanup
> 3) Server::handle_client_request
>
> But it seems that no path called the MDS::queue_one_replay method. As
> a result,  the mds stuck in clientreplay state.
>
> Maybe there is a request process path which will never use the above
> three methed. But I can't find the previous request while it seems to
> completed and cleaned up from the MDCache.
>
> There is any one has some idea about these problem?
>
> I can give more details if needed. I have the core dump but it is too
> big (300MB+) to upload.
>
> Thanks for any help.
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Dong Yuan <yuandong1222@gmail.com>
Subject: mds stuck in clientreplay state after failover
Date: Wed, 9 Oct 2013 13:21:51 +0800
Message-ID: <CAMm-wcKj8nOHj739wMy07=hi2-6hqW77FSauT9ObgrsMPuGn1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:60290 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3JIFVx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Oct 2013 01:21:53 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so287217wes.23
        for <ceph-devel@vger.kernel.org>; Tue, 08 Oct 2013 22:21:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I think I found a bug about the clientreply of mds. (different from #4742)

After failover, the standby mds begin to recover and enter the
clientreply state and never moves to the next state(Active).

I gdbed the mds process by gcore and found that the main thread
(dispatch thread) is idle and  mdcache->active_request is empty, but
mds->replay_queue still has one element, that is strange.

From the code, replay_queue has all requests which need to be
replayed. When the mds enters clientreplay state,
MDS::queue_one_replay will be called to pick a requect from the
replay_queue and put the request into finished_queue. So the replay
operation begins to work.

After the first replay request has finished,  MDS::queue_one_replay
should be called again to deal with the next replay request. There are
three paths to do this:
1) Server::journal_and_reply
2) MDCache::reqeust_cleanup
3) Server::handle_client_request

But it seems that no path called the MDS::queue_one_replay method. As
a result,  the mds stuck in clientreplay state.

Maybe there is a request process path which will never use the above
three methed. But I can't find the previous request while it seems to
completed and cleaned up from the MDCache.

There is any one has some idea about these problem?

I can give more details if needed. I have the core dump but it is too
big (300MB+) to upload.

Thanks for any help.

-- 
Dong Yuan
Email:yuandong1222@gmail.com

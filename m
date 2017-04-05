From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 3/5] ceph: fix potential use-after-free
Date: Thu, 6 Apr 2017 07:59:32 +0800
Message-ID: <1E86D7FE-0751-4C78-B39D-C2199E64F874@redhat.com>
References: <20170405013019.5032-1-zyan@redhat.com>
 <20170405013019.5032-3-zyan@redhat.com>
 <1491412901.18658.16.camel@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756252AbdDEX7g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Apr 2017 19:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC12E461EA
        for <ceph-devel@vger.kernel.org>; Wed,  5 Apr 2017 23:59:35 +0000 (UTC)
In-Reply-To: <1491412901.18658.16.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel@vger.kernel.org


> On 6 Apr 2017, at 01:21, Jeff Layton <jlayton@redhat.com> wrote:
> 
> On Wed, 2017-04-05 at 09:30 +0800, Yan, Zheng wrote:
>> __unregister_session() free the session if it drops the last
>> reference. We should grab an extra reference if we want to use
>> session after __unregister_session().
>> 
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>> fs/ceph/mds_client.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 163f0d3..bf765a8 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -2658,8 +2658,10 @@ static void handle_session(struct ceph_mds_session *session,
>> 	seq = le64_to_cpu(h->seq);
>> 
>> 	mutex_lock(&mdsc->mutex);
>> -	if (op == CEPH_SESSION_CLOSE)
>> +	if (op == CEPH_SESSION_CLOSE) {
>> +		get_session(session);
>> 		__unregister_session(mdsc, session);
>> +	}
>> 	/* FIXME: this ttl calculation is generous */
>> 	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
>> 	mutex_unlock(&mdsc->mutex);
>> @@ -2748,6 +2750,8 @@ static void handle_session(struct ceph_mds_session *session,
>> 			kick_requests(mdsc, mds);
>> 		mutex_unlock(&mdsc->mutex);
>> 	}
>> +	if (op == CEPH_SESSION_CLOSE)
>> +		ceph_put_mds_session(session);
>> 	return;
>> 
>> bad:
>> @@ -3148,8 +3152,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>> 			if (s->s_state == CEPH_MDS_SESSION_OPENING) {
>> 				/* the session never opened, just close it
>> 				 * out now */
>> -				__wake_requests(mdsc, &s->s_waiting);
>> +				get_session(s);
>> 				__unregister_session(mdsc, s);
>> +				__wake_requests(mdsc, &s->s_waiting);
>> +				ceph_put_mds_session(s);
> 
> What about this last bit? Why do we need to __wake_requests after
> __unregister_session here? If not for that change then you wouldn't
> need to take the extra reference here, AFAICS.

wake_requests() calls __do_request(). I think do_request may choose the session we want to unregister.

> 
>> 			} else {
>> 				/* just close it */
>> 				mutex_unlock(&mdsc->mutex);
> 
> Reviewed-by: Jeff Layton <jlayton@redhat.com>


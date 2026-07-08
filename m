Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB630D41D
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549068; cv=none; b=lkx+RESDp7jdMeJkplrCSxzflTppZAWNnXNs/ai5GNATuQ3MLNKcNEPK8kRWjizNDLPAJuM7NtiPpAqXME0Tar203mdSGuBTrs/OSDM5b+yvgrEufd7f5naqJKqeWu2zP8CnE61IOLTaNtbkH6uOuJInFREYhRtOwRxllhJGcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549068; c=relaxed/simple;
	bh=sP5TaXE6OCX4DtncDP5hN1KCYLKaTlPVM3ZLgKb4cho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4AFCHdoF+DYX5kfFU+2GL77u4M9kwTbv5r4+Qdbfl35CwxQ8f1DbyNQDoo68MJ0wFK5zBevavMOhF8ZoACAJkrlPEE31xfMjW06gZFTd01mVHJMA/lws/J/TuHw01Bp6aUnGSVFEphaP1UkXI3pgpVEHdQxlVn2Mgw0xVwqbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZJTJrmiP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZJTJrmiP"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-495b250b01cso977157b6e.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jul 2026 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1783549065; x=1784153865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=24y69AJneapRjn/79LSS7d+cxbOO03kpFqP/nxLFpxA=;
        b=ZJTJrmiPn5BYr/HxTDJW2uIJ9qPj00q8rlmnSQrE9Yhyz61Ycwj0kgt7JGpCJ2YSev
         7BsIHUE+O1XeN8vQh1egFILGyaXrjrxaD+ZrRam/g5tNSSlozqZtwAqigC22ExD/BIeA
         rhGgzQPyAptBOe9tYnxaDHaCK5lpOvfehL77Td7rIY1FLvuNrjsQQN5+KhZYG37mE6GS
         HrW3iQwWELQpqUI8QL+yPpSYwXcfSZijls9+bL1o/EbXmIr4oXGKHtI7L6pm+fn6Ehjj
         lRhWYS1R3ILGPLT5bARl28i3QVS/1QxtxkirKVwdyTc69ULG+1qQwunX9UH332YZ/ryr
         cYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549065; x=1784153865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24y69AJneapRjn/79LSS7d+cxbOO03kpFqP/nxLFpxA=;
        b=qrQXlqYRFGpEWr/LlWzNJOvK7gSak4jTtSFMnM/h7klzy47ntNcMr9DR3YIffM8JfM
         a2daotvCAaiBlCgf0L4P/Cl2yzOQHGFvKiDG4U97mBgS0+OkZTptFYGPlfJWxid+j5j6
         ApuUy5KgBi69GNPBYPFCQLBV7ZPUG/RNwFWw/POLcCOPQfYhhfaQPJ9P/mLnZhD7NjcU
         OiOlE+5SWB2XI5QoKIxTb2WF56wzO7V+LxYc7m763PMx+a/xOtdQgg0FagQBGnFkU6PB
         +WtZYqAATUdSQQugukPiiAkhyK9FTah3Coo1pip461RhVdjLaIH5+jnzamwGDFLwTfJx
         eLSg==
X-Forwarded-Encrypted: i=1; AFNElJ/bki3aampTlkku8WIXrKnfUt7uG7DWJMkuzvHUZ8cW7tCZn5TY0LvtK1rzryPiQIYv+WLIu5E7uIlM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl++cKAFpEjp25eMGTNgJ2loCDgwW7K0BGwhfvsvmideupMOmr
	0+e5ysQCUypptXQ2kJqbkMUG8qJlg8zz83KTT71F6BsYBzPumNxmEq7grFGbQwEXjtY=
X-Gm-Gg: AfdE7ck0wCPK2i1Y1lRW/lDdN6k2qjBA3YRiskzUNPQSExaHmb4n7ENRnxOdHvLzDFT
	fl8hVhys5DS+cTozbv40IQAVQ3UQUmM2acT9hO8WwytK/Y9DbLkiub6+umsIGEtJIz2xLgbTJjL
	kScpSH1Qar2SzI6m+tK9dNBL8JWCX2g+Nwlv2Js8+gDnMfHNtxHbQ0LarKcZXvldYmtvWV5tzAT
	+a1NWRjlmTUREf/Kda1izhZuI5bGo20Dhqyr4nNvHXSt+5HiAn8/j7Mi0K2milQHg8uoobJdfD7
	LPEIfj2xF7V0LcX9WNBoEUO1QbeIRi78hapO0wAbtf9JY/6OKkPvb3tmF0wbR/ReQnlhCyLLDJ5
	Lrrr7vnUvNANP/B7ozEL2DiNMHAxayVRgaaGIVKwX3yzwOEb1bDZtNtWsXRJ/Ko2HNVcEaq8=
X-Received: by 2002:a05:6808:1808:b0:49b:1b6d:c95 with SMTP id 5614622812f47-4a20200e0eemr3409823b6e.11.1783549065242;
        Wed, 08 Jul 2026 15:17:45 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:2632::3ce:9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1adca6bedsm2645440b6e.8.2026.07.08.15.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 15:17:43 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:17:40 -0500
From: Chris Arges <carges@cloudflare.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"zyan@redhat.com" <zyan@redhat.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"ademaria@cloudflare.com" <ademaria@cloudflare.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH] libceph: reset OSD session when keepalive2 acks stop
 arriving
Message-ID: <ak7MhOYrTMip9IpF@20HS2G4>
References: <20260707-fix-rbd-keepalives-v1-1-be888d525d6a@cloudflare.com>
 <c97c245feafde9295dea3039fc3d2c01d1e1d741.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97c245feafde9295dea3039fc3d2c01d1e1d741.camel@ibm.com>

On 2026-07-08 21:07:53, Viacheslav Dubeyko wrote:
> On Tue, 2026-07-07 at 19:46 -0500, Chris J Arges wrote:
> > handle_timeout() in osd_client.c sends CEPH_MSGR2_TAG_KEEPALIVE2 frames
> > to OSDs with stalled requests, but libceph never verifies if the ACKs
> > actually return.
> > 
> > Consequently, if an OSD messenger queue wedges while the underlying
> > TCP socket remains ESTABLISHED, the client will block indefinitely in
> > ceph_osdc_wait_request(), causing tasks to hang in D state.
> > 
> > Fix this by introducing a watchdog in handle_timeout() that checks
> > ceph_con_keepalive_expired() against a new CEPH_OSD_PING_TIMEOUT (60s).
> > On expiry, reset the sparse-read state, call reopen_osd(), and kick
> > outstanding requests when the session is reopened.
> > 
> > Because OSD keepalives are only sent to OSDs with stalled requests,
> > last_keepalive_ack can be stale on an otherwise healthy connection that
> > has simply been idle. Track the start of each slow/probing episode per
> > OSD and require the episode to last CEPH_OSD_PING_TIMEOUT before checking
> > for an expired keepalive ack, so the watchdog only fires after we have
> > been actively pinging.
> > 
> > Additionally, seed last_keepalive_ack to the current time in
> > ceph_con_open() to prevent the watchdog from firing spuriously on fresh
> > connections for both OSD and monitor clients.
> > 
> > Fixes: 8b9558aab853 ("libceph: use keepalive2 to verify the mon session is alive")
> > Link: https://urldefense.proofpoint.com/v2/url?u=https-3A__tracker.ceph.com_issues_76202&d=DwICaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=8udRqH37aQXbOFlaT2eCFf9V5N2umZEpRHyjRWqPY9nOaaxnBb5-_kuP0k6YrT4O&s=4IAHOQNcSzsOsmpIm3nIsgqXGHCx-bxmgd1yDJ3m-VU&e= 
> > Co-developed-by: Andrew DeMaria <ademaria@cloudflare.com>
> > Signed-off-by: Andrew DeMaria <ademaria@cloudflare.com>
> > Signed-off-by: Chris J Arges <carges@cloudflare.com>
> > ---
> > This patch fixes an issue where the kernel rbd client and an OSD have an
> > ESTABLISHED TCP connection, but keepalive2 ACKs stop returning from the
> > OSD. When that happens, outstanding OSD requests can remain held by the
> > client and callers can hang in D state. We were able to mitgiate this
> > issue by using ss -K to kill the affected OSD TCP connection which
> > reopened the OSD session.
> > 
> > We were able to reproduce this issue in production a few times, and
> > synthetically by dropping OSD to rbd application frames while allowing
> > TCP ACKs through.
> > 
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__tracker.ceph.com_issues_76202&d=DwICaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=8udRqH37aQXbOFlaT2eCFf9V5N2umZEpRHyjRWqPY9nOaaxnBb5-_kuP0k6YrT4O&s=4IAHOQNcSzsOsmpIm3nIsgqXGHCx-bxmgd1yDJ3m-VU&e=  describes the same situation.
> > 
> > The following patch addresses this by creating a watchdog that resets the
> > OSD session if this situation is detected.
> > ---
> >  include/linux/ceph/libceph.h    |  1 +
> >  include/linux/ceph/osd_client.h |  1 +
> >  net/ceph/messenger.c            |  3 +++
> >  net/ceph/osd_client.c           | 23 ++++++++++++++++++++++-
> >  4 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> > index 63e0e2aa1ce9..1a117c5f1964 100644
> > --- a/include/linux/ceph/libceph.h
> > +++ b/include/linux/ceph/libceph.h
> > @@ -74,6 +74,7 @@ struct ceph_options {
> >   */
> >  #define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
> >  #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
> > +#define CEPH_OSD_PING_TIMEOUT		msecs_to_jiffies(60 * 1000)
> 
> Could we reuse the user-configurable osd_keepalive_timeout (default 5s)? Why
> exactly 60s has been selected?
> 
> Thanks,
> Slava.
> 

I think CEPH_OSD_KEEPALIVE_TIMEOUT should be distinct from
CEPH_OSD_PING_TIMEOUT. This way keepalive_timeout fires more frequently, and
can still catch a TCP session going bad. The ping_timeout should be longer so
we can try a few application-layer ACKs and if the TCP session is still good
then it shows a session reset may be warranted.

We chose 60s specifically because other timeouts had that value and it worked
in test.

--chris

> >  #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
> >  #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
> >  #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
> > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > index 50b14a5661c7..52eb76e9d62a 100644
> > --- a/include/linux/ceph/osd_client.h
> > +++ b/include/linux/ceph/osd_client.h
> > @@ -94,6 +94,7 @@ struct ceph_osd {
> >  	struct ceph_auth_handshake o_auth;
> >  	unsigned long lru_ttl;
> >  	struct list_head o_keepalive_item;
> > +	unsigned long o_keepalive_stamp;
> >  	struct mutex lock;
> >  	struct ceph_sparse_read	o_sparse_read;
> >  };
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 34b3097b4c7b..f7776d83d506 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -610,6 +610,9 @@ void ceph_con_open(struct ceph_connection *con,
> >  
> >  	memcpy(&con->peer_addr, addr, sizeof(*addr));
> >  	con->delay = 0;      /* reset backoff memory */
> > +
> > +	ktime_get_real_ts64(&con->last_keepalive_ack);
> > +
> >  	mutex_unlock(&con->mutex);
> >  	queue_con(con);
> >  }
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 2ff00070c181..6d9530beb2e3 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -53,6 +53,7 @@ static void link_linger(struct ceph_osd *osd,
> >  static void unlink_linger(struct ceph_osd *osd,
> >  			  struct ceph_osd_linger_request *lreq);
> >  static void clear_backoffs(struct ceph_osd *osd);
> > +static void kick_osd_requests(struct ceph_osd *osd);
> >  
> >  #if 1
> >  static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
> > @@ -3480,8 +3481,11 @@ static void handle_timeout(struct work_struct *work)
> >  			mutex_unlock(&lreq->lock);
> >  		}
> >  
> > -		if (found)
> > +		if (found) {
> >  			list_move_tail(&osd->o_keepalive_item, &slow_osds);
> > +		} else {
> > +			osd->o_keepalive_stamp = 0;
> > +		}
> >  	}
> >  
> >  	if (opts->osd_request_timeout) {
> > @@ -3507,6 +3511,23 @@ static void handle_timeout(struct work_struct *work)
> >  							struct ceph_osd,
> >  							o_keepalive_item);
> >  		list_del_init(&osd->o_keepalive_item);
> > +
> > +		/* Record start of ping timeout from the first slow tick. */
> > +		if (!osd->o_keepalive_stamp) {
> > +			osd->o_keepalive_stamp = jiffies;
> > +		} else if (time_after_eq(jiffies,
> > +				  osd->o_keepalive_stamp + CEPH_OSD_PING_TIMEOUT) &&
> > +		    ceph_con_keepalive_expired(&osd->o_con,
> > +					       CEPH_OSD_PING_TIMEOUT)) {
> > +			pr_warn_ratelimited("osd%d not responding to keepalives, resetting session\n",
> > +					    osd->o_osd);
> > +			osd->o_sparse_op_idx = -1;
> > +			ceph_init_sparse_read(&osd->o_sparse_read);
> > +			if (!reopen_osd(osd))
> > +				kick_osd_requests(osd);
> > +			continue;
> > +		}
> > +
> >  		ceph_con_keepalive(&osd->o_con);
> >  	}
> >  
> > 
> > ---
> > base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> > change-id: 20260707-fix-rbd-keepalives-664fe9266c35
> > 
> > Best regards,
> > --  
> > Chris J Arges <carges@cloudflare.com>
> > 

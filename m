From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 10/39] mds: unify slave request waiting
Date: Wed, 20 Mar 2013 15:52:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303201552210.14461@cobra.newdream.net>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-11-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54277 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab3CTWwd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 18:52:33 -0400
In-Reply-To: <1363531902-24909-11-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

Much simpler!

Reviewed-by: Sage Weil <sage@inktank.com>

On Sun, 17 Mar 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When requesting remote xlock or remote wrlock, the master request is
> put into lock object's REMOTEXLOCK waiting queue. The problem is that
> remote wrlock's target can be different from lock's auth MDS. When
> the lock's auth MDS recovers, MDCache::handle_mds_recovery() may wake
> incorrect request. So just unify slave request waiting, dispatch the
> master request when receiving slave request reply.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Locker.cc | 49 ++++++++++++++++++++++---------------------------
>  src/mds/Server.cc | 12 ++++++++++--
>  2 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index d06a9cc..0055a19 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -544,8 +544,6 @@ void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
>        if (need_issue)
>  	pneed_issue->insert(static_cast<CInode *>(lock->get_parent()));
>      }
> -  } else {
> -    lock->finish_waiters(SimpleLock::WAIT_REMOTEXLOCK);
>    }
>    mut->finish_locking(lock);
>  }
> @@ -1326,18 +1324,16 @@ void Locker::remote_wrlock_start(SimpleLock *lock, int target, MDRequest *mut)
>    }
>  
>    // send lock request
> -  if (!lock->is_waiter_for(SimpleLock::WAIT_REMOTEXLOCK)) {
> -    mut->start_locking(lock, target);
> -    mut->more()->slaves.insert(target);
> -    MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
> -					       MMDSSlaveRequest::OP_WRLOCK);
> -    r->set_lock_type(lock->get_type());
> -    lock->get_parent()->set_object_info(r->get_object_info());
> -    mds->send_message_mds(r, target);
> -  }
> -  
> -  // wait
> -  lock->add_waiter(SimpleLock::WAIT_REMOTEXLOCK, new C_MDS_RetryRequest(mdcache, mut));
> +  mut->start_locking(lock, target);
> +  mut->more()->slaves.insert(target);
> +  MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
> +					     MMDSSlaveRequest::OP_WRLOCK);
> +  r->set_lock_type(lock->get_type());
> +  lock->get_parent()->set_object_info(r->get_object_info());
> +  mds->send_message_mds(r, target);
> +
> +  assert(mut->more()->waiting_on_slave.count(target) == 0);
> +  mut->more()->waiting_on_slave.insert(target);
>  }
>  
>  void Locker::remote_wrlock_finish(SimpleLock *lock, int target, Mutation *mut)
> @@ -1411,19 +1407,18 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
>      }
>      
>      // send lock request
> -    if (!lock->is_waiter_for(SimpleLock::WAIT_REMOTEXLOCK)) {
> -      int auth = lock->get_parent()->authority().first;
> -      mut->more()->slaves.insert(auth);
> -      mut->start_locking(lock, auth);
> -      MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
> -						 MMDSSlaveRequest::OP_XLOCK);
> -      r->set_lock_type(lock->get_type());
> -      lock->get_parent()->set_object_info(r->get_object_info());
> -      mds->send_message_mds(r, auth);
> -    }
> -    
> -    // wait
> -    lock->add_waiter(SimpleLock::WAIT_REMOTEXLOCK, new C_MDS_RetryRequest(mdcache, mut));
> +    int auth = lock->get_parent()->authority().first;
> +    mut->more()->slaves.insert(auth);
> +    mut->start_locking(lock, auth);
> +    MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
> +					       MMDSSlaveRequest::OP_XLOCK);
> +    r->set_lock_type(lock->get_type());
> +    lock->get_parent()->set_object_info(r->get_object_info());
> +    mds->send_message_mds(r, auth);
> +
> +    assert(mut->more()->waiting_on_slave.count(auth) == 0);
> +    mut->more()->waiting_on_slave.insert(auth);
> +
>      return false;
>    }
>  }
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index 6d0519f..4c4c86b 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -1371,7 +1371,11 @@ void Server::handle_slave_request_reply(MMDSSlaveRequest *m)
>        mdr->locks.insert(lock);
>        mdr->finish_locking(lock);
>        lock->get_xlock(mdr, mdr->get_client());
> -      lock->finish_waiters(SimpleLock::WAIT_REMOTEXLOCK);
> +
> +      assert(mdr->more()->waiting_on_slave.count(from));
> +      mdr->more()->waiting_on_slave.erase(from);
> +      assert(mdr->more()->waiting_on_slave.empty());
> +      dispatch_client_request(mdr);
>      }
>      break;
>      
> @@ -1385,7 +1389,11 @@ void Server::handle_slave_request_reply(MMDSSlaveRequest *m)
>        mdr->remote_wrlocks[lock] = from;
>        mdr->locks.insert(lock);
>        mdr->finish_locking(lock);
> -      lock->finish_waiters(SimpleLock::WAIT_REMOTEXLOCK);
> +
> +      assert(mdr->more()->waiting_on_slave.count(from));
> +      mdr->more()->waiting_on_slave.erase(from);
> +      assert(mdr->more()->waiting_on_slave.empty());
> +      dispatch_client_request(mdr);
>      }
>      break;
>  
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

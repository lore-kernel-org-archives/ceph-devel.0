From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 06/39] mds: make table client/server tolerate duplicated message
Date: Fri, 29 Mar 2013 15:00:12 -0700
Message-ID: <CAPYLRzi12A+yFFaY35YMsiMCgdh_fec5QCkc7QFExGGHxN_v-A@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-7-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:56018 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab3C2WAO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 18:00:14 -0400
Received: by mail-we0-f182.google.com with SMTP id k14so621730wer.13
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 15:00:12 -0700 (PDT)
In-Reply-To: <1363531902-24909-7-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

I believe this patch has been outdated thanks to the tid exchange
you're doing now, right?
-Greg

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Anchor client re-sends queries when the anchor server becomes active.
> So it's possible to get duplicated query reply.
>
> When the table server recovers, the clients re-send commits to the
> server, the server re-sends 'agree' messages to the clients. When
> the clients receive the 'agree' messages, they may send another
> commit/rollback message to the server.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/AnchorClient.cc   |  4 +++-
>  src/mds/AnchorServer.cc   |  6 ++++--
>  src/mds/MDSTableServer.cc | 22 ++++++++++++++++------
>  3 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/src/mds/AnchorClient.cc b/src/mds/AnchorClient.cc
> index d7da9d1..bcc8710 100644
> --- a/src/mds/AnchorClient.cc
> +++ b/src/mds/AnchorClient.cc
> @@ -41,7 +41,9 @@ void AnchorClient::handle_query_result(class MMDSTableRequest *m)
>    ::decode(ino, p);
>    ::decode(trace, p);
>
> -  assert(pending_lookup.count(ino));
> +  if (!pending_lookup.count(ino))
> +    return;
> +
>    list<_pending_lookup> ls;
>    ls.swap(pending_lookup[ino]);
>    pending_lookup.erase(ino);
> diff --git a/src/mds/AnchorServer.cc b/src/mds/AnchorServer.cc
> index 6f37e53..594bf7b 100644
> --- a/src/mds/AnchorServer.cc
> +++ b/src/mds/AnchorServer.cc
> @@ -213,10 +213,12 @@ bool AnchorServer::check_pending(version_t tid, MMDSTableRequest *req, list<Cont
>        ++p;
>      }
>      assert(p != pending.end());
> -    assert(p->second == NULL);
>      // not the earliest pending operation, wait if it's a commit
>      if (req) {
> -      p->second = new C_MDS_RetryMessage(mds, req);
> +      if (p->second == NULL)
> +       p->second = new C_MDS_RetryMessage(mds, req);
> +      else
> +       req->put(); // duplicated commit
>        return false;
>      }
>    }
> diff --git a/src/mds/MDSTableServer.cc b/src/mds/MDSTableServer.cc
> index 07c7d26..730606f 100644
> --- a/src/mds/MDSTableServer.cc
> +++ b/src/mds/MDSTableServer.cc
> @@ -120,15 +120,25 @@ void MDSTableServer::_commit_logged(MMDSTableRequest *req)
>  void MDSTableServer::handle_rollback(MMDSTableRequest *req)
>  {
>    dout(7) << "handle_rollback " << *req << dendl;
> -  _rollback(req->get_tid());
> -  _note_rollback(req->get_tid());
> -  mds->mdlog->start_submit_entry(new ETableServer(table, TABLESERVER_OP_ROLLBACK, 0, -1,
> -                                                 req->get_tid(), version));
> +
> +  version_t tid = req->get_tid();
> +  if (pending_for_mds.count(tid)) {
> +    _rollback(tid);
> +    _note_rollback(tid);
> +    mds->mdlog->start_submit_entry(new ETableServer(table, TABLESERVER_OP_ROLLBACK, 0, -1,
> +         tid, version));
> +  } else if (tid <= version) {
> +    dout(0) << "got rollback for tid " << tid << " <= " << version
> +           << ", already rollbacked or committed." << dendl;
> +  }
> +  else {
> +    // wtf.
> +    dout(0) << "got rollbacked for tid " << tid << " > " << version << dendl;
> +    assert(tid <= version);
> +  }
>    req->put();
>  }
>
> -
> -
>  // SERVER UPDATE
>
>  void MDSTableServer::do_server_update(bufferlist& bl)
> --
> 1.7.11.7
>

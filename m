From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Fri, 29 Mar 2013 15:12:40 -0700
Message-ID: <CAPYLRzgiRL0eq+Brivm8PXCFtv-hHaVh=Gq==ErNzwMcsCnZug@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-5-git-send-email-zheng.z.yan@intel.com>
	<C7E493EEAA91442B9BD120B881E4638F@inktank.com>
	<51494EF6.6040607@intel.com>
	<alpine.DEB.2.00.1303192309380.11428@cobra.newdream.net>
	<51495BEC.9000802@intel.com>
	<971E9C644F3C4AD9A4BFA042FC238F34@inktank.com>
	<514ABFC6.3080100@intel.com>
	<CAPYLRzhrH-=9itgY95XuE+uP54b4GxqVstRtmmW9_Qn1C3dHXw@mail.gmail.com>
	<5150355D.1050501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:64945 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab3C2WMm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 18:12:42 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so630702wea.10
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 15:12:40 -0700 (PDT)
In-Reply-To: <5150355D.1050501@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This looks good to me and Sage liked the shape of it.
Reviewed-by: Greg Farnum <greg@inktank.com>

We do still need to update the mds protocol version, and I'd like to
switch over the messages that are already changed to the new encoding
system at the same time. I'm happy to do all that but will wait to
hear back about that patch I think we can drop before doing so.

Thanks very much for all the work! :)
-Greg

On Mon, Mar 25, 2013 at 4:30 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> On 03/22/2013 06:03 AM, Gregory Farnum wrote:
>> Right. I'd like to somehow mark those reqid's so that we can tell when
>> they come from a different incarnation of the MDS TableClient daemon.
>> One way is via some piece of random data that will probably
>> distinguish them, although if we have something which we can know is
>> different that would be preferable. I think we can work something out
>> of the startup session data each MDS does with the monitors, but I'm
>> not sure I can check any time soon; I have a number of other things to
>> get to now that I've gotten through (the first round on) this series.
>>
>
> How about the attached patch?
>
> Thanks
>
> ----
> commit d460b766e16ec2cacac239a74af0e226108ab95a
> Author: Yan, Zheng <zheng.z.yan@intel.com>
> Date:   Sat Mar 16 08:02:18 2013 +0800
>
>     mds: make sure table request id unique
>
>     When a MDS becomes active, the table server re-sends 'agree' messages
>     for old prepared request. If the recoverd MDS starts a new table request
>     at the same time, The new request's ID can happen to be the same as old
>     prepared request's ID, because current table client code assigns request
>     ID from zero after MDS restarts.
>
>     This patch make table server send 'ready' messages when table clients
>     become active or itself becomes active. The 'ready' message updates
>     table client's last_reqid to avoid request ID collision. The message
>     also replaces the roles of finish_recovery() and handle_mds_recovery()
>     callbacks for table client.
>
>     Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>
> diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
> index bb1c833..834a7aa 100644
> --- a/src/mds/MDS.cc
> +++ b/src/mds/MDS.cc
> @@ -1508,14 +1508,13 @@ void MDS::recovery_done()
>
>    // kick anchortable (resent AGREEs)
>    if (mdsmap->get_tableserver() == whoami) {
> -    anchorserver->finish_recovery();
> -    snapserver->finish_recovery();
> +    set<int> active;
> +    mdsmap->get_mds_set(active, MDSMap::STATE_ACTIVE);
> +    mdsmap->get_mds_set(active, MDSMap::STATE_STOPPING);
> +    anchorserver->finish_recovery(active);
> +    snapserver->finish_recovery(active);
>    }
> -
> -  // kick anchorclient (resent COMMITs)
> -  anchorclient->finish_recovery();
> -  snapclient->finish_recovery();
> -
> +
>    mdcache->start_recovered_truncates();
>    mdcache->do_file_recover();
>
> @@ -1537,8 +1536,6 @@ void MDS::handle_mds_recovery(int who)
>      anchorserver->handle_mds_recovery(who);
>      snapserver->handle_mds_recovery(who);
>    }
> -  anchorclient->handle_mds_recovery(who);
> -  snapclient->handle_mds_recovery(who);
>
>    queue_waiters(waiting_for_active_peer[who]);
>    waiting_for_active_peer.erase(who);
> diff --git a/src/mds/MDSTableClient.cc b/src/mds/MDSTableClient.cc
> index ea021f5..29e172b 100644
> --- a/src/mds/MDSTableClient.cc
> +++ b/src/mds/MDSTableClient.cc
> @@ -101,6 +101,16 @@ void MDSTableClient::handle_request(class MMDSTableRequest *m)
>      }
>      break;
>
> +  case TABLESERVER_OP_SERVER_READY:
> +    if (last_reqid == 0) {
> +      assert(reqid > 0);
> +      last_reqid = reqid;
> +    }
> +
> +    resend_queries();
> +    resend_prepares();
> +    resend_commits();
> +    break;
>    default:
>      assert(0);
>    }
> @@ -126,19 +136,23 @@ void MDSTableClient::_logged_ack(version_t tid)
>  void MDSTableClient::_prepare(bufferlist& mutation, version_t *ptid, bufferlist *pbl,
>                               Context *onfinish)
>  {
> -  uint64_t reqid = ++last_reqid;
> -  dout(10) << "_prepare " << reqid << dendl;
> -
> -  // send message
> -  MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_PREPARE, reqid);
> -  req->bl = mutation;
> -
> -  pending_prepare[reqid].mutation = mutation;
> -  pending_prepare[reqid].ptid = ptid;
> -  pending_prepare[reqid].pbl = pbl;
> -  pending_prepare[reqid].onfinish = onfinish;
> -
> -  send_to_tableserver(req);
> +  if (last_reqid > 0) {
> +    uint64_t reqid = ++last_reqid;
> +    dout(10) << "_prepare " << reqid << dendl;
> +    // send message
> +    MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_PREPARE, reqid);
> +    req->bl = mutation;
> +
> +    pending_prepare[reqid].mutation = mutation;
> +    pending_prepare[reqid].ptid = ptid;
> +    pending_prepare[reqid].pbl = pbl;
> +    pending_prepare[reqid].onfinish = onfinish;
> +
> +    send_to_tableserver(req);
> +  } else {
> +    dout(10) << "table server is not ready yet, waiting" << dendl;
> +    waiting_for_server.push_back(_pending_prepare(onfinish, ptid, pbl, mutation));
> +  }
>  }
>
>  void MDSTableClient::send_to_tableserver(MMDSTableRequest *req)
> @@ -176,6 +190,7 @@ void MDSTableClient::got_journaled_agree(version_t tid, LogSegment *ls)
>    ls->pending_commit_tids[table].insert(tid);
>    pending_commit[tid] = ls;
>  }
> +
>  void MDSTableClient::got_journaled_ack(version_t tid)
>  {
>    dout(10) << "got_journaled_ack " << tid << dendl;
> @@ -185,12 +200,6 @@ void MDSTableClient::got_journaled_ack(version_t tid)
>    }
>  }
>
> -void MDSTableClient::finish_recovery()
> -{
> -  dout(7) << "finish_recovery" << dendl;
> -  resend_commits();
> -}
> -
>  void MDSTableClient::resend_commits()
>  {
>    for (map<version_t,LogSegment*>::iterator p = pending_commit.begin();
> @@ -202,24 +211,18 @@ void MDSTableClient::resend_commits()
>    }
>  }
>
> -void MDSTableClient::handle_mds_recovery(int who)
> +void MDSTableClient::resend_prepares()
>  {
> -  dout(7) << "handle_mds_recovery mds." << who << dendl;
> -
> -  if (who != mds->mdsmap->get_tableserver())
> -    return; // do nothing.
> -
> -  resend_queries();
> -
> -  // prepares.
> +  while (!waiting_for_server.empty()) {
> +    pending_prepare[++last_reqid] = waiting_for_server.front();
> +    waiting_for_server.pop_front();
> +  }
>    for (map<uint64_t, _pending_prepare>::iterator p = pending_prepare.begin();
>         p != pending_prepare.end();
>         ++p) {
> -    dout(10) << "resending " << p->first << dendl;
> +    dout(10) << "resending prepare on " << p->first << dendl;
>      MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_PREPARE, p->first);
>      req->bl = p->second.mutation;
>      mds->send_message_mds(req, mds->mdsmap->get_tableserver());
> -  }
> -
> -  resend_commits();
> +  }
>  }
> diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
> index e15837f..7638260 100644
> --- a/src/mds/MDSTableClient.h
> +++ b/src/mds/MDSTableClient.h
> @@ -38,9 +38,12 @@ protected:
>      bufferlist mutation;
>
>      _pending_prepare() : onfinish(0), ptid(0), pbl(0) {}
> +    _pending_prepare(Context *c, version_t *pt, bufferlist *pb, bufferlist& m) :
> +      onfinish(c), ptid(pt), pbl(pb), mutation(m) {}
>    };
>
>    map<uint64_t, _pending_prepare> pending_prepare;
> +  list<_pending_prepare> waiting_for_server;
>
>    // pending commits
>    map<version_t, LogSegment*> pending_commit;
> @@ -68,9 +71,8 @@ public:
>    void _prepare(bufferlist& mutation, version_t *ptid, bufferlist *pbl, Context *onfinish);
>    void commit(version_t tid, LogSegment *ls);
>
> -  // for recovery (by other nodes)
> -  void handle_mds_recovery(int mds); // called when someone else recovers
>    void resend_commits();
> +  void resend_prepares();
>
>    // for recovery (by me)
>    void got_journaled_agree(version_t tid, LogSegment *ls);
> @@ -82,7 +84,6 @@ public:
>    void wait_for_ack(version_t tid, Context *c) {
>      ack_waiters[tid].push_back(c);
>    }
> -  void finish_recovery();                // called when i recover and go active
>
>    void send_to_tableserver(MMDSTableRequest *req);
>
> diff --git a/src/mds/MDSTableServer.cc b/src/mds/MDSTableServer.cc
> index 4f86ff1..e56e2b4 100644
> --- a/src/mds/MDSTableServer.cc
> +++ b/src/mds/MDSTableServer.cc
> @@ -144,24 +144,30 @@ void MDSTableServer::do_server_update(bufferlist& bl)
>
>  // recovery
>
> -void MDSTableServer::finish_recovery()
> +void MDSTableServer::finish_recovery(set<int>& active)
>  {
>    dout(7) << "finish_recovery" << dendl;
> -  handle_mds_recovery(-1);  // resend agrees for everyone.
> +  for (set<int>::iterator p = active.begin(); p != active.end(); ++p)
> +    handle_mds_recovery(*p);  // resend agrees for everyone.
>  }
>
>  void MDSTableServer::handle_mds_recovery(int who)
>  {
> -  if (who >= 0)
> -    dout(7) << "handle_mds_recovery mds." << who << dendl;
> -
> +  dout(7) << "handle_mds_recovery mds." << who << dendl;
> +
> +  uint64_t next_reqid = 1;
>    // resend agrees for recovered mds
>    for (map<version_t,mds_table_pending_t>::iterator p = pending_for_mds.begin();
>         p != pending_for_mds.end();
>         ++p) {
> -    if (who >= 0 && p->second.mds != who)
> +    if (p->second.mds != who)
>        continue;
> +    if (p->second.reqid >= next_reqid)
> +      next_reqid = p->second.reqid + 1;
>      MMDSTableRequest *reply = new MMDSTableRequest(table, TABLESERVER_OP_AGREE, p->second.reqid, p->second.tid);
> -    mds->send_message_mds(reply, p->second.mds);
> +    mds->send_message_mds(reply, who);
>    }
> +
> +  MMDSTableRequest *reply = new MMDSTableRequest(table, TABLESERVER_OP_SERVER_READY, next_reqid);
> +  mds->send_message_mds(reply, who);
>  }
> diff --git a/src/mds/MDSTableServer.h b/src/mds/MDSTableServer.h
> index 26cd594..55827e7 100644
> --- a/src/mds/MDSTableServer.h
> +++ b/src/mds/MDSTableServer.h
> @@ -90,7 +90,7 @@ private:
>    }
>
>    // recovery
> -  void finish_recovery();
> +  void finish_recovery(set<int>& active);
>    void handle_mds_recovery(int who);
>  };
>
> diff --git a/src/mds/mds_table_types.h b/src/mds/mds_table_types.h
> index b094c75..c08519a 100644
> --- a/src/mds/mds_table_types.h
> +++ b/src/mds/mds_table_types.h
> @@ -39,6 +39,7 @@ enum {
>    TABLESERVER_OP_ACK          = -6,
>    TABLESERVER_OP_ROLLBACK     =  7,
>    TABLESERVER_OP_SERVER_UPDATE = 8,
> +  TABLESERVER_OP_SERVER_READY = -9,
>  };
>
>  inline const char *get_mdstableserver_opname(int op) {
> @@ -51,6 +52,7 @@ inline const char *get_mdstableserver_opname(int op) {
>    case TABLESERVER_OP_ACK: return "ack";
>    case TABLESERVER_OP_ROLLBACK: return "rollback";
>    case TABLESERVER_OP_SERVER_UPDATE: return "server_update";
> +  case TABLESERVER_OP_SERVER_READY: return "server_ready";
>    default: assert(0); return 0;
>    }
>  };
>

From: Sage Weil <sage@newdream.net>
Subject: Re: Correct proceedure for removing ceph nodes
Date: Mon, 7 Jun 2010 10:38:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006071033460.20365@cobra.newdream.net>
References: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com>
 <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net> <20100604130359.GT1211@skl-net.de>
 <Pine.LNX.4.64.1006040951210.2384@cobra.newdream.net>
 <AANLkTik0eXCX53WQ9aTYz5qmpFunTTCoTxQeK42lYWfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35745 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0FGRiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jun 2010 13:38:10 -0400
In-Reply-To: <AANLkTik0eXCX53WQ9aTYz5qmpFunTTCoTxQeK42lYWfb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 7 Jun 2010, Paul wrote:
> Took a shot at implementing the remove mon command, turned out to be
> not _quite_ as trivial as I'd expected.
> 
> The monitors need to adjust their whoami values after getting the new
> map, which is annoying since the value is stored in quite a few
> places. Ended up removing all the direct copies I could find and had
> them lookup the value in Monitor instead.

Looks good.

> The interaction with MonClient (i.e. via ceph command) needs a bit
> more work, but I'm not really sure how to proceed at this point. If
> the client happens to pick the monitor that is to be removed to send
> the remove command to, it'll retry with another monitor and get a
> "does not exist" error (because the first operation already removed
> it). If the client happens to pick a monitor whose id is greater than
> the one to be removed, it will never get an response to the command.

Hmm.  If we can get the reply sent before the monmap change is broadcast, 
the first case should be avoidable.  I'm not sure what would case the 
second case.

The patches below are mangled (wordwrapped) by gmail.  Can you resend them 
using 'git send-email'?  Or if they're in a public git tree somewhere I 
can grab them from there.

Thanks!
sage


> 
> >From 1d30deea10266392328c6fbdf176b766db42c32f Mon Sep 17 00:00:00 2001
> From: Paul Chiang <paul_chiang@tcloudcomputing.com>
> Date: Mon, 7 Jun 2010 09:47:48 +0800
> Subject: [PATCH 1/2] Removed all copies of the whoami value
> 
> 
> Signed-off-by: Paul Chiang <paul_chiang@tcloudcomputing.com>
> ---
>  src/mon/Elector.cc |   10 +++++-----
>  src/mon/Elector.h  |    3 +--
>  src/mon/Monitor.cc |    4 ++--
>  src/mon/Paxos.cc   |   16 ++++++++--------
>  src/mon/Paxos.h    |    5 ++---
>  5 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/src/mon/Elector.cc b/src/mon/Elector.cc
> index 7f8fa62..41fde6e 100644
> --- a/src/mon/Elector.cc
> +++ b/src/mon/Elector.cc
> @@ -69,11 +69,11 @@ void Elector::start()
>      bump_epoch(epoch+1);  // odd == election cycle
>    start_stamp = g_clock.now();
>    electing_me = true;
> -  acked_me.insert(whoami);
> +  acked_me.insert(mon->whoami);
> 
>    // bcast to everyone else
>    for (unsigned i=0; i<mon->monmap->size(); ++i) {
> -    if ((int)i == whoami) continue;
> +    if ((int)i == mon->whoami) continue;
>      mon->messenger->send_message(new
> MMonElection(MMonElection::OP_PROPOSE, epoch, mon->monmap),
>  				 mon->monmap->get_inst(i));
>    }
> @@ -151,7 +151,7 @@ void Elector::victory()
>    for (set<int>::iterator p = quorum.begin();
>         p != quorum.end();
>         ++p) {
> -    if (*p == whoami) continue;
> +    if (*p == mon->whoami) continue;
>      MMonElection *m = new MMonElection(MMonElection::OP_VICTORY,
> epoch, mon->monmap);
>      m->quorum = quorum;
>      mon->messenger->send_message(m, mon->monmap->get_inst(*p));
> @@ -186,7 +186,7 @@ void Elector::handle_propose(MMonElection *m)
>      }
>    }
> 
> -  if (whoami < from) {
> +  if (mon->whoami < from) {
>      // i would win over them.
>      if (leader_acked >= 0) {        // we already acked someone
>        assert(leader_acked < from);  // and they still win, of course
> @@ -250,7 +250,7 @@ void Elector::handle_victory(MMonElection *m)
>    dout(5) << "handle_victory from " << m->get_source() << dendl;
>    int from = m->get_source().num();
> 
> -  assert(from < whoami);
> +  assert(from < mon->whoami);
>    assert(m->epoch % 2 == 0);
> 
>    // i should have seen this election if i'm getting the victory.
> diff --git a/src/mon/Elector.h b/src/mon/Elector.h
> index 9bfd7cb..8a21e09 100644
> --- a/src/mon/Elector.h
> +++ b/src/mon/Elector.h
> @@ -32,7 +32,6 @@ class Monitor;
>  class Elector {
>   private:
>    Monitor *mon;
> -  int whoami;
> 
>    Context *expire_event;
> 
> @@ -71,7 +70,7 @@ class Elector {
>    void handle_victory(class MMonElection *m);
> 
>   public:
> -  Elector(Monitor *m, int w) : mon(m), whoami(w),
> +  Elector(Monitor *m) : mon(m),
>  			       expire_event(0),
>  			       epoch(0),
>  			       electing_me(false),
> diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
> index cf0b20b..db086be 100644
> --- a/src/mon/Monitor.cc
> +++ b/src/mon/Monitor.cc
> @@ -93,7 +93,7 @@ Monitor::Monitor(int w, MonitorStore *s, Messenger
> *m, MonMap *map) :
> 
>    state(STATE_STARTING), stopping(false),
> 
> -  elector(this, w),
> +  elector(this),
>    mon_epoch(0),
>    leader(0),
>    paxos(PAXOS_NUM), paxos_service(PAXOS_NUM),
> @@ -114,7 +114,7 @@ Monitor::Monitor(int w, MonitorStore *s, Messenger
> *m, MonMap *map) :
> 
>  Paxos *Monitor::add_paxos(int type)
>  {
> -  Paxos *p = new Paxos(this, whoami, type);
> +  Paxos *p = new Paxos(this, type);
>    paxos[type] = p;
>    return p;
>  }
> diff --git a/src/mon/Paxos.cc b/src/mon/Paxos.cc
> index d10f31c..9c247e8 100644
> --- a/src/mon/Paxos.cc
> +++ b/src/mon/Paxos.cc
> @@ -23,7 +23,7 @@
> 
>  #define DOUT_SUBSYS paxos
>  #undef dout_prefix
> -#define dout_prefix _prefix(mon, whoami, machine_name, state, last_committed)
> +#define dout_prefix _prefix(mon, mon->whoami, machine_name, state,
> last_committed)
>  static ostream& _prefix(Monitor *mon, int whoami, const char
> *machine_name, int state, version_t last_committed) {
>    return *_dout << dbeginl
>  		<< "mon" << whoami
> @@ -87,7 +87,7 @@ void Paxos::collect(version_t oldpn)
>    for (set<int>::const_iterator p = mon->get_quorum().begin();
>         p != mon->get_quorum().end();
>         ++p) {
> -    if (*p == whoami) continue;
> +    if (*p == mon->whoami) continue;
> 
>      MMonPaxos *collect = new MMonPaxos(mon->get_epoch(),
> MMonPaxos::OP_COLLECT, machine_id);
>      collect->last_committed = last_committed;
> @@ -336,7 +336,7 @@ void Paxos::begin(bufferlist& v)
> 
>    // accept it ourselves
>    accepted.clear();
> -  accepted.insert(whoami);
> +  accepted.insert(mon->whoami);
>    new_value = v;
>    mon->store->put_bl_sn(new_value, machine_name, last_committed+1);
> 
> @@ -356,7 +356,7 @@ void Paxos::begin(bufferlist& v)
>    for (set<int>::const_iterator p = mon->get_quorum().begin();
>         p != mon->get_quorum().end();
>         ++p) {
> -    if (*p == whoami) continue;
> +    if (*p == mon->whoami) continue;
> 
>      dout(10) << " sending begin to mon" << *p << dendl;
>      MMonPaxos *begin = new MMonPaxos(mon->get_epoch(),
> MMonPaxos::OP_BEGIN, machine_id);
> @@ -483,7 +483,7 @@ void Paxos::commit()
>    for (set<int>::const_iterator p = mon->get_quorum().begin();
>         p != mon->get_quorum().end();
>         ++p) {
> -    if (*p == whoami) continue;
> +    if (*p == mon->whoami) continue;
> 
>      dout(10) << " sending commit to mon" << *p << dendl;
>      MMonPaxos *commit = new MMonPaxos(mon->get_epoch(),
> MMonPaxos::OP_COMMIT, machine_id);
> @@ -527,7 +527,7 @@ void Paxos::extend_lease()
>    lease_expire = g_clock.now();
>    lease_expire += g_conf.mon_lease;
>    acked_lease.clear();
> -  acked_lease.insert(whoami);
> +  acked_lease.insert(mon->whoami);
> 
>    dout(7) << "extend_lease now+" << g_conf.mon_lease << " (" <<
> lease_expire << ")" << dendl;
> 
> @@ -535,7 +535,7 @@ void Paxos::extend_lease()
>    for (set<int>::const_iterator p = mon->get_quorum().begin();
>         p != mon->get_quorum().end();
>         ++p) {
> -    if (*p == whoami) continue;
> +    if (*p == mon->whoami) continue;
>      MMonPaxos *lease = new MMonPaxos(mon->get_epoch(),
> MMonPaxos::OP_LEASE, machine_id);
>      lease->last_committed = last_committed;
>      lease->lease_timestamp = lease_expire;
> @@ -724,7 +724,7 @@ version_t Paxos::get_new_proposal_number(version_t gt)
>    last_pn /= 100;
>    last_pn++;
>    last_pn *= 100;
> -  last_pn += (version_t)whoami;
> +  last_pn += (version_t)mon->whoami;
> 
>    // write
>    mon->store->put_int(last_pn, machine_name, "last_pn");
> diff --git a/src/mon/Paxos.h b/src/mon/Paxos.h
> index c6eff22..9d34605 100644
> --- a/src/mon/Paxos.h
> +++ b/src/mon/Paxos.h
> @@ -68,7 +68,6 @@ class Paxos;
>  // i am one state machine.
>  class Paxos {
>    Monitor *mon;
> -  int whoami;
> 
>    // my state machine info
>    int machine_id;
> @@ -225,8 +224,8 @@ private:
>    version_t get_new_proposal_number(version_t gt=0);
> 
>  public:
> -  Paxos(Monitor *m, int w,
> -	int mid) : mon(m), whoami(w),
> +  Paxos(Monitor *m,
> +	int mid) : mon(m),
>  		   machine_id(mid),
>  		   machine_name(get_paxos_name(mid)),
>  		   state(STATE_RECOVERING),
> -- 
> 1.6.4.2
> 
> >From eb7308104c33aa50195e3736483c6bf9a145a518 Mon Sep 17 00:00:00 2001
> From: Paul Chiang <paul_chiang@tcloudcomputing.com>
> Date: Mon, 7 Jun 2010 10:16:39 +0800
> Subject: [PATCH 2/2] Introduced ceph mon remove command
> 
> 
> Signed-off-by: Paul Chiang <paul_chiang@tcloudcomputing.com>
> ---
>  src/common/LogClient.h   |    1 +
>  src/mon/Monitor.cc       |    1 +
>  src/mon/Monitor.h        |    1 +
>  src/mon/MonmapMonitor.cc |   61 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/mon/MonmapMonitor.h  |    1 +
>  5 files changed, 65 insertions(+), 0 deletions(-)
> 
> diff --git a/src/common/LogClient.h b/src/common/LogClient.h
> index 0185eec..bc5e227 100644
> --- a/src/common/LogClient.h
> +++ b/src/common/LogClient.h
> @@ -56,6 +56,7 @@ class LogClient : public Dispatcher {
>    void send_log();
>    void handle_log_ack(MLogAck *m);
>    void set_synchronous(bool sync) { is_synchronous = sync; }
> +  void set_mon(int mon_id) { mon = mon_id; }
> 
>    LogClient(Messenger *m, MonMap *mm) :
>      messenger(m), monmap(mm), mon(-1), is_synchronous(false),
> diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
> index db086be..259b6ce 100644
> --- a/src/mon/Monitor.cc
> +++ b/src/mon/Monitor.cc
> @@ -110,6 +110,7 @@ Monitor::Monitor(int w, MonitorStore *s, Messenger
> *m, MonMap *map) :
>    mon_caps = new MonCaps();
>    mon_caps->set_allow_all(true);
>    mon_caps->text = "allow *";
> +  myaddr = map->get_inst(w).addr;
>  }
> 
>  Paxos *Monitor::add_paxos(int type)
> diff --git a/src/mon/Monitor.h b/src/mon/Monitor.h
> index 829c506..a673972 100644
> --- a/src/mon/Monitor.h
> +++ b/src/mon/Monitor.h
> @@ -58,6 +58,7 @@ class Monitor : public Dispatcher {
>  public:
>    // me
>    int whoami;
> +  entity_addr_t myaddr;
>    Messenger *messenger;
>    Mutex lock;
> 
> diff --git a/src/mon/MonmapMonitor.cc b/src/mon/MonmapMonitor.cc
> index 0aca5fb..5368ab7 100644
> --- a/src/mon/MonmapMonitor.cc
> +++ b/src/mon/MonmapMonitor.cc
> @@ -48,6 +48,7 @@ bool MonmapMonitor::update_from_paxos()
>    dout(10) << "update_from_paxos paxosv " << paxosv
>  	   << ", my v " << mon->monmap->epoch << dendl;
> 
> +  int original_map_size = mon->monmap->size();
>    //read and decode
>    monmap_bl.clear();
>    bool success = paxos->read(paxosv, monmap_bl);
> @@ -58,6 +59,20 @@ bool MonmapMonitor::update_from_paxos()
>    //save the bufferlist version in the paxos instance as well
>    paxos->stash_latest(paxosv, monmap_bl);
> 
> +  if (original_map_size != mon->monmap->size())
> +  {
> +    _update_whoami();
> +
> +    // call election?
> +    if (mon->monmap->size() > 1) {
> +      mon->call_election();
> +    } else {
> +      // we're standalone.
> +      set<int> q;
> +      q.insert(mon->whoami);
> +      mon->win_election(1, q);
> +    }
> +  }
>    return true;
>  }
> 
> @@ -127,6 +142,8 @@ bool MonmapMonitor::preprocess_command(MMonCommand *m)
>      }
>      else if (m->cmd[1] == "add")
>        return false;
> +    else if (m->cmd[1] == "remove")
> +      return false;
>    }
> 
>    if (r != -1) {
> @@ -177,6 +194,23 @@ bool MonmapMonitor::prepare_command(MMonCommand *m)
>        paxos->wait_for_commit(new Monitor::C_Command(mon, m, 0, rs,
> paxos->get_version()));
>        return true;
>      }
> +    else if (m->cmd.size() == 3 && m->cmd[1] == "remove") {
> +      entity_addr_t addr;
> +      parse_ip_port(m->cmd[2].c_str(), addr);
> +      bufferlist rdata;
> +      if (!pending_map.contains(addr)) {
> +        err = -ENOENT;
> +        ss << "mon " << addr << " does not exist";
> +        goto out;
> +      }
> +
> +      pending_map.remove(addr);
> +      pending_map.last_changed = g_clock.now();
> +      ss << "removed mon" << " at " << addr << ", there are now " <<
> pending_map.size() << " monitors" ;
> +      getline(ss, rs);
> +      paxos->wait_for_commit(new Monitor::C_Command(mon, m, 0, rs,
> paxos->get_version()));
> +      return true;
> +    }
>      else
>        ss << "unknown command " << m->cmd[1];
>    } else
> @@ -203,3 +237,30 @@ void MonmapMonitor::tick()
>  {
>    update_from_paxos();
>  }
> +
> +void MonmapMonitor::_update_whoami()
> +{
> +  // first check if there is any change
> +  if (mon->whoami < mon->monmap->size() &&
> +      mon->monmap->get_inst(mon->whoami).addr == mon->myaddr)
> +  {
> +    return;
> +  }
> +
> +  // then check backwards starting from min(whoami-1, size-1) since
> whoami only ever decreases
> +  unsigned i=(mon->whoami-1) < mon->monmap->size() ?
> (mon->whoami-1):(mon->monmap->size()-1);
> +  for (; i>=0; i--)
> +  {
> +    if (mon->monmap->get_inst(i).addr == mon->myaddr)
> +    {
> +      dout(10) << "Changing whoami from " << mon->whoami << " to " <<
> i << dendl;
> +      mon->whoami = i;
> +      mon->messenger->set_myname(entity_name_t::MON(i));
> +      mon->logclient.set_mon(i);
> +      return;
> +    }
> +  }
> +  dout(0) << "Cannot find myself (mon" << mon->whoami << ", " <<
> mon->myaddr << ") in new monmap! I must have been removed, shutting
> down." << dendl;
> +  mon->shutdown();
> +}
> +
> diff --git a/src/mon/MonmapMonitor.h b/src/mon/MonmapMonitor.h
> index fbb7fa5..b14c012 100644
> --- a/src/mon/MonmapMonitor.h
> +++ b/src/mon/MonmapMonitor.h
> @@ -67,6 +67,7 @@ class MonmapMonitor : public PaxosService {
> 
>   private:
>    bufferlist monmap_bl;
> +  void _update_whoami();
>  };
> 
> 
> -- 
> 1.6.4.2
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

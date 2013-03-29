From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 18/39] mds: fix MDS recovery involving cross authority rename
Date: Fri, 29 Mar 2013 15:02:37 -0700
Message-ID: <CAPYLRzikMrkzA+xW6ojfLq_DDF9naZbevdxxRP6So308ttMq5g@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-19-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzj3O_bsAux6oi3H6cTD9dWNTvvBgOUa7Z3JzayUxREzKA@mail.gmail.com>
	<514BCA3D.7010402@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36852 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964Ab3C2WCi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 18:02:38 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so767273wgh.20
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 15:02:37 -0700 (PDT)
In-Reply-To: <514BCA3D.7010402@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yep, this all looks good in your tree now.
Reviewed-by: Greg Farnum <greg@inktank.com>

On Thu, Mar 21, 2013 at 8:04 PM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> On 03/22/2013 01:59 AM, Gregory Farnum wrote:
>> On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> =
wrote:
>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>
>>> For mds cluster, rename operation may involve multiple MDS. If the
>>> rename source's auth MDS crashes after some witness MDS have prepar=
ed
>>> the rename but before the rename is committing. Later when the MDS
>>> recovers, its subtree map and linkages are different from the prepa=
red
>>> MDS'. This causes problems for both subtree resolve and cache rejoi=
n.
>>> The solution is, if the rename source's auth MDS fails, the prepare=
d
>>> witness MDS query the master MDS if the operation is committing. If
>>> it's not, rollback the rename, then send resolve message to the
>>> recovering MDS.
>>>
>>> Another similar case is a prepared witness MDS crashes when the
>>> rename source's auth MDS has prepared or is preparing the operation=
=2E
>>> when the witness recovers, the master just delay sending the resolv=
e
>>> ack message until the it commits the operation.
>>>
>>> This patch also updates Server::handle_client_rename(). Make prepar=
ing
>>> the rename source's auth MDS be the final step before committing th=
e
>>> rename.
>>
>> Why? It's not immediately obvious to me what the benefit is, and the
>> commit message should state it. :)
>
> For the second case, it's possible the recovering MDS is anchor serve=
r. The master delays
> sending the resolve ack message until pending update is committed. To=
 commit the pending
> update, the master needs anchor server's preparation ack. The master =
and the anchor server
> wait for each other.
>
>>
>>>
>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>>> ---
>>>  src/mds/MDCache.cc |  75 +++++++++++++++++++++++++++++-----------
>>>  src/mds/MDCache.h  |  17 +++++++--
>>>  src/mds/Mutation.h |   2 ++
>>>  src/mds/Server.cc  | 100 ++++++++++++++++++++++++++++-------------=
------------
>>>  4 files changed, 124 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
>>> index 9b37b1e..d934020 100644
>>> --- a/src/mds/MDCache.cc
>>> +++ b/src/mds/MDCache.cc
>>> @@ -2491,7 +2491,7 @@ void MDCache::send_slave_resolves()
>>>        if (!p->second->is_slave() || !p->second->slave_did_prepare(=
))
>>>         continue;
>>>        int master =3D p->second->slave_to_mds;
>>> -      if (resolve_set.count(master)) {
>>> +      if (resolve_set.count(master) || is_ambiguous_slave_update(p=
->first, master)) {
>>>         dout(10) << " including uncommitted " << *p->second << dend=
l;
>>>         if (!resolves.count(master))
>>>           resolves[master] =3D new MMDSResolve;
>>> @@ -2610,6 +2610,7 @@ void MDCache::handle_mds_failure(int who)
>>>
>>>    resolve_gather.insert(who);
>>>    discard_delayed_resolve(who);
>>> +  ambiguous_slave_updates.erase(who);
>>>
>>>    rejoin_gather.insert(who);
>>>    rejoin_sent.erase(who);        // i need to send another
>>> @@ -2642,14 +2643,46 @@ void MDCache::handle_mds_failure(int who)
>>>           finish.push_back(p->second);
>>>        }
>>>      }
>>> +
>>> +    if (p->second->is_slave() &&
>>> +       p->second->slave_did_prepare() && p->second->more()->srcdn_=
auth_mds =3D=3D who &&
>>> +       mds->mdsmap->is_clientreplay_or_active_or_stopping(p->secon=
d->slave_to_mds)) {
>>> +      // rename srcdn's auth mds failed, resolve even I'm a surviv=
or.
>>> +      dout(10) << " slave request " << *p->second << " uncommitted=
, will resolve shortly" << dendl;
>>> +      add_ambiguous_slave_update(p->first, p->second->slave_to_mds=
);
>>> +    }
>>>
>>>      // failed node is slave?
>>>      if (p->second->is_master() && !p->second->committing) {
>>> +      if (p->second->more()->srcdn_auth_mds =3D=3D who) {
>>> +       dout(10) << " master request " << *p->second << " waiting f=
or rename srcdn's auth mds."
>>> +                << who << " to recover" << dendl;
>>> +       assert(p->second->more()->witnessed.count(who) =3D=3D 0);
>>> +       if (p->second->more()->is_ambiguous_auth)
>>> +         p->second->clear_ambiguous_auth();
>>> +       // rename srcdn's auth mds failed, all witnesses will rollb=
ack
>>> +       p->second->more()->witnessed.clear();
>>> +       pending_masters.erase(p->first);
>>> +      }
>>> +
>>>        if (p->second->more()->witnessed.count(who)) {
>>> -       dout(10) << " master request " << *p->second << " no longer=
 witnessed by slave mds." << who
>>> -                << dendl;
>>> -       // discard this peer's prepare (if any)
>>> -       p->second->more()->witnessed.erase(who);
>>> +       int srcdn_auth =3D p->second->more()->srcdn_auth_mds;
>>> +       if (srcdn_auth >=3D 0 && p->second->more()->waiting_on_slav=
e.count(srcdn_auth)) {
>>> +         dout(10) << " master request " << *p->second << " waiting=
 for rename srcdn's auth mds."
>>> +                  << p->second->more()->srcdn_auth_mds << " to rep=
ly" << dendl;
>>> +         // waiting for the last slave (rename srcdn's auth mds), =
delay sending resolve ack
>>> +         // until either the request is committing or the last sla=
ve also fails.
>>> +         assert(p->second->more()->waiting_on_slave.size() =3D=3D =
1);
>>> +         pending_masters.insert(p->first);
>>
>> The language about "last slave" is confusing me here =97 I'm with yo=
u
>> that this rename should only have one slave, but I don't think it ev=
er
>> should have had more than one. Do you mean "only slave" or am I
>> missing something?
>
> Yes, I mean the 'only slave'. But the code 'more()->waiting_on_slave'=
 also considers witnesses
> also as slave, that's why I use 'last slave'. Will update the comment=
=2E
>
>>
>>> +       } else {
>>> +         dout(10) << " master request " << *p->second << " no long=
er witnessed by slave mds."
>>> +                  << who << " to recover" << dendl;
>>> +         if (srcdn_auth >=3D 0)
>>> +           assert(p->second->more()->witnessed.count(srcdn_auth) =3D=
=3D 0);
>>> +
>>> +         // discard this peer's prepare (if any)
>>> +         p->second->more()->witnessed.erase(who);
>>> +       }
>>>        }
>>>
>>>        if (p->second->more()->waiting_on_slave.count(who)) {
>>> @@ -2657,14 +2690,8 @@ void MDCache::handle_mds_failure(int who)
>>>                  << " to recover" << dendl;
>>>         // retry request when peer recovers
>>>         p->second->more()->waiting_on_slave.erase(who);
>>> -       mds->wait_for_active_peer(who, new C_MDS_RetryRequest(this,=
 p->second));
>>> -      }
>>> -
>>> -      if (p->second->has_more() && p->second->more()->is_ambiguous=
_auth &&
>>> -         p->second->more()->rename_inode->authority().first =3D=3D=
 who) {
>>> -       dout(10) << " master request " << *p->second << " waiting f=
or renamed inode's auth mds." << who
>>> -                << " to recover" << dendl;
>>> -       p->second->clear_ambiguous_auth();
>>
>> Why are you getting rid of waiting for the renamed inode's MDS? I
>> could be misremembering, but I believe we need it, and it might be
>> different from the source or dest dentry auths.
>
> The code is moved up. see above test "(p->second->more()->srcdn_auth_=
mds =3D=3D who)"
>
>>
>>> +       if (p->second->more()->waiting_on_slave.empty())
>>> +         mds->wait_for_active_peer(who, new C_MDS_RetryRequest(thi=
s, p->second));
>>>        }
>>>
>>>        if (p->second->locking && p->second->locking_target_mds =3D=3D=
 who)
>>> @@ -2951,16 +2978,27 @@ void MDCache::handle_resolve_ack(MMDSResolv=
eAck *ack)
>>>    dout(10) << "handle_resolve_ack " << *ack << " from " << ack->ge=
t_source() << dendl;
>>>    int from =3D ack->get_source().num();
>>>
>>> -  if (!resolve_ack_gather.count(from)) {
>>> +  if (!resolve_ack_gather.count(from) ||
>>> +      mds->mdsmap->get_state(from) < MDSMap::STATE_RESOLVE) {
>>>      ack->put();
>>>      return;
>>>    }
>>>
>>> +  if (ambiguous_slave_updates.count(from)) {
>>> +    assert(mds->mdsmap->is_clientreplay_or_active_or_stopping(from=
));
>>> +    assert(mds->is_clientreplay() || mds->is_active() || mds->is_s=
topping());
>>> +  }
>>> +
>>>    for (vector<metareqid_t>::iterator p =3D ack->commit.begin();
>>>         p !=3D ack->commit.end();
>>>         ++p) {
>>>      dout(10) << " commit on slave " << *p << dendl;
>>>
>>> +    if (ambiguous_slave_updates.count(from)) {
>>> +      remove_ambiguous_slave_update(*p, from);
>>> +      continue;
>>> +    }
>>> +
>>>      if (mds->is_resolve()) {
>>>        // replay
>>>        MDSlaveUpdate *su =3D get_uncommitted_slave_update(*p, from)=
;
>>> @@ -3020,13 +3058,8 @@ void MDCache::handle_resolve_ack(MMDSResolve=
Ack *ack)
>>>      }
>>>    }
>>>
>>> -  if (!mds->is_resolve()) {
>>> -    for (hash_map<metareqid_t, MDRequest*>::iterator p =3D active_=
requests.begin();
>>> -       p !=3D active_requests.end(); ++p)
>>> -      assert(p->second->slave_to_mds !=3D from);
>>> -  }
>>> -
>>> -  resolve_ack_gather.erase(from);
>>> +  if (!ambiguous_slave_updates.count(from))
>>> +    resolve_ack_gather.erase(from);
>>>    if (resolve_ack_gather.empty() && need_resolve_rollback.empty())=
 {
>>>      send_subtree_resolves();
>>>      process_delayed_resolve();
>>> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
>>> index 8f262b9..a05ced7 100644
>>> --- a/src/mds/MDCache.h
>>> +++ b/src/mds/MDCache.h
>>> @@ -327,9 +327,8 @@ protected:
>>>    map<metareqid_t, umaster>                 uncommitted_masters;  =
       // master: req -> slave set
>>>
>>>    set<metareqid_t>             pending_masters;
>>> +  map<int, set<metareqid_t> >  ambiguous_slave_updates;
>>>
>>> -  //map<metareqid_t, bool>     ambiguous_slave_updates;         //=
 for log trimming.
>>> -  //map<metareqid_t, Context*> waiting_for_slave_update_commit;
>>>    friend class ESlaveUpdate;
>>>    friend class ECommitted;
>>>
>>> @@ -353,6 +352,20 @@ protected:
>>>  public:
>>>    void remove_inode_recursive(CInode *in);
>>>
>>> +  bool is_ambiguous_slave_update(metareqid_t reqid, int master) {
>>> +    return ambiguous_slave_updates.count(master) &&
>>> +          ambiguous_slave_updates[master].count(reqid);
>>> +  }
>>> +  void add_ambiguous_slave_update(metareqid_t reqid, int master) {
>>> +    ambiguous_slave_updates[master].insert(reqid);
>>> +  }
>>> +  void remove_ambiguous_slave_update(metareqid_t reqid, int master=
) {
>>> +    assert(ambiguous_slave_updates[master].count(reqid));
>>> +    ambiguous_slave_updates[master].erase(reqid);
>>> +    if (ambiguous_slave_updates[master].empty())
>>> +      ambiguous_slave_updates.erase(master);
>>> +  }
>>> +
>>>    void add_rollback(metareqid_t reqid, int master) {
>>>      need_resolve_rollback[reqid] =3D master;
>>>    }
>>> diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
>>> index 5013f04..de122a5 100644
>>> --- a/src/mds/Mutation.h
>>> +++ b/src/mds/Mutation.h
>>> @@ -207,6 +207,7 @@ struct MDRequest : public Mutation {
>>>
>>>      // for rename
>>>      set<int> extra_witnesses; // replica list from srcdn auth (ren=
ame)
>>> +    int srcdn_auth_mds;
>>>      version_t src_reanchor_atid;  // src->dst
>>>      version_t dst_reanchor_atid;  // dst->stray
>>>      bufferlist inode_import;
>>> @@ -233,6 +234,7 @@ struct MDRequest : public Mutation {
>>>      bufferlist rollback_bl;
>>>
>>>      More() :
>>> +      srcdn_auth_mds(-1),
>>>        src_reanchor_atid(0), dst_reanchor_atid(0), inode_import_v(0=
),
>>>        rename_inode(0), is_freeze_authpin(false), is_ambiguous_auth=
(false),
>>>        is_remote_frozen_authpin(false), is_inode_exporter(false),
>>> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
>>> index 1330f11..b6e5665 100644
>>> --- a/src/mds/Server.cc
>>> +++ b/src/mds/Server.cc
>>> @@ -5772,12 +5772,52 @@ void Server::handle_client_rename(MDRequest=
 *mdr)
>>>    if (mdr->now =3D=3D utime_t())
>>>      mdr->now =3D ceph_clock_now(g_ceph_context);
>>>
>>> +  // -- prepare anchor updates --
>>> +  if (!linkmerge || srcdnl->is_primary()) {
>>> +    C_GatherBuilder anchorgather(g_ceph_context);
>>> +
>>> +    if (srcdnl->is_primary() &&
>>> +      (srcdnl->get_inode()->is_anchored() ||
>>> +       (srcdnl->get_inode()->is_dir() && (srcdnl->get_inode()->ino=
de.rstat.ranchors ||
>>> +                                          srcdnl->get_inode()->nes=
ted_anchors ||
>>> +                                          !mdcache->is_leaf_subtre=
e(mdcache->get_projected_subtree_root(srcdn->get_dir()))))) &&
>>> +      !mdr->more()->src_reanchor_atid) {
>>> +      dout(10) << "reanchoring src->dst " << *srcdnl->get_inode() =
<< dendl;
>>> +      vector<Anchor> trace;
>>> +      destdn->make_anchor_trace(trace, srcdnl->get_inode());
>>> +      mds->anchorclient->prepare_update(srcdnl->get_inode()->ino()=
,
>>> +                                       trace, &mdr->more()->src_re=
anchor_atid,
>>> +                                       anchorgather.new_sub());
>>> +    }
>>> +    if (destdnl->is_primary() &&
>>> +       destdnl->get_inode()->is_anchored() &&
>>> +       !mdr->more()->dst_reanchor_atid) {
>>> +      dout(10) << "reanchoring dst->stray " << *destdnl->get_inode=
() << dendl;
>>> +
>>> +      assert(straydn);
>>> +      vector<Anchor> trace;
>>> +      straydn->make_anchor_trace(trace, destdnl->get_inode());
>>> +
>>> +      mds->anchorclient->prepare_update(destdnl->get_inode()->ino(=
), trace,
>>> +                 &mdr->more()->dst_reanchor_atid, anchorgather.new=
_sub());
>>> +    }
>>> +
>>> +    if (anchorgather.has_subs())  {
>>> +      anchorgather.set_finisher(new C_MDS_RetryRequest(mdcache, md=
r));
>>> +      anchorgather.activate();
>>> +      return;  // waiting for anchor prepares
>>> +    }
>>> +
>>> +    assert(g_conf->mds_kill_rename_at !=3D 2);
>>> +  }
>>> +
>>>    // -- prepare witnesses --
>>>
>>>    // do srcdn auth last
>>>    int last =3D -1;
>>>    if (!srcdn->is_auth()) {
>>>      last =3D srcdn->authority().first;
>>> +    mdr->more()->srcdn_auth_mds =3D last;
>>>      // ask auth of srci to mark srci as ambiguous auth if more tha=
n two MDS
>>>      // are involved in the rename operation.
>>>      if (srcdnl->is_primary() && !mdr->more()->is_ambiguous_auth) {
>>> @@ -5803,58 +5843,18 @@ void Server::handle_client_rename(MDRequest=
 *mdr)
>>>    if (!mdr->more()->waiting_on_slave.empty())
>>>      return;  // we're waiting for a witness.
>>>
>>> -  if (last >=3D 0 &&
>>> -      mdr->more()->witnessed.count(last) =3D=3D 0 &&
>>> -      mdr->more()->waiting_on_slave.count(last) =3D=3D 0) {
>>> +  if (last >=3D 0 && mdr->more()->witnessed.count(last) =3D=3D 0) =
{
>>>      dout(10) << " preparing last witness (srcdn auth)" << dendl;
>>> +    assert(mdr->more()->waiting_on_slave.count(last) =3D=3D 0);
>>>      _rename_prepare_witness(mdr, last, witnesses, srcdn, destdn, s=
traydn);
>>>      return;
>>>    }
>>>
>>>    // test hack: bail after slave does prepare, so we can verify it=
's _live_ rollback.
>>>    if (!mdr->more()->slaves.empty() && !srci->is_dir())
>>> -    assert(g_conf->mds_kill_rename_at !=3D 2);
>>> +    assert(g_conf->mds_kill_rename_at !=3D 3);
>>>    if (!mdr->more()->slaves.empty() && srci->is_dir())
>>> -    assert(g_conf->mds_kill_rename_at !=3D 3);
>>> -
>>> -  // -- prepare anchor updates --
>>> -  if (!linkmerge || srcdnl->is_primary()) {
>>> -    C_GatherBuilder anchorgather(g_ceph_context);
>>> -
>>> -    if (srcdnl->is_primary() &&
>>> -       (srcdnl->get_inode()->is_anchored() ||
>>> -        (srcdnl->get_inode()->is_dir() && (srcdnl->get_inode()->in=
ode.rstat.ranchors ||
>>> -                                           srcdnl->get_inode()->ne=
sted_anchors ||
>>> -                                           !mdcache->is_leaf_subtr=
ee(mdcache->get_projected_subtree_root(srcdn->get_dir()))))) &&
>>> -       !mdr->more()->src_reanchor_atid) {
>>> -      dout(10) << "reanchoring src->dst " << *srcdnl->get_inode() =
<< dendl;
>>> -      vector<Anchor> trace;
>>> -      destdn->make_anchor_trace(trace, srcdnl->get_inode());
>>> -      mds->anchorclient->prepare_update(srcdnl->get_inode()->ino()=
,
>>> -                                       trace, &mdr->more()->src_re=
anchor_atid,
>>> -                                       anchorgather.new_sub());
>>> -    }
>>> -    if (destdnl->is_primary() &&
>>> -       destdnl->get_inode()->is_anchored() &&
>>> -       !mdr->more()->dst_reanchor_atid) {
>>> -      dout(10) << "reanchoring dst->stray " << *destdnl->get_inode=
() << dendl;
>>> -
>>> -      assert(straydn);
>>> -      vector<Anchor> trace;
>>> -      straydn->make_anchor_trace(trace, destdnl->get_inode());
>>> -
>>> -      mds->anchorclient->prepare_update(destdnl->get_inode()->ino(=
), trace,
>>> -                 &mdr->more()->dst_reanchor_atid, anchorgather.new=
_sub());
>>> -    }
>>> -
>>> -    if (anchorgather.has_subs())  {
>>> -      anchorgather.set_finisher(new C_MDS_RetryRequest(mdcache, md=
r));
>>> -      anchorgather.activate();
>>> -      return;  // waiting for anchor prepares
>>> -    }
>>> -
>>>      assert(g_conf->mds_kill_rename_at !=3D 4);
>>> -  }
>>>
>>>    // -- prepare journal entry --
>>>    mdr->ls =3D mdlog->get_current_segment();
>>> @@ -6762,10 +6762,17 @@ void Server::_commit_slave_rename(MDRequest=
 *mdr, int r,
>>>      // abort
>>>      //  rollback_bl may be empty if we froze the inode but had to =
provide an expanded
>>>      // witness list from the master, and they failed before we tri=
ed prep again.
>>> -    if (mdr->more()->rollback_bl.length())
>>> -      do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_m=
ds, mdr);
>>> -    else
>>> +    if (mdr->more()->rollback_bl.length()) {
>>> +      if (mdcache->is_ambiguous_slave_update(mdr->reqid, mdr->slav=
e_to_mds)) {
>>> +       mdcache->remove_ambiguous_slave_update(mdr->reqid, mdr->sla=
ve_to_mds);
>>> +       // rollback but preserve the slave request
>>> +       do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_=
mds, NULL);
>>> +      } else
>>> +       do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_=
mds, mdr);
>>> +    } else {
>>>        dout(10) << " rollback_bl empty, not rollback back rename (m=
aster failed after getting extra witnesses?)" << dendl;
>>> +      mds->mdcache->request_finish(mdr);
>>> +    }
>>>    }
>>>  }
>>>
>>> @@ -6825,7 +6832,6 @@ void Server::do_rename_rollback(bufferlist &r=
bl, int master, MDRequest *mdr)
>>>    dout(10) << "do_rename_rollback on " << rollback.reqid << dendl;
>>>    // need to finish this update before sending resolve to claim th=
e subtree
>>>    mds->mdcache->add_rollback(rollback.reqid, master);
>>> -  assert(mdr || mds->is_resolve());
>>>
>>>    Mutation *mut =3D new Mutation(rollback.reqid);
>>>    mut->ls =3D mds->mdlog->get_current_segment();
>>> --
>>> 1.7.11.7
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

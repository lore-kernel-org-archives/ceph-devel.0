From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 22/39] mds: handle linkage mismatch during cache rejoin
Date: Fri, 22 Mar 2013 11:05:42 +0800
Message-ID: <514BCA86.7090201@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-23-git-send-email-zheng.z.yan@intel.com> <CAPYLRzi5wRLUndEczMbrwjNBTwKwdOvFw=s5bhDNDcncWMxSuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17377 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab3CVDFp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Mar 2013 23:05:45 -0400
In-Reply-To: <CAPYLRzi5wRLUndEczMbrwjNBTwKwdOvFw=s5bhDNDcncWMxSuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 03/22/2013 05:23 AM, Gregory Farnum wrote:
> On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> w=
rote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> For MDS cluster, not all file system namespace operations that impac=
t
>> multiple MDS use two phase commit. Some operations use dentry link/u=
nlink
>> message to update replica dentry's linkage after they are committed =
by
>> the master MDS. It's possible the master MDS crashes after journalin=
g an
>> operation, but before sending the dentry link/unlink messages. Later=
 when
>> the MDS recovers and receives cache rejoin messages from the survivi=
ng
>> MDS, it will find linkage mismatch.
>=20
> I think you're here talking about link/unlink, and the MDS crashing
> after it's sent out the LogEvent to the OSD but it hasn't actually
> dispatched the observer slave requests. Is that right? This commit
> message really confused me; I was trying to figure out which namespac=
e
> operations were hacking around a proper 2-phase commit by unlinking
> and relinking inodes into the tree! (The link/unlink code also is
> doing a 2-phase commit, it just doesn't force a particular order for
> the journaling, which was previously left unhandled).

I was talking about the cases that use MDCache::send_dentry_{link,unlin=
k}
to update replica dentry. There are a lot of usage in Server.cc.=20

>=20
>>
>> The original cache rejoin code does not properly handle the case tha=
t
>> dentry unlink messages were missing. Unlinked inodes were linked to =
stray
>> dentries. So the cache rejoin ack message need push replicas of thes=
e
>> stray dentries to the surviving MDS.
>>
>> This patch also adds code that handles cache expiration in the middl=
e of
>> cache rejoining.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  src/mds/MDCache.cc | 348 +++++++++++++++++++++++++++++++++++-------=
-----------
>>  src/mds/MDCache.h  |   1 +
>>  2 files changed, 233 insertions(+), 116 deletions(-)
>>
>> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
>> index 344777e..38b1fdf 100644
>> --- a/src/mds/MDCache.cc
>> +++ b/src/mds/MDCache.cc
>> @@ -3536,7 +3536,6 @@ void MDCache::rejoin_send_rejoins()
>>      } else {
>>        // strong
>>        if (p->first =3D=3D 0 && root) {
>> -       p->second->add_weak_inode(root->vino());
>>         p->second->add_strong_inode(root->vino(),
>>                                     root->get_replica_nonce(),
>>                                     root->get_caps_wanted(),
>> @@ -3550,7 +3549,6 @@ void MDCache::rejoin_send_rejoins()
>>        }
>>
>>        if (CInode *in =3D get_inode(MDS_INO_MDSDIR(p->first))) {
>> -       p->second->add_weak_inode(in->vino());
>>         p->second->add_strong_inode(in->vino(),
>>                                     in->get_replica_nonce(),
>>                                     in->get_caps_wanted(),
>> @@ -3567,6 +3565,8 @@ void MDCache::rejoin_send_rejoins()
>>      for (hash_map<metareqid_t, MDRequest*>::iterator p =3D active_r=
equests.begin();
>>          p !=3D active_requests.end();
>>          ++p) {
>> +      if ( p->second->is_slave())
>> +       continue;
>>        // auth pins
>>        for (set<MDSCacheObject*>::iterator q =3D p->second->remote_a=
uth_pins.begin();
>>            q !=3D p->second->remote_auth_pins.end();
>> @@ -4226,6 +4226,8 @@ void MDCache::handle_cache_rejoin_strong(MMDSC=
acheRejoin *strong)
>>      rejoin_potential_updated_scatterlocks.insert(in);
>>    }
>>
>> +  rejoin_unlinked_inodes[from].clear();
>> +
>>    // surviving peer may send incorrect dirfrag here (maybe they did=
n't
>>    // get the fragment notify, or maybe we rolled back?).  we need t=
o
>>    // infer the right frag and get them with the program.  somehow.
>> @@ -4332,105 +4334,125 @@ void MDCache::handle_cache_rejoin_strong(M=
MDSCacheRejoin *strong)
>>
>>        dn->add_replica(from, q->second.nonce);
>>        dout(10) << " have " << *dn << dendl;
>> -
>> -      // inode?
>> -      if (dnl->is_primary()) {
>> -       CInode *in =3D dnl->get_inode();
>> -       assert(in);
>> -
>> -       if (strong->strong_inodes.count(in->vino())) {
>> -         MMDSCacheRejoin::inode_strong &is =3D strong->strong_inode=
s[in->vino()];
>>
>> -         // caps_wanted
>> -         if (is.caps_wanted) {
>> -           in->mds_caps_wanted[from] =3D is.caps_wanted;
>> -           dout(15) << " inode caps_wanted " << ccap_string(is.caps=
_wanted)
>> -                    << " on " << *in << dendl;
>> -         }
>> -
>> -         // scatterlocks?
>> -         //  infer state from replica state:
>> -         //   * go to MIX if they might have wrlocks
>> -         //   * go to LOCK if they are LOCK (just bc identify_files=
_to_recover might start twiddling filelock)
>> -         in->filelock.infer_state_from_strong_rejoin(is.filelock, t=
rue);  // maybe also go to LOCK
>> -         in->nestlock.infer_state_from_strong_rejoin(is.nestlock, f=
alse);
>> -         in->dirfragtreelock.infer_state_from_strong_rejoin(is.dftl=
ock, false);
>> -
>> -         // auth pin?
>> -         if (strong->authpinned_inodes.count(in->vino())) {
>> -           MMDSCacheRejoin::slave_reqid r =3D strong->authpinned_in=
odes[in->vino()];
>> -           dout(10) << " inode authpin by " << r << " on " << *in <=
< dendl;
>> -
>> -           // get/create slave mdrequest
>> -           MDRequest *mdr;
>> -           if (have_request(r.reqid))
>> -             mdr =3D request_get(r.reqid);
>> -           else
>> -             mdr =3D request_start_slave(r.reqid, r.attempt, from);
>> -           if (strong->frozen_authpin_inodes.count(in->vino())) {
>> -             assert(!in->get_num_auth_pins());
>> -             mdr->freeze_auth_pin(in);
>> -           } else {
>> -             assert(!in->is_frozen_auth_pin());
>> -           }
>> -           mdr->auth_pin(in);
>> -         }
>> -         // xlock(s)?
>> -         if (strong->xlocked_inodes.count(in->vino())) {
>> -           for (map<int,MMDSCacheRejoin::slave_reqid>::iterator r =3D=
 strong->xlocked_inodes[in->vino()].begin();
>> -                r !=3D strong->xlocked_inodes[in->vino()].end();
>> -                ++r) {
>> -             SimpleLock *lock =3D in->get_lock(r->first);
>> -             dout(10) << " inode xlock by " << r->second << " on " =
<< *lock << " on " << *in << dendl;
>> -             MDRequest *mdr =3D request_get(r->second.reqid);  // s=
hould have this from auth_pin above.
>> -             assert(mdr->is_auth_pinned(in));
>> -             if (lock->is_stable())
>> -               in->auth_pin(lock);
>> -             lock->set_state(LOCK_XLOCK);
>> -             if (lock =3D=3D &in->filelock)
>> -               in->loner_cap =3D -1;
>> -             lock->get_xlock(mdr, mdr->get_client());
>> -             mdr->xlocks.insert(lock);
>> -             mdr->locks.insert(lock);
>> -           }
>> -         }
>> -         // wrlock(s)?
>> -         if (strong->wrlocked_inodes.count(in->vino())) {
>> -           for (map<int,MMDSCacheRejoin::slave_reqid>::iterator r =3D=
 strong->wrlocked_inodes[in->vino()].begin();
>> -                r !=3D strong->wrlocked_inodes[in->vino()].end();
>> -                ++r) {
>> -             SimpleLock *lock =3D in->get_lock(r->first);
>> -             dout(10) << " inode wrlock by " << r->second << " on "=
 << *lock << " on " << *in << dendl;
>> -             MDRequest *mdr =3D request_get(r->second.reqid);  // s=
hould have this from auth_pin above.
>> -             assert(mdr->is_auth_pinned(in));
>> -             lock->set_state(LOCK_LOCK);
>> -             if (lock =3D=3D &in->filelock)
>> -               in->loner_cap =3D -1;
>> -             lock->get_wrlock(true);
>> -             mdr->wrlocks.insert(lock);
>> -             mdr->locks.insert(lock);
>> -           }
>> +      if (dnl->is_primary()) {
>> +       if (q->second.is_primary()) {
>> +         if (!(vinodeno_t(q->second.ino, q->first.snapid) =3D=3D dn=
l->get_inode()->vino())) {
>=20
> Maybe it's worth adding an operator!=3D for vinodeno_t, since you see=
m
> to use this a couple times.
>=20
>> +           // the survivor missed MDentryUnlink+MDentryLink message=
s ?
>> +           assert(strong->strong_inodes.count(dnl->get_inode()->vin=
o()) =3D=3D 0);
>> +           CInode *in =3D get_inode(q->second.ino, q->first.snapid)=
;
>> +           assert(in);
>> +           rejoin_unlinked_inodes[from].insert(in);
>> +           dout(7) << " sender has primary dentry but wrong inode" =
<< dendl;
>>           }
>>         } else {
>> -         dout(10) << " sender has dentry but not inode, adding them=
 as a replica" << dendl;
>> +         // the survivor missed MDentryLink message ?
>> +         assert(strong->strong_inodes.count(dnl->get_inode()->vino(=
)) =3D=3D 0);
>> +         dout(7) << " sender doesn't primay dentry" << dendl;
>=20
> doesn't have primary? or something else?

will fix.

>=20
>> +       }
>> +      } else {
>> +       if (q->second.is_primary()) {
>> +         // the survivor missed MDentryUnlink message ?
>> +         CInode *in =3D get_inode(q->second.ino, q->first.snapid);
>> +         assert(in);
>> +         rejoin_unlinked_inodes[from].insert(in);
>> +         dout(7) << " sender has primary dentry but we don't" << de=
ndl;
>>         }
>> -
>> -       in->add_replica(from, p->second.nonce);
>> -       dout(10) << " have " << *in << dendl;
>>        }
>>      }
>>    }
>>
>> -  // base inodes?  (root, stray, etc.)
>> -  for (set<vinodeno_t>::iterator p =3D strong->weak_inodes.begin();
>> -       p !=3D strong->weak_inodes.end();
>> +  for (map<vinodeno_t, MMDSCacheRejoin::inode_strong>::iterator p =3D=
 strong->strong_inodes.begin();
>> +       p !=3D strong->strong_inodes.end();
>>         ++p) {
>> -    CInode *in =3D get_inode(*p);
>> -    dout(10) << " have base " << *in << dendl;
>> -    in->add_replica(from);
>> +    CInode *in =3D get_inode(p->first);
>> +    assert(in);
>> +    in->add_replica(from, p->second.nonce);
>> +    dout(10) << " have " << *in << dendl;
>> +
>> +    MMDSCacheRejoin::inode_strong &is =3D p->second;
>> +
>> +    // caps_wanted
>> +    if (is.caps_wanted) {
>> +      in->mds_caps_wanted[from] =3D is.caps_wanted;
>> +      dout(15) << " inode caps_wanted " << ccap_string(is.caps_want=
ed)
>> +              << " on " << *in << dendl;
>> +    }
>> +
>> +    // scatterlocks?
>> +    //  infer state from replica state:
>> +    //   * go to MIX if they might have wrlocks
>> +    //   * go to LOCK if they are LOCK (just bc identify_files_to_r=
ecover might start twiddling filelock)
>> +    in->filelock.infer_state_from_strong_rejoin(is.filelock, true);=
  // maybe also go to LOCK
>> +    in->nestlock.infer_state_from_strong_rejoin(is.nestlock, false)=
;
>> +    in->dirfragtreelock.infer_state_from_strong_rejoin(is.dftlock, =
false);
>> +
>> +    // auth pin?
>> +    if (strong->authpinned_inodes.count(in->vino())) {
>> +      MMDSCacheRejoin::slave_reqid r =3D strong->authpinned_inodes[=
in->vino()];
>> +      dout(10) << " inode authpin by " << r << " on " << *in << den=
dl;
>> +
>> +      // get/create slave mdrequest
>> +      MDRequest *mdr;
>> +      if (have_request(r.reqid))
>> +       mdr =3D request_get(r.reqid);
>> +      else
>> +       mdr =3D request_start_slave(r.reqid, r.attempt, from);
>> +      if (strong->frozen_authpin_inodes.count(in->vino())) {
>> +       assert(!in->get_num_auth_pins());
>> +       mdr->freeze_auth_pin(in);
>> +      } else {
>> +       assert(!in->is_frozen_auth_pin());
>> +      }
>> +      mdr->auth_pin(in);
>> +    }
>> +    // xlock(s)?
>> +    if (strong->xlocked_inodes.count(in->vino())) {
>> +      for (map<int,MMDSCacheRejoin::slave_reqid>::iterator q =3D st=
rong->xlocked_inodes[in->vino()].begin();
>> +          q !=3D strong->xlocked_inodes[in->vino()].end();
>> +          ++q) {
>> +       SimpleLock *lock =3D in->get_lock(q->first);
>> +       dout(10) << " inode xlock by " << q->second << " on " << *lo=
ck << " on " << *in << dendl;
>> +       MDRequest *mdr =3D request_get(q->second.reqid);  // should =
have this from auth_pin above.
>> +       assert(mdr->is_auth_pinned(in));
>> +       if (lock->is_stable())
>> +         in->auth_pin(lock);
>> +       lock->set_state(LOCK_XLOCK);
>> +       if (lock =3D=3D &in->filelock)
>> +         in->loner_cap =3D -1;
>> +       lock->get_xlock(mdr, mdr->get_client());
>> +       mdr->xlocks.insert(lock);
>> +       mdr->locks.insert(lock);
>> +      }
>> +    }
>> +    // wrlock(s)?
>> +    if (strong->wrlocked_inodes.count(in->vino())) {
>> +      for (map<int,MMDSCacheRejoin::slave_reqid>::iterator q =3D st=
rong->wrlocked_inodes[in->vino()].begin();
>> +          q !=3D strong->wrlocked_inodes[in->vino()].end();
>> +          ++q) {
>> +       SimpleLock *lock =3D in->get_lock(q->first);
>> +       dout(10) << " inode wrlock by " << q->second << " on " << *l=
ock << " on " << *in << dendl;
>> +       MDRequest *mdr =3D request_get(q->second.reqid);  // should =
have this from auth_pin above.
>> +       assert(mdr->is_auth_pinned(in));
>> +       lock->set_state(LOCK_LOCK);
>> +       if (lock =3D=3D &in->filelock)
>> +         in->loner_cap =3D -1;
>> +       lock->get_wrlock(true);
>> +       mdr->wrlocks.insert(lock);
>> +       mdr->locks.insert(lock);
>> +      }
>> +    }
>>    }
>>
>> -
>> +  // unlinked inodes should be in stray
>> +  for (set<CInode*>::iterator p =3D rejoin_unlinked_inodes[from].be=
gin();
>> +       p !=3D rejoin_unlinked_inodes[from].end();
>> +       ++p) {
>> +    CInode *in =3D *p;
>> +    dout(7) << " unlinked inode " << *in << dendl;
>> +    assert(in->get_parent_dn());
>> +    assert(in->is_replica(from));
>> +  }
>=20
> I'm not clear on why we need to check this here =97 the previous for
> loop wasn't adding any inodes to the cache, so shouldn't we just chec=
k
> these conditions as we add them?
>=20
will update the code.

Thanks
Yan, Zheng

>>
>>    // done?
>>    assert(rejoin_gather.count(from));
>> @@ -4448,6 +4470,9 @@ void MDCache::handle_cache_rejoin_ack(MMDSCach=
eRejoin *ack)
>>    dout(7) << "handle_cache_rejoin_ack from " << ack->get_source() <=
< dendl;
>>    int from =3D ack->get_source().num();
>>
>> +  // for sending cache expire message
>> +  list<CInode*> isolated_inodes;
>> +
>>    // dirs
>>    for (map<dirfrag_t, MMDSCacheRejoin::dirfrag_strong>::iterator p =
=3D ack->strong_dirfrags.begin();
>>         p !=3D ack->strong_dirfrags.end();
>> @@ -4455,7 +4480,29 @@ void MDCache::handle_cache_rejoin_ack(MMDSCac=
heRejoin *ack)
>>      // we may have had incorrect dir fragmentation; refragment base=
d
>>      // on what they auth tells us.
>>      CDir *dir =3D get_force_dirfrag(p->first);
>> -    assert(dir);
>> +    if (!dir) {
>> +      CInode *diri =3D get_inode(p->first.ino);
>> +      if (!diri) {
>> +       // barebones inode; the full inode loop below will clean up.
>> +       diri =3D new CInode(this, false);
>> +       diri->inode.ino =3D p->first.ino;
>> +       diri->inode.mode =3D S_IFDIR;
>> +       if (MDS_INO_MDSDIR(p->first.ino)) {
>> +         diri->inode_auth =3D pair<int,int>(from, CDIR_AUTH_UNKNOWN=
);
>> +         add_inode(diri);
>> +         dout(10) << " add inode " << *diri << dendl;
>> +       } else {
>> +         diri->inode_auth =3D CDIR_AUTH_UNDEF;
>> +         isolated_inodes.push_back(diri);
>> +         dout(10) << " unconnected dirfrag " << p->first << dendl;
>> +       }
>> +      }
>> +      // barebones dirfrag; the full dirfrag loop below will clean =
up.
>> +      dir =3D diri->add_dirfrag(new CDir(diri, p->first.frag, this,=
 false));
>> +      if (dir->authority().first !=3D from)
>> +       adjust_subtree_auth(dir, from);
>> +      dout(10) << " add dirfrag " << *dir << dendl;
>> +    }
>>
>>      dir->set_replica_nonce(p->second.nonce);
>>      dir->state_clear(CDir::STATE_REJOINING);
>> @@ -4467,7 +4514,9 @@ void MDCache::handle_cache_rejoin_ack(MMDSCach=
eRejoin *ack)
>>          q !=3D dmap.end();
>>          ++q) {
>>        CDentry *dn =3D dir->lookup(q->first.name, q->first.snapid);
>> -      assert(dn);
>> +      if(!dn)
>> +       dn =3D dir->add_null_dentry(q->first.name, q->second.first, =
q->first.snapid);
>> +
>>        CDentry::linkage_t *dnl =3D dn->get_linkage();
>>
>>        assert(dn->last =3D=3D q->first.snapid);
>> @@ -4476,33 +4525,48 @@ void MDCache::handle_cache_rejoin_ack(MMDSCa=
cheRejoin *ack)
>>         dn->first =3D q->second.first;
>>        }
>>
>> +      // may have bad linkage if we missed dentry link/unlink messa=
ges
>> +      if (dnl->is_primary()) {
>> +       CInode *in =3D dnl->get_inode();
>> +       if (!q->second.is_primary() ||
>> +           !(vinodeno_t(q->second.ino, q->first.snapid) =3D=3D in->=
vino())) {
>> +         dout(10) << " had bad linkage for " << *dn << ", unlinking=
 " << *in << dendl;
>> +         dir->unlink_inode(dn);
>> +       }
>> +      } else if (dnl->is_remote()) {
>> +       if (!q->second.is_remote() ||
>> +           q->second.remote_ino !=3D dnl->get_remote_ino() ||
>> +           q->second.remote_d_type !=3D dnl->get_remote_d_type()) {
>> +         dout(10) << " had bad linkage for " << *dn <<  dendl;
>> +         dir->unlink_inode(dn);
>> +       }
>> +      } else {
>> +       if (!q->second.is_null())
>> +         dout(10) << " had bad linkage for " << *dn <<  dendl;
>> +      }
>> +
>>        // hmm, did we have the proper linkage here?
>> -      if (dnl->is_null() &&
>> -         !q->second.is_null()) {
>> -       dout(10) << " had bad (missing) linkage for " << *dn << dend=
l;
>> +      if (dnl->is_null() && !q->second.is_null()) {
>>         if (q->second.is_remote()) {
>>           dn->dir->link_remote_inode(dn, q->second.remote_ino, q->se=
cond.remote_d_type);
>>         } else {
>>           CInode *in =3D get_inode(q->second.ino, q->first.snapid);
>> -         assert(in =3D=3D 0);  // a rename would have been caught b=
e the resolve stage.
>> -         // barebones inode; the full inode loop below will clean u=
p.
>> -         in =3D new CInode(this, false, q->second.first, q->first.s=
napid);
>> -         in->inode.ino =3D q->second.ino;
>> -         add_inode(in);
>> +         if (!in) {
>> +           // barebones inode; assume it's dir, the full inode loop=
 below will clean up.
>> +           in =3D new CInode(this, false, q->second.first, q->first=
=2Esnapid);
>> +           in->inode.ino =3D q->second.ino;
>> +           in->inode.mode =3D S_IFDIR;
>> +           add_inode(in);
>> +           dout(10) << " add inode " << *in << dendl;
>> +         } else if (in->get_parent_dn()) {
>> +           dout(10) << " had bad linkage for " << *(in->get_parent_=
dn())
>> +                    << ", unlinking " << *in << dendl;
>> +           in->get_parent_dir()->unlink_inode(in->get_parent_dn());
>> +         }
>>           dn->dir->link_primary_inode(dn, in);
>>         }
>>        }
>> -      else if (!dnl->is_null() &&
>> -              q->second.is_null()) {
>> -       dout(0) << " had bad linkage for " << *dn << dendl;
>> -       /*
>> -        * this should happen:
>> -        *  if we're a survivor, any unlink should commit or rollbac=
k during
>> -        * the resolve stage.
>> -        *  if we failed, we shouldn't have non-auth leaf dentries a=
t all
>> -        */
>> -       assert(0);  // uh oh.
>> -      }
>> +
>>        dn->set_replica_nonce(q->second.nonce);
>>        dn->lock.set_state_rejoin(q->second.lock, rejoin_waiters);
>>        dn->state_clear(CDentry::STATE_REJOINING);
>> @@ -4564,6 +4628,21 @@ void MDCache::handle_cache_rejoin_ack(MMDSCac=
heRejoin *ack)
>>      dout(10) << " got inode locks " << *in << dendl;
>>    }
>>
>> +  // trim unconnected subtree
>> +  if (!isolated_inodes.empty()) {
>> +    map<int, MCacheExpire*> expiremap;
>> +    for (list<CInode*>::iterator p =3D isolated_inodes.begin();
>> +        p !=3D isolated_inodes.end();
>> +        ++p) {
>> +      list<CDir*> ls;
>> +      (*p)->get_dirfrags(ls);
>> +      trim_dirfrag(*ls.begin(), 0, expiremap);
>> +      assert((*p)->get_num_ref() =3D=3D 0);
>> +      delete *p;
>> +    }
>> +    send_expire_messages(expiremap);
>> +  }
>> +
>>    // done?
>>    assert(rejoin_ack_gather.count(from));
>>    rejoin_ack_gather.erase(from);
>> @@ -5164,6 +5243,37 @@ void MDCache::finish_snaprealm_reconnect(clie=
nt_t client, SnapRealm *realm, snap
>>  void MDCache::rejoin_send_acks()
>>  {
>>    dout(7) << "rejoin_send_acks" << dendl;
>> +
>> +  // replicate stray
>> +  for (map<int, set<CInode*> >::iterator p =3D rejoin_unlinked_inod=
es.begin();
>> +       p !=3D rejoin_unlinked_inodes.end();
>> +       ++p) {
>> +    for (set<CInode*>::iterator q =3D p->second.begin();
>> +        q !=3D p->second.end();
>> +        ++q) {
>> +      CInode *in =3D *q;
>> +      dout(7) << " unlinked inode " << *in << dendl;
>> +      // inode expired
>> +      if (!in->is_replica(p->first))
>> +       continue;
>> +      while (1) {
>> +       CDentry *dn =3D in->get_parent_dn();
>> +       if (dn->is_replica(p->first))
>> +         break;
>> +       dn->add_replica(p->first);
>> +       CDir *dir =3D dn->get_dir();
>> +       if (dir->is_replica(p->first))
>> +         break;
>> +       dir->add_replica(p->first);
>> +       in =3D dir->get_inode();
>> +       if (in->is_replica(p->first))
>> +         break;
>> +       if (in->is_base())
>> +         break;
>> +      }
>> +    }
>> +  }
>> +  rejoin_unlinked_inodes.clear();
>>
>>    // send acks to everyone in the recovery set
>>    map<int,MMDSCacheRejoin*> ack;
>> @@ -5203,23 +5313,29 @@ void MDCache::rejoin_send_acks()
>>         CDentry *dn =3D q->second;
>>         CDentry::linkage_t *dnl =3D dn->get_linkage();
>>
>> +       // inode
>> +       CInode *in =3D NULL;
>> +       if (dnl->is_primary())
>> +         in =3D dnl->get_inode();
>> +
>>         // dentry
>>         for (map<int,int>::iterator r =3D dn->replicas_begin();
>>              r !=3D dn->replicas_end();
>> -            ++r)
>> +            ++r) {
>>           ack[r->first]->add_strong_dentry(dir->dirfrag(), dn->name,=
 dn->first, dn->last,
>>                                            dnl->is_primary() ? dnl->=
get_inode()->ino():inodeno_t(0),
>>                                            dnl->is_remote() ? dnl->g=
et_remote_ino():inodeno_t(0),
>>                                            dnl->is_remote() ? dnl->g=
et_remote_d_type():0,
>>                                            ++r->second,
>>                                            dn->lock.get_replica_stat=
e());
>> +         // peer missed MDentrylink message ?
>> +         if (in && !in->is_replica(r->first))
>> +           in->add_replica(r->first);
>> +       }
>>
>> -       if (!dnl->is_primary())
>> +       if (!in)
>>           continue;
>>
>> -       // inode
>> -       CInode *in =3D dnl->get_inode();
>> -
>>         for (map<int,int>::iterator r =3D in->replicas_begin();
>>              r !=3D in->replicas_end();
>>              ++r) {
>> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
>> index 85f5d65..09cc092 100644
>> --- a/src/mds/MDCache.h
>> +++ b/src/mds/MDCache.h
>> @@ -416,6 +416,7 @@ protected:
>>    set<CInode*> rejoin_undef_inodes;
>>    set<CInode*> rejoin_potential_updated_scatterlocks;
>>    set<CDir*>   rejoin_undef_dirfrags;
>> +  map<int, set<CInode*> > rejoin_unlinked_inodes;
>>
>>    vector<CInode*> rejoin_recover_q, rejoin_check_q;
>>    list<Context*> rejoin_waiters;
>> --
>> 1.7.11.7
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

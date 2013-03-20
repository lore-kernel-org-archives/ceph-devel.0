From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 20/39] mds: include replica nonce in MMDSCacheRejoin::inode_strong
Date: Wed, 20 Mar 2013 16:26:58 -0700
Message-ID: <CAPYLRzhjBfH7bF-Ywq5eH=wt17KfhNBQ4h_eLuez4KEJ_E9XRg@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-21-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:44969 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab3CTX07 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 19:26:59 -0400
Received: by mail-qa0-f51.google.com with SMTP id g10so1377594qah.3
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 16:26:58 -0700 (PDT)
In-Reply-To: <1363531902-24909-21-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> So the recovering MDS can properly handle cache expire messages.
> Also increase the nonce value when sending the cache rejoin acks.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc             | 35 +++++++++++++++++++++++---------=
---
>  src/messages/MMDSCacheRejoin.h | 11 +++++++----
>  2 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 008a8a2..8ba676e 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -3538,6 +3538,7 @@ void MDCache::rejoin_send_rejoins()
>        if (p->first =3D=3D 0 && root) {
>         p->second->add_weak_inode(root->vino());
>         p->second->add_strong_inode(root->vino(),
> +                                   root->get_replica_nonce(),
>                                     root->get_caps_wanted(),
>                                     root->filelock.get_state(),
>                                     root->nestlock.get_state(),
> @@ -3551,6 +3552,7 @@ void MDCache::rejoin_send_rejoins()
>        if (CInode *in =3D get_inode(MDS_INO_MDSDIR(p->first))) {
>         p->second->add_weak_inode(in->vino());
>         p->second->add_strong_inode(in->vino(),
> +                                   in->get_replica_nonce(),
>                                     in->get_caps_wanted(),
>                                     in->filelock.get_state(),
>                                     in->nestlock.get_state(),
> @@ -3709,6 +3711,7 @@ void MDCache::rejoin_walk(CDir *dir, MMDSCacheR=
ejoin *rejoin)
>         CInode *in =3D dnl->get_inode();
>         dout(15) << " add_strong_inode " << *in << dendl;
>         rejoin->add_strong_inode(in->vino(),
> +                                in->get_replica_nonce(),
>                                  in->get_caps_wanted(),
>                                  in->filelock.get_state(),
>                                  in->nestlock.get_state(),
> @@ -4248,7 +4251,7 @@ void MDCache::handle_cache_rejoin_strong(MMDSCa=
cheRejoin *strong)
>         dir =3D rejoin_invent_dirfrag(p->first);
>      }
>      if (dir) {
> -      dir->add_replica(from);
> +      dir->add_replica(from, p->second.nonce);
>        dir->dir_rep =3D p->second.dir_rep;
>      } else {
>        dout(10) << " frag " << p->first << " doesn't match dirfragtre=
e " << *diri << dendl;
> @@ -4263,7 +4266,7 @@ void MDCache::handle_cache_rejoin_strong(MMDSCa=
cheRejoin *strong)
>           dir =3D rejoin_invent_dirfrag(p->first);
>         else
>           dout(10) << " have(approx) " << *dir << dendl;
> -       dir->add_replica(from);
> +       dir->add_replica(from, p->second.nonce);
>         dir->dir_rep =3D p->second.dir_rep;
>        }
>        refragged =3D true;
> @@ -4327,7 +4330,7 @@ void MDCache::handle_cache_rejoin_strong(MMDSCa=
cheRejoin *strong)
>         mdr->locks.insert(&dn->lock);
>        }
>
> -      dn->add_replica(from);
> +      dn->add_replica(from, q->second.nonce);
>        dout(10) << " have " << *dn << dendl;
>
>        // inode?
> @@ -4412,7 +4415,7 @@ void MDCache::handle_cache_rejoin_strong(MMDSCa=
cheRejoin *strong)
>           dout(10) << " sender has dentry but not inode, adding them =
as a replica" << dendl;
>         }
>
> -       in->add_replica(from);
> +       in->add_replica(from, p->second.nonce);
>         dout(10) << " have " << *in << dendl;
>        }
>      }
> @@ -5176,7 +5179,7 @@ void MDCache::rejoin_send_acks()
>        for (map<int,int>::iterator r =3D dir->replicas_begin();
>            r !=3D dir->replicas_end();
>            ++r)
> -       ack[r->first]->add_strong_dirfrag(dir->dirfrag(), r->second, =
dir->dir_rep);
> +       ack[r->first]->add_strong_dirfrag(dir->dirfrag(), ++r->second=
, dir->dir_rep);
>
>        for (CDir::map_t::iterator q =3D dir->items.begin();
>            q !=3D dir->items.end();
> @@ -5192,7 +5195,7 @@ void MDCache::rejoin_send_acks()
>                                            dnl->is_primary() ? dnl->g=
et_inode()->ino():inodeno_t(0),
>                                            dnl->is_remote() ? dnl->ge=
t_remote_ino():inodeno_t(0),
>                                            dnl->is_remote() ? dnl->ge=
t_remote_d_type():0,
> -                                          r->second,
> +                                          ++r->second,
>                                            dn->lock.get_replica_state=
());
>
>         if (!dnl->is_primary())
> @@ -5205,7 +5208,7 @@ void MDCache::rejoin_send_acks()
>              r !=3D in->replicas_end();
>              ++r) {
>           ack[r->first]->add_inode_base(in);
> -         ack[r->first]->add_inode_locks(in, r->second);
> +         ack[r->first]->add_inode_locks(in, ++r->second);
>         }
>
>         // subdirs in this subtree?
> @@ -5220,14 +5223,14 @@ void MDCache::rejoin_send_acks()
>          r !=3D root->replicas_end();
>          ++r) {
>        ack[r->first]->add_inode_base(root);
> -      ack[r->first]->add_inode_locks(root, r->second);
> +      ack[r->first]->add_inode_locks(root, ++r->second);
>      }
>    if (myin)
>      for (map<int,int>::iterator r =3D myin->replicas_begin();
>          r !=3D myin->replicas_end();
>          ++r) {
>        ack[r->first]->add_inode_base(myin);
> -      ack[r->first]->add_inode_locks(myin, r->second);
> +      ack[r->first]->add_inode_locks(myin, ++r->second);
>      }
>
>    // include inode base for any inodes whose scatterlocks may have u=
pdated
> @@ -5728,6 +5731,12 @@ void MDCache::send_expire_messages(map<int, MC=
acheExpire*>& expiremap)
>    for (map<int, MCacheExpire*>::iterator it =3D expiremap.begin();
>         it !=3D expiremap.end();
>         ++it) {
> +    if (mds->mdsmap->get_state(it->first) < MDSMap::STATE_REJOIN ||
> +       (mds->mdsmap->get_state(it->first) =3D=3D MDSMap::STATE_REJOI=
N &&
> +        rejoin_sent.count(it->first) =3D=3D 0)) {
> +      it->second->put();
> +      continue;
> +    }
>      dout(7) << "sending cache_expire to " << it->first << dendl;
>      mds->send_message_mds(it->second, it->first);
>    }
> @@ -9640,9 +9649,11 @@ void MDCache::handle_dentry_link(MDentryLink *=
m)
>      CInode *in =3D add_replica_inode(p, NULL, finished);
>      assert(in->get_num_ref() =3D=3D 0);
>      assert(in->get_parent_dn() =3D=3D NULL);
> -    MCacheExpire* expire =3D new MCacheExpire(mds->get_nodeid());
> -    expire->add_inode(m->get_subtree(), in->vino(), in->get_replica_=
nonce());
> -    mds->send_message_mds(expire, m->get_source().num());
> +    map<int, MCacheExpire*> expiremap;
> +    int from =3D m->get_source().num();
> +    expiremap[from] =3D new MCacheExpire(mds->get_nodeid());
> +    expiremap[from]->add_inode(m->get_subtree(), in->vino(), in->get=
_replica_nonce());
> +    send_expire_messages(expiremap);
>      remove_inode(in);
>    }
>
> diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheR=
ejoin.h
> index 825400d..b88f551 100644
> --- a/src/messages/MMDSCacheRejoin.h
> +++ b/src/messages/MMDSCacheRejoin.h
> @@ -43,19 +43,22 @@ class MMDSCacheRejoin : public Message {
>
>    // -- types --
>    struct inode_strong {
> +    int32_t nonce;
>      int32_t caps_wanted;
>      int32_t filelock, nestlock, dftlock;
>      inode_strong() {}
> -    inode_strong(int cw, int dl, int nl, int dftl) :
> -      caps_wanted(cw),
> +    inode_strong(int n, int cw, int dl, int nl, int dftl) :
> +      nonce(n), caps_wanted(cw),
>        filelock(dl), nestlock(nl), dftlock(dftl) { }
>      void encode(bufferlist &bl) const {
> +      ::encode(nonce, bl);
>        ::encode(caps_wanted, bl);
>        ::encode(filelock, bl);
>        ::encode(nestlock, bl);
>        ::encode(dftlock, bl);
>      }
>      void decode(bufferlist::iterator &bl) {
> +      ::decode(nonce, bl);
>        ::decode(caps_wanted, bl);
>        ::decode(filelock, bl);
>        ::decode(nestlock, bl);

This is a wire format change without any versioning to cover it =97
we're going to need to at a minimum add feature bits to cover this. It
might be more appropriate to introduce proper versioning at the same
time, though. You should find examples of everything you need in my
recent encoding changes.

The rest looks good.
-Greg

> @@ -208,8 +211,8 @@ public:
>    void add_weak_inode(vinodeno_t i) {
>      weak_inodes.insert(i);
>    }
> -  void add_strong_inode(vinodeno_t i, int cw, int dl, int nl, int df=
tl) {
> -    strong_inodes[i] =3D inode_strong(cw, dl, nl, dftl);
> +  void add_strong_inode(vinodeno_t i, int n, int cw, int dl, int nl,=
 int dftl) {
> +    strong_inodes[i] =3D inode_strong(n, cw, dl, nl, dftl);
>    }
>    void add_inode_locks(CInode *in, __u32 nonce) {
>      ::encode(in->inode.ino, inode_locks);
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

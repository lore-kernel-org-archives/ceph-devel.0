From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 23/39] mds: reqid for rejoinning authpin/wrlock need to be list
Date: Wed, 20 Mar 2013 16:59:31 -0700
Message-ID: <CAPYLRzhHOCsZ7nXSaVjQR5UL6Ax8iVa5r-P-RVOQeb0B6orrzA@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-24-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:41219 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab3CTX7c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 19:59:32 -0400
Received: by mail-qa0-f43.google.com with SMTP id l8so1010075qaq.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 16:59:31 -0700 (PDT)
In-Reply-To: <1363531902-24909-24-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

I think Sage is right, we can just bump the MDS protocol instead of
spending a feature bit on OTW changes =97 but this is another message w=
e
should update to the new encoding macros while we're making that bump.
The rest looks good!
-Greg

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc             | 78 ++++++++++++++++++++++++--------=
----------
>  src/messages/MMDSCacheRejoin.h | 12 +++----
>  2 files changed, 50 insertions(+), 40 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 38b1fdf..f4622de 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -4305,16 +4305,19 @@ void MDCache::handle_cache_rejoin_strong(MMDS=
CacheRejoin *strong)
>        // dn auth_pin?
>        if (strong->authpinned_dentries.count(p->first) &&
>           strong->authpinned_dentries[p->first].count(q->first)) {
> -       MMDSCacheRejoin::slave_reqid r =3D strong->authpinned_dentrie=
s[p->first][q->first];
> -       dout(10) << " dn authpin by " << r << " on " << *dn << dendl;
> -
> -       // get/create slave mdrequest
> -       MDRequest *mdr;
> -       if (have_request(r.reqid))
> -         mdr =3D request_get(r.reqid);
> -       else
> -         mdr =3D request_start_slave(r.reqid, r.attempt, from);
> -       mdr->auth_pin(dn);
> +       for (list<MMDSCacheRejoin::slave_reqid>::iterator r =3D stron=
g->authpinned_dentries[p->first][q->first].begin();
> +            r !=3D strong->authpinned_dentries[p->first][q->first].e=
nd();
> +            ++r) {
> +         dout(10) << " dn authpin by " << *r << " on " << *dn << den=
dl;
> +
> +         // get/create slave mdrequest
> +         MDRequest *mdr;
> +         if (have_request(r->reqid))
> +           mdr =3D request_get(r->reqid);
> +         else
> +           mdr =3D request_start_slave(r->reqid, r->attempt, from);
> +         mdr->auth_pin(dn);
> +       }
>        }
>
>        // dn xlock?
> @@ -4389,22 +4392,25 @@ void MDCache::handle_cache_rejoin_strong(MMDS=
CacheRejoin *strong)
>
>      // auth pin?
>      if (strong->authpinned_inodes.count(in->vino())) {
> -      MMDSCacheRejoin::slave_reqid r =3D strong->authpinned_inodes[i=
n->vino()];
> -      dout(10) << " inode authpin by " << r << " on " << *in << dend=
l;
> +      for (list<MMDSCacheRejoin::slave_reqid>::iterator r =3D strong=
->authpinned_inodes[in->vino()].begin();
> +          r !=3D strong->authpinned_inodes[in->vino()].end();
> +          ++r) {
> +       dout(10) << " inode authpin by " << *r << " on " << *in << de=
ndl;
>
> -      // get/create slave mdrequest
> -      MDRequest *mdr;
> -      if (have_request(r.reqid))
> -       mdr =3D request_get(r.reqid);
> -      else
> -       mdr =3D request_start_slave(r.reqid, r.attempt, from);
> -      if (strong->frozen_authpin_inodes.count(in->vino())) {
> -       assert(!in->get_num_auth_pins());
> -       mdr->freeze_auth_pin(in);
> -      } else {
> -       assert(!in->is_frozen_auth_pin());
> +       // get/create slave mdrequest
> +       MDRequest *mdr;
> +       if (have_request(r->reqid))
> +         mdr =3D request_get(r->reqid);
> +       else
> +         mdr =3D request_start_slave(r->reqid, r->attempt, from);
> +       if (strong->frozen_authpin_inodes.count(in->vino())) {
> +         assert(!in->get_num_auth_pins());
> +         mdr->freeze_auth_pin(in);
> +       } else {
> +         assert(!in->is_frozen_auth_pin());
> +       }
> +       mdr->auth_pin(in);
>        }
> -      mdr->auth_pin(in);
>      }
>      // xlock(s)?
>      if (strong->xlocked_inodes.count(in->vino())) {
> @@ -4427,19 +4433,23 @@ void MDCache::handle_cache_rejoin_strong(MMDS=
CacheRejoin *strong)
>      }
>      // wrlock(s)?
>      if (strong->wrlocked_inodes.count(in->vino())) {
> -      for (map<int,MMDSCacheRejoin::slave_reqid>::iterator q =3D str=
ong->wrlocked_inodes[in->vino()].begin();
> +      for (map<int, list<MMDSCacheRejoin::slave_reqid> >::iterator q=
 =3D strong->wrlocked_inodes[in->vino()].begin();
>            q !=3D strong->wrlocked_inodes[in->vino()].end();
>            ++q) {
>         SimpleLock *lock =3D in->get_lock(q->first);
> -       dout(10) << " inode wrlock by " << q->second << " on " << *lo=
ck << " on " << *in << dendl;
> -       MDRequest *mdr =3D request_get(q->second.reqid);  // should h=
ave this from auth_pin above.
> -       assert(mdr->is_auth_pinned(in));
> -       lock->set_state(LOCK_LOCK);
> -       if (lock =3D=3D &in->filelock)
> -         in->loner_cap =3D -1;
> -       lock->get_wrlock(true);
> -       mdr->wrlocks.insert(lock);
> -       mdr->locks.insert(lock);
> +       for (list<MMDSCacheRejoin::slave_reqid>::iterator r =3D q->se=
cond.begin();
> +            r !=3D q->second.end();
> +            ++r) {
> +         dout(10) << " inode wrlock by " << *r << " on " << *lock <<=
 " on " << *in << dendl;
> +         MDRequest *mdr =3D request_get(r->reqid);  // should have t=
his from auth_pin above.
> +         assert(mdr->is_auth_pinned(in));
> +         lock->set_state(LOCK_MIX);
> +         if (lock =3D=3D &in->filelock)
> +           in->loner_cap =3D -1;
> +         lock->get_wrlock(true);
> +         mdr->wrlocks.insert(lock);
> +         mdr->locks.insert(lock);
> +       }
>        }
>      }
>    }
> diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheR=
ejoin.h
> index 7c37ab4..f29e8f5 100644
> --- a/src/messages/MMDSCacheRejoin.h
> +++ b/src/messages/MMDSCacheRejoin.h
> @@ -188,11 +188,11 @@ class MMDSCacheRejoin : public Message {
>        ::decode(attempt, bl);
>      }
>    };
> -  map<vinodeno_t, slave_reqid> authpinned_inodes;
> +  map<vinodeno_t, list<slave_reqid> > authpinned_inodes;
>    map<vinodeno_t, slave_reqid> frozen_authpin_inodes;
>    map<vinodeno_t, map<__s32, slave_reqid> > xlocked_inodes;
> -  map<vinodeno_t, map<__s32, slave_reqid> > wrlocked_inodes;
> -  map<dirfrag_t, map<string_snap_t, slave_reqid> > authpinned_dentri=
es;
> +  map<vinodeno_t, map<__s32, list<slave_reqid> > > wrlocked_inodes;
> +  map<dirfrag_t, map<string_snap_t, list<slave_reqid> > > authpinned=
_dentries;
>    map<dirfrag_t, map<string_snap_t, slave_reqid> > xlocked_dentries;
>
>    MMDSCacheRejoin() : Message(MSG_MDS_CACHEREJOIN) {}
> @@ -232,7 +232,7 @@ public:
>      ::encode(bl, inode_base);
>    }
>    void add_inode_authpin(vinodeno_t ino, const metareqid_t& ri, __u3=
2 attempt) {
> -    authpinned_inodes[ino] =3D slave_reqid(ri, attempt);
> +    authpinned_inodes[ino].push_back(slave_reqid(ri, attempt));
>    }
>    void add_inode_frozen_authpin(vinodeno_t ino, const metareqid_t& r=
i, __u32 attempt) {
>      frozen_authpin_inodes[ino] =3D slave_reqid(ri, attempt);
> @@ -241,7 +241,7 @@ public:
>      xlocked_inodes[ino][lt] =3D slave_reqid(ri, attempt);
>    }
>    void add_inode_wrlock(vinodeno_t ino, int lt, const metareqid_t& r=
i, __u32 attempt) {
> -    wrlocked_inodes[ino][lt] =3D slave_reqid(ri, attempt);
> +    wrlocked_inodes[ino][lt].push_back(slave_reqid(ri, attempt));
>    }
>
>    void add_scatterlock_state(CInode *in) {
> @@ -282,7 +282,7 @@ public:
>    }
>    void add_dentry_authpin(dirfrag_t df, const string& dname, snapid_=
t last,
>                           const metareqid_t& ri, __u32 attempt) {
> -    authpinned_dentries[df][string_snap_t(dname, last)] =3D slave_re=
qid(ri, attempt);
> +    authpinned_dentries[df][string_snap_t(dname, last)].push_back(sl=
ave_reqid(ri, attempt));
>    }
>    void add_dentry_xlock(dirfrag_t df, const string& dname, snapid_t =
last,
>                         const metareqid_t& ri, __u32 attempt) {
> --
> 1.7.11.7
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

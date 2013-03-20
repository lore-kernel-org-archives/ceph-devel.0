From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 21/39] mds: encode dirfrag base in cache rejoin ack
Date: Wed, 20 Mar 2013 16:33:12 -0700
Message-ID: <CAPYLRzjwL43cDez1aC7x_m7E71Udrus3vqm1+j1f4O+0MmG5+w@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-22-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:54524 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3CTXdN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 19:33:13 -0400
Received: by mail-qa0-f51.google.com with SMTP id g10so1378676qah.17
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 16:33:12 -0700 (PDT)
In-Reply-To: <1363531902-24909-22-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

This needs to handle versioning the encoding based on peer feature bits=
 too.

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Cache rejoin ack message already encodes inode base, make it also enc=
ode
> dirfrag base. This allowes the message to replicate stray dentries li=
ke
> MDentryUnlink message. The function will be used by later patch.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDir.h                 | 20 +++++++++++++-------
>  src/mds/MDCache.cc             | 20 ++++++++++++++++++--
>  src/messages/MMDSCacheRejoin.h | 12 +++++++++++-
>  3 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/src/mds/CDir.h b/src/mds/CDir.h
> index 79946f1..f4a3a3d 100644
> --- a/src/mds/CDir.h
> +++ b/src/mds/CDir.h
> @@ -437,23 +437,29 @@ private:
>      ::encode(dist, bl);
>    }
>
> -  void encode_replica(int who, bufferlist& bl) {
> -    __u32 nonce =3D add_replica(who);
> -    ::encode(nonce, bl);
> +  void _encode_base(bufferlist& bl) {
>      ::encode(first, bl);
>      ::encode(fnode, bl);
>      ::encode(dir_rep, bl);
>      ::encode(dir_rep_by, bl);
>    }
> -  void decode_replica(bufferlist::iterator& p) {
> -    __u32 nonce;
> -    ::decode(nonce, p);
> -    replica_nonce =3D nonce;
> +  void _decode_base(bufferlist::iterator& p) {
>      ::decode(first, p);
>      ::decode(fnode, p);
>      ::decode(dir_rep, p);
>      ::decode(dir_rep_by, p);
>    }
> +  void encode_replica(int who, bufferlist& bl) {
> +    __u32 nonce =3D add_replica(who);
> +    ::encode(nonce, bl);
> +    _encode_base(bl);
> +  }
> +  void decode_replica(bufferlist::iterator& p) {
> +    __u32 nonce;
> +    ::decode(nonce, p);
> +    replica_nonce =3D nonce;
> +    _decode_base(p);
> +  }
>
>
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 8ba676e..344777e 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -4510,8 +4510,22 @@ void MDCache::handle_cache_rejoin_ack(MMDSCach=
eRejoin *ack)
>      }
>    }
>
> +  // full dirfrags
> +  bufferlist::iterator p =3D ack->dirfrag_base.begin();
> +  while (!p.end()) {
> +    dirfrag_t df;
> +    bufferlist basebl;
> +    ::decode(df, p);
> +    ::decode(basebl, p);
> +    CDir *dir =3D get_dirfrag(df);
> +    assert(dir);
> +    bufferlist::iterator q =3D basebl.begin();
> +    dir->_decode_base(q);
> +    dout(10) << " got dir replica " << *dir << dendl;
> +  }
> +
>    // full inodes
> -  bufferlist::iterator p =3D ack->inode_base.begin();
> +  p =3D ack->inode_base.begin();
>    while (!p.end()) {
>      inodeno_t ino;
>      snapid_t last;
> @@ -5178,8 +5192,10 @@ void MDCache::rejoin_send_acks()
>        // dir
>        for (map<int,int>::iterator r =3D dir->replicas_begin();
>            r !=3D dir->replicas_end();
> -          ++r)
> +          ++r) {
>         ack[r->first]->add_strong_dirfrag(dir->dirfrag(), ++r->second=
, dir->dir_rep);
> +       ack[r->first]->add_dirfrag_base(dir);
> +      }
>
>        for (CDir::map_t::iterator q =3D dir->items.begin();
>            q !=3D dir->items.end();
> diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheR=
ejoin.h
> index b88f551..7c37ab4 100644
> --- a/src/messages/MMDSCacheRejoin.h
> +++ b/src/messages/MMDSCacheRejoin.h
> @@ -20,6 +20,7 @@
>  #include "include/types.h"
>
>  #include "mds/CInode.h"
> +#include "mds/CDir.h"
>
>  // sent from replica to auth
>
> @@ -169,6 +170,7 @@ class MMDSCacheRejoin : public Message {
>    // full
>    bufferlist inode_base;
>    bufferlist inode_locks;
> +  bufferlist dirfrag_base;
>
>    // authpins, xlocks
>    struct slave_reqid {
> @@ -258,7 +260,13 @@ public:
>    void add_strong_dirfrag(dirfrag_t df, int n, int dr) {
>      strong_dirfrags[df] =3D dirfrag_strong(n, dr);
>    }
> -
> +  void add_dirfrag_base(CDir *dir) {
> +    ::encode(dir->dirfrag(), dirfrag_base);
> +    bufferlist bl;
> +    dir->_encode_base(bl);
> +    ::encode(bl, dirfrag_base);
> +  }

We are guilty of doing this in other places, but we should avoid
implicit encodings like this one, especially when the decode happens
somewhere else like it does here. We can make a vector dirfrag_bases
and add to that, and then encode and decode it along with the rest of
the message =97 would that work for your purposes?
-Greg

> +
>    // dentries
>    void add_weak_dirfrag(dirfrag_t df) {
>      weak_dirfrags.insert(df);
> @@ -294,6 +302,7 @@ public:
>      ::encode(wrlocked_inodes, payload);
>      ::encode(cap_export_bl, payload);
>      ::encode(strong_dirfrags, payload);
> +    ::encode(dirfrag_base, payload);
>      ::encode(weak, payload);
>      ::encode(weak_dirfrags, payload);
>      ::encode(weak_inodes, payload);
> @@ -319,6 +328,7 @@ public:
>        ::decode(cap_export_paths, q);
>      }
>      ::decode(strong_dirfrags, p);
> +    ::decode(dirfrag_base, p);
>      ::decode(weak, p);
>      ::decode(weak_dirfrags, p);
>      ::decode(weak_inodes, p);
> --
> 1.7.11.7
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

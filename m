From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 28/39] mds: add dirty imported dirfrag to LogSegment
Date: Wed, 20 Mar 2013 20:14:32 -0700
Message-ID: <CAPYLRzjLDnDiddz-s-x3EGGEgNDro8axxXJ+kyVTxDNevBk+Eg@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-29-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49109 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3CUDOd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:14:33 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so710203wiw.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:14:32 -0700 (PDT)
In-Reply-To: <1363531902-24909-29-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Whoops!
Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDir.cc     | 7 +++++--
>  src/mds/CDir.h      | 2 +-
>  src/mds/Migrator.cc | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index af0ae9c..34bd8d3 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -2164,7 +2164,7 @@ void CDir::finish_export(utime_t now)
>    dirty_old_rstat.clear();
>  }
>
> -void CDir::decode_import(bufferlist::iterator& blp, utime_t now)
> +void CDir::decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls)
>  {
>    ::decode(first, blp);
>    ::decode(fnode, blp);
> @@ -2177,7 +2177,10 @@ void CDir::decode_import(bufferlist::iterator& blp, utime_t now)
>    ::decode(s, blp);
>    state &= MASK_STATE_IMPORT_KEPT;
>    state |= (s & MASK_STATE_EXPORTED);
> -  if (is_dirty()) get(PIN_DIRTY);
> +  if (is_dirty()) {
> +    get(PIN_DIRTY);
> +    _mark_dirty(ls);
> +  }
>
>    ::decode(dir_rep, blp);
>
> diff --git a/src/mds/CDir.h b/src/mds/CDir.h
> index f4a3a3d..7e1db73 100644
> --- a/src/mds/CDir.h
> +++ b/src/mds/CDir.h
> @@ -550,7 +550,7 @@ public:
>    void abort_export() {
>      put(PIN_TEMPEXPORTING);
>    }
> -  void decode_import(bufferlist::iterator& blp, utime_t now);
> +  void decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls);
>
>
>    // -- auth pins --
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 833df12..d626cb1 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -2397,7 +2397,7 @@ int Migrator::decode_import_dir(bufferlist::iterator& blp,
>    dout(7) << "decode_import_dir " << *dir << dendl;
>
>    // assimilate state
> -  dir->decode_import(blp, now);
> +  dir->decode_import(blp, now, ls);
>
>    // mark  (may already be marked from get_or_open_dir() above)
>    if (!dir->is_auth())
> --
> 1.7.11.7
>

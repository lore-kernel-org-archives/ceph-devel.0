From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 34/39] mds: don't open dirfrag while subtree is frozen
Date: Wed, 20 Mar 2013 20:38:10 -0700
Message-ID: <CAPYLRzgGsicQX=ru4r9wRzMsJhbQPa6Jdb_qwO+n5v7GR8XLWQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-35-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:42041 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3CUDiL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:38:11 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so719261wiw.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:38:10 -0700 (PDT)
In-Reply-To: <1363531902-24909-35-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index e9a79cd..30687ec 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -7101,9 +7101,9 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
>      if (!curdir) {
>        if (cur->is_auth()) {
>          // parent dir frozen_dir?
> -        if (cur->is_frozen_dir()) {
> -          dout(7) << "traverse: " << *cur->get_parent_dir() << " is frozen_dir, waiting" << dendl;
> -          cur->get_parent_dn()->get_dir()->add_waiter(CDir::WAIT_UNFREEZE, _get_waiter(mdr, req, fin));
> +        if (cur->is_frozen()) {
> +          dout(7) << "traverse: " << *cur << " is frozen, waiting" << dendl;
> +          cur->add_waiter(CDir::WAIT_UNFREEZE, _get_waiter(mdr, req, fin));
>            return 1;
>          }
>          curdir = cur->get_or_open_dirfrag(this, fg);
> --
> 1.7.11.7
>

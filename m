From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 31/39] mds: unfreeze subtree if import aborts in PREPPED state
Date: Wed, 20 Mar 2013 20:27:24 -0700
Message-ID: <CAPYLRzgcRLpR=-XNS-JVwpLXS2_oZsigqpV=O8Xg5YRf2dRdww@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-32-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37277 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab3CUD10 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:27:26 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so6055114wib.16
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:27:24 -0700 (PDT)
In-Reply-To: <1363531902-24909-32-git-send-email-zheng.z.yan@intel.com>
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
>  src/mds/Migrator.cc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 143d71e..963706c 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -1658,11 +1658,14 @@ void Migrator::handle_export_cancel(MExportDirCancel *m)
>      CInode *in = cache->get_inode(df.ino);
>      assert(in);
>      import_reverse_discovered(df, in);
> -  } else if (import_state[df] == IMPORT_PREPPING ||
> -            import_state[df] == IMPORT_PREPPED) {
> +  } else if (import_state[df] == IMPORT_PREPPING) {
>      CDir *dir = mds->mdcache->get_dirfrag(df);
>      assert(dir);
>      import_reverse_prepping(dir);
> +  } else if (import_state[df] == IMPORT_PREPPED) {
> +    CDir *dir = mds->mdcache->get_dirfrag(df);
> +    assert(dir);
> +    import_reverse_unfreeze(dir);
>    } else {
>      assert(0 == "got export_cancel in weird state");
>    }
> --
> 1.7.11.7
>

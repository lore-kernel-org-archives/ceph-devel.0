From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 38/39] mds: don't replicate purging dentry
Date: Wed, 20 Mar 2013 20:46:42 -0700
Message-ID: <CAPYLRzhPWq8627FMSu-Xri3YP6pk1Ttk=G-=8DRYBwZXh5tBDQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-39-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:39028 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab3CUDqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:46:43 -0400
Received: by mail-we0-f170.google.com with SMTP id z2so450653wey.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:46:42 -0700 (PDT)
In-Reply-To: <1363531902-24909-39-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> open_remote_ino is racy, it's possible someone deletes the inode's
> last linkage while the MDS is discovering the inode.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 24f1109..d730ff1 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -9225,8 +9225,15 @@ void MDCache::handle_discover(MDiscover *dis)
>      if (dis->get_want_ino()) {
>        // lookup by ino
>        CInode *in = get_inode(dis->get_want_ino(), snapid);
> -      if (in && in->is_auth() && in->get_parent_dn()->get_dir() == curdir)
> +      if (in && in->is_auth() && in->get_parent_dn()->get_dir() == curdir) {
>         dn = in->get_parent_dn();
> +       if (dn->state_test(CDentry::STATE_PURGING)) {
> +         // set error flag in reply
> +         dout(7) << "dentry " << *dn << " is purging, flagging error ino" << dendl;
> +         reply->set_flag_error_ino();
> +         break;
> +       }
> +      }
>      } else if (dis->get_want().depth() > 0) {
>        // lookup dentry
>        dn = curdir->lookup(dis->get_dentry(i), snapid);
> --
> 1.7.11.7
>

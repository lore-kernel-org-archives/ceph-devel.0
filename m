From: Samuel Just <sam.just@inktank.com>
Subject: Re: [PATCH] ReplicatedPG: For async-read, set the real result after
 completing read.
Date: Fri, 11 Jul 2014 10:21:10 -0700
Message-ID: <CA+4uBUbYO-yrKaALNy=8Y5UJ0k2oLfWM4sT9Da3iQB2_-aP_JA@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C88781F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51872 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaGKRVL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 13:21:11 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so1719019pdb.7
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jul 2014 10:21:11 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C88781F@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks about right, file a pull request?
-Sam

On Thu, Jul 10, 2014 at 2:23 AM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> When reading an object from replicated pool, ceph uses sync mode, so it can set the results in execute_ctx correctly.
> However, For the async-read in EC Pool, current code didn't set the real results after read in complete_read_ctx.
>
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  src/osd/ReplicatedPG.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index cab3fde..ac0e8ad 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -5318,7 +5318,7 @@ void ReplicatedPG::complete_read_ctx(int result, OpContext *ctx)
>      // on ENOENT, set a floor for what the next user version will be.
>      reply->set_enoent_reply_versions(info.last_update, info.last_user_version);
>    }
> -
> +  reply->set_result(result);
>    reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
>    osd->send_message_osd_client(reply, m->get_connection());
>    close_op_ctx(ctx, 0);
> --
> 1.9.1

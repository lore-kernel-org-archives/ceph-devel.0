From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] mon: OSDMonitor: add "osd pool get <pool> erasure_code_profile"
 command
Date: Wed, 16 Jul 2014 17:53:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407161749220.9196@cobra.newdream.net>
References: <6AA21C22F0A5DA478922644AD2EC308C893D76@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51252 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaGQAx3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 20:53:29 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C893D76@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Samuel Just <sam.just@inktank.com>, "loic@dachary.org" <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Applied, thanks!

sage

On Thu, 17 Jul 2014, Ma, Jianpeng wrote:

> Enable us to obtain the erasure-code-profile for a given erasure-pool.
> 
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  src/mon/MonCommands.h |  2 +-
>  src/mon/OSDMonitor.cc | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/src/mon/MonCommands.h b/src/mon/MonCommands.h
> index f429e0f..627546b 100644
> --- a/src/mon/MonCommands.h
> +++ b/src/mon/MonCommands.h
> @@ -571,7 +571,7 @@ COMMAND("osd pool rename " \
>         "rename <srcpool> to <destpool>", "osd", "rw", "cli,rest")
>  COMMAND("osd pool get " \
>         "name=pool,type=CephPoolname " \
> -       "name=var,type=CephChoices,strings=size|min_size|crash_replay_interval|pg_num|pgp_num|crush_ruleset|hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|auid|target_max_objects|target_max_bytes|cache_target_dirty_ratio|cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age", \
> +       "name=var,type=CephChoices,strings=size|min_size|crash_replay_interval|pg_num|pgp_num|crush_ruleset|hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|auid|target_max_objects|target_max_bytes|cache_target_dirty_ratio|cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|erasure_code_profile", \
>         "get pool parameter <var>", "osd", "r", "cli,rest")
>  COMMAND("osd pool set " \
>         "name=pool,type=CephPoolname " \
> diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
> index c60d744..d267245 100644
> --- a/src/mon/OSDMonitor.cc
> +++ b/src/mon/OSDMonitor.cc
> @@ -2483,6 +2483,13 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
>        goto reply;
>      }
> 
> +    if (!p->is_erasure() && var == "erasure_code_profile") {
> +      ss << "pool '" << poolstr
> +         << "' is not a erasure pool: variable not applicable";
> +      r = -EACCES;
> +      goto reply;
> +    }
> +
>      if (f) {
>        f->open_object_section("pool");
>        f->dump_string("pool", poolstr);
> @@ -2536,6 +2543,8 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
>          f->dump_unsigned("cache_min_flush_age", p->cache_min_flush_age);
>        } else if (var == "cache_min_evict_age") {
>          f->dump_unsigned("cache_min_evict_age", p->cache_min_evict_age);
> +      } else if (var == "erasure_code_profile") {
> +       f->dump_string("erasure_code_profile", p->erasure_code_profile);
>        }
> 
>        f->close_section();
> @@ -2583,6 +2592,8 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
>          ss << "cache_min_flush_age: " << p->cache_min_flush_age;
>        } else if (var == "cache_min_evict_age") {
>          ss << "cache_min_evict_age: " << p->cache_min_evict_age;
> +      } else if (var == "erasure_code_profile") {
> +       ss << "erasure_code_profile: " << p->erasure_code_profile;
>        }
> 
>        rdata.append(ss);
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

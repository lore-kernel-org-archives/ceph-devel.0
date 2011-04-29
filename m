From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] hadoop: cleanups for libceph type update
Date: Fri, 29 Apr 2011 08:51:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104290851410.31733@cobra.newdream.net>
References: <1304090039-14246-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab1D2PvY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 11:51:24 -0400
In-Reply-To: <1304090039-14246-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Fri, 29 Apr 2011, Jim Schutt wrote:

> 
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  src/client/hadoop/CephFSInterface.cc |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/client/hadoop/CephFSInterface.cc b/src/client/hadoop/CephFSInterface.cc
> index 38c9be9..dea082b 100644
> --- a/src/client/hadoop/CephFSInterface.cc
> +++ b/src/client/hadoop/CephFSInterface.cc
> @@ -13,7 +13,7 @@ union ceph_mount_union_t {
>    jlong cjlong;
>  };
>  
> -static void set_struct ceph_mount_info(JNIEnv *env, jobject obj, struct ceph_mount_info *cmount)
> +static void set_ceph_mount_info(JNIEnv *env, jobject obj, struct ceph_mount_info *cmount)
>  {
>    jclass cls = env->GetObjectClass(obj);
>    jfieldID fid = env->GetFieldID(cls, "cmount", "Ljava/lang/Long;");
> @@ -105,7 +105,7 @@ JNIEXPORT jboolean JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1initi
>      ceph_set_default_preferred_pg(cmount, ceph_get_local_osd(cmount));
>    }
>  
> -  set_ceph_mount_t(env, obj, cmount);
> +  set_ceph_mount_info(env, obj, cmount);
>    return true;
>  }
>  
> @@ -609,7 +609,7 @@ JNIEXPORT jboolean JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1kill_
>    if (!cmount)
>      return true;
>    ceph_shutdown(cmount);
> -  set_ceph_mount_t(env, obj, NULL);
> +  set_ceph_mount_info(env, obj, NULL);
>    return true;
>  }
>  
> -- 
> 1.6.6
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

From: Sage Weil <sage@newdream.net>
Subject: Re: PATCH: link ceph-client version to kernel version
Date: Wed, 7 Jul 2010 08:03:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007070757310.23002@cobra.newdream.net>
References: <i11fb7$mk1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53534 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab0GGPBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 11:01:54 -0400
In-Reply-To: <i11fb7$mk1$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Wed, 7 Jul 2010, Thomas Mueller wrote:
> hi
> 
> reading the version in ceph_fs.h made me think, that now that ceph is in 
> vanilla kernel, it would be nice to have the version linked to the kernel 
> version. this is how the kvm guys work for their backported module.

Hmm, how does that work?  This would divorce the kclient version from the 
server side (which is basically already is, teh CEPH_VERSION* defines are 
ignored by the kclient currently) and match it up with the kernel version.  
For most people, that is just whatever upstream kernel they downloaded.

Is the goal just to make the standalone/backported code tell you which 
version the client code corresponds to?  If that's the case, I wonder the 
defines should be generated exclusively in the backport branches of the 
-standalone.git repo.

(Currently the only reason those defines are there at all is because the
ceph_fs.h header (along with a few others) is periodically synced up with 
the server code.  Probably they should be moved into a non-synced header 
to avoid that confusion.)

sage

> I've also patched super.c to expose the version to modinfo.
> 
> - Thomas
> 
> 
> diff --git a/ceph_fs.h b/ceph_fs.h
> index 63ff461..cfc995b 100644
> --- a/ceph_fs.h
> +++ b/ceph_fs.h
> @@ -18,16 +18,17 @@
>  /*
>   * Ceph release version
>   */
> -#define CEPH_VERSION_MAJOR 0
> -#define CEPH_VERSION_MINOR 20
> -#define CEPH_VERSION_PATCH 0
> +#define CEPH_VERSION_MAJOR 2
> +#define CEPH_VERSION_MINOR 6
> +#define CEPH_VERSION_PATCH 35
> +#define CEPH_VERSION_FIX 0
>  
>  #define _CEPH_STRINGIFY(x) #x
>  #define CEPH_STRINGIFY(x) _CEPH_STRINGIFY(x)
> -#define CEPH_MAKE_VERSION(x, y, z) CEPH_STRINGIFY(x) "." CEPH_STRINGIFY(y) \
> -       "." CEPH_STRINGIFY(z)
> +#define CEPH_MAKE_VERSION(w, x, y, z) CEPH_STRINGIFY(w) "." CEPH_STRINGIFY(x) \
> +       "." CEPH_STRINGIFY(y) "." CEPH_STRINGIFY(z)
>  #define CEPH_VERSION CEPH_MAKE_VERSION(CEPH_VERSION_MAJOR, \
> -                                      CEPH_VERSION_MINOR, CEPH_VERSION_PATCH)
> +                                      CEPH_VERSION_MINOR, CEPH_VERSION_PATCH, CEPH_VERSION_FIX)
>  
>  /*
>   * subprotocol versions.  when specific messages types or high-level
> diff --git a/super.c b/super.c
> index 27447a2..93d9c59 100644
> --- a/super.c
> +++ b/super.c
> @@ -1149,3 +1149,4 @@ MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
>  MODULE_AUTHOR("Patience Warnick <patience@newdream.net>");
>  MODULE_DESCRIPTION("Ceph filesystem for Linux");
>  MODULE_LICENSE("GPL");
> +MODULE_INFO(version, CEPH_VERSION);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

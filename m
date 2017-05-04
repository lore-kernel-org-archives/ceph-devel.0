From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: attr: add support for cephfs
Date: Thu, 4 May 2017 11:23:40 +0800
Message-ID: <20170504032340.GH7250@eguan.usersys.redhat.com>
References: <20170503105413.8314-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbdEDDXn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 3 May 2017 23:23:43 -0400
Content-Disposition: inline
In-Reply-To: <20170503105413.8314-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, ceph-devel@vger.kernel.org

On Wed, May 03, 2017 at 11:54:13AM +0100, Luis Henriques wrote:
> Block size for cephfs is 4M, which makes generic/020 test fail as the
> value for MAX_ATTRS and MAX_ATTRVAL_SIZE will be too high.  Restrict these
> two variables to sane values for this FSTYP.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Thanks for the patch! I'd like some reviews from ceph developers on the
ceph MAX_ATTRS and MAX_ATTRVAL_SIZE numbers.

Thanks,
Eryu

> ---
>  common/attr | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index ac139e618b2a..c840ce42a1fa 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -254,26 +254,36 @@ _sort_getfattr_output()
>  }
>  
>  # set maximum total attr space based on fs type
> -if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "pvfs2" ]; then
> +case "$FSTYP" in
> +xfs|udf|pvfs2|ceph)
>  	MAX_ATTRS=1000
> -else # Assume max ~1 block of attrs
> +	;;
> +*)
> +	# Assume max ~1 block of attrs
>  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
>  	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
>  	let MAX_ATTRS=$BLOCK_SIZE/40
> -fi
> +esac
>  
>  export MAX_ATTRS
>  
>  # Set max attr value size based on fs type
> -if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "btrfs" ]; then
> +case "$FSTYP" in
> +xfs|udf|btrfs)
>  	MAX_ATTRVAL_SIZE=64
> -elif [ "$FSTYP" == "pvfs2" ]; then
> +	;;
> +pvfs2)
>  	MAX_ATTRVAL_SIZE=8192
> -else # Assume max ~1 block of attrs
> +	;;
> +ceph)
> +	MAX_ATTRVAL_SIZE=65536
> +	;;
> +*)
> +	# Assume max ~1 block of attrs
>  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
>  	# leave a little overhead
>  	let MAX_ATTRVAL_SIZE=$BLOCK_SIZE-256
> -fi
> +esac
>  
>  export MAX_ATTRVAL_SIZE
>  # make sure this script returns success
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

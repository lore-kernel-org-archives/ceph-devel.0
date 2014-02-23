From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/6] libceph: add support for CEPH_OSD_OP_SETALLOCHINT
 osd op
Date: Sun, 23 Feb 2014 08:03:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402230759290.17508@cobra.newdream.net>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-3-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55054 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaBWQDC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 11:03:02 -0500
In-Reply-To: <1393008946-7931-3-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 21 Feb 2014, Ilya Dryomov wrote:
> This is primarily for rbd's benefit and is supposed to combat
> fragmentation:
> 
> "... knowing that rbd images have a 4m size, librbd can pass a hint
> that will let the osd do the xfs allocation size ioctl on new files so
> that they are allocated in 1m or 4m chunks.  We've seen cases where
> users with rbd workloads have very high levels of fragmentation in xfs
> and this would mitigate that and probably have a pretty nice
> performance benefit."
> 
> SETALLOCHINT is considered advisory, so our backwards compatibility
> mechanism here is to set FAILOK flag for all SETALLOCHINT ops.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osd_client.h |    9 +++++++++
>  include/linux/ceph/rados.h      |    8 ++++++++
>  net/ceph/osd_client.c           |   30 ++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index e94f5da251d6..6bfcb0eca8ab 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -103,6 +103,11 @@ struct ceph_osd_req_op {
>  			u32 timeout;
>  			__u8 flag;
>  		} watch;
> +		struct {
> +			u64 expected_size;
> +			u64 expected_write_size;
> +			__u8 expected_size_probability;
> +		} hint;

s/hint/alloc_hint/ ?

>  	};
>  };
>  
> @@ -294,6 +299,10 @@ extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>  extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>  					unsigned int which, u16 opcode,
>  					u64 cookie, u64 version, int flag);
> +extern void osd_req_op_hint_init(struct ceph_osd_request *osd_req,
> +				 unsigned int which, u16 opcode,
> +				 u64 expected_size, u64 expected_write_size,
> +				 u8 expected_size_probability);
>  
>  extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>  					       struct ceph_snap_context *snapc,
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index 8f9bf4570215..b8e2dd11f186 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -227,6 +227,9 @@ enum {
>  	CEPH_OSD_OP_OMAPRMKEYS    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 24,
>  	CEPH_OSD_OP_OMAP_CMP      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 25,
>  
> +	/* hints */
> +	CEPH_OSD_OP_SETALLOCHINT = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 35,
> +
>  	/** multi **/
>  	CEPH_OSD_OP_CLONERANGE = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_MULTI | 1,
>  	CEPH_OSD_OP_ASSERT_SRC_VERSION = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_MULTI | 2,
> @@ -416,6 +419,11 @@ struct ceph_osd_op {
>  			__le64 offset, length;
>  			__le64 src_offset;
>  		} __attribute__ ((packed)) clonerange;
> +		struct {
> +			__le64 expected_size;
> +			__le64 expected_write_size;
> +			__u8 expected_size_probability;
> +		} __attribute__ ((packed)) hint;

s/hint/alloc_hint/, I think.  Just made the same comment on the user space 
side.

>  	};
>  	__le32 payload_len;
>  } __attribute__ ((packed));
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5d7fd0b8c1c8..4090f6e8db3a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -436,6 +436,7 @@ static bool osd_req_opcode_valid(u16 opcode)
>  	case CEPH_OSD_OP_OMAPCLEAR:
>  	case CEPH_OSD_OP_OMAPRMKEYS:
>  	case CEPH_OSD_OP_OMAP_CMP:
> +	case CEPH_OSD_OP_SETALLOCHINT:
>  	case CEPH_OSD_OP_CLONERANGE:
>  	case CEPH_OSD_OP_ASSERT_SRC_VERSION:
>  	case CEPH_OSD_OP_SRC_CMPXATTR:
> @@ -591,6 +592,28 @@ void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>  }
>  EXPORT_SYMBOL(osd_req_op_watch_init);
>  
> +void osd_req_op_hint_init(struct ceph_osd_request *osd_req,
> +			  unsigned int which, u16 opcode,
> +			  u64 expected_size, u64 expected_write_size,
> +			  u8 expected_size_probability)
> +{
> +	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
> +
> +	BUG_ON(opcode != CEPH_OSD_OP_SETALLOCHINT);

I would just drop the opcode argument all together.  And 
s/hint/alloc_hint/ in the function name...  I wouldn't expect that any 
other type of hint would have these same arguments.

> +
> +	op->hint.expected_size = expected_size;
> +	op->hint.expected_write_size = expected_write_size;
> +	op->hint.expected_size_probability = expected_size_probability;
> +
> +	/*
> +	 * CEPH_OSD_OP_SETALLOCHINT op is advisory and therefore deemed
> +	 * not worth a feature bit.  Set FAILOK per-op flag to make
> +	 * sure older osds don't trip over an unsupported opcode.
> +	 */
> +	op->flags |= CEPH_OSD_OP_FLAG_FAILOK;
> +}
> +EXPORT_SYMBOL(osd_req_op_hint_init);
> +
>  static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
>  				struct ceph_osd_data *osd_data)
>  {
> @@ -681,6 +704,13 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
>  		dst->watch.ver = cpu_to_le64(src->watch.ver);
>  		dst->watch.flag = src->watch.flag;
>  		break;
> +	case CEPH_OSD_OP_SETALLOCHINT:
> +		dst->hint.expected_size = cpu_to_le64(src->hint.expected_size);
> +		dst->hint.expected_write_size =
> +		    cpu_to_le64(src->hint.expected_write_size);
> +		dst->hint.expected_size_probability =
> +		    src->hint.expected_size_probability;
> +		break;
>  	default:
>  		pr_err("unsupported osd opcode %s\n",
>  			ceph_osd_op_name(src->op));
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Wed, 29 Jul 2015 08:34:47 -0500
Message-ID: <55B8D677.8040800@ieee.org>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: mchristi@redhat.com, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 07/29/2015 04:23 AM, mchristi@redhat.com wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
> 
> LIO uses scatterlist for its page/data management. This patch
> adds a scatterlist messenger data type, so LIO can pass its sg
> down directly to rbd.
> 
> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

I'm not going to be able to review all of these, and this
isnt' even a complete review.  But it's something...

You're clearly on the right track, but I want to provide
a meaningful review for correctness and design so I'm
looking for a bit more information.

> ---
>  include/linux/ceph/messenger.h  | 13 ++++++
>  include/linux/ceph/osd_client.h | 12 +++++-
>  net/ceph/messenger.c            | 96 +++++++++++++++++++++++++++++++++++++++++
>  net/ceph/osd_client.c           | 26 +++++++++++
>  4 files changed, 146 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 3775327..bc1bde8 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -79,6 +79,7 @@ enum ceph_msg_data_type {
>  #ifdef CONFIG_BLOCK
>  	CEPH_MSG_DATA_BIO,	/* data source/destination is a bio list */
>  #endif /* CONFIG_BLOCK */
> +	CEPH_MSG_DATA_SG,	/* data source/destination is a scatterlist */
>  };
>  
>  static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
> @@ -90,6 +91,7 @@ static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
>  #ifdef CONFIG_BLOCK
>  	case CEPH_MSG_DATA_BIO:
>  #endif /* CONFIG_BLOCK */
> +	case CEPH_MSG_DATA_SG:
>  		return true;
>  	default:
>  		return false;
> @@ -112,6 +114,11 @@ struct ceph_msg_data {
>  			unsigned int	alignment;	/* first page */
>  		};
>  		struct ceph_pagelist	*pagelist;
> +		struct {
> +			struct scatterlist *sgl;
> +			unsigned int	sgl_init_offset;
> +			u64		sgl_length;
> +		};

Can you supply a short explanation of what these fields
represent?  It seems sgl_init_offset is the offset of the
starting byte in the sgl, but is the purpose of that for
page offset calculation, or does it represent an offset
into the total length of the sgl?  Or put another way,
does sgl_init_offset represent some portion of the
sgl_length that has been consumed already (and so the
initial residual length is sgl_length - sgl_init_offset)?

>  	};
>  };
>  
> @@ -139,6 +146,10 @@ struct ceph_msg_data_cursor {
>  			struct page	*page;		/* page from list */
>  			size_t		offset;		/* bytes from list */
>  		};
> +		struct {
> +			struct scatterlist	*sg;		/* curr sg */

							/* current sg */

> +			unsigned int		sg_consumed;

Here too, what does sg_consumed represent with respect to the
initial offset and the length?

I guess I'm going to stop with that.  It'll be a lot easier
for me to review this if I'm sure I'm sure I understand what
these represent.  Thanks.

					-Alex

> +		};
>  	};
>  };
>  

. . .

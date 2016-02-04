From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Thu, 4 Feb 2016 11:33:48 +0100
Message-ID: <20160204113348.71731879@g21.suse.de>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54126 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362AbcBDKdu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 05:33:50 -0500
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Jul 2015 04:23:38 -0500, mchristi@redhat.com wrote:

> From: Mike Christie <michaelc@cs.wisc.edu>
> 
> LIO uses scatterlist for its page/data management. This patch
> adds a scatterlist messenger data type, so LIO can pass its sg
> down directly to rbd.
> 
> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

...

>  /*
> + * For a sg data item, a piece is whatever remains of the next
> + * entry in the current sg entry, or the first entry in the next
> + * sg in the list.
> + */
> +static void ceph_msg_data_sg_cursor_init(struct ceph_msg_data_cursor *cursor,
> +					 size_t length)
> +{
> +	struct ceph_msg_data *data = cursor->data;
> +	struct scatterlist *sg;
> +
> +	BUG_ON(data->type != CEPH_MSG_DATA_SG);
> +
> +	sg = data->sgl;
> +	BUG_ON(!sg);
> +
> +	cursor->resid = min_t(u64, length, data->sgl_length);
> +	cursor->sg = sg;
> +	cursor->sg_consumed = data->sgl_init_offset;
> +	cursor->last_piece = cursor->resid <= sg->length;
> +}

Just in case the CEPH_MSG_DATA_SG changes are picked up, the
cursor->last_piece calculation here needs to take into account the
data->sgl_init_offset:
	if (cursor->resid <= (sg->length - data->sgl_init_offset))
		cursor->last_piece = true;
	...

Cheers, David

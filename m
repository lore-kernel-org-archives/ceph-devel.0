From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCHv2 5/6] osd_client: add support for notify payloads via
 notify event
Date: Mon, 22 Jun 2015 19:20:56 -0500
Message-ID: <5588A668.5060101@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com> <c486ba353fea150db8bc78b9ad03f07f03882b46.1434550968.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbbFWAU6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Jun 2015 20:20:58 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id E21B03582B3
	for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 00:20:57 +0000 (UTC)
In-Reply-To: <c486ba353fea150db8bc78b9ad03f07f03882b46.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/17/2015 09:25 AM, Douglas Fuller wrote:
>  
> @@ -3055,12 +3151,33 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
>  	struct ceph_osd *osd = con->private;
>  	int type = le16_to_cpu(hdr->type);
>  	int front = le32_to_cpu(hdr->front_len);
> +	struct ceph_msg *m;
> +	size_t len = con->in_hdr.data_len;
>  
>  	*skip = 0;
>  	switch (type) {
>  	case CEPH_MSG_OSD_MAP:
>  	case CEPH_MSG_WATCH_NOTIFY:
> -		return ceph_msg_new(type, front, GFP_NOFS, false);
> +		m = ceph_msg_new(type, front, GFP_NOFS, false);
> +		if (!m)
> +			goto out;
> +
> +		if (len > 0) {
> +			struct page **pages;
> +			struct ceph_osd_data osd_data;
> +			pages = ceph_alloc_page_vector(
> +				      calc_pages_for(0, len), GFP_NOFS);
> +			if (!pages)
> +				goto out2;
> +			osd_data.type = CEPH_OSD_DATA_TYPE_PAGES;

Sorry for the late comment. ceph_alloc_page_vector uses ERR_PTR, so the
above check should be

if (IS_ERR(pages))
	goto out2;
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in

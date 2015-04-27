From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/3] libceph: properly release STAT request's raw_data_in
Date: Mon, 27 Apr 2015 10:21:00 -0500
Message-ID: <553E53DC.1000509@ieee.org>
References: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34841 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317AbbD0PVD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 11:21:03 -0400
Received: by pdbqd1 with SMTP id qd1so131797926pdb.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 08:21:03 -0700 (PDT)
In-Reply-To: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 04/27/2015 03:24 AM, Yan, Zheng wrote:
> Signed-off-by: Yan, Zheng <zyan@redhat.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   net/ceph/osd_client.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 41a4abc..b93531f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -296,6 +296,9 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
>   	case CEPH_OSD_OP_CMPXATTR:
>   		ceph_osd_data_release(&op->xattr.osd_data);
>   		break;
> +	case CEPH_OSD_OP_STAT:
> +		ceph_osd_data_release(&op->raw_data_in);
> +		break;
>   	default:
>   		break;
>   	}
>


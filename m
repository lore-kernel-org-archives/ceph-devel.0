Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1C308F3E;
	Mon,  4 May 2026 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883692; cv=none; b=sHqCxrJW67HaQlCSzG9NWOJrrvxq+EOl8o0npQ8CmUiNZ1cO8kRxD9xs00rRDSRzvFJUvgq9UEBqhYxgewOWuoYYtiUCvwFfR0To91O2EqElTQIOJ0hAXvLC6I21ZTQ+GPFLl6Xoh0DlZwfCRWZZcjMWRCGNcqLmGo9whxlb+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883692; c=relaxed/simple;
	bh=QZ5PWNgIkcuG+F5JvM9vmaynZUVkwNt0KEU7n0q2Lq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/icwjIk6c2uWMmPTkXECXE2Za4GbuIoUtrRSZuWbaY7jOD9RODhQMzcLRpN1TFQA6Ut9NMNYvL2V3eNU9LNyILWdllDkj5exZm+lrFGq9N9YW5vvJPvwe2p/GlJdP2GiDu2lXvKcLtMveNcOtgNJ4Np/2iUJVDYIGCyZUn0QcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=gSeXot4c; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="gSeXot4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1777883681; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=QZ5PWNgIkcuG+F5JvM9vmaynZUVkwNt0KEU7n0q2Lq4=;
 b=gSeXot4cJqcs7jHa/w1yFl6s4X3qCJ0Hg21ILD8Ig/dzkccMaopIS7o+cLP+BHLUeO2b7
 4Eoa5d8e+2y5gRGM8OlCQwILt48wf0hEUty/dVXDqKXkGy0FCA3XWV2iD/n4K9f0I9Dux65
 NEbTajwsOFMsGbkswI5gF9FH8rbzKZKOu5oF1CNuxxG95PxrM0RgZW3lO+VZTl4s9vvjy2W
 KZpRcUxoJ0w3sllW+idItveQR7yncOcPi4DSf5pxdY5ZLg++DQwPoaYIUga/yTJrCVwwflV
 v5HZQgimSNh1XGEUfpiX/LfPSwJFimvRopoxwUWbJoVWd4U7rmxVH8dFi2qQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id AA8AF5FB24;
	Mon,  4 May 2026 10:34:40 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 2FB915FC56;
	Mon,  4 May 2026 10:34:40 +0200 (CEST)
Message-ID: <3fb2610b-5240-41ff-a5d9-699a445dffd3@tu-ilmenau.de>
Date: Mon, 4 May 2026 10:34:39 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libceph: reject monitor replies with oversized data
 segment
To: Dhiraj Mishra <mishra.dhiraj95@gmail.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
 security@kernel.org
References: <20260501193722.25194-1-mishra.dhiraj95@gmail.com>
 <20260502052242.33396-1-mishra.dhiraj95@gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <20260502052242.33396-1-mishra.dhiraj95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.05.26 7:22 AM, Dhiraj Mishra wrote:
> Monitor messages can be allocated from preallocated reply messages or
> with ceph_msg_new(), both of which may provide only front-buffer storage
> and no data items.  The messenger receive path copies the wire header
> into the selected ceph_msg and later uses hdr.data_len to decide whether
> to initialize a data cursor.
> 
> If a malicious or compromised monitor advertises a non-zero data segment
> for one of these front-only replies, the receive path can call
> ceph_msg_data_cursor_init() with length greater than msg->data_length and
> hit its BUG_ON() checks, crashing the client kernel.
> 
> I verified the issue against v7.1-rc1-123-ge75a43c7cec4.  The msgr2
> trigger path is present since commit cd1a677cad99 ("libceph, ceph:
> implement msgr2.1 protocol (crc and secure modes)"), which is contained
> in v5.11-rc1 and later.  The monitor allocator pattern is older, but I
> have not tested older msgr1-only kernels.
> 
> A concrete trigger is a monitor connection over msgr2 after
> CEPH_CON_S_OPEN where a FRAME_TAG_MESSAGE contains a monitor reply type
> handled by mon_alloc_msg(), a valid front_len for that message type and
> data_len = 1.  CEPH_MSG_MON_MAP is one such example: the message is
> allocated with ceph_msg_new(), leaving msg->data_length and
> msg->num_data_items as zero.
> 
> Reject monitor replies whose wire data segment is larger than the data
> backing allocated for the selected ceph_msg, mirroring the existing OSD
> reply hardening.
> 
> Fixes: cd1a677cad99 ("libceph, ceph: implement msgr2.1 protocol (crc and secure modes)")
> Signed-off-by: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
> ---
> v3:
>   - Remove the impossible !req->reply check for generic requests.
>   - Use pr_warn_ratelimited() for malicious-monitor log spam resistance.
>   - Avoid adding __func__ to the new mon_client warnings.
>   - Add a blank line between the front_len and data_len checks.
> 
> v2:
>   - Resend as an inline plain-text patch.
>   - Add full email address to the From and Signed-off-by identities.
>   - Add ceph-devel and LKML to the recipient list when sending.
> 
>  net/ceph/mon_client.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index d2cdc8ee3155..9f1c7ca42f36 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -712,6 +712,7 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
>  	struct ceph_mon_client *monc = con->private;
>  	struct ceph_mon_generic_request *req;
>  	u64 tid = le64_to_cpu(hdr->tid);
> +	u32 data_len = le32_to_cpu(hdr->data_len);
>  	struct ceph_msg *m;
>  
>  	mutex_lock(&monc->mutex);
> @@ -720,6 +721,11 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
>  		dout("get_generic_reply %lld dne\n", tid);
>  		*skip = 1;
>  		m = NULL;
> +	} else if (data_len > req->reply->data_length) {
> +		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
> +				    tid, data_len, req->reply->data_length);
> +		*skip = 1;
> +		m = NULL;
>  	} else {
>  		dout("get_generic_reply %lld got %p\n", tid, req->reply);
>  		*skip = 0;
> @@ -1499,6 +1505,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
>  	struct ceph_mon_client *monc = con->private;
>  	int type = le16_to_cpu(hdr->type);
>  	int front_len = le32_to_cpu(hdr->front_len);
> +	u32 data_len = le32_to_cpu(hdr->data_len);
>  	struct ceph_msg *m = NULL;
>  
>  	*skip = 0;
> @@ -1545,5 +1552,15 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
>  		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
>  	}
>  
> +	if (m && data_len > m->data_length) {
> +		pr_warn_ratelimited("mon message data %u > prealloc %zu (%u#%llu), skipping\n",
> +				    data_len, m->data_length,
> +				    (unsigned int)con->peer_name.type,
> +				    le64_to_cpu(con->peer_name.num));
> +		ceph_msg_put(m);
> +		m = NULL;
> +		*skip = 1;
> +	}
> +
>  	return m;
>  }

Hi Dhiraj,
as far as I can see, the same issue can also occur on MDS connections
here:
https://elixir.bootlin.com/linux/v7.0.1/source/fs/ceph/mds_client.c#L6477
I guess a similar check should also be added there. Maybe this can be
done in one patch.

Best regards,
Raphael

From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH 2/3] libceph: fix overflow in osdmap_decode()
Date: Wed, 6 Jun 2012 13:56:04 -0400
Message-ID: <16A6B85A-9BD1-4242-95CD-5ACFC43956F4@gmail.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <1335682765-1643-2-git-send-email-xi.wang@gmail.com> <4FCF84A4.4040005@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62691 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab2FFR4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 13:56:09 -0400
Received: by yenm10 with SMTP id m10so5238345yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 10:56:09 -0700 (PDT)
In-Reply-To: <4FCF84A4.4040005@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Jun 6, 2012, at 12:26 PM, Alex Elder wrote:
> 
> Just above here we see:
>        /* pg_temp */
>        ceph_decode_32_safe(p, end, len, bad);
>        for (i = 0; i < len; i++) {
> 
> We haven't validated "len" here either.  Looking at it I'm not sure
> we can do much, but I think we do know a few things should be true:
> - (len & (sizeof (u32) - 1)) == 0
> - len <= (UINT_MAX / (sizeof (struct ceph_pg) + sizeof (u32)))
>    and further, if it's invalid to have a value for pg->len of
>    zero, then we can instead assert:
> - len <= (UINT_MAX / (sizeof (struct ceph_pg) + 2 * sizeof (u32)))
> 
> I don't know if it's that important do do a check like this though.

I don't see any overflow issue here.  Are you worried about the loop
running for a while given a large n?  How about this check?

	/* pg_temp */
	ceph_decode_32_safe(p, end, len, bad);
+	if (len > UINT_MAX / (sizeof(u32) + sizeof(u64)))
+		goto bad;
+	ceph_decode_need(p, end, len * (sizeof(u32) + sizeof(u64)), bad);

- xi

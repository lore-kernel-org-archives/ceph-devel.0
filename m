From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/5] libceph: isolate message page field manipulation
Date: Tue, 05 Mar 2013 10:03:24 -0600
Message-ID: <5136174C.5000306@inktank.com>
References: <5135F859.1090606@inktank.com> <5135F8A9.2080506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:37361 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab3CEQD2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 11:03:28 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so2708123obb.39
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 08:03:28 -0800 (PST)
In-Reply-To: <5135F8A9.2080506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 03/05/2013 07:52 AM, Alex Elder wrote:
> +void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
> +		unsigned int page_count, size_t alignment)
> +{
> +	/* BUG_ON(!pages); */
> +	/* BUG_ON(!page_count); */
> +	/* BUG_ON(msg->pages); */
> +	/* BUG_ON(msg->page_count); */
> +
> +	msg->pages = pages;
> +	msg->page_count = page_count;
> +	msg->page_alignment = alignment & PAGE_SIZE;

Whoops, this is supposed to be:
	msg->page_alignment = alignment & ~PAGE_MASK;

I think it works despite the bug, it just isn't very
good for performance on the other end...

I will fix this before I commit anything (and after
review).

					-Alex

> +}
> +EXPORT_SYMBOL(ceph_msg_data_set_pages);


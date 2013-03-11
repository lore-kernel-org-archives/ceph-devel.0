From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/6] libceph: refactor messenger for multiple data sources
Date: Mon, 11 Mar 2013 14:01:49 -0700
Message-ID: <513E463D.3040008@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:53352 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab3CKVCb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 17:02:31 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so981837dak.11
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 14:02:30 -0700 (PDT)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/09/2013 08:41 AM, Alex Elder wrote:
> This series factors out blocks of common code and generally
> aims to simplify and make more consistent the way the ceph
> messenger processes the data portions of both incoming and
> outgoing messages.
>
> They can be found in the "review/wip-msgr-refactor" branch of
> the ceph-client git repository.  (That branch is based on
> branch "review/wip-abstract-2").
>
> 					-Alex
>
> [PATCH 1/6] libceph: use local variables for message positions
> [PATCH 2/6] libceph: consolidate message prep code
> [PATCH 3/6] libceph: small write_partial_msg_pages() refactor
> [PATCH 4/6] libceph: encapsulate reading message data
> [PATCH 5/6] libceph: define and use ceph_tcp_recvpage()
> [PATCH 6/6] libceph: define and use ceph_crc32c_page()

These all look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


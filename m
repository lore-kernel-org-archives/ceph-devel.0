From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/9]
Date: Thu, 04 Apr 2013 20:03:08 -0700
Message-ID: <515E3EEC.5040604@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:37829 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161109Ab3DEDCe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 23:02:34 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so1406169dak.30
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 20:02:33 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/04/2013 09:16 AM, Alex Elder wrote:
> (The following patches are available in branch "review/wip-3761"
> on the ceph-client git respository.)
>
> These are actually a few sets of patches but I'm just going to
> post them as a single series this time.
>
> 					-Alex
>
> [PATCH 1/9] ceph: use page_offset() in ceph_writepages_start()
>      Fixes a potential bug in ceph_writepages_start().
>
> [PATCH 2/9] libceph: drop ceph_osd_request->r_con_filling_msg
>      Removes a no-longer-needed field, to simplify code.
>
> [PATCH 3/9] libceph: record length of bio list with bio
> [PATCH 4/9] libceph: record message data length
>      Has each message maintain its data length, so we can
>      avoid depending on what's in the message's header.
>
> [PATCH 5/9] libceph: don't build request in ceph_osdc_new_request()
> [PATCH 6/9] ceph: define ceph_writepages_osd_request()
> [PATCH 7/9] ceph: kill ceph alloc_page_vec()
> [PATCH 8/9] libceph: hold off building osd request
> [PATCH 9/9] ceph: build osd request message later for writepages
>      Defers "building" a request message until right before
>      it's submitted to the osd client to start its execution.
>      Also stops having the length field in a message header
>      get updated by the file system code.

These all look good. The one thing I'm uncertain about is changing
the mempool allocation failure from a WARN to a BUG, but it seems
there's no good way to recover at that point.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


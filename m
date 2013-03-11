From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/8] libceph: miscellaneous cleanups
Date: Mon, 11 Mar 2013 11:57:52 -0700
Message-ID: <513E2930.1010708@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:62698 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab3CKS6d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 14:58:33 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so4051060pbc.7
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 11:58:33 -0700 (PDT)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/09/2013 07:11 AM, Alex Elder wrote:
> This series contains a bunch of small cleanups.  All of
> them I've created while working on other things, and most
> of them were done in order to allow upcoming work to be
> easier, or easier to understand.  I've moved them all to
> the front of my stack of patches and now I'm posting them
> as a set for review.  They apply on top of the ceph-client
> "testing" branch as of a couple of days ago:
>      2f60d302  libceph: fix decoding of pgids
>
> 					-Alex
>
> [PATCH 1/8] libceph: define CEPH_MSG_MAX_MIDDLE_LEN
> [PATCH 2/8] libceph: minor byte order problems in
> [PATCH 3/8] libceph: change type of ceph_tcp_sendpage() "more"
> [PATCH 4/8] libceph: kill args in read_partial_message_bio()
> [PATCH 5/8] libceph: define and use in_msg_pos_next()
> [PATCH 6/8] libceph: advance pagelist with list_rotate_left()
> [PATCH 7/8] libceph: simplify new message initialization
> [PATCH 8/8] libceph: record byte count not page count

These look good except for 5/8.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

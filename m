From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] libceph: get rid of ceph_msg_pos
Date: Thu, 14 Mar 2013 12:54:28 -0700
Message-ID: <51422AF4.5080707@inktank.com>
References: <513FD178.60207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:35129 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3CNTzN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:55:13 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so2713063pbc.39
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 12:55:12 -0700 (PDT)
In-Reply-To: <513FD178.60207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/12/2013 06:08 PM, Alex Elder wrote:
> Previously a ceph_msg_pos structure contained information
> for iterating through the data in a message.  Now we use
> information in a data item's cursor for that purpose.
> This series completes the switchover to use of the cursor
> and then eliminates that definition of ceph_msg_pos and
> the functions that support it.
>
> 					-Alex
>
> [PATCH 1/4] libceph: use cursor resid for loop condition
> [PATCH 2/4] libceph: kill most of ceph_msg_pos
> [PATCH 3/4] libceph: kill last of ceph_msg_pos
> [PATCH 4/4] libceph: use only ceph_msg_data_advance()

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


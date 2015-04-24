From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 0/3] rbd: header read/refresh improvements
Date: Fri, 24 Apr 2015 08:11:54 -0500
Message-ID: <553A411A.8060902@ieee.org>
References: <cover.1429814290.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36842 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbDXNL5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 09:11:57 -0400
Received: by pdea3 with SMTP id a3so48575314pde.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2015 06:11:56 -0700 (PDT)
In-Reply-To: <cover.1429814290.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 04/23/2015 02:06 PM, Douglas Fuller wrote:
> Support multiple class op calls in one ceph_msg and consolidate rbd header
> read and refresh processes to use this feature to reduce the number of
> ceph_msgs sent for that process. Refresh features on header refresh and
> begin returning EIO if features have changed since mapping.
>
> Douglas Fuller (3):
>    ceph: support multiple class method calls in one ceph_msg
>    rbd: combine object method calls in header refresh using fewer
>      ceph_msgs
>    rbd: re-read features during header refresh and detect changes.
>
>   drivers/block/rbd.c             | 518 +++++++++++++++++++++++++++++-----------
>   include/linux/ceph/osd_client.h |   3 +-
>   net/ceph/messenger.c            |   4 +
>   net/ceph/osd_client.c           |  92 ++++++-
>   4 files changed, 470 insertions(+), 147 deletions(-)
>

In case Ilya or others don't get to it soon, I plan to review this
series tomorrow.

					-Alex

From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: [PATCH v2 21/24] libceph: Replace CURRENT_TIME with
 ktime_get_real_ts
Date: Mon, 20 Jun 2016 10:33:37 +0200
Message-ID: <936f4df1-dfb9-1906-019e-8f82b8e950eb@digiware.nl>
References: <1466382443-11063-1-git-send-email-deepa.kernel@gmail.com>
 <1466382443-11063-22-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.ip-176-74-240-009.signet.nl ([176.74.240.9]:49463 "EHLO
	smtp.digiware.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcFTIeD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 04:34:03 -0400
In-Reply-To: <1466382443-11063-22-git-send-email-deepa.kernel@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 20-6-2016 02:27, Deepa Dinamani wrote:
> CURRENT_TIME is not y2038 safe.
> The macro will be deleted and all the references to it
> will be replaced by ktime_get_* apis.
> 
> struct timespec is also not y2038 safe.
> Retain timespec for timestamp representation here as ceph
> uses it internally everywhere.
> These references will be changed to use struct timespec64
> in a separate patch.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: "Yan, Zheng" <zyan@redhat.com>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> ---
>  net/ceph/messenger.c  | 6 ++++--
>  net/ceph/osd_client.c | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Hi Deepa,

Although I applaud 64-bit timestamps,
the ktime_get_* api seems to be a Linux only API.

So IF ever things need to be the least bit portable, I suggest wrapping
these routines into a class of itself. So that porting confines itself
to only that class. (plus/minus hairy semantic details)

For what is now committed the change is not really that big.

On the other hand, I 'll have to start figuring out if FreeBSD really
does do 64bit timestamps...

So I would welcome a more elaborate description of the problem (it seems
that Linux is going 64bit in its inodes??) and what is being fixed and
how. So that in the porting case not only the code will be the source to
figure out what is going on.

Thanx,
--WjW



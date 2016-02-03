From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/5] libceph: crush tunables5
Date: Wed, 3 Feb 2016 09:28:31 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602030928180.28963@cpach.fuggernut.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55989 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcBCO2Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:28:16 -0500
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 3 Feb 2016, Ilya Dryomov wrote:
> Hello,
> 
> This series adds support for the new chooseleaf_stable CRUSH tunable
> and enables TUNABLES5 feature bit.  It's likely that TUNABLES5 bit will
> be shared and cover request_redirect_t encoding in MOSDOpReply and
> possibly new file layouts but those aren't in master yet.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (5):
>   crush: ensure bucket id is valid before indexing buckets array
>   crush: ensure take bucket value is valid
>   crush: add chooseleaf_stable tunable
>   crush: decode and initialize chooseleaf_stable
>   libceph: advertise support for TUNABLES5
> 
>  include/linux/ceph/ceph_features.h | 13 ++++++++++++-
>  include/linux/crush/crush.h        |  8 +++++++-
>  net/ceph/crush/mapper.c            | 33 ++++++++++++++++++++++++++-------
>  net/ceph/osdmap.c                  | 19 ++++++++++++++-----
>  4 files changed, 59 insertions(+), 14 deletions(-)

Whole series 

Reviewed-by: Sage Weil <sage@redhat.com>

Thanks!
sage


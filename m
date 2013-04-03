From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] libceph: use op formatter for ceph_osdc_new_request()
Date: Wed, 03 Apr 2013 11:48:45 -0700
Message-ID: <515C798D.5020207@inktank.com>
References: <5156080E.9040603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:37193 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760424Ab3DCStE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 14:49:04 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so1050227pab.18
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 11:49:03 -0700 (PDT)
In-Reply-To: <5156080E.9040603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/29/2013 02:30 PM, Alex Elder wrote:
> The only place outside rbd that allocates an osd request
> and then initializes the array of osd ops inside it is
> ceph_osdc_new_request().  This series rearranges a little
> code so that the new op formatting functions (osd_req_op_init()
> and osd_req_op_extent_init()) can be used there.
>
> 					-Alex
>
> [PATCH 1/4] libceph: pass offset and length out of calc_layout()
> [PATCH 2/4] libceph: don't update op in calc_layout()
> [PATCH 3/4] libceph: clean up ceph_osd_new_request()
> [PATCH 4/4] libceph: use osd_req_op_extent_init()

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

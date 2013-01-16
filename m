From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/6] libceph: parameter cleanup
Date: Wed, 16 Jan 2013 15:12:23 -0800
Message-ID: <50F733D7.7030407@inktank.com>
References: <50E6E7C2.2020604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34869 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab3APXMb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 18:12:31 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1068179pad.32
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 15:12:30 -0800 (PST)
In-Reply-To: <50E6E7C2.2020604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 06:31 AM, Alex Elder wrote:
> This series mostly cleans up parameters used by functions
> in libceph, in the osd client code.
>
> 					-Alex
>
> [PATCH REPOST 1/6] libceph: pass length to ceph_osdc_build_request()
> [PATCH REPOST 2/6] libceph: pass length to ceph_calc_file_object_mapping()
> [PATCH REPOST 3/6] libceph: drop snapid in ceph_calc_raw_layout()
> [PATCH REPOST 4/6] libceph: drop osdc from ceph_calc_raw_layout()
> [PATCH REPOST 5/6] libceph: don't set flags in ceph_osdc_alloc_request()
> [PATCH REPOST 6/6] libceph: don't set pages or bio in
> ceph_osdc_alloc_request()

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


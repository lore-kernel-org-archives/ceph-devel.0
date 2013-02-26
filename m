From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] libceph: focus calc_layout() on filling in the osd
 op
Date: Tue, 26 Feb 2013 10:20:45 -0800
Message-ID: <512CFCFD.7070900@inktank.com>
References: <512BEF26.3030207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:53635 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab3BZSVH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 13:21:07 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so2604263pad.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 10:21:07 -0800 (PST)
In-Reply-To: <512BEF26.3030207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/25/2013 03:09 PM, Alex Elder wrote:
> This series refactors the code involved with identifying the
> details of the name, offset, and length of an object involved
> with an osd request based on a file layout.  It makes the focus
> of calc_layout() be filling in an osd op structure based on the
> file layout it is provided.  The caller (ceph_osdc_new_request())
> is then responsible for filling in fields related to the request,
> such as the name of the target object.
>
> 					-Alex
>
> [PATCH 1/3] libceph: pass object number back to calc_layout() caller
> [PATCH 2/3] libceph: format target object name in caller
> [PATCH 3/3] libceph: don't pass request to calc_layout()

These all look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


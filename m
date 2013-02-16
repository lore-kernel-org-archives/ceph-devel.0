From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] libceph: update osd_req_encode_op()
Date: Sat, 16 Feb 2013 15:56:36 -0800
Message-ID: <51201CB4.7000303@inktank.com>
References: <511FBB12.6050207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:61828 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab3BPX4j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 18:56:39 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so1949487dak.30
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 15:56:39 -0800 (PST)
In-Reply-To: <511FBB12.6050207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/16/2013 09:00 AM, Alex Elder wrote:
> This series just modifies osd_req_encode_op so it is
> more informative, distinguishing between defined but
> not supported opcodes and garbage opcodes.
>
> 					-Alex
>
> [PATCH 1/2] libceph: report defined but unsupported osd ops
> [PATCH 2/2] libceph: remove dead code in osd_req_encode_op()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


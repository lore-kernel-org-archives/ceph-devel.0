From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] rbd: fix integer overflow in rbd_header_from_disk()
Date: Wed, 18 Apr 2012 19:59:58 -0400
Message-ID: <4373FB99-15E4-4464-B2F2-73EC7C7C857D@gmail.com>
References: <1334008335-8377-1-git-send-email-xi.wang@gmail.com> <4F8ECDFA.70209@dreamhost.com> <30227880-FACB-4180-B129-7B5D407094E5@gmail.com> <4F8F0C35.8090903@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57495 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab2DSAAD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 20:00:03 -0400
Received: by iagz16 with SMTP id z16so11104329iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 17:00:02 -0700 (PDT)
In-Reply-To: <4F8F0C35.8090903@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>, Sage Weil <sage@newdream.net>

On Apr 18, 2012, at 2:47 PM, Alex Elder wrote:

> It may not matter in practice, but I prefer to be very
> careful.  As long as you're going out of your way to
> avoid overflow might as well make sure it works on all
> architectures in the process.

I agree.  Probably a cleaner way is to define SIZE_MAX
or use KMALLOC_MAX_SIZE.

- xi

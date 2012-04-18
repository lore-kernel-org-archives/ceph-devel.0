From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] rbd: fix integer overflow in rbd_header_from_disk()
Date: Wed, 18 Apr 2012 14:09:35 -0400
Message-ID: <30227880-FACB-4180-B129-7B5D407094E5@gmail.com>
References: <1334008335-8377-1-git-send-email-xi.wang@gmail.com> <4F8ECDFA.70209@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43130 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2DRSJj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 14:09:39 -0400
Received: by yenl12 with SMTP id l12so3872201yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 11:09:39 -0700 (PDT)
In-Reply-To: <4F8ECDFA.70209@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>, Sage Weil <sage@newdream.net>

On Apr 18, 2012, at 10:21 AM, Alex Elder wrote:
> 
> This looks good, however I have changed it to use UINT_MAX
> rather than ULONG_MAX, because on some architectures size_t
> (__kernel_size_t) is defined as type (unsigned int).  It
> is the more conservative value, and even on architectures
> where __BITS_PER_LONG is 64, it still offers a sane upper
> bound on the number of snapshots for a rbd device.

Looks good to me.

BTW, on which arch is size_t 32-bit while long is 64?
Several commits still use ULONG_MAX, such as

http://git.kernel.org/linus/64486697

- xi

From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH RESEND] ceph: avoid panic with mismatched symlink sizes in fill_inode()
Date: Fri, 3 Feb 2012 15:49:07 -0500
Message-ID: <972F971B-171E-467D-8E64-C1C49CB94622@gmail.com>
References: <1328280936-2688-1-git-send-email-xi.wang@gmail.com> <1328300672.21405.90.camel@doink>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43952 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab2BCUtM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 15:49:12 -0500
In-Reply-To: <1328300672.21405.90.camel@doink>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@dreamhost.com
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 3, 2012, at 3:24 PM, Alex Elder wrote:
> Looks good, though it might good to at least call
> WARN_ON().  What do you think?

Sounds good to me.  I will send a v2.  Thanks.

- xi

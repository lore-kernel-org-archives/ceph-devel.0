From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 2/3] ceph: fix bounds check macros ceph_decode_need and
 ceph_encode_need
Date: Wed, 18 Apr 2012 13:41:23 -0500
Message-ID: <4F8F0AD3.2030403@dreamhost.com>
References: <1323894273-13904-1-git-send-email-xi.wang@gmail.com> <1323894273-13904-3-git-send-email-xi.wang@gmail.com> <4F8ECBF7.7060509@dreamhost.com> <Pine.LNX.4.64.1204181052530.15730@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41194 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2DRSlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 14:41:25 -0400
In-Reply-To: <Pine.LNX.4.64.1204181052530.15730@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Xi Wang <xi.wang@gmail.com>, ceph-devel@vger.kernel.org

On 04/18/2012 12:53 PM, Sage Weil wrote:
> Would something like ceph_has_room() make more sense?

Yes, and standing by itself it reads a lot better too.

The "need_ok" came from the fact that it was only ever
called by ceph_need_*() macros.

Without objection I'll change it to ceph_has_room()
before I commit it for testing.

					-Alex

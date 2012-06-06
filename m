From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH 2/3] libceph: fix overflow in osdmap_decode()
Date: Wed, 6 Jun 2012 15:20:04 -0400
Message-ID: <2F8FF9AC-D5D0-403B-91C9-99B7E4A88BA6@gmail.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <1335682765-1643-2-git-send-email-xi.wang@gmail.com> <4FCF84A4.4040005@dreamhost.com> <16A6B85A-9BD1-4242-95CD-5ACFC43956F4@gmail.com> <4FCFAC33.6020003@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64030 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab2FFTUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 15:20:11 -0400
Received: by yhmm54 with SMTP id m54so5195982yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 12:20:10 -0700 (PDT)
In-Reply-To: <4FCFAC33.6020003@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Jun 6, 2012, at 3:14 PM, Alex Elder wrote:
> It probably won't matter because in time if the value is too large
> then one of the checks inside the loop might bail out.  But catching
> it as early as possible is always better.

Yeah I Agree. :-)

- xi

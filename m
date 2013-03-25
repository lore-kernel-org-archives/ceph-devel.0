From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/6] libceph: wrap auth methods in a mutex
Date: Mon, 25 Mar 2013 11:49:55 -0500
Message-ID: <51508033.3010009@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com> <1363734486-26879-5-git-send-email-sage@inktank.com> <51506006.50403@inktank.com> <alpine.DEB.2.00.1303250925530.12444@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:37549 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab3CYQtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 12:49:53 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so7362513iee.39
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 09:49:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303250925530.12444@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/25/2013 11:26 AM, Sage Weil wrote:
>> > And ceph_auth_is_authenticated() here...
> These *are* the wrappers :)

D'oh!

Good thing I quit commenting on those then.


From: John Spray <john.spray@inktank.com>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Mon, 3 Mar 2014 22:53:31 +0000
Message-ID: <CAGd4Wr38czZ5REXmFaeniR8Umr9z-UN8sMrfMawh4ZF0pR_NhA@mail.gmail.com>
References: <alpine.DEB.2.00.1403031423270.17314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64285 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaCCWxc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 17:53:32 -0500
Received: by mail-pb0-f46.google.com with SMTP id rq2so4331008pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 14:53:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1403031423270.17314@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 3, 2014 at 10:23 PM, Sage Weil <sage@inktank.com> wrote:
> ** CID 1188299:  Data race condition  (MISSING_LOCK)
> /mds/MDSUtility.cc: 142 in MDSUtility::handle_mds_map(MMDSMap *)()

Is there a trick to getting coverity to realise that the lock is held,
but by the calling function?  Does it recognise assertions that the
lock is held?

Cheers,
John

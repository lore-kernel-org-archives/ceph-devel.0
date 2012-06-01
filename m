From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 07/13] libceph: embed ceph connection structure in mon_client
Date: Fri, 01 Jun 2012 11:32:58 -0500
Message-ID: <4FC8EEBA.5050402@inktank.com>
References: <4FC673FC.3060004@inktank.com> <4FC67662.2060005@inktank.com> <Pine.LNX.4.64.1205312108540.2166@cobra.newdream.net> <4FC8B19D.2080204@inktank.com> <4FC8C410.3080703@inktank.com> <Pine.LNX.4.64.1206010918020.9007@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63087 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965419Ab2FAQdB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 12:33:01 -0400
Received: by gglu4 with SMTP id u4so1907850ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 09:33:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206010918020.9007@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/01/2012 11:20 AM, Sage Weil wrote:
> The problem is that socket events queue work, which can take a while, and
> race with, say, osd_client getting an osdmap and dropping it's
> struct ceph_osd.  The ->get and ->put ops just twiddle the containing
> struct's refcount, in that case, so the con_work will find the (now
> closed) ceph_connection and do nothing...

I think you're saying that the connection (or its socket) needs to
be protected from its containing structure going away.  So the
connection needs to hold a reference to its container.  If that's
the case then the disposal of the ceph_osd needs to clean up
the connection fully before it goes away.

Anyway, I think I see why there might be a need for the ref counts
and they obviously won't go away if they're needed...

					-Alex

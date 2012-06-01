From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 07/13] libceph: embed ceph connection structure in mon_client
Date: Fri, 01 Jun 2012 12:09:11 -0500
Message-ID: <4FC8F737.7080905@inktank.com>
References: <4FC673FC.3060004@inktank.com> <4FC67662.2060005@inktank.com> <Pine.LNX.4.64.1205312108540.2166@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:35583 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759269Ab2FARJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 13:09:13 -0400
Received: by gglu4 with SMTP id u4so1943624ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 10:09:12 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205312108540.2166@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/31/2012 11:24 PM, Sage Weil wrote:
> Also: when poking around, I noticed that ceph_con_get() and put() are
> called directly from osd_client.c... that's a bug!  Those connections have
> a get and put op defined that twiddles the containing ceph_osd struct's
> ref count.

So are you saying that the calls in "osd_client.c" to ceph_con_get()
and ceph_con_put() should instead be calls to get_osd_con() and
put_osd_con(), respectively?  (Or more generally con->ops->get()
and con->ops->put()?)

					-Alex

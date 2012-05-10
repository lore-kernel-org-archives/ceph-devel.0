From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] ceph: messenger: read_partial() cleanups
Date: Thu, 10 May 2012 17:56:25 -0500
Message-ID: <4FAC4799.3010903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50950 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab2EJW42 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:56:28 -0400
Received: by yhmm54 with SMTP id m54so2040327yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 15:56:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This short series adds the use of read_partial() in a few places
that it is not already.  It also gets rid of the in/out "to"
argument (which continues to cause confusion every time I see it),
using an in-only "end" argument in its place.

					-Alex

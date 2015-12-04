From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: cmake
Date: Fri, 4 Dec 2015 01:59:42 -0700
Message-ID: <20151204015942.19951132@lembas.zaitcev.lan>
References: <20151203152436.73e15e38@lembas.zaitcev.lan>
	<20151203223020.GB17144@ultraspiritum.redhat.com>
	<20151203170347.33867061@lembas.zaitcev.lan>
	<295720458.28620860.1449188812348.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbbLDI7n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 03:59:43 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 6E1188E50E
	for <ceph-devel@vger.kernel.org>; Fri,  4 Dec 2015 08:59:43 +0000 (UTC)
In-Reply-To: <295720458.28620860.1449188812348.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, ceph-devel@vger.kernel.org

On Thu, 3 Dec 2015 19:26:52 -0500 (EST)
Matt Benjamin <mbenjamin@redhat.com> wrote:

> Could you share the branch you are trying to build?  (ceph/wip-5073 would not appear to be it.)

It's the trunk with a few of my insignificant cleanups.

But I found a fix: deleting the CMakeFiles/ and CMakeCache.txt let
it run. Thanks again for the tip about the separate build directory.

-- Pete

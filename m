From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] librados: Add RADOS locks to the C/C++ API
Date: Fri, 31 May 2013 12:44:54 -0700
Message-ID: <51A8FDB6.3020908@inktank.com>
References: <1369918922-867-1-git-send-email-philipgian@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57827 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757145Ab3EaTpA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 15:45:00 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so2681494pde.23
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 12:44:59 -0700 (PDT)
In-Reply-To: <1369918922-867-1-git-send-email-philipgian@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 05/30/2013 06:02 AM, Filippos Giannakos wrote:
> The following patches export the RADOS advisory locks functionality to the C/C++
> librados API. The extra API calls added are inspired by the relevant functions
> of librbd.

This looks good to me overall. I wonder if we should create a new
library in the future for these kinds of things that are built on top
of librados. Other generally useful class client operations could go
there, as well as generally useful things built on top of librados,
like methods for striping over many objects.

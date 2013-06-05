From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2 v2] librados: Add RADOS locks to the C/C++ API
Date: Wed, 05 Jun 2013 13:40:35 -0700
Message-ID: <51AFA243.9060609@inktank.com>
References: <1370339528-26872-1-git-send-email-philipgian@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35078 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab3FEUks (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jun 2013 16:40:48 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2353160pde.32
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jun 2013 13:40:47 -0700 (PDT)
In-Reply-To: <1370339528-26872-1-git-send-email-philipgian@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 06/04/2013 02:52 AM, Filippos Giannakos wrote:
> Hi team,
>
> This set of patches export the RADOS advisory locking functionality to the C/C++
> API.
> They have been refactored to incorporate Josh suggestions from his review:
>   * Always set tag to "" for exclusive lock
>   * Add duration argument to lock_{exclusive, shared}
>   * Add lock flags to librados.h
>   * Return -EINVAL on client parsing error
>   * Remove unneeded std::string convertions
>   * Typos/style fixes
>
> Kind Regards,
> Filippos
>
> Filippos Giannakos (2):
>    Add RADOS lock mechanism to the librados C/C++ API.
>    Add RADOS API lock tests
>
>   src/Makefile.am                |   11 +-
>   src/include/rados/librados.h   |  102 +++++++++++++-
>   src/include/rados/librados.hpp |   29 ++++
>   src/librados/librados.cc       |  180 ++++++++++++++++++++++++
>   src/test/librados/lock.cc      |  301 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 621 insertions(+), 2 deletions(-)
>   create mode 100644 src/test/librados/lock.cc
>

Applied, thanks!

Josh

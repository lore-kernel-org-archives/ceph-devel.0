From: Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v3 1/4] buffer: add an aligned buffer with less alignment
 than a page
Date: Thu, 2 Oct 2014 14:12:12 +0200
Message-ID: <20141002121212.GN2542@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
 <1411994072-18850-2-git-send-email-j@jannau.net>
 <54295E26.4080705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:38157 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbaJBMMN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 08:12:13 -0400
Content-Disposition: inline
In-Reply-To: <54295E26.4080705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hi,

On 2014-09-29 15:27:02 +0200, Loic Dachary wrote:
> 
> I think the implementation of the bufferlist n_align_sized functions is missing. That showed when adding unit tests for them

yes, I didn't saw the need for it.

> https://github.com/dachary/ceph/commit/fd01824f1681edd0ec029b02318b6c40b923c156
> 
> Feel free to pick up where I left, I won't work on them any more today ;-)

Did you continue to work on them? If not I'll start from there now.

Janne



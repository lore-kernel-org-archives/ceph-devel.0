From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: hammer mon failure
Date: Thu, 7 Jan 2016 19:33:55 +0000
Message-ID: <568EBDA3.50604@suse.de>
References: <CAN=+7FVaMHKft1F1qcAw_s9oDTBWMAPj4LJRWYLpBcTz6MrquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53377 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbcAGTd5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jan 2016 14:33:57 -0500
In-Reply-To: <CAN=+7FVaMHKft1F1qcAw_s9oDTBWMAPj4LJRWYLpBcTz6MrquA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>

On 01/05/2016 07:55 PM, Samuel Just wrote:
> http://tracker.ceph.com/issues/14236
> 
> New hammer mon failure in the nightlies (missing a map apparently?),
> can you take a look?
> -Sam

This is a regression introduced by

171fee1b82d2675e364da7f96dfb9dd286d9b6e6

to the best of my knowledge, it only affects the yet-to-be-released
hammer version.

I've got a fix for this in https://github.com/ceph/ceph/pull/7150

Still needs testing and review, but looks a solid one to me.

Kefu, would you mind taking a look?

  -Joao


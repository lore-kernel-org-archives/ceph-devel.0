From: Daniel Poelzleithner <poelzleithner@b1-systems.de>
Subject: Re: [PATCH] Fix for corrupted ceph cluster
Date: Thu, 06 Mar 2014 00:03:52 +0100
Message-ID: <5317AD58.1060705@b1-systems.de>
References: <52F9C7A1.3060705@b1-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.b1-systems.de ([84.200.69.220]:60593 "EHLO
	mx1.b1-systems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaCEXDz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Mar 2014 18:03:55 -0500
Received: from [192.168.93.240] (146-52-17-92-dynip.superkabel.de [146.52.17.92])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 19809B8DFB
	for <ceph-devel@vger.kernel.org>; Thu,  6 Mar 2014 00:03:53 +0100 (CET)
In-Reply-To: <52F9C7A1.3060705@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 02/11/2014 07:48 AM, Daniel Poelzleithner wrote:

> I wrote a small patch that ignores object_trim requests when he does not
> find the context of this request.
> We have a node that fails to start permanently and there is no way to
> get all nodes back up.
[...]
> This is regarding bug http://tracker.ceph.com/issues/6101

The patch now ran for 2 weeks and the 4th node is working again.
I think this patch is safe to apply, but not fixing the underlying problem.
Some state in ceph causes the delete event to be triggered every some
seconds and causes a log entry to be generated.

Do you need more informations to find the cause ? This definitely is
some wired internal state and is no race condition.


kind regards
 Daniel

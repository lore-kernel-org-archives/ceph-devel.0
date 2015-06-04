From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: preparing v0.80.11
Date: Thu, 04 Jun 2015 14:53:47 +0200
Message-ID: <55704A5B.4040302@suse.cz>
References: <5562DEEC.5060602@dachary.org> <5564D772.9080909@suse.cz> <556F45C9.7080003@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39394 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbbFDMxu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Jun 2015 08:53:50 -0400
In-Reply-To: <556F45C9.7080003@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> Could I also ask for this one to be backported?
>
> https://github.com/ceph/ceph/pull/4844
>
> It breaks a couple of setups I know of. It's not in master yet, but it's
> a very trivial fix.

Hi Wido:

firefly backport: https://github.com/ceph/ceph/pull/4861
hammer backport: https://github.com/ceph/ceph/pull/4862

Please take a look.

Nathan

From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: dealing with conflicting pull requests
Date: Thu, 09 Jul 2015 12:55:50 +0200
Message-ID: <559E5336.6040704@suse.cz>
References: <559E4F52.9070007@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38452 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbGIKzw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jul 2015 06:55:52 -0400
In-Reply-To: <559E4F52.9070007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "Shu, Xinxin" <xinxin.shu@intel.com>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> For the first time we have a few conflicting pull requests that prevent merging all in the integration branch.
...

> I think the simplest way to deal with that is to arbitrarily pick a few that apply cleanly and just DNM the others so they wait for the next round of integration testing. After the first round of integration test, the chosen one will be merged and the DNM will have to be rebased to resolve the conflict, but that's what we do routinely.
>
> What do you think ?

I think your suggestion is reasonable and I can't think of any better 
way to proceed, so +1 !

Nathan


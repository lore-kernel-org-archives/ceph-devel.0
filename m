From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Proposal for a Backport tracker
Date: Thu, 21 May 2015 14:41:41 +0200
Message-ID: <555DD285.3050204@suse.cz>
References: <555DC080.8050508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44528 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbbEUMln (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 May 2015 08:41:43 -0400
In-Reply-To: <555DC080.8050508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

> * a backport issue is created in the "Backport" tracker and is 
> "Related" to the original issue

Hi Loic:

I like the idea of having backport tickets in a separate Redmine
subproject/issue tracker. In fact, I would go even a step further and
have separate subprojects for each target version (hammer backports,
firefly backports).

Having all, e.g. hammer, backports in one place is advantageous in
pretty much every way I can think of: easier to see what has been
done, what needs to be done, easier to search, easier to automate,
less risk of munging something not related to backports...

It also has the effect of removing all the backport-related tickets
from the bug tracker(s).

Nathan

From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Mourning the demise of mkcephfs
Date: Mon, 11 Nov 2013 17:51:41 +0000
Message-ID: <5281192D.4090707@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ip.uk.com ([81.2.115.98]:45776 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754139Ab3KKSSt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Nov 2013 13:18:49 -0500
Received: from [10.0.1.108]
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>)
	id 1VfvYN-0002Oo-Q3
	for ceph-devel@vger.kernel.org; Mon, 11 Nov 2013 17:45:36 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The utility mkcephfs seemed to work, it was very simple to use and
apparently effective.

It has been deprecated in favour of something called ceph-deploy, which
does not work for me.

I've ignored the deprecation messages until now, but in going from 70 to
72 I find that mkcephfs has finally gone.

I have tried ceph-deploy, and it seems to be tied in to specific
'distributions' in some way.

It is unuseable for me at present, because it reports:

[ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:


I therefore need to go back to first principles, but the documentation
seems to have dropped descriptions of driving ceph without smoke and
mirrors.

The direct approach may be more laborious, but at least it would not
depend on anything except ceph itself.

Maybe I need to step back a version or two, set up my cluster with
mkcephfs, then switch back to the latest to use it.

I'll search the documentation again.

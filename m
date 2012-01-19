From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Thu, 19 Jan 2012 17:35:15 +0000 (UTC)
Message-ID: <loom.20120119T183130-208@post.gmane.org>
References: <orboq2w2vq.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:39009 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571Ab2ASRkL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Jan 2012 12:40:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Rnvy3-0001IY-24
	for ceph-devel@vger.kernel.org; Thu, 19 Jan 2012 18:40:07 +0100
Received: from charybdis-ext.suse.de ([195.135.221.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jan 2012 18:40:07 +0100
Received: from hmacht by charybdis-ext.suse.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jan 2012 18:40:07 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Alexandre Oliva <oliva <at> lsd.ic.unicamp.br> writes:

> 
> Some post-install rpmbuild defaults byte-compile all packaged python
> files, so don't bother removing the .pyc files, and package .py* to
> get both .pyo and .pyc.  It wastes a tiny little bit of space, but it
> makes the spec file portable across a wider range of rpm and python
> configurations.

Just wondering...do you have a concrete issue or an example where this is a 
problem?

Regards
 Holger



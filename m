From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Thu, 19 Jan 2012 22:26:09 -0200
Message-ID: <orehuvp6ce.fsf@livre.localdomain>
References: <orboq2w2vq.fsf@livre.localdomain>
	<loom.20120119T183130-208@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:42526 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756222Ab2ATA0W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Jan 2012 19:26:22 -0500
In-Reply-To: <loom.20120119T183130-208@post.gmane.org> (Holger Macht's message
	of "Thu, 19 Jan 2012 17:35:15 +0000 (UTC)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Holger Macht <hmacht@suse.de>
Cc: ceph-devel@vger.kernel.org

On Jan 19, 2012, Holger Macht <hmacht@suse.de> wrote:

> Alexandre Oliva <oliva <at> lsd.ic.unicamp.br> writes:
>> 
>> Some post-install rpmbuild defaults byte-compile all packaged python
>> files, so don't bother removing the .pyc files, and package .py* to
>> get both .pyo and .pyc.  It wastes a tiny little bit of space, but it
>> makes the spec file portable across a wider range of rpm and python
>> configurations.

> Just wondering...do you have a concrete issue or an example where this is a 
> problem?

It failed to build on a BLAGified Fedora 16, complaining about the
unpackaged .pyc files.  It's not just CentOS that creates the .pyc files
in brp-python-bytecompile.  Plus, they should be packaged (if at all) in
python-ceph, but definitely not in the main ceph package.


Another issue I forgot while posting the patch was that there was not a
.tar.bz2 available from the ceph site.  I ended up recompressing the .gz
as .bz2, but if ceph is going to be released compressed as .gz, the spec
file ought to be adjusted to reflect that.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

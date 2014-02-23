From: Sage Weil <sage@inktank.com>
Subject: doxygen help
Date: Sun, 23 Feb 2014 12:38:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402231235060.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57178 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaBWUik (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 15:38:40 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5A42180069
	for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 12:38:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 28C5680069
	for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 12:38:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A while back I added some doxygen comments/docs to librados.hpp and tried 
to have sphinx slurp it up into the generated docs on ceph.com:

	https://github.com/ceph/ceph/commit/d0c4600e6645d116b9b2c4eea56ef5851eea54d5

Unfortunately this flames out with some obscure doxygen error and I wasn't 
able to sort it out given my limited attention span and experience with 
such tools.  You can see the error here:

	http://gitbuilder.sepia.ceph.com/gitbuilder-doc/log.cgi?log=d0c4600e6645d116b9b2c4eea56ef5851eea54d5

Exception occurred:
File "/tmp/virtualenv-docs/src/asphyxiate/asphyxiate/__init__.py", line 
388, in render_compounddef
"cannot handle {node.tag} kind={node.attrib[kind]}".format(node=node)
Error: Assertion cannot handle compounddef kind=class

Anybody know what might be going on?  This is the main thing preventing 
the C++ librados API docs (such as they are) from appearing on the site.

sage

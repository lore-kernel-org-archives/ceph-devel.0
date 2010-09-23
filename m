From: Sage Weil <sage@newdream.net>
Subject: corrupt pg logs
Date: Thu, 23 Sep 2010 08:05:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009230757330.16100@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52613 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab0IWPDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 11:03:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: henry_c_chang@tcloudcomputing.com

One problem that keeps popping up is corruption in the PG logs.  This 
usually manifests itself as a crash when the OSD restarts and is unable to 
parse the log.  There are a couple of things to do here.

First, we need to figure out where the corruption is coming from.  Dumps 
of the corrupt pglog files will help.  Are they zeroed out?  Entirely?  Is 
there valid data at the end of the file?  etc.  

Second, we need to come up with a reasonable way to start up even when 
some PGs are corrupt.  Deleting them is one option, but we want to avoid 
doing so unless we're sure we have a good copy elsewhere.

Another option would be to make a 'corrupt' subdirectory on the OSD and 
move the log there.  Without the log, the OSD will need to rebuild the 
object list to recover/resync with other PG copies, but at least it will 
start and (eventually) recover.

http://tracker.newdream.net/issues/169

Thoughts?

sage

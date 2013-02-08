From: Sage Weil <sage@inktank.com>
Subject: the autobuild gpg key expired!
Date: Thu, 7 Feb 2013 22:46:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302072235180.28547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36999 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab3BHGqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 01:46:04 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B1DAA80060
	for <ceph-devel@vger.kernel.org>; Thu,  7 Feb 2013 22:46:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7884C80060
	for <ceph-devel@vger.kernel.org>; Thu,  7 Feb 2013 22:46:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all-

For some silly reason I made the GPG key used to sign autobuild packages 
from git expire after 1 year... a year ago today.  Which broke the builds 
this afternoon, and may be causing warnings from anyone using those 
packages.  (Note that official release packages are not affected!)

The Ubuntu keys that sign cd images and such have no expiry; the Debian 
keys expire after 15-20 years.  Since these packages are only 
quasi-trusted (they are automatically built from branches in git, after 
all), just setting no expiry is simplest.  Our future selves exactly N 
years in an alternate timeline will surely agree.

The key in question is

pub   1024D/03C3951A 2011-02-08
uid                  Ceph automated package build (Ceph automated package build) <sage@newdream.net>
sub   4096g/2E457B51 2011-02-08

If you previously installed this as a trusted key on your system, the 
key can be updated (or newly installed) with

 wget -q -O- https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo apt-key add -

If you only install *release* packages (not bleeding edge code), you can 
ignore all of this; *that* key (17ED316D) has no expiry:

pub   4096R/17ED316D 2012-05-20
uid                  Ceph Release Key <sage@newdream.net>

sage


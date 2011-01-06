From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Installing and configuring ceph
Date: Thu, 06 Jan 2011 08:24:41 -0700
Message-ID: <1294327481.3371.163.camel@hermosa.morreale.net>
Reply-To: pmorreale@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:54573 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753035Ab1AFPYt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jan 2011 10:24:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


I'm having a difficult time installing ceph for the first time by
following the newdream wiki site.  Can some kind soul help with the
following?

I've built ceph 0.24 from the tarball on a pristine OpenSUSE 11.3
release, and performed:

% make 
% make install
% make install-data (from reading the makefiles)

The goal is to install ceph on 3 identical machines, each with a
dedicated partition, using btrfs.  (yes, ssh access w/o passwords are
configured among these machines)

1) /etc/init.d/ceph is not installed, nor are the sample confs installed
in /etc/ceph.  Is there some other make target I need to run?  The
INSTALL file in the source is not very helpful.  Install manually?
Where is the init.d script?  (.../src/ceph is a binary.)

2) Do I need a kernel client?  Its not clear to me from the wiki what
the role of the kernel module is.   Do I need the kernel client for
client access only?  From a previous post I inferred that one could use
fuse for client access, is that correct?

3) I assume I need to install the user-space portion of ceph on all
machines?  Or do we differentiate between ceph user-space servers on on
"server" machines and the kernel client for 'client' access. 

4) Is there some other documentation that explains bringing up ceph for
the first time?  Everything I find is vectored to the wiki. 

Clearly I am missing the larger picture on how to install.  Thanks in
advance for any info.  

Best,
-PWM


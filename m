From: Sage Weil <sage@newdream.net>
Subject: packaging for ceph-gui
Date: Tue, 14 Dec 2010 11:56:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40255 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab0LNTvq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Dec 2010 14:51:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gcs@debian.hu
Cc: ceph-devel@vger.kernel.org

Hi Laszlo,

Colin separated out the gui from the 'ceph' binary (it's gceph) in the 
unstable branch of git, which means we can break it into a separate 
package and eliminate all the gtk dependencies for the other stuff.  
Maybe a ceph-gui, recommended by ceph?

sage

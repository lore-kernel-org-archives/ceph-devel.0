From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: "--restart" broken due to bug in init script?
Date: Mon, 04 Mar 2013 13:32:23 -0500
Message-ID: <201303041832.r24IWN3f029106@ayesha.phys.virginia.edu>
Reply-To: bkw1a@ayesha.phys.virginia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:43359 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab3CDScY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:32:24 -0500
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id r24IWN3f029106
	for <ceph-devel@vger.kernel.org>; Mon, 4 Mar 2013 13:32:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

	It looks like the "--restart" option in the ceph init script
is broken.  The flag sets the variable "$docrun", but then
later, when it's tested, the script looks for "$crun" instead.

					Bryan

-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================



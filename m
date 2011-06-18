From: Sage Weil <sage@newdream.net>
Subject: metablob fix
Date: Fri, 17 Jun 2011 22:17:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106172215440.4755@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54949 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1FRFPj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Jun 2011 01:15:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samlang@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Sam-

I pushed a fix for the valgrind error you were seeing to mds_metablob_fix.  
There was a class used in an STL container that wasn't copyable.  As far 
as I can tell, you can't actually put items in a container (map<> in this 
case) that aren't copyable, so I used a boost::smart_ptr.  

Maybe someone with better C++-fu than I has a way to avoid the copies 
entirely?  Adding

	fullbit(const fullbit& other);
	const fullbit operator=(const fullbit& other);

fails to link, and if I assert in there I can't get past inserting the 
initial element.  :/

sage


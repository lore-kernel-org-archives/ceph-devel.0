From: Sage Weil <sage@newdream.net>
Subject: Fixes: #NNN
Date: Tue, 21 Oct 2014 13:32:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410211331490.29946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60367 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529AbaJUUc6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 16:32:58 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0EF228004F
	for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 13:32:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D78E18004F
	for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 13:32:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Please remember to use the # when adding lines like

    Fixes: #1234

to your commit messages.  The #NNNN makes Redmine pick them up and display 
them with the bug, which is pretty handy.

sage

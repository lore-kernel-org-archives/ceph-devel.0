From: Rutger ter Borg <rutger@terborg.net>
Subject: Question about librados
Date: Mon, 04 Apr 2011 13:33:56 +0200
Message-ID: <incab7$gnn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50546 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294Ab1DDLfL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Apr 2011 07:35:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q6i3l-0003lL-4V
	for ceph-devel@vger.kernel.org; Mon, 04 Apr 2011 13:35:09 +0200
Received: from 233-250-103-145.static.glaslokaal.nl ([145.103.250.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2011 13:35:05 +0200
Received: from rutger by 233-250-103-145.static.glaslokaal.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2011 13:35:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hello,

I'm in the progress of evaluating librados as an object store. I'm using 
Debian's latest packages as of today, and noted that I need to define 
NO_ATOMIC_OPS to get something compiled that includes librados.hpp.

My actual question: is there a requirement/optimum on the relation 
between number of objects and number of pools? Or may this be chosen to 
be something completely arbitrary? I.e., is it a problem to have a 
couple of hundred IoCtxs active in one process? What is a 
reasonable/performance-wise-good object-size?

TIA,

Rutger




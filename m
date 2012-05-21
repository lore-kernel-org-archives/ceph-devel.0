From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Replication at file/folder filen
Date: Mon, 21 May 2012 17:28:24 +0000 (UTC)
Message-ID: <loom.20120521T192333-932@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50468 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868Ab2EUR2k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 May 2012 13:28:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SWWPM-0007ba-Ca
	for ceph-devel@vger.kernel.org; Mon, 21 May 2012 19:28:36 +0200
Received: from Static-80.59.96.14.tataidc.co.in ([Static-80.59.96.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 19:28:36 +0200
Received: from madhusudhana.u.acharya by Static-80.59.96.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 19:28:36 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I assume in CEPH, by default, replications are set for both data and metadata. 
Is it possible for setting replication for individual file/folders ? I find this 
very usefule. In most of the cases, we may need more protections for just few 
files/folders. Instead of setting replication level for entire data, it would be 
good to set for required files/folders. If not possible in current version,
is it possible to add this in future? I would love to see this feature in CEPH.

Thanks
__Madhusudhana


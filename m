From: Ankur Kemkar <ankur.kemkar@emc.com>
Subject: Re: vstart problem in master branch
Date: Sat, 16 Apr 2011 00:39:57 +0000 (UTC)
Message-ID: <loom.20110416T023608-477@post.gmane.org>
References: <B6DAFB0C-A321-499A-A21E-7CA59EFCDA5B@cs.ucsc.edu> <054B710EFF18497CB0B964DC9819B556@gmail.com> <20110331180652.GA12850@dreamer> <0A340955-01D3-4E72-AC72-0F9EFBC94227@cs.ucsc.edu> <loom.20110415T225346-950@post.gmane.org> <20110415212743.GB31400@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36704 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1DPAkM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2011 20:40:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QAtYX-0004ZU-MH
	for ceph-devel@vger.kernel.org; Sat, 16 Apr 2011 02:40:09 +0200
Received: from 137.69.117.57 ([137.69.117.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2011 02:40:09 +0200
Received: from ankur.kemkar by 137.69.117.57 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2011 02:40:09 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tommi.virtanen <at> dreamhost.com> writes:


> Quick guess -- perhaps you didn't have /data/osd2 mounted at the time
> you ran mkcephfs, and the files were created in a subdirectory of your
> root filesystem.
> 
> Shut down ceph, do umount /data/osd2, and ls /data/osd2; if the files
> are there, then that was what happened.
> 


Thanks - It works. Yes, I didn't have any of the btrfs on any of the 3 nodes
mounted prior to mkcephfs. 


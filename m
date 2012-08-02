From: "Niko!" <nicola.ranaldo@gmail.com>
Subject: Ceph fs stability
Date: Thu, 02 Aug 2012 19:10:49 +0200
Message-ID: <501AB499.1080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34903 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab2HBRKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 13:10:52 -0400
Received: by bkwj10 with SMTP id j10so4356647bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 10:10:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

we are using ceph 0.48 on three nodes to provide rbd images for further 
four kvm nodes (not kernel mapped) with no big issues and would mount 
the ceph fs on the kvm nodes just to store xml virtual machine 
definitions in order to have them immediately in the case an host 
crashes (we are in multimds configuration). As ceph fs is not production 
ready what are the possible problems? May the fs corrupt the rbd pool or 
damages will be limited only to the data/metadata pools (acceptable for 
us)? may the fs hang the entire cluster or kvm client nodes?

Regards.

     Niko



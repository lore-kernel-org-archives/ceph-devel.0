From: Amit Tiwary <tiwaryamt@gmail.com>
Subject: Efficiently scan all objects in a rados pool/namespace
Date: Wed, 16 Oct 2013 04:48:58 +0000 (UTC)
Message-ID: <loom.20131016T060803-617@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43306 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab3JPGAG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Oct 2013 02:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VWK9L-0003EG-Az
	for ceph-devel@vger.kernel.org; Wed, 16 Oct 2013 08:00:03 +0200
Received: from NSG-Static-099.53.71.182.airtel.in ([NSG-Static-099.53.71.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Oct 2013 08:00:03 +0200
Received: from tiwaryamt by NSG-Static-099.53.71.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Oct 2013 08:00:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We are using ceph version 0.56.6, librados C++ APIs and have more than 750 
million objects in a single pool. Objects are named as "domain-name_file-
name".

We are unable to ascertain in what order objects are listed with the command 
"rados -p poolname ls". They are neither ordered on objectname, nor size or 
mtime.

Q1) Is there any way we can control the way objects are scanned/listed in a 
pool with the below librados c++ code? We are interested in getting list of 
objects sorted or grouped by object name
    librados::ObjectIterator it = ioctx.objects_begin();
    for (; it != ioctx.objects_end(); ++it)
        ...

Q2) In near future, if we upgrade and make use of namespaces (i.e make 
domain-name as namespace and store all objects of a particular domain in that 
namespace); would scanning of objects in a namespace be efficient than 
current scenario where we have to scan the entire pool to fetch all objects?

Q3) Do you any other recommendations on top of your mind that can improve 
time required to scan all objects of pool/namespace?

Thanks,
Amit Tiwary

  




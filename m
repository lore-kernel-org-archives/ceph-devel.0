From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Problems while doing rpmbuild on CENTOS
Date: Thu, 24 May 2012 14:07:26 +0530
Message-ID: <1337848646.30818.48.camel@indica.cc.iitb.ac.in>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:33921 "EHLO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370Ab2EXIh3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 May 2012 04:37:29 -0400
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 02DC94340628
	for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 14:07:27 +0530 (IST)
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id 8A38613906
	for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 14:07:26 +0530 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I am trying to build the CEPH stuff from bzip source archive by
using the command below:

      rpmbuild -tb /home/src/ceph.related/ceph-0.47.2.tar.bz2

I get the following error:

      error: File /home/src/ceph.related/libs3-trunk.tar.gz: No such
file or directory

What is this and where do I get this file from ? Can anyone pl give
me some pointers on this ?

Regards.

--ajit


      


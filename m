From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 14:27:09 +0530
Message-ID: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([14.139.97.13]:34781 "EHLO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947Ab2CYJdb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 25 Mar 2012 05:33:31 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 90ECEC01AB88
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 14:27:10 +0530 (IST)
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id 3153113900
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 14:27:10 +0530 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello All,

I have lost touch with the growth of ceph after version 0.30.
I am trying to compile version 0.43 and 0.44 on FC13 and FC15.
It does not build successfully. I get the following error:

   make[3]: *** No rule to make target `leveldb/libleveldb.a', needed by
`ceph-osd'.  Stop.
   make[3]: *** Waiting for unfinished jobs....

I have the following questions:

  a) What is this error about ? Has CEPH dropped Fedora as a target
     OS platform ?

  b) What is the best suited OS for building/testing CEPH prototypes ?

Thanks for your attention.

--ajit



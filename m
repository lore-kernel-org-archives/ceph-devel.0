From: Peter Smith <peterfruits@gmail.com>
Subject: Understanding Ceph
Date: Sat, 19 Jan 2013 23:50:56 +0800
Message-ID: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f196.google.com ([209.85.210.196]:47707 "EHLO
	mail-ia0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab3ASPu5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 10:50:57 -0500
Received: by mail-ia0-f196.google.com with SMTP id l25so525329iad.7
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 07:50:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am considering deploying Ceph as the volume backend for our
Openstack cloud service. After reviewing the documents available on
the Internet, I am still confusing with several things.

1. Architecture/Implementation questions: What are the functionalities
of kernel-rbd, kernel client, kernel object exactly? How the different
parts of Ceph interact with each other, e.g. what is the data path of
librados/librbd requests going into OSD daemon?
2. QEMU performance: It says the QEMU uses librbd to avoid the
overhead of kernel object. What does this mean? With the answer of
question 1, I can probably understand this one. Do you have any data
about the performance difference between Ceph and Sheepdog?
3. OS recommendation: The OS recommendation page:
http://ceph.com/docs/master/install/os-recommendations/#bobtail-0-56
says CentOS 6.3 has a default kernel with old kernel client. CentOS
6.3 is our production environment. I am wondering if we only make use
of the Ceph block storage feature, does this old kernel client
influence the stability of production? Do you suggest we upgrade from
the default kernel of CentOS 6.3? I am concerning this will hurt the
stability of CentOS.

Thank you very much for anwsering my questions. I really appreciate.


Regards,
Peter

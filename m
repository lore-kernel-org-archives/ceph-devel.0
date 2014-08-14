From: =?ISO-8859-1?Q?Luis_Pab=F3n?= <lpabon@redhat.com>
Subject: RGW Swift questions
Date: Thu, 14 Aug 2014 10:27:02 -0400
Message-ID: <53ECC736.2090202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56737 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbaHNO1D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Aug 2014 10:27:03 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7EER20g021990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 10:27:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi Yehuda,
     I am starting work on RGW and have a few questions:

* Why is the command 'user create' when I am sending '--subuser'. Seems 
confusing.  Is there a reason why we are not to use 'subuser create'?
* If I use "user create --subuser", the JSON returned shows the entry 
for "subusers" is empty.  What is subusers for? (This is related to the 
previous question)
* Where do I place the OpenStack Tenant information?
* Is there a document which describes how to setup RGW for OpenStack Swift?
* The radosgw-admin help screen does not explain which options to use 
for certain commands.  Is this something that we should fix?
* On page: http://ceph.com/docs/master/radosgw/swift/auth/ , clicking on 
"see radosgw-admin" does not work.

Please let me know if these are already answered in some document.

Regards,

Luis

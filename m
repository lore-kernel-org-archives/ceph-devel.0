From: John Wright <jwright@psfc.mit.edu>
Subject: MPI applications on ceph fs
Date: Sun, 26 Aug 2012 10:03:12 -0400
Message-ID: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:57990 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144Ab2HZOIQ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 Aug 2012 10:08:16 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id q7QE3E5Q007851
	for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 10:03:14 -0400
Received: from [192.168.2.140] (c-66-30-248-143.hsd1.ma.comcast.net [66.30.248.143])
	(authenticated bits=0)
        (User authenticated as jcwright@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id q7QE3Cqg014679
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 10:03:13 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,
We're running ceph 0.48 on  small three node test cluster. We've had good stability with I/O using dd and iozone especially after upgrading to 0.48. However, we're running into a repeatable lockup of the linux ceph client ( 3.3.5-2.fc16.x86_64 ) when running an mpi program that has simple I/O on a ceph mount. This is an mpi program running processes on two nodes. It is the remote node on which the ceph client locks up. The cient becomes immediately unresponsive and any attempt to access the mounted volume produces a process with status 'D'. I can see no indication in the server logs that it is ever contacted. Regular serial processes run fine on the volume. MPI runs on the nodes work fine when not using the ceph volume.

So any suggestions on where to look? Any one have an experience testing parallel programs on ceph?

thanks,
-john


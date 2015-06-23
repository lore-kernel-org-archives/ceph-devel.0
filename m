From: Samuel Just <sjust@redhat.com>
Subject: librados clone_range
Date: Tue, 23 Jun 2015 14:17:52 -0400 (EDT)
Message-ID: <14671826.29748867.1435083472672.JavaMail.zimbra@redhat.com>
References: <715184714.29747901.1435083376029.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:55720 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbFWSRx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 14:17:53 -0400
In-Reply-To: <715184714.29747901.1435083376029.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>

ObjectWriteOperations currently allow you to perform a clone_range from another object with the same object locator.  Years ago, rgw used this as part of multipart upload.  Today, the implementation complicates the OSD considerably, and it doesn't appear to have any users left.  Is there anyone who would be sad to see it removed from the librados interface?
-Sam

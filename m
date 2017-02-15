From: Matt Benjamin <mbenjamin@redhat.com>
Subject: swift slo manifest etag
Date: Wed, 15 Feb 2017 14:18:45 -0500 (EST)
Message-ID: <1625664484.107586782.1487186325410.JavaMail.zimbra@redhat.com>
References: <868184347.107585548.1487186032181.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:45499 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdBOTSp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 14:18:45 -0500
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id v1FJIj3G004137
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 14:18:45 -0500
In-Reply-To: <868184347.107585548.1487186032181.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Swift mavens,

Current swift documentation states that slo manifest etag and size_bytes keys are optional [1].  I found [2], which suggests that only recently did Swift object storage actually behave as if the etag is "fully optional."

Currently attempts to fetch an object whose manifest etag is not defined ("") result in ERR_PRECONDITION_FAILED due to the if_match logic in  RGWRados::Object::Read::prepare().  Should this logic permit the if-match to succeed if etag is not defined?

Thanks,

Matt

[1] http://docs.openstack.org/developer/swift/overview_large_objects.html
[2] http://git.openstack.org/cgit/openstack/swift/commit/?id=462f91b040ff47b51e5397eed930785590638d69

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309

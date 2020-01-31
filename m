From: David Galloway <dgallowa@redhat.com>
Subject: v14.2.7 Nautilus released
Date: Fri, 31 Jan 2020 16:49:11 -0500
Message-ID: <0600f6f1-ae42-83e5-114a-0e32676ac998@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43259 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgAaVtW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jan 2020 16:49:22 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.io, ceph-users@ceph.io, dev@ceph.io, ceph-devel@vger.kernel.org

This is the seventh update to the Ceph Nautilus release series. This is
a hotfix release primarily fixing a couple of security issues. We
recommend that all users upgrade to this release.


Notable Changes
---------------

* CVE-2020-1699: Fixed a path traversal flaw in Ceph dashboard that
could allow
  for potential information disclosure (Ernesto Puerta)
* CVE-2020-1700: Fixed a flaw in RGW beast frontend that could lead to
denial of
  service from an unauthenticated client (Or Friedmann)

-- 
David Galloway
Systems Administrator, RDU
Ceph Engineering
IRC: dgalloway

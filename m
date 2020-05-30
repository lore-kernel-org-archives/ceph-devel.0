From: Josh Durgin <jdurgin@redhat.com>
Subject: v15.2.3 Octopus released
Date: Fri, 29 May 2020 18:56:47 -0700
Message-ID: <0d1374f4-981a-30c4-a992-07b6c8f0db1c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727876AbgE3B5M (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2020 21:57:12 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.io, ceph-users@ceph.io, dev@ceph.io, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.io

We’re happy to announce the availability of the third Octopus stable
release series. This release mainly is a workaround for a potential OSD
corruption in v15.2.2. We advise users to upgrade to v15.2.3 directly.
For users running v15.2.2 please execute the following::

     ceph config set osd bluefs_preextend_wal_files false

Changelog
~~~~~~~~~
  * bluestore: common/options.cc: disable bluefs_preextend_wal_files

Getting Ceph
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-15.2.3.tar.gz
* For packages, see
http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: d289bbdec69ed7c1f516e0a093594580a76b78d0

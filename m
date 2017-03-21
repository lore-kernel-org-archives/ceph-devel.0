From: liuchang0812 <liuchang0812@gmail.com>
Subject: Broken links in Ceph documentation
Date: Tue, 21 Mar 2017 11:06:29 +0800
Message-ID: <CACKY0b8-rq-R0Sun9Mxfk3ogtA-YMF26HMWUJj0xEZ__9_Z9YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35947 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755307AbdCUDGc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Mar 2017 23:06:32 -0400
Received: by mail-yw0-f169.google.com with SMTP id o4so102512731ywd.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 20:06:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

I have run `sphinx linkcheck` for our documentation. Here are all
broken links(there are some non-broken urls, bug of linkcheck?) :

api/index.rst:39: [broken]
http://ceph.com/calamari/docs/calamari_rest/index.html: HTTP Error
404: Not Found
architecture.rst:108: [broken]
http://ceph.com/papers/weil-crush-sc06.pdf: HTTP Error 404: Not Found
cephfs/mantle.rst:38: [broken] https://sourceforge.net/projects/mdtest/: ''
dev/cpu-profiler.rst:5: [broken]
http://oprofile.sourceforge.net/about/: HTTP Error 502: Bad Gateway
dev/development-workflow.rst:57: [broken]
http://wiki.ceph.com/Planning/CDS/: HTTP Error 404: Not Found
dev/development-workflow.rst:126: [broken]
http://ceph.com/resources/mailing-list-irc/: HTTP Error 404: Not Found
dev/documenting.rst:27: [broken]
https://raw.github.com/ceph/ceph/master/doc/api/librados.rst: HTTP
Error 404: Not Found
dev/documenting.rst:77: [broken] http://blockdiag.com/: timed out
dev/index.rst:114: [broken] http://tracker.ceph.com/account/register:
HTTP Error 500: Internal Server Error
dev/index.rst:136: [broken]
https://ceph.com/resources/mailing-list-irc/: HTTP Error 404: Not
Found
dev/index.rst:148: [broken]
https://ceph.com/resources/mailing-list-irc/: HTTP Error 404: Not
Found
dev/index.rst:429: [broken] https://github.com/mygithubaccount/ceph:
HTTP Error 404: Not Found
dev/index.rst:450: [broken]
https://github.com/mygithubaccount/ceph.git: HTTP Error 404: Not Found
dev/index.rst:716: [broken]
http://ceph.com/resources/mailing-list-irc/: HTTP Error 404: Not Found
dev/index.rst:1164: [broken] https://docs.docker.com/linux/: HTTP
Error 403: Forbidden
dev/osd_internals/erasure_coding/developer_notes.rst:190: [broken]
https://github.com/ceph/ceph/blob/v0.78/src/test/osd/ErasureCodePluginExample.cc:
HTTP Error 404: Not Found
dev/placement-group.rst:47: [broken]
http://ceph.com/wiki/Changing_the_number_of_PGs: HTTP Error 404: Not
Found
dev/rbd-layering.rst:92: [broken]
http://marc.info/?l=ceph-devel&m=129867273303846: timed out
install/get-packages.rst:148: [broken]
https://download.ceph.com/packages/google-perftools/debian: HTTP Error
404: Not Found
install/mirrors.rst:25: [broken] http://us-east.ceph.com/: HTTP Error
502: Bad Gateway
install/mirrors.rst:18: [broken] http://au.ceph.com/: timed out
rados/operations/crush-map.rst:12: [broken]
http://ceph.com/papers/weil-crush-sc06.pdf: HTTP Error 404: Not Found
rados/operations/crush-map.rst:408: [broken]
http://ceph.com/papers/weil-crush-sc06.pdf: HTTP Error 404: Not Found
rados/operations/crush-map.rst:491: [broken]
http://ceph.com/papers/weil-crush-sc06.pdf: HTTP Error 404: Not Found
rados/operations/erasure-code-jerasure.rst:8: [broken]
https://bitbucket.org/jimplank/jerasure/: HTTP Error 404: Not Found
rados/operations/operating.rst:112: [broken]
http://manpages.ubuntu.com/manpages/raring/en/man8/initctl.8.html:
HTTP Error 404: Not Found
rados/troubleshooting/cpu-profiling.rst:5: [broken]
http://oprofile.sourceforge.net/about/: HTTP Error 502: Bad Gateway
rados/troubleshooting/memory-profiling.rst:63: [broken]
http://google-perftools.googlecode.com/svn/trunk/doc/heapprofile.html:
HTTP Error 404: Not Found
radosgw/keystone.rst:24: [broken]
http://docs.openstack.org/developer/keystone/configuringservices.html:
HTTP Error 404: Not Found
rbd/rbd-cloudstack.rst:89: [broken]
http://cloudstack.apache.org/docs/en-US/Apache_CloudStack/4.2.0/html/Admin_Guide/primary-storage-add.html:
HTTP Error 404: Not Found
rbd/rbd-cloudstack.rst:108: [broken]
http://cloudstack.apache.org/docs/en-US/Apache_CloudStack/4.2.0/html/Admin_Guide/compute-disk-service-offerings.html:
HTTP Error 404: Not Found
release-notes.rst:2137: [broken] https://: <urlopen error no host given>
start/documenting-ceph.rst:482: [broken]
http://docutils.sourceforge.net/docs/user/rst/quickstart.html: HTTP
Error 502: Bad Gateway
start/documenting-ceph.rst:486: [broken]
http://docutils.sourceforge.net/docs/user/rst/quickstart.html: HTTP
Error 502: Bad Gateway
start/documenting-ceph.rst:563: [broken]
http://docutils.sourceforge.net/docs/ref/rst/directives.html: HTTP
Error 502: Bad Gateway
start/get-involved.rst:15: [broken]
http://ceph.com/community/planet-ceph/: HTTP Error 404: Not Found
start/get-involved.rst:36: [broken]
http://news.gmane.org/gmane.comp.file-systems.ceph.user: HTTP Error
404: Not Found
start/get-involved.rst:43: [broken]
http://news.gmane.org/gmane.comp.file-systems.ceph.devel: HTTP Error
404: Not Found

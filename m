From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Wed,  9 Jan 2013 22:35:15 +0100
Message-ID: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51436 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933318Ab3AIVfT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:35:19 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

The attached patch depends on the set of 6 patches I send some days ago.
See: http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/11793

Danny Al-Gaaf (1):
  configure.ac: check for org.junit.rules.ExternalResource

 autogen.sh                |   2 +-
 configure.ac              |  29 ++++++-------
 m4/ac_check_class.m4      | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 m4/ac_check_classpath.m4  |  24 +++++++++++
 m4/ac_check_rqrd_class.m4 |  26 +++++++++++
 m4/ac_java_options.m4     |  33 ++++++++++++++
 m4/ac_prog_jar.m4         |  39 +++++++++++++++++
 m4/ac_prog_java.m4        |  83 +++++++++++++++++++++++++++++++++++
 m4/ac_prog_java_works.m4  |  98 +++++++++++++++++++++++++++++++++++++++++
 m4/ac_prog_javac.m4       |  45 +++++++++++++++++++
 m4/ac_prog_javac_works.m4 |  36 ++++++++++++++++
 m4/ac_prog_javah.m4       |  28 ++++++++++++
 m4/ac_try_compile_java.m4 |  40 +++++++++++++++++
 m4/ac_try_run_javac.m4    |  41 ++++++++++++++++++
 14 files changed, 615 insertions(+), 17 deletions(-)
 create mode 100644 m4/ac_check_class.m4
 create mode 100644 m4/ac_check_classpath.m4
 create mode 100644 m4/ac_check_rqrd_class.m4
 create mode 100644 m4/ac_java_options.m4
 create mode 100644 m4/ac_prog_jar.m4
 create mode 100644 m4/ac_prog_java.m4
 create mode 100644 m4/ac_prog_java_works.m4
 create mode 100644 m4/ac_prog_javac.m4
 create mode 100644 m4/ac_prog_javac_works.m4
 create mode 100644 m4/ac_prog_javah.m4
 create mode 100644 m4/ac_try_compile_java.m4
 create mode 100644 m4/ac_try_run_javac.m4

-- 
1.8.1


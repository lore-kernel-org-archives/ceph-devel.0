From: Noah Watkins <noah.watkins@inktank.com>
Subject: [ANN] Maven support for CephFS Java
Date: Fri, 23 May 2014 14:42:36 -0700
Message-ID: <CA+Hcz59B0nKBbBaF6jVLnmRXARyk88Ve_Oa_QUCcMjWBB7H5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:58504 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaEWVmh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 May 2014 17:42:37 -0400
Received: by mail-qc0-f173.google.com with SMTP id i8so8784211qcq.4
        for <ceph-devel@vger.kernel.org>; Fri, 23 May 2014 14:42:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

The `cephfs-java` package can now to retreived from the Maven repository below.

Note that this is a _very alpha_ release, but contains a whole lot of
awesome in the form of the native JNI bits embedded in the package, so
there should be no need to do an RPM/Deb install of these dependencies
(e.g. libcephfs-jni) and deal with all those silly search paths.

Please shoot any bug reports to the list.

Current support is limited to Linux/x86-64, but can add other archs if
requested. All existing cephfs-java packages are unaffected.

- Noah

  <repositories>
      <repository>
          <id>ceph-maven</id>
          <url>http://ceph.com/maven</url>
      </repository>
  </repositories>

  <dependencies>
    <dependency>
      <groupId>com.ceph</groupId>
      <artifactId>cephfs</artifactId>
      <version>0.0.1</version>
    </dependency>
  </dependencies>

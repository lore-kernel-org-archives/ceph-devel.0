From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Cmake: determening Ceph version when there is no git checkout.
Date: Tue, 11 Jul 2017 15:36:07 +0200
Message-ID: <7683db13-17fc-44a8-cb6c-bcc83048378a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25539 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754514AbdGKNgO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Jul 2017 09:36:14 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 586B044529
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 15:36:11 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm doing some work to be ready when Luminous gets fully released.
But I now run into the following code from src/CMakeLists.txtx
====
# the src/.git_version file may be written out by make-dist; otherwise
# we pull the git version from .git
option(ENABLE_GIT_VERSION "build Ceph with git version string" ON)
if(${ENABLE_GIT_VERSION})
  get_git_head_revision(GIT_REFSPEC CEPH_GIT_VER)
  git_describe(CEPH_GIT_NICE_VER --always)
  #if building from a source tarball via make-dist
  if(${CEPH_GIT_VER} STREQUAL "GITDIR-NOTFOUND")
    message(STATUS "Ceph/.git directory not found, parsing
${CMAKE_CURRENT_SOURCE_DIR}/.git_version for CEPH_GIT_VER and
CEPH_GIT_NICE_VER")
    file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/.git_version
CEPH_GIT_SHA_AND_TAG)
    list(GET CEPH_GIT_SHA_AND_TAG 0 CEPH_GIT_VER)
    list(GET CEPH_GIT_SHA_AND_TAG 1 CEPH_GIT_NICE_VER)
  endif(${CEPH_GIT_VER} STREQUAL "GITDIR-NOTFOUND")
  # remove 'v' prefix from raw git version
  string(SUBSTRING ${CEPH_GIT_NICE_VER} 1 -1 CEPH_GIT_NICE_VER)
else(${ENABLE_GIT_VERSION})
  set(CEPH_GIT_VER "no_version")
  set(CEPH_GIT_NICE_VER "Development")
endif(${ENABLE_GIT_VERSION})
====

This build the Ceph version from data in the .git repo.
But that is not how FreeBSD packaging works. There a tarbal is fetched
but that does not contain any git info.

Work is done in:
	/usr/ports/net/ceph/work/ceph-12.1.0
and that is about all where I can extract some versioning from.

Does anybody have suggestions for an easy way out?
Other than hardcode it in the Makefile as an option to CMake.

--WjW

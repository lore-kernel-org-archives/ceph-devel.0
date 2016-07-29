From: Gerard Braad <me@gbraad.nl>
Subject: Cmake and rpmbuild
Date: Fri, 29 Jul 2016 09:50:51 +0800
Message-ID: <CAGrH30XYN5fsx4HojZf3QdEAyvLm+-7N=tKYJU13HhjLrrRToQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33805 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcG2Buw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2016 21:50:52 -0400
Received: by mail-io0-f195.google.com with SMTP id g86so8738773ioj.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2016 18:50:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

Hi All,


At the moment I am setting up CI pipelines for Ceph and ran into a
small issue; I have some memory constrained runners (2G). So, when
performing a build using do-cmake all is fine... the build might last
long, but after an hour or two I am greeted with a 'Build succeeded'
message, I gather the artifacts and all is well.

But when I do a rpmbuild, I have to rely on doing a make-dist, and
then issue a rpmbuild targeting this tarball. However, in the same
runners, this build will fail with "virtual memory exhausted". Is
there anything I can do that does not immediately involve adding more
memory?

If more information is needed, please let me know...

regards,


Gerard

-- 

   Gerard Braad | http://gbraad.nl
   [ Doing Open Source Matters ]

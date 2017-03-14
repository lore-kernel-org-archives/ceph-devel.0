From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Can't compile because of -lpthreads
Date: Tue, 14 Mar 2017 16:03:23 +0530
Message-ID: <CAAXqJ+qjr5WaaR4MmanVLyd_PdWC0=8CYYP0dyTBkrEvXF4ofA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:34061 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdCNKdZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 06:33:25 -0400
Received: by mail-ot0-f182.google.com with SMTP id o24so130389915otb.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 03:33:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: kchai@redhat.com, amaredia@redhat.com, dang@fprintf.net, matt@linuxbox.com

Hey everyone,

I am interested in contributing to Ceph and thus I tried to build the
source code but unfortunately it has some errors. I will list out the
steps I did:

 * Clone the ceph/ceph.git repo from github on my local machine
 * `./install_deps.sh`
 * `./do_cmake.sh`

Now the last command shows some errors. This[1] is the output of
CMakeError.log file
 while this[2]. I am using Ubuntu 16.04 LTS.

The particular problem is that my system can't recognise `-lpthreads`
but it recognises `-pthread` and `-lpthread`. I had tried a lot to
search this on the internet and also tried out all the stuff described
in the stackoverflow results but all in vain. I am familiar with
Makefiles but not so familiar with CMake files and thus couldn't
really find a solution. I would be really glad if someone could help!

Cc'ing some people who have worked with CMakeLists.txt

[1]: http://paste.ubuntu.com/24175792/
[2]: http://paste.ubuntu.com/24175794/

-- 
Spandan Kumar Sahu

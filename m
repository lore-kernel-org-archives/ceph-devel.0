From: kefu chai <tchaikov@gmail.com>
Subject: bump librados' soversion
Date: Wed, 9 Nov 2016 14:16:25 +0800
Message-ID: <CAJE9aOMoOJSccnXA=gCxuO3KN+0fziF3mRhMxBcF3dy4tmwy9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33843 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbcKIGQ0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 01:16:26 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so245093117qke.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 22:16:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, dillaman@redhat.com

hi cephers,

i am proposing bumping the soversion of librados2 to librados3. as in
053bfa6[0], we changed the function signature of
ceph::buffer::list::advance(), which is incompatible with the prior
version of librados. that's partially why we have
http://tracker.ceph.com/issues/17809, in which, the old librbd client
fails to start, due to unresolved symbols.

and if user has some (homebrew) packages depending on librados2. those
packages will be broken as well. the same applies to executables
linked against librados2 shared library. so we need to bump the
soversion. but to minimize the impact, i think we will not introduce
incompatible changes between major releases, in other words, the
soversion won't change from jewel to kraken, for example. if i
understand sage's comment correctly.

yes, i knew this issue was raised before from time to time. but maybe
this is a good chance to do the soversion change in kraken.

a PR is posted to address this problem. see
https://github.com/ceph/ceph/pull/11843.

--
[0] https://github.com/ceph/ceph/pull/9395/commits/053bfa650ba1d656dfb20e389ef25afc4c383bb3
[1] https://github.com/ceph/ceph/pull/9395#issuecomment-224278945

-- 
Regards
Kefu Chai

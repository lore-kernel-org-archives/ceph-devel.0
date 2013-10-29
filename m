From: Noah Watkins <noah.watkins@inktank.com>
Subject: feedback on supporting libc++
Date: Tue, 29 Oct 2013 15:51:36 -0700
Message-ID: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:52694 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3J2Wvg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Oct 2013 18:51:36 -0400
Received: by mail-qa0-f50.google.com with SMTP id cm18so434993qab.16
        for <ceph-devel@vger.kernel.org>; Tue, 29 Oct 2013 15:51:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

Out of the box on OSX Mavericks libc++ [1] is being used as opposed to
libstdc++. One of the issues is that stuff from tr1 isn't available
(e.g. std::tr1::shared_ptr), as they have moved to std in c++11.

I'm looking for any feedback on this patch set, or if there is a
better way forward.

A set of patches on ceph.git:wip-libc++ [2] adds initial support (with
a couple temporary hacks). These patches are very similar to the
method used to support libc++ in mongodb.

Summary of changes:

  std::tr1::shared/weak_ptr maps to ceph::shared/weak_ptr

  hash_map/set maps to ceph::unordered_map/set

which will choose tr1::unordered_map/set over ext/hash_map/set.

[1] http://libcxx.llvm.org/
[2] https://github.com/ceph/ceph/compare/wip-libc%2B%2B

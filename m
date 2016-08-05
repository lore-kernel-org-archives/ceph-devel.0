From: kefu chai <tchaikov@gmail.com>
Subject: gcc-6 is c++14 by default, and hammer does not like it
Date: Fri, 5 Aug 2016 22:05:51 +0800
Message-ID: <CAJE9aOPoceT-SGM7ANLqtnaF6T8PUcEJJqwefx7BQj7N3A=i4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36749 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759711AbcHEOFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 10:05:53 -0400
Received: by mail-qt0-f170.google.com with SMTP id 52so174538190qtq.3
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 07:05:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hey cephers,

just a heads up, for those who are using the bleeding edge
compiler[1], hammer does not compile by default.

i took a while to figure it out tonight. and seems the packaged
liboost is now compiled using gcc6 with C++14 enabled, so the headers
are found, but the source does not link with some libboost libraries
if you pass 'CXXFLAGS=-std=c++98' to configure. and moreover, seems
libstdc++ does not play well with hammer, i didn't root cause this.

at last, i cowardly used gcc-5 to compile hammer.

---
[1] https://gcc.gnu.org/gcc-6/changes.html

-- 
Regards
Kefu Chai

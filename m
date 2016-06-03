From: kefu chai <tchaikov@gmail.com>
Subject: Shall we remove static libraries from *-dev debian pacakges?
Date: Sat, 4 Jun 2016 01:10:55 +0800
Message-ID: <CAJE9aOMma9roYzaTnPE7WdSf4s93QDqTvy6N87YcMgRuyQiR4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34737 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905AbcFCRK5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 13:10:57 -0400
Received: by mail-yw0-f178.google.com with SMTP id c127so86173493ywb.1
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2016 10:10:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Cephers,

As your know, we are trying to ditch autotools and moving to the cmake
building system. Currently, we ship both static (.a) and shared
libraries (.so) and their .la files in
lib{rbd,rgw,rados,cephfs,radosstriper}-dev debian packages, but only
package the shared libraries in rpm packages. When working on the
cmake, I find it's a little bit tricky to prepare both static and
shared libraries in cmake, see [1].

So questions:

- Is it fine if we don't ship static libraries any more in the *-dev
.deb packages just like .rpms?
- What about the .la files? can we remove them also when switching to cmake?


Thanks in advance,

---
[1] https://github.com/ceph/ceph/pull/9446/commits/1a5ba13d9071c5d37f5955667828ede99744fa6a



-- 
Regards
Kefu Chai

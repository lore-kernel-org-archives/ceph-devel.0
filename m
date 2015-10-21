From: Luis Periquito <periquito@gmail.com>
Subject: rgw with keystone v3
Date: Wed, 21 Oct 2015 15:01:54 +0100
Message-ID: <CACx0BdO67Z=La43JS7Zz_3JkF4VooeWVQU3WdiTyp2AkaMsmtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33864 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJUOBz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2015 10:01:55 -0400
Received: by igbxf8 with SMTP id xf8so5449944igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 07:01:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I've created a merge request in github (Rgw keystone v3 #6337) to add
integration with keystone auth v3 to ceph rgw.

We've tested the best we could, and it does seem to work as it should.

There are some notes on the merge request.

I don't know what's the usual testing process, but we would like, if
possible, to have some binaries built to make further tests - to
ensure that we're not suffering from some compiling/copying issues.

PS: sorry for any mistakes with the process. This is my first time
doing such a thing.

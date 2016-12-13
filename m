From: Wido den Hollander <wido@42on.com>
Subject: gmock issues when switching Git branches
Date: Tue, 13 Dec 2016 12:51:42 +0100 (CET)
Message-ID: <1172024124.4367.1481629902991@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:45934 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbcLMLvu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 06:51:50 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id F1A623FC2C
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 12:51:43 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I've been seeing this multiple times when switching Git branches on git Git repo:

wido@wido-desktop:~/repos/ceph$ git branch
  firefly
  hammer
  jewel
* master
wido@wido-desktop:~/repos/ceph$ git checkout jewel
error: Updating the following directories would lose untracked files in it:
	src/gmock

Aborting
wido@wido-desktop:~/repos/ceph$

The gmock submodule is often preventing me from switching branches.

Since I don't work with Git submodules that much I usually end up removing the directory and going a submodule update.

Is that the good way to go? And am I the only one running into this?

Wido

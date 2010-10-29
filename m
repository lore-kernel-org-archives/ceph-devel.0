From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: mds getattr locked again
Date: Fri, 29 Oct 2010 12:13:58 +0800
Message-ID: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40271 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab0J2EN7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 00:13:59 -0400
Received: by qwf7 with SMTP id 7so1922342qwf.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Oct 2010 21:13:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

getattr on mds hanged again.

I have already reverted d91f2438d881514e4a923fd786dbd94b764a9440.
Although the probability is significant lowered down, it still has the
chance to hang on getattr.

Attached are the logs of mds and the hanging client. :(

I'm using ceph-client-standalone master-backport branch on 2.6.32 kernel.

Henry

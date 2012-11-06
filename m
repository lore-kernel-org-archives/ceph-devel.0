From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Tue, 6 Nov 2012 18:33:58 +0100
Message-ID: <CAJH6TXgcsi4QT+wKtGqjrCYF1M8Ruar9LaJ1Z7_3yQct3t1SkQ@mail.gmail.com>
References: <50993755.8060800@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:32945 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2KFRd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 12:33:59 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so267445eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 09:33:58 -0800 (PST)
In-Reply-To: <50993755.8060800@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

2012/11/6 Oliver Francke <Oliver.Francke@filoo.de>:
> 2012-11-06 17:05:51.863921 7f5cc52e3780  0 filestore(/data/osd6-3) mount
> syncfs(2) syscall not support by glibc
> 2012-11-06 17:05:51.863925 7f5cc52e3780  0 filestore(/data/osd6-3) mount no
> syncfs(2), must use sync(2).

Could you please try to run "ldd --version" and test if "man syncfs"
is working ?

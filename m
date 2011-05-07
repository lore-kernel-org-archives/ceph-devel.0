From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: rados_sync
Date: Fri, 6 May 2011 17:55:47 -0700
Message-ID: <BANLkTinYrgfB0fxMyEMxdA4+2Uo4RaW7zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42013 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab1EGAzs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 20:55:48 -0400
Received: by fxm17 with SMTP id 17so2680791fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2011 17:55:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I implemented a handy tool called rados_sync. It can be used to back
up all the items in a rados pool to a directory on disk.

It correctly handles object names which contain slashes or which are
too long to fit in a normal file. Extended attributes in rados are
stored as extended attributes on the local files.

Only things which have changed are transferred-- objects which have
the same size and modification time will not be re-downloaded or
re-uploaded. If only extended attributes have changed, only they will
be resent.

P.S.

Have a good weekend, all.

Colin.

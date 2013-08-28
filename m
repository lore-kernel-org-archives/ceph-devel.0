From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Questions about mds locks
Date: Thu, 29 Aug 2013 07:41:21 +0800
Message-ID: <CAMm-wcJ13NDMXfNymURbgaHvGF42Py2fKJHSSAwBLs=Qif3_8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:56949 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3H1XlW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 19:41:22 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so8589491oah.23
        for <ceph-devel@vger.kernel.org>; Wed, 28 Aug 2013 16:41:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello, everyone.

I have some questions about mds locks. I search google and read almost
all Sage's papers, but I found no details about mds locks.  :(

1, There are three classes about locks in mds: SimpleLock, ScatterLock
and LocalLock which are used for different lock items such as
CDentry.lock, CInode.authlock. What is the difference among the three
classes? or which situation they are used for?

2, There are 13 kinds of locks defined in ceph_fs.h:
CEPH_LOCK_DVERSION to CEPH_LOCK_IPOLICY, according to them there are
13 kinds of lock items,: two in CDentry and 11 in CInode. I think they
are used to lock different zone of their parent (CDentry or CInode).
Is that right? And which zone they locks?

2, Each lock item have 38 states which is defined in locks.h and
organized by 4 state machines. Is there any documents described these
states and state machines? Many states look the same, such as
LOCK_LOCK and LOCK_EXCL, What is their difference? Or under what
condition, the state changes?

3, Each lock item can get rdlocks, wrlocks, xlocks and maybe
remote_wrlocks. It seems that the life cycle of rdlocks, wrlocks and
xlocks is the same as a MDRequest, is that right? What is the
difference between these kinds of locks and the states(LOCK_SYNC,
LOCK_LOCK ,....)?

I have read the codes about mds locks for almost one week, but I think
I missed some key designs or ideas, so the codes is quite hard to
understand for me.

Thanks for any help.

-- 
Dong Yuan
Email:yuandong1222@gmail.com

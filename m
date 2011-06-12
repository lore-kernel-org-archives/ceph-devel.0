From: Simon Tian <aixt2006@gmail.com>
Subject: snapshot of rbd
Date: Sun, 12 Jun 2011 22:02:31 +0800
Message-ID: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39098 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FLOCc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jun 2011 10:02:32 -0400
Received: by wwa36 with SMTP id 36so4099284wwa.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 07:02:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi guys,

    I have some questions about librbd snapshot:

  int snap_create(const char *snapname);
  int snap_remove(const char *snapname);
  int snap_rollback(const char *snap_name);
  int snap_set(const char *snap_name);

  int copy(IoCtx& src_io_ctx, const char *srcname, IoCtx& dest_io_ctx,
const char *destname);

If I create a snapshot S1, and then write 10GB data, and then I want
to create a snapshot S2. About how long time will the "snap_create"
take?  May take just several seconds?
And how long will it task when remove S2?
How long when rollback to S1?
How long when set to S1?

When I open snapshot S2 as an io_ctx, and copy it with the copy
interface, how long time will it spent?

Thx very much!
Simon

From: Jaze Lee <jazeltq@gmail.com>
Subject: ceph watch/notify
Date: Wed, 26 Oct 2016 18:34:57 +0800
Message-ID: <CAKZcxgdqeFzTFQmESLrvhoBXJFE4TWaaD10gc0qw923Xc1aTRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37734 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753803AbcJZKnG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 06:43:06 -0400
Received: by mail-it0-f54.google.com with SMTP id u205so23603514itc.0
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 03:43:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all
  When the notify payload of snap create is sent to watchers. Only the excl=
usive
locker owner can send snap create request to osd. But here
https://github.com/ceph/ceph/blob/master/src/librbd/ImageWatcher.cc#L819
It is not estimate whether it is owner.  I do not why, can someone explain
more about this? Thanks.

May be i miss something? Or i do not understand it correctly.
Thanks a lot.



template <typename I>
bool ImageWatcher<I>::handle_payload(const SnapCreatePayload &payload,
            C_NotifyAck *ack_ctx) {
  RWLock::RLocker l(m_image_ctx.owner_lock);
  if (m_image_ctx.exclusive_lock !=3D nullptr) {// here.....
    int r;
    if (m_image_ctx.exclusive_lock->accept_requests(&r)) {
      ldout(m_image_ctx.cct, 10) << this << " remote snap_create request: "
        << payload.snap_name << dendl;

      m_image_ctx.operations->execute_snap_create(payload.snap_name,
                                                  new
C_ResponseMessage(ack_ctx),
                                                  0, false);
      return false;
    } else if (r < 0) {
      ::encode(ResponseMessage(r), ack_ctx->out);
    }
  }
  return true;
}








--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90

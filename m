From: na an <luckyfirea@gmail.com>
Subject: about clientreplay with lots of clients
Date: Thu, 14 Jul 2011 16:25:56 +0800
Message-ID: <CAKbx_ij_vMEfz88UQXHUa5Kyp83ZRG0pjswm-6YL4q4XZU16FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37666 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1GNIZ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 04:25:57 -0400
Received: by gxk21 with SMTP id 21so7650gxk.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 01:25:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all:

      when MDS is to restart , it will replay journal, and client will
replay 'unsafe requests' that have replyed from that MDS while the
metadata change maybe have not been writen to disk actually.
      I have a question that if there are many clients, how ceph keeps
consistence? because multiple clients may operate on the same file,
just like one to create a file and another to delete it.
      And how the ceph deal with such a situation that one or more
clients fail in the process of clientsreplay ? once it happen, the
whole system may be untrusty.
      if we have hundreds and thousands of clients , does it may take
a long time to recover?

From: kefu chai <tchaikov@gmail.com>
Subject: librados3
Date: Thu, 19 Oct 2017 17:25:27 +0800
Message-ID: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:52053 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdJSJZ2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 05:25:28 -0400
Received: by mail-oi0-f52.google.com with SMTP id j126so13444309oib.8
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 02:25:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

in luminous, we introduced a change not backward compatible with
pre-luminous librados. see see http://tracker.ceph.com/issues/21573.
and i cannot see an obvious solution without bumping up the so version
of librados to 3.

if we have the luxury to do it,  we will be able to give librados an
overhaul. for a todo list, see http://pad.ceph.com/p/librados3.

what do you think?

-- 
Regards
Kefu Chai

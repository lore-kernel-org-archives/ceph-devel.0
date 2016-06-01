From: Samuel Just <sjust@redhat.com>
Subject: sortbitwise
Date: Wed, 1 Jun 2016 15:47:51 -0700
Message-ID: <CAN=+7FVAAMZSeZDDeUdqt_cA7TR50jLWCnyh0ZjXXFrYzMNkBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33060 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcFAWrw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 18:47:52 -0400
Received: by mail-qk0-f172.google.com with SMTP id n63so26392401qkf.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 15:47:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weinstein, Yuri" <yweinste@redhat.com>, "Weil, Sage" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think the hammer-x tests aren't setting sortbitwise at all.  At
least, I don't see it in the yamls.
-Sam

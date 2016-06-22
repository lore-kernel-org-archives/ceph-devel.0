From: Samuel Just <sjust@redhat.com>
Subject: thrash thread hang in tests
Date: Wed, 22 Jun 2016 10:51:21 -0700
Message-ID: <CAN=+7FURg2W99mFuy=FdbN61EzaY8sWMvvLryaF7jbRdtAsSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32886 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbcFVRvX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 13:51:23 -0400
Received: by mail-qk0-f182.google.com with SMTP id a186so75421940qkf.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 10:51:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zafman, David" <dzafman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/16331 is showing up reliably in tests,
can you take a look?
-Sam

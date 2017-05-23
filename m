From: Jos Collin <jcollin@redhat.com>
Subject: Re: How to initiate tests in jenkins.
Date: Tue, 23 May 2017 09:50:27 +0530
Message-ID: <22176efb-d2f4-a209-4df4-4bfa196c10c2@redhat.com>
References: <CAGvpcHYotA=9gb8d2OAcOVBrnx5+zOQ_np8M4Dkk6UiWNQJtow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33352 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbdEWEUb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 00:20:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so101717041pfh.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 21:20:31 -0700 (PDT)
In-Reply-To: <CAGvpcHYotA=9gb8d2OAcOVBrnx5+zOQ_np8M4Dkk6UiWNQJtow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Myna V <mynaramana@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Please see the comment of liewegas in your PR. That will do.
But before doing that make sure that the errors are not introduced by 
your changes.

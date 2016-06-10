From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: increase default debug level
Date: Fri, 10 Jun 2016 10:47:40 -0700
Message-ID: <CAKPXa=biYbvnupYKdTcQRBfAiK2e8HNBqbrvQ15VtEZg99fWrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34731 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbcFJRro (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 13:47:44 -0400
Received: by mail-oi0-f45.google.com with SMTP id d132so19697339oig.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 10:47:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I am trying to check if it makes sense to set the default ceph debug
level for daemons to something higher from the current levels, this
might cause huge log files but with log rotate and size restrictions
it can be still be at a manageable levels,  Setting higher debug
output will save time when there is an hard to recreate issue and the
logs generated first time would provide more info for root cause.

for example:

debug osd = 20
debug filestore = 20
debug ms = 1


Regards
Vasu

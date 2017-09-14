From: Two Spirit <twospirit6905@gmail.com>
Subject: request improve online mds help
Date: Thu, 14 Sep 2017 13:31:51 -0700
Message-ID: <CAKRxpuu9Wn9eS4hBQ4BwSHc_TMY6G9hWH7mCYROvsEhgs16sDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:46935 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdINUbw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 16:31:52 -0400
Received: by mail-it0-f48.google.com with SMTP id 6so1231072itl.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 13:31:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

$ ceph mds ?

mds rmfailed <who> {<confirm>}
mds repaired <rank>

I thought the <who> was the id since the next line said <rank>, so I
concluded <who> != <rank>

It is my understanding that this is more correct:

mds rmfailed <rank> {<confirm>}
mds repaired <rank>

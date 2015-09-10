From: =?UTF-8?B?556/5aSp5ZaE?= <qutianshan@gmail.com>
Subject: A new rados api set_client_priority
Date: Thu, 10 Sep 2015 17:43:20 +0800
Message-ID: <CAEv+sP6jsqAitvGnWxbtZdcFtof2V7NB_C583w2JZnOjf7T4EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34764 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbIJJnV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 05:43:21 -0400
Received: by ykdg206 with SMTP id g206so51349274ykd.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2015 02:43:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
  I'm working on the topic
<http://tracker.ceph.com/projects/ceph/wiki/Messenger_-_priorities_for_Client>
, first step I add a new rados api set_client_priority, then I will do
more test to get the idea of how to balance the performance.
   code is in the pr <https://github.com/ceph/ceph/pull/5602>,
originally client read the config to get priority.
   Is the api ok?

Thanks

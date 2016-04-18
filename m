From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Few EC related questions
Date: Mon, 18 Apr 2016 20:00:22 +0530
Message-ID: <CAOu2ZZUAbZxYSMdqQ-cx+WopK8DOE7WUFiqWF2tRDpZMYf2xqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32956 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcDROaX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 10:30:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id y144so25070927wmd.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 07:30:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Loic Dachary <loic@dachary.org>

Hi

I have few questions (also posted on cep-users) on EC pool. I will be
highly obliged if you can help out.

1) Is there any disadvantage of storing small objects (< 1MB) in an EC
pool as opposed to large objects?

2) Is it possible to append to objects in EC pool if the objects are
of random sizes?

3) Do you see any disadvantage of storing striped objects in an EC pool.

Thanks

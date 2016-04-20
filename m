From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Mojette based Erasure Code is more performant than ISA-L or Jerasure
Date: Wed, 20 Apr 2016 14:22:30 +0530
Message-ID: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38089 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbcDTIwc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2016 04:52:32 -0400
Received: by mail-wm0-f44.google.com with SMTP id u206so69378429wme.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2016 01:52:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

The authors of  Mojette Erasure Encoding claim that this EC has higher
performance than ISA-L and Jerasure and can be used for hot storage
use cases. Their EC is used in open source RozoFS. What is your
evaluation of it? It will be nice if it is available as another EC
plugin.

Regards
Chandan

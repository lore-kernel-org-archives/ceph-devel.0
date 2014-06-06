From: zou wonder <wonder.zou@gmail.com>
Subject: What the ceph do when detecting one OSD overloaded?
Date: Fri, 6 Jun 2014 16:14:16 +0800
Message-ID: <CAOXjUBxhgB4L7PNdAcYhbFx8LCvW8eJ7Qj1vRbYn=aCfjGroBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47094 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaFFIOS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 04:14:18 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so1274102lbj.38
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jun 2014 01:14:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi buddies,

  I am doing investigation on Ceph and Swift,and I am newbie to Ceph.

I am unclear to the behaviour of the Ceph when there is overload situation.
According to the doc, when Ceph do CRUSH, if it find the OSD is overload,
it will skip it to select the other OSD. It means if the OSD don't get
overloaded
the object should be put in this OSD. So how about the original on put on
this OSD when it is not get overloaded?
Can we read it ? When doing CRUSH , the OSD will be skip.

If my understanding is wrong, please correct me.

Best Regards,
zou

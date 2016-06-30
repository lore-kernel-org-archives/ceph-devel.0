From: RomanS <execooler@gmail.com>
Subject: The newbie questions
Date: Fri, 1 Jul 2016 00:15:02 +0300
Message-ID: <CALBCzHe0gCiv_YR-2k5ywk24+pHKiunHbjvKrLV9EwsqZsxT3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37328 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcF3VPF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 17:15:05 -0400
Received: by mail-wm0-f42.google.com with SMTP id a66so3254775wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2016 14:15:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello.

I'm not sure that this list is correct to ask the following question.
It would be nice to understand the architecture of Ceph. To do this i
want to find answers for the following questions:

1. Ceph supports 2 types of scrubbing. To do check need to calculate
something and compare the result and the previously stored value. If i
understand correctly Ceph uses crc32. Where the value is stored?

2. Where can i read (in details) about data placement (structure)? only sources?

3. I tried to find information about behavior of Ceph in case of
failures?  For example I put a data to Ceph. Placement logic has done
its work and we know where need to place the data. We send data to
primary OSD and it resend the data to the secondary OSDs. At some
point a primary OSD fails. What next? Need to call CRUSH again?

4. What is the minimal structure of data in Ceph? object or object-chunk?

5. Where object-metadata is stored? as a separate metadata-object or
as a part of object structure?

Thanks.

From: Abhishek Dixit <dixitabhi@gmail.com>
Subject: Added Transaction Id in response
Date: Tue, 7 Apr 2015 23:12:26 +0530
Message-ID: <CAGoDY9ndCkcPdP6u9ddXoyLaV_-ZGTrm1u1HPtWjqL7P6nd1UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33634 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbDGRms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 13:42:48 -0400
Received: by layy10 with SMTP id y10so47919223lay.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Apr 2015 10:42:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, rzarzynski@mirantis.com, ZHOU Yuan <dunk007@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I have added Transaction Id in both S3 and swift response.
S3 will have id in x-amz-request-id header and Swift have X-Trans-Id header.
For S3, id is concatenation of gateway id and request id.
Swift will have additional timestamp appended in human readable format.

I have created pull request for same.
https://github.com/ceph/ceph/pull/4277

Thanks
Abhishek Dixit

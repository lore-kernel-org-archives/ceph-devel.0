From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Duplicate bucket creation Response in RGW
Date: Thu, 11 Jun 2015 14:22:56 -0700
Message-ID: <CAFMfnwqsxGyQSE64G6_MsQMdN5PD-yoBsfrujpKxXj2zOQUUsA@mail.gmail.com>
References: <CAPRac-a9gp1B9J3L-_TjkkP3-M9ZkvF-HwQ505NvJaqhEC392w@mail.gmail.com>
	<1875013920.12639009.1433959710332.JavaMail.zimbra@redhat.com>
	<CAPRac-b9O0Dx4mGnMDfe5NjW5gGmAqp7zN6k9DcTdceHK5AS8Q@mail.gmail.com>
	<1688384556.13183297.1434040012831.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:34804 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbbFKVW5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 17:22:57 -0400
Received: by yhid80 with SMTP id d80so6970759yhi.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2015 14:22:56 -0700 (PDT)
In-Reply-To: <1688384556.13183297.1434040012831.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Harshal Gupta <harshal.gupta001@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

> I don't see a compelling reason why to change our current behaviour. The fact that Amazon itself is inconsistent makes me think that it just an artifact of their architecture, rather than a carefully designed api.

Interesting.. if we look at the Amazon S3 FAQ we can understand the
differences in API responses:

"Q: What data consistency model does Amazon S3 employ?

Amazon S3 buckets in the US Standard region provide eventual
consistency. Amazon S3 buckets in all other regions provide
read-after-write consistency for PUTS of new objects and eventual
consistency for overwrite PUTS and DELETES."

If we consider buckets in our implementation to be eventually
consistent, we should probably return 200. If we can provide
read-after-write consistency, then we should probably return 209.

-- 

Kyle

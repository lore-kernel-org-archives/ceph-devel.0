From: Joel Cooklin <joel.cooklin@gmail.com>
Subject: Testing 3rd party integration with ceph object storag
Date: Tue, 4 Feb 2014 07:32:29 -0700
Message-ID: <CA+k2-NmsGVaSBjerdPUNy-GnFX7Jf-C4=B1526URwQw_AQTmzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:36980 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaBDOcb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 09:32:31 -0500
Received: by mail-we0-f176.google.com with SMTP id q58so4233359wes.35
        for <ceph-devel@vger.kernel.org>; Tue, 04 Feb 2014 06:32:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Folks,

I hope this is the right forum.  I am evaluating S3QL
(http://www.rath.org/s3ql-docs/about.html) and have run into issues
with it when attempting to connect to our Ceph based object storage.
The issue described here
(https://bitbucket.org/nikratio/s3ql/issue/26/doesnt-work-with-cephs-swift-impl)
has been reported to the developer but at this point he needs the
service exposed so that he can investigate further and unfortunately I
cannot expose our instance to him.  Is there a solution that someone
on this list can suggest or provide?  Is there an integration
environment for 3rd parties that want to integrate with Ceph that he
could get access to?

Thanks,
Joel

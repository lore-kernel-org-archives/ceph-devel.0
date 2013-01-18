From: Cesar Mello <cmello@gmail.com>
Subject: ListBuckets works but PutObject not
Date: Fri, 18 Jan 2013 10:05:08 -0200
Message-ID: <CAJVE5RWovpnsdwy6nt3d6UFiqo-+bLAFPCEPk=+hkjdOFgLzMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:53750 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3ARMFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 07:05:09 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so3807183lab.38
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 04:05:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Just in case someone sees some obvious mistake of mine...

I have setup an S3 gateway and it seems to be running fine. I'm trying
the samples from the API documentation for C# [1]. The connection and
authentication is working successfully. The ListBuckets sample works
and the response is OK. But when I try the PutBucket sample, the SDK
times out after 3 retries.

I'll keep investigating, but any suggestion is welcome.

Thank you a lot for the attention.

Best regards
Cesar

[1] http://ceph.com/docs/master/radosgw/s3/csharp/

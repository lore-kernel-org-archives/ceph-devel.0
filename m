From: Guang Yang <guangyy@gmail.com>
Subject: Re: Symbolic links like feature on radosgw
Date: Mon, 2 Nov 2015 21:25:31 -0800
Message-ID: <CAKtk8he19oYaEC9op5PFj6mRaA0jqQ5eFe2rRkj2JMV-E29AhQ@mail.gmail.com>
References: <CAKtk8hcvWJmdYmY20ZQsUuE=ww+Q=pDv6=HRVJhZ6Hk01U3wSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35608 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbbKCFZc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Nov 2015 00:25:32 -0500
Received: by iofz202 with SMTP id z202so8674816iof.2
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 21:25:31 -0800 (PST)
In-Reply-To: <CAKtk8hcvWJmdYmY20ZQsUuE=ww+Q=pDv6=HRVJhZ6Hk01U3wSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>

Hi Yehuda,
We have a user requirement that needs symbolic link like feature on
radosgw - two object ids pointing to the same object (ideally it could
cross bucket, but same bucket is fine).

The closest feature on Amazon S3 I could find is [1], but not exact
the same, the one from Amazon S3 API was designed for static web site
hosting.

Is this a valid feature request we can put into radosgw? The way I am
thinking to implement is like symbolic link, the link object just
contains a pointer to the original object.

 [1] http://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html

 --
 Regards,
 Guang




-- 
--
Regards,
Guang

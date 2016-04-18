From: fangchen sun <sunspot0105@gmail.com>
Subject: The RGW create new bucket instance then delete it at every create
 bucket OP
Date: Mon, 18 Apr 2016 22:38:54 +0800
Message-ID: <CACepTxiZjEY2e+wbTMNOiuDyQJmG0WdmRbqQNBCeVPWa_gN4Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33457 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcDROiz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 10:38:55 -0400
Received: by mail-qk0-f173.google.com with SMTP id n63so45540597qkf.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 07:38:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear ALL,

I found a problem that the RGW create a new bucket instance and delete
the bucket instance at every create bucket OP.

http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html

According to the error code "BucketAlreadyOwnedByYou" from the above
link, shouldn't the RGW return directly or do nothing when recreate
the bucket?
Why do the RGW create a new bucket instance and delete it?

Thanks for the reply!
sunfch

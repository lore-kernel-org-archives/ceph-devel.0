From: Artur Molchanov <artur.molchanov@synesis.ru>
Subject: GET bucket policy response format
Date: Fri, 31 Mar 2017 14:35:15 +0300
Message-ID: <57e69661-958a-7a6f-6307-c37e41e72b9d@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36662 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbdCaLfS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Mar 2017 07:35:18 -0400
Received: by mail-wr0-f182.google.com with SMTP id w11so100798435wrc.3
        for <ceph-devel@vger.kernel.org>; Fri, 31 Mar 2017 04:35:17 -0700 (PDT)
Received: from [172.20.9.159] ([86.57.155.118])
        by smtp.gmail.com with ESMTPSA id m7sm2546065wmi.34.2017.03.31.04.35.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Mar 2017 04:35:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Request GET /{bucket}/?policy returns data in XML format. However, by AWS S3 API 
documentation response should be in JSON format.

"The response contains the (JSON) policy of the specified bucket."
http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETpolicy.html

This incompatibility, for example, makes Ansible module s3_bucket useless.

-- 
Artur

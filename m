From: Andrew Woodward <xarses@gmail.com>
Subject: CephX key/secret generation
Date: Wed, 15 Jul 2015 14:44:09 -0700
Message-ID: <CACEfbZhXSNp0_WxyX2mwSeg2rdEdYSfVbGDZsrHKqPvAGa7oBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33320 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbGOVoK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 17:44:10 -0400
Received: by iggp10 with SMTP id p10so267325igg.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2015 14:44:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi, I'm looking for help understanding how the cephx auth keys are
generated. I want to pre-create the keys for the cluster within my
deployment engine. It appears that we can use `ceph-athtool
--gen-print-key` in order to generate the keys and use them, however
the application runs inside a container and it seems silly to 150mb of
deps to get access to ceph-authtool.

Looking through the code at a basic level, I see that it's calling
some AES functions, however it quickly goes over my ability to read C.

Can some one go over the key construction requirements? Can we use any
string encoded with base64? Is the AES encoding needed? What is the
correct formula for the AES generation? It looks like the have the
same seed but I'm having problems reading it out of the code.

-- 
Andrew
Mirantis
Fuel community ambassador

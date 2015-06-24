From: Alphe Salas <asalas@kepler.cl>
Subject: ceph v0.94.2 source package comes without debian directory
Date: Wed, 24 Jun 2015 14:28:27 -0300
Message-ID: <558AE8BB.8030607@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34603 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbFXR2b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 13:28:31 -0400
Received: by qgev13 with SMTP id v13so16417729qge.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2015 10:28:30 -0700 (PDT)
Received: from [192.168.0.44] ([200.111.172.141])
        by mx.google.com with ESMTPSA id w67sm3445249qha.7.2015.06.24.10.28.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 10:28:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
debian directory is missing in the ceph 0.94.2 tar.gz file.
So dpkg-buildpackages doesn t work.
I tryed taking the debian directory from github repo and it doesn t go 
through  I don t get the debian built due to a weird error
I tryed taking the debian directory from v0.94.1 but same as previous
I get weird error.

Regards.
-- 
Alphe Salas
I.T ingeneer

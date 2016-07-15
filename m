From: Igor Fedotov <ifedotov@mirantis.com>
Subject: bluestore checksum enable/disable behavior
Date: Fri, 15 Jul 2016 14:37:55 +0300
Message-ID: <d25e0238-722d-b061-2ee9-126739f1c8f2@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33214 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbcGOLh7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jul 2016 07:37:59 -0400
Received: by mail-lf0-f41.google.com with SMTP id b199so86441193lfe.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jul 2016 04:37:58 -0700 (PDT)
Received: from [172.18.12.66] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id f3sm1800117lff.21.2016.07.15.04.37.55
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2016 04:37:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

During read regression testing I realized that one can't disable 
checksum verification on read if corresponding blob was created with 
csum verification enabled.

More detailed overview is below.

We have "bluestore csum" flag in ceph config that currently 
enables/disables csum generation for blob writing only. It appeared that 
this flag has no impact on the read request handling. During blob 
reading we simply check whether csum tag is attached for the blob and 
verify csum if it's there.

The question is if such behavior is OK or we need finer way to control 
csum verification on read?

I can see a couple of ways to improve that.

1) Use "bluestore csum" flag during the reading too.

2) Introduce another flag ("bluestore csum on read"?) to have explicit 
control on read handling. Thus we'll have independent control on both 
read and write.

The second way is more flexible but IMHO is an overkill hence I vote for 1).

Any thoughts?


Thanks,

Igor






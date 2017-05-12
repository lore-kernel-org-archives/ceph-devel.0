From: Loic Dachary <loic@dachary.org>
Subject: An algorithm to fix uneven CRUSH distributions in Ceph
Date: Fri, 12 May 2017 13:26:51 +0200
Message-ID: <66e67a16-9cb2-aa2c-cf81-fc66b03e16d8@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40639 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbdELL04 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 May 2017 07:26:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Pedro_L=c3=b3pez-Adeva?= <plopezadeva@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Pedro,

After significant testing I believe the algorithm described at http://dachary.org/?p=4055 works. I'll publish an implementation next week with python-crush[1]. There is however something I don't understand other than intuitively. Why does it converge in all cases ? The core of the algorithm is:

repeat while the distribution improves
         run a simulation
         lower the weight of the most overfilled device
         increase the weight of the most underfilled device

Which we can do because we can run a simulation with all the values. We always know the full set of values (PGs in the Ceph parlance but you can think of them as files) that are distributed to devices. The loss function is the sum of the absolute value of the difference between the expected distribution and the actual distribution for each device. The Kullback-Liebler divergence also works and has a fancier name but that does not seem to be better.

With a better understanding of why it works we may be able to come up with a faster faster implementation and get closer to the perfect distribution in some cases.

I'm curious to know what you think about that :-)

Cheers

[1] http://crush.readthedocs.io/
-- 
Loïc Dachary, Artisan Logiciel Libre

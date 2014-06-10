From: Alphe Salas Michels <asalas@kepler.cl>
Subject: rbd after removal still 10 TB used.
Date: Mon, 09 Jun 2014 20:46:34 -0400
Message-ID: <5396556A.8010908@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:51147 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbaFJAqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jun 2014 20:46:38 -0400
Received: by mail-qa0-f49.google.com with SMTP id w8so1597336qac.22
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jun 2014 17:46:37 -0700 (PDT)
Received: from [192.168.0.44] ([200.111.172.141])
        by mx.google.com with ESMTPSA id i9sm33083102qaq.14.2014.06.09.17.46.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 17:46:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
I have this issue to submit you.It is with ceph emperor version 0.72 i 
don t know if in firefly it is solved. I didnt see in the changelog any 
change to that issue.

First of all ceph is storage ogre. Let me explain. In an global 40TB 
disk the real data i can use is 40 TB /2 - 25% = around 15TB. But as I 
delete data and store new data I notice the replicas are never 
overwritten. logically a pg has its mirror and so if the pg is updated 
then the mirrored pg corresponding is updated too. or better said if a 
pg is overwritten with new data then its related pg mirror is 
overwritten too with that new data. Experience in real life shown to me 
that it is not the case. Simply pg are overwriten and a new pg mirror is 
created to contain the new data letting the old pg mirror remain. So as 
i delete and overwrite  data to my rbd image I notice the ever growing 
effect that lead to a forever pgs stuck to backfill osds. So slowly ceph 
is stopping to accept new data. More osd are in near_full ratio then 
full ratio.

Still after I do a rbd rm myimagename I notice that because some pgs 
where stuck to backfill then i still have 10 TB locked. Only way to 
retrieve that data is to completly clear the ceph cluster and reinstall 
a new version. I don t think most people using ceph will affort an ever 
growing ceph system, because yes beleive it or not new disks and new 
nodes have a cost, and that it is not  wise to have replicas that over 
match more than 3 times the data they backup on a replica = 2 environement.


At the time ceph is willing to extend it seems we are all oblivious to 
the core problems of ceph. No data triming no data replicas triming.

Probably triming data is ressource consuming. So we should have at least 
a "lets plan and do a trim for that day" possibility. The other way 
around would be to have a better replica management since that is where 
the problem is orginated.

Best regards

-------
Alphe Salas

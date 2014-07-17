From: Alphe Salas <asalas@kepler.cl>
Subject: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 10:11:09 -0400
Message-ID: <53C7D97D.3010607@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:55302 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbaGQOLN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 10:11:13 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so1918310qaq.27
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 07:11:12 -0700 (PDT)
Received: from [192.168.0.44] ([200.111.172.141])
        by mx.google.com with ESMTPSA id z11sm4655477qaz.45.2014.07.17.07.11.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 07:11:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
I would like to know if there is something planned to correct the 
"forever growing" effet when using rbd image.
My experience shows that the replicas of a rbd images are never 
discarded and never overwriten. Lets say my physical share is about 30 
TB I make an image of 13TB (half the real space - 25% of disfunction osd 
support). My experience shows that the rbd image is overwriten so if I 
top the 13TB once i get a 26TB of real space used (replicas set to 2) if 
I delete 8TB from those 13TB I see the real space used unchanged.
If I write back 4TB then ceph collapse it is nearfull and I have to go 
buy another 30TB integrate it to my cluster to hold the problem. But 
still soon I have in my ceph more useless replicas of "delete" datas 
than usefull data with they replicas.

Usually when I talk to dev team about this problem they tell me that the 
real problem is the lack of trim in XFS, but my own analysis shows that 
the real problem is ceph internal way to handle data. It is ceph that 
never discard any replicas and never "clean" itself to only keep records 
of the data in use.

If ceph was behaving properly then for a replicas set to 2 I would have 
my rbd image of 13 TB the 13TB replicas corresponding, and a fix 26TB
of overall used data. When I would "free" data in the rbd image the 
corresponding replicas would be considered as discarded by ceph and when 
the real data in the rbd image is overwriten their corresponding 
replicas would be overwriten too with the new data. That would show the 
overall data space used as fixed.

In case of the failure of 2 osd then the ceph system would have just 
enough space to clone the replicas of the missing data which actually is
not the case in a environement that reach near full state.



So my ask is what is planned to correct this problem?

Best regards,

-- 
Alphe Salas
I.T ingeneer

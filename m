From: norbi <norbi@rocknob.de>
Subject: How to compile rbd clients only ?
Date: Thu, 12 Jun 2014 15:55:16 +0200
Message-ID: <5399B144.5080304@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:41937 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbaFLOAz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jun 2014 10:00:55 -0400
Received: from [80.67.16.214] (helo=[192.168.10.165])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <norbi@rocknob.de>)
	id 1Wv5TI-0008Vp-0Y
	for ceph-devel@vger.kernel.org; Thu, 12 Jun 2014 15:55:16 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

which way is the best for compiling only the rbd binarys? My 
Ceph-Cluster is allready running, now i need client software to connect 
to the cluster, but i don't want to compile the hole ceph-binarys, 
because.. it doesn't work :)

is there a way to do "--without-all --with-clientsonly" ?

norbi

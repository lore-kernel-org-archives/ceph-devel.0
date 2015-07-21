From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: upstream/firefly exporting the same snap 2 times results in
 different exports
Date: Tue, 21 Jul 2015 10:32:44 -0400 (EDT)
Message-ID: <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com>
References: <55AE3B3A.2040902@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:42972 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbbGUOct (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 10:32:49 -0400
In-Reply-To: <55AE3B3A.2040902@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

Any chance that the snapshot was just created prior to the first export and you have a process actively writing to the image?

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
> From: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> To: ceph-devel@vger.kernel.org
> Sent: Tuesday, July 21, 2015 8:29:46 AM
> Subject: upstream/firefly exporting the same snap 2 times results in different exports
> 
> Hi,
> 
> i remember there was a bug before in ceph not sure in which release
> where exporting the same rbd snap multiple times results in different
> raw images.
> 
> Currently running upstream/firefly and i'm seeing the same again.
> 
> 
> # rbd export cephstor/disk-116@snap dump1
> # sleep 10
> # rbd export cephstor/disk-116@snap dump2
> 
> # md5sum -b dump*
> b89198f118de59b3aa832db1bfddaf8f *dump1
> f63ed9345ac2d5898483531e473772b1 *dump2
> 
> Can anybody help?
> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

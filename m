From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: upstream/firefly exporting the same snap 2 times results in
 different exports
Date: Tue, 21 Jul 2015 13:19:51 -0400 (EDT)
Message-ID: <1828157940.1473499.1437499191528.JavaMail.zimbra@redhat.com>
References: <55AE3B3A.2040902@profihost.ag> <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com> <55AE798F.1010206@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:55703 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbbGURTz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 13:19:55 -0400
In-Reply-To: <55AE798F.1010206@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

Does this still occur if you export the images to the console (i.e. "rbd export cephstor/disk-116@snap - > dump_file")?  

Would it be possible for you to provide logs from the two "rbd export" runs on your smallest VM image?  If so, please add the following to the "[client]" section of your ceph.conf:

  log file = /valid/path/to/logs/$name.$pid.log
  debug rbd = 20

I opened a ticket [1] where you can attach the logs (if they aren't too large).

[1] http://tracker.ceph.com/issues/12422

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
> From: "Stefan Priebe" <s.priebe@profihost.ag>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Tuesday, July 21, 2015 12:55:43 PM
> Subject: Re: upstream/firefly exporting the same snap 2 times results in different exports
> 
> 
> Am 21.07.2015 um 16:32 schrieb Jason Dillaman:
> > Any chance that the snapshot was just created prior to the first export and
> > you have a process actively writing to the image?
> >
> 
> Sadly not. I executed those commands exactly as i've posted manually at
> bash.
> 
> I can reproduce this at 5 different ceph cluster and 500 vms each.
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [ceph-users] Backups
Date: Sat, 16 Feb 2013 20:33:15 +0100
Message-ID: <511FDEFB.4070908@profihost.ag>
References: <CAJH6TXjWNmc15TZKEhyPbJ5HPKcL4EC_YBQsQtOfYJOYuk1S9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:40909 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab3BPTdN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 14:33:13 -0500
In-Reply-To: <CAJH6TXjWNmc15TZKEhyPbJ5HPKcL4EC_YBQsQtOfYJOYuk1S9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hi,

I think the bigges problem is that an incremental backup is missing in 
ceph for the rados object. So you can just copy / export the changes 
rados objects from an rbd volume instead the whole volume again and 
every day.

Greets,
Stefan
Am 16.02.2013 17:15, schrieb Gandalf Corvotempesta:
> Hi,
> let's assume a huge ceph clusters, with 300TB full of datas (rgw, rbd
> and the future cephfs)
> How will you manage backups of this cluster?
>
> Will snapshot be enough? For example, one snapshot per day should be
> allow me to revert or restore a single file from the previous day.
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

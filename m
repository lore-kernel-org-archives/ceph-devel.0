From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph mon failed to restart
Date: Thu, 3 Mar 2016 10:32:45 +0100
Message-ID: <56D804BD.1010806@suse.cz>
References: <CANA9Uk7foqUXQkbVBerBdHothy91CzohWeW+NfYMdtaTqHXwOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46404 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165AbcCCJcr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Mar 2016 04:32:47 -0500
In-Reply-To: <CANA9Uk7foqUXQkbVBerBdHothy91CzohWeW+NfYMdtaTqHXwOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 03/03/2016 09:30 AM, M Ranga Swami Reddy wrote:
> I have tried to restart the one of the ceph mon , got the below error:
> ==
>
> 2016-03-03 08:16:00.120355 7f43b067d7c0 -1 obtain_monmap unable to find a monmap
>
> 2016-03-03 08:16:00.120374 7f43b067d7c0 -1 unable to obtain a monmap:
> (2) No such file or directory
>
> 2016-03-03 08:16:00.124437 7f43b067d7c0 -1 mon.node-11@-1(probing) e0
> not in monmap and have been in a quorum before; must have been removed
>
> 2016-03-03 08:16:00.124715 7f43b067d7c0 -1 mon.node-11@-1(probing) e0
> commit suicide!
>
> 2016-03-03 08:16:00.124727 7f43b067d7c0 -1 failed to initialize
>
> failed: 'ulimit -n 32768;  /usr/bin/ceph-mon -i node-11 --pid-file
> /var/run/ceph/mon.node-11.pid -c /etc/ceph/ceph.conf --cluster ceph '
>
> Starting ceph-create-keys on node-11...
> ===
>
> Any hint appriciated...

Which Ceph version are you running?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037

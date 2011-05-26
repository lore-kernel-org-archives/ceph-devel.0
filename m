From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: cluster status information
Date: Thu, 26 May 2011 08:38:04 -0500
Message-ID: <9cfe71a1497bf3e0acf5d0550c02e78b@pl1.haspere.com>
References: <4DDE4531.6060703@ufm.su>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:48241 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454Ab1EZNiG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 09:38:06 -0400
In-Reply-To: <4DDE4531.6060703@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org



> Hi!
>
> How to get information about status of each server in cluster?
>
> #ceph osd stat
> 2011-05-26 15:07:05.103621 mon 'e413: 6 osds: 5 up, 5 in' (0)
>
> I see - in cluster 6 osd servers and now up only 5. How do I know 
> which
> server is down?

 # ceph osd dump -o -


>
> More global question - how to monitor the state of servers in a 
> cluster?
>

 # ceph -w


> WBR,
> Fyodor.
>
> P.S. JFYI: key "-s" do not described in manual page about ceph 
> command.


 Thanks,
 Dyweni


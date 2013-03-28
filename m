From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [ceph-users] Mon crash
Date: Thu, 28 Mar 2013 19:03:46 +0000
Message-ID: <51549412.4020707@inktank.com>
References: <515396F3.3030106@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:54539 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab3C1TES (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Mar 2013 15:04:18 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so3629373wib.15
        for <ceph-devel@vger.kernel.org>; Thu, 28 Mar 2013 12:04:17 -0700 (PDT)
In-Reply-To: <515396F3.3030106@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-users@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/28/2013 01:03 AM, Martin Mailand wrote:
> Hi,
>
> today one of my mons crashed, the log is here.
> http://pastebin.com/ugr1fMJR
>
> I think the most important part is:
> 2013-03-28 01:57:48.564647 7fac6c0ea700 -1
> auth/none/AuthNoneServiceHandler.h: In function 'virtual int
> AuthNoneServiceHandler::handle_request(ceph::buffer::list::iterator&,
> ceph::bufferlist&, uint64_t&, AuthCapsInfo&, uint64_t*)' thread
> 7fac6c0ea700 time 2013-03-28 01:57:48.563831
> auth/none/AuthNoneServiceHandler.h: 35: FAILED assert(0)
>
> In the log it is reported that osd.12 is down, but it is not.
>
>   ceph -s
>     health HEALTH_WARN 1 mons down, quorum 1,2 b,c
>     monmap e1: 3 mons at
> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
> election epoch 32, quorum 1,2 b,c
>     osdmap e133: 24 osds: 24 up, 24 in
>      pgmap v22454: 4800 pgs: 4800 active+clean; 23185 MB data, 49126 MB
> used, 174 TB / 174 TB avail
>     mdsmap e1: 0/0/1 up
>

Hi Martin,

As John said in his reply, these should be reported to ceph-devel (CC'ing).

Anyway, this is bug #4519 [1].  It was introduced after 0.58, released 
under 0.59 and is already fixed in master.  As far as we can tell, only 
when using auth none will anyone using 0.59 stumble upon it.

   -Joao

[1] - http://tracker.ceph.com/issues/4519


>
> -martin
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


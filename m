From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: excluding /var/lib/ceph in updatedb.conf
Date: Wed, 20 May 2015 17:09:12 -0600
Message-ID: <555D1418.8070801@redhat.com>
References: <555D0BC5.7030403@redhat.com> <CABZ+qq=s9P2UWCnvF09We3zn+AytRjj7KWLZ5oQDJVj=CKDBUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49538 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbbETXJO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 May 2015 19:09:14 -0400
In-Reply-To: <CABZ+qq=s9P2UWCnvF09We3zn+AytRjj7KWLZ5oQDJVj=CKDBUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Woah, and "Ken Dreyer" even commented on that Redmine ticket there, long
ago :)

I will take that ticket and run this down with Fedora now.
https://bugzilla.redhat.com/1223582

- Ken



On 05/20/2015 04:43 PM, Dan van der Ster wrote:
> Hi Ken,
> Not sure, here's what I could find:
> 
> The original thread:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-February/037446.html
> More discussion on ceph-devel:
> http://www.spinics.net/lists/ceph-devel/msg18098.html
> Eventually on your tracker: http://tracker.ceph.com/issues/7451
> Filed by Wido for Ubuntu:
> https://bugs.launchpad.net/ubuntu/+source/mlocate/+bug/1281074
> 
> I guess it never made it into Fedora trackers.
> 
> Cheers, Dan
> 
> 
> 
> On Wed, May 20, 2015 at 3:33 PM, Ken Dreyer <kdreyer@redhat.com
> <mailto:kdreyer@redhat.com>> wrote:
> 
>     Hi Dan,
> 
>     I watched your OpenStack Summit conference where you talked about
>     excluding /var/lib/ceph from /etc/updatedb.conf.
> 
>     Did you open any bugs for that? That change seems like something we
>     should get into the distros.
> 
>     - Ken
> 
> 


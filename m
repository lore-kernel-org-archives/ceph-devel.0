From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: getting ready for jewel 10.2.1
Date: Wed, 30 Mar 2016 11:47:38 -0700
Message-ID: <CAJ4mKGYg++sGuqHQPkNa1GrVeDO=KFZNtp4FTYX=zOkrAbnFeQ@mail.gmail.com>
References: <56FBAADF.3020407@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34913 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcC3Srk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 14:47:40 -0400
Received: by mail-vk0-f41.google.com with SMTP id e6so73267172vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 11:47:39 -0700 (PDT)
In-Reply-To: <56FBAADF.3020407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Mar 30, 2016 at 3:30 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Now is a good time to get ready for jewel 10.2.1 and I created http://tracker.ceph.com/issues/15317 for that purpose. The goal is to be able to run as many suites as possible on OpenStack, so that we do not have to wait days (sometime a week) for runs to complete on Sepia. Best case scenario, all OpenStack specific problems are fixed by the time 10.2.1 is being prepared. Worst case scenario there is no time to fix issues and we keep using the sepia lab. I guess we'll end up somewhere in the middle : some suites will run fine on Openstack and we'll use sepia for others.
>
> In a previous mail I voiced my concerns regarding the lack of interest of developers regarding teuthology job failures that are cause by variations in the infrastructure. I still have no clue how to convey my belief that it is important for teuthology jobs to succeed despite infrastructure variations. But instead of just giving up and do nothing, I will work on that for the rados suite and hope things will evolve in a good way. To be honest, figuring out http://tracker.ceph.com/issues/15236 and seeing a good run of the rados suite on jewel as a result renewed my motivation in that area :-)

I think you've convinced us all it's important in the abstract; that's
just very different from putting it on top of our list of priorities,
especially since we alleviated many of our needs in the sepia lab.
Beyond that, a lot of the issues we're seeing have very little to do
with Ceph itself, or even the testing programs, and that can make it
more difficult to get interested as we lack the necessary expertise. I
spent some time trying to get disk sizes and things matched up (and I
suddenly realize that never got merged), but some of the other odder
issues we're having:

http://tracker.ceph.com/issues/13980, in which we are failing to mount
anything with nfs v3. This is a config file that needs to get updated;
we do it for the sepia lab (probably in ansible?) but somehow that
information isn't getting into the ovh slaves. (Or else it is in
there, and there's something *else* broken.) If we are using a
separate setup regimen for OpenStack than we are in the sepia lab
there will be persistent breakage as new dependencies and
environmental expectations get added to one and not the other. :/

http://tracker.ceph.com/issues/13876, in which MPI is just failing to
get any connections going. Why? No idea; there's a teuthology commit
from you that's supposed to have opened up all the ports in the
firewall (and it sure *looks* like it does do that, but I don't know
how the rules work), but this works in sepia and inasmuch as we have
debugging info sure looks like some kind of network blockage...

So I think this isn't something that's going to get done properly
unless somebody gets assigned to just make everything work in all the
suites, who has the time to learn all the fiddly little bits. (Or we
somehow take a break for it as a project. But I don't see that going
well.) :/
-Greg

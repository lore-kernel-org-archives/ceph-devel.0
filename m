From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: getting ready for jewel 10.2.1
Date: Thu, 31 Mar 2016 12:01:53 -0700
Message-ID: <CAJ4mKGZHyR3m7LVRuqv5jw19sGCWTStX+Sfbj6AkZr5byrrN1A@mail.gmail.com>
References: <56FBAADF.3020407@dachary.org>
	<CAJ4mKGYg++sGuqHQPkNa1GrVeDO=KFZNtp4FTYX=zOkrAbnFeQ@mail.gmail.com>
	<56FD34AC.1030501@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35829 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbcCaTBy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 15:01:54 -0400
Received: by mail-vk0-f51.google.com with SMTP id e6so115365575vkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 12:01:53 -0700 (PDT)
In-Reply-To: <56FD34AC.1030501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 31, 2016 at 7:31 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Gregory,
>
> On 30/03/2016 20:47, Gregory Farnum wrote:
>> On Wed, Mar 30, 2016 at 3:30 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi,
>>>
>>> Now is a good time to get ready for jewel 10.2.1 and I created http://tracker.ceph.com/issues/15317 for that purpose. The goal is to be able to run as many suites as possible on OpenStack, so that we do not have to wait days (sometime a week) for runs to complete on Sepia. Best case scenario, all OpenStack specific problems are fixed by the time 10.2.1 is being prepared. Worst case scenario there is no time to fix issues and we keep using the sepia lab. I guess we'll end up somewhere in the middle : some suites will run fine on Openstack and we'll use sepia for others.
>>>
>>> In a previous mail I voiced my concerns regarding the lack of interest of developers regarding teuthology job failures that are cause by variations in the infrastructure. I still have no clue how to convey my belief that it is important for teuthology jobs to succeed despite infrastructure variations. But instead of just giving up and do nothing, I will work on that for the rados suite and hope things will evolve in a good way. To be honest, figuring out http://tracker.ceph.com/issues/15236 and seeing a good run of the rados suite on jewel as a result renewed my motivation in that area :-)
>>
>> I think you've convinced us all it's important in the abstract; that's
>> just very different from putting it on top of our list of priorities,
>> especially since we alleviated many of our needs in the sepia lab.
>> Beyond that, a lot of the issues we're seeing have very little to do
>> with Ceph itself, or even the testing programs, and that can make it
>> more difficult to get interested as we lack the necessary expertise. I
>> spent some time trying to get disk sizes and things matched up (and I
>> suddenly realize that never got merged), but some of the other odder
>> issues we're having:
>>
>> http://tracker.ceph.com/issues/13980, in which we are failing to mount
>> anything with nfs v3. This is a config file that needs to get updated;
>> we do it for the sepia lab (probably in ansible?) but somehow that
>> information isn't getting into the ovh slaves. (Or else it is in
>> there, and there's something *else* broken.) If we are using a
>> separate setup regimen for OpenStack than we are in the sepia lab
>> there will be persistent breakage as new dependencies and
>> environmental expectations get added to one and not the other. :/
>
> ceph-cm-ansible does not have any OpenStack specific instructions. It's supposed to work exactly the same on both sepia and OpenStack. When teuthology provisions an OpenStack target, it does so in the same way it provisions VPS in sepia. The only difference is that OpenStack uses images that come from http://cloud.centos.org/centos/7/images/ etc., unmodified. The VPS images have sometime been modified. However, this has only been an issue once, over six months ago.
>
> On OVH the UDP ports were firewalled, and that created the problem. I changed the firewall rules and I'm hopefull http://pulpito.ovh.sepia.ceph.com:8081/loic-2016-03-31_14:10:18-knfs-jewel-testing-basic-openstack/ will now pass.
>
>> http://tracker.ceph.com/issues/13876, in which MPI is just failing to
>> get any connections going. Why? No idea; there's a teuthology commit
>> from you that's supposed to have opened up all the ports in the
>> firewall (and it sure *looks* like it does do that, but I don't know
>> how the rules work), but this works in sepia and inasmuch as we have
>> debugging info sure looks like some kind of network blockage...
>
> I opened the required port on the OVH lab. I don't think there is an ansible rule that does it but I'll ask Zack to be sure.
>
>> So I think this isn't something that's going to get done properly
>> unless somebody gets assigned to just make everything work in all the
>> suites, who has the time to learn all the fiddly little bits. (Or we
>> somehow take a break for it as a project. But I don't see that going
>> well.) :/
>
> If you suspect an OpenStack specific problem, feel free to ping me. There is a good chance I can help and together we can make teuthology happy with OpenStack :-)

I really wasn't fishing with those, but hey! thanks so much for those fixes. :)

Do we have any way to automate those kinds of things for external
users? It sounds like right now these are just some random things any
third party needs to know to do, or their tests will mysteriously
fail?
-Greg

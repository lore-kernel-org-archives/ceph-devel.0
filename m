From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: jerasure packaging and Ceph
Date: Fri, 7 Aug 2015 14:09:17 -0600
Message-ID: <55C5106D.9070008@redhat.com>
References: <55C4EA1C.3080601@redhat.com> <55C506AF.4080309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43707 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946205AbbHGUJT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Aug 2015 16:09:19 -0400
In-Reply-To: <55C506AF.4080309@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/07/2015 01:27 PM, Loic Dachary wrote:
> Hi Ken,
> 
> On 07/08/2015 19:25, Ken Dreyer wrote:
>> Hi Loic,
>>
>> I was looking through Ceph's bundled libraries recently and I was
>> wondering why Ceph bundles its own copy of jerasure.
>>
>> Could you give some background on that? Why don't we link to an separate
>> system package?
> 
> Mainly because there is no proper non regression testing of the packages found in the distributions. It is absolutely critical for Ceph to ensure there is no regression because it would mean data loss. The packagers do not have that concern in mind right now, nor do they have the infrastructure to run non regression tests, to the best of my knowledge.
> 
> Even if they had non regression tests, whenever a new package is published, we would need to run Ceph integration tests before it lands in the distribution repositories to ensure that everything is fine from the Ceph perspective. The recent work with teuthology and OpenStack simplified this quite a lot and anyone can run teuthology now. However the level of coordination it would require between the jerasure packager and the ceph packager is far from what is going on currently.
> 
> I offered to package jerasure for Debian to solve that problem in the Debian / Ubuntu realm. I thought a first step to decouple ceph from jerasure could be that I care for jerasure because I have access to the test infrastructure and I understand what Ceph needs. And I could gradually make it possible for any packager to do the same, somehow (I have no idea how to do that, honestly). Unfortunately the person responsible for packaging jerasure did not respond favorably to my offer. Nor does he plan to implement integration or non regression tests.
> 
> Hopefully that will change in the future, but for now I think bundling jerasure with Ceph is the best way to preserve the data of our users.
> 

Hi Loic,

Thank you, that helps me understand the context a lot more.

It sounds like you're concerned that Debian might change their package
behind Ceph's back, and it could have implications for the way Ceph
stores its' data.

I guess at some level it's true that all of Ceph's dependencies could
impact its behavior.

I would like it if Teuthology ran with the "epel-testing" repository
enabled, for example, so we could catch these sort of problems before
they went into the main "epel" repo that most users consume. That
certainly would have caught some issues in the past with the conflicts
between EPEL and Firefly.

Is there some equivalent in Debian?

- Ken

From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Sat, 12 Oct 2013 07:20:19 -0400
Message-ID: <CAOGLoJNEtxyRoGV8sLpUMvgfiJxJ9UfDVs5yjN2yhY42z1OOFw@mail.gmail.com>
References: <52580F9B.3080607@dachary.org>
	<525816D8.3000609@dachary.org>
	<CAHX4EnM8C=wy+ixFQu5XJOGo6=6gW6NfkU6=oC7s66X0+UTbWQ@mail.gmail.com>
	<52581A06.2000706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:60084 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3JLLUU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Oct 2013 07:20:20 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so2374088ead.2
        for <ceph-devel@vger.kernel.org>; Sat, 12 Oct 2013 04:20:19 -0700 (PDT)
In-Reply-To: <52581A06.2000706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 11, 2013 at 11:32 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 11/10/2013 17:25, Darren Birkett wrote:
>> Hi Loic,
>>
>> I wonder is it also worth discussing the state of the 'official' chef cookbooks?
>>
>> https://github.com/ceph/ceph-cookbooks
>>
>> We're interested in these at Rackspace, since we already deploy OpenStack using our own chef cookbooks:
>>
>> https://github.com/rcbops/chef-cookbooks
>>
>> We plan on pulling in the ceph cookbooks for the rados cluster deployments, and we have some working POC code inside our other recipes to do the OpenStack specific config for RBD.
>>
>> - Darren
>
> I suspect there is a fragmentation of the work with Chef and probably Salt, Ansible etc. I've not done any research in this area though. Don't you think it deserves a separate discussion ?

At Bloomberg, we use Chef to build out our OpenStack/Ceph (and more!) clusters:

https://github.com/bloomberg/chef-bcpc

Cheers.  -- justin

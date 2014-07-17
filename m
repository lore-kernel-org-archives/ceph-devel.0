From: Wido den Hollander <wido@42on.com>
Subject: Re: [ceph-users] EU mirror now supports rsync
Date: Thu, 17 Jul 2014 11:21:07 +0200
Message-ID: <53C79583.6030103@42on.com>
References: <2069129717.8.1397023489379.open-xchange@websrv.42on.com> <3DEA146C-4659-4F9C-ACD2-8C536C056E3A@iweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:50068 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077AbaGQJ2s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jul 2014 05:28:48 -0400
In-Reply-To: <3DEA146C-4659-4F9C-ACD2-8C536C056E3A@iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Moreau Simard <dmsimard@iweb.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On 07/16/2014 09:48 PM, David Moreau Simard wrote:
> Hi,
>
> Thanks for making this available.
> I am currently synchronizing off of it and will make it available on our 4 Gbps mirror on the Canadian east coast by the end of this week.
>

Cool! More mirrors is always better.

> Are you able to share how you are synchronizing from the Ceph repositories ?
> It would probably be better for us to synchronize from the source rather than the Europe mirror.
>

I have a SSH account into the ceph.com server and use that to sync the 
packages. I've set this up the the community guys Ross and Patrick, you 
might want to ping them.

There is no official distribution mechanism for this right now. I simply 
set up a rsyncd to provide this the community.

Wido

> --
> David Moreau Simard
>
> On Apr 9, 2014, at 2:04 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Hi,
>>
>> I just enabled rsync on the eu.ceph.com mirror.
>>
>> eu.ceph.com mirrors from Ceph.com every 3 hours.
>>
>> Feel free to rsync all the contents to your local environment, might be useful
>> for some large deployments where you want to save external bandwidth by not
>> having each machine fetch the Deb/RPM packages from the internet.
>>
>> Rsync is available over IPv4 and IPv6, simply sync with this command:
>> $ mkdir cephmirror
>> $ rsync -avr --stats --progress eu.ceph.com::ceph cephmirror
>>
>> I ask you all to be gentle. It's a free service, so don't start hammering the
>> server by setting your Cron to sync every 5 minutes. Once every couple of hours
>> should be sufficient.
>>
>> Also, please don't all start syncing at the first minute of the hour. When
>> setting up the Cron, select a random minute from the hour. This way the load on
>> the system can be spread out.
>>
>> Should you have any questions or issues, let me know!
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


-- 
Wido den Hollander
Ceph consultant and trainer
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on

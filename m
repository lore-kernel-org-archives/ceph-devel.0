From: David Moreau Simard <dmsimard@iweb.com>
Subject: Re: [ceph-users] EU mirror now supports rsync
Date: Wed, 16 Jul 2014 19:48:03 +0000
Message-ID: <3DEA146C-4659-4F9C-ACD2-8C536C056E3A@iweb.com>
References: <2069129717.8.1397023489379.open-xchange@websrv.42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmx1.iweb.com ([70.38.127.135]:49228 "EHLO bmx1.iweb.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbaGPTsG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 15:48:06 -0400
In-Reply-To: <2069129717.8.1397023489379.open-xchange@websrv.42on.com>
Content-Language: en-US
Content-ID: <2EAAA25DE73AB24F9A89012C5FE797B8@corp.iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hi,

Thanks for making this available.
I am currently synchronizing off of it and will make it available on our 4 Gbps mirror on the Canadian east coast by the end of this week.

Are you able to share how you are synchronizing from the Ceph repositories ?
It would probably be better for us to synchronize from the source rather than the Europe mirror.

--
David Moreau Simard

On Apr 9, 2014, at 2:04 AM, Wido den Hollander <wido@42on.com> wrote:

> Hi,
> 
> I just enabled rsync on the eu.ceph.com mirror.
> 
> eu.ceph.com mirrors from Ceph.com every 3 hours.
> 
> Feel free to rsync all the contents to your local environment, might be useful
> for some large deployments where you want to save external bandwidth by not
> having each machine fetch the Deb/RPM packages from the internet.
> 
> Rsync is available over IPv4 and IPv6, simply sync with this command:
> $ mkdir cephmirror
> $ rsync -avr --stats --progress eu.ceph.com::ceph cephmirror
> 
> I ask you all to be gentle. It's a free service, so don't start hammering the
> server by setting your Cron to sync every 5 minutes. Once every couple of hours
> should be sufficient.
> 
> Also, please don't all start syncing at the first minute of the hour. When
> setting up the Cron, select a random minute from the hour. This way the load on
> the system can be spread out.
> 
> Should you have any questions or issues, let me know!
> 
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


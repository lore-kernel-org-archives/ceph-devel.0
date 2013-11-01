From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [ANN] ceph-deploy 1.3 released!
Date: Fri, 01 Nov 2013 20:21:14 +0100
Message-ID: <5273FF2A.4040605@profihost.ag>
References: <CANtztVz+=1DawR-it8t_9WSkxALzMvrXA6SxoomD9x9N-hztgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:39794 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3KAT1k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Nov 2013 15:27:40 -0400
In-Reply-To: <CANtztVz+=1DawR-it8t_9WSkxALzMvrXA6SxoomD9x9N-hztgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <alfredo.deza@inktank.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i didn't found something in the changelog so i just would like to ask if 
this is planned.

Right now you can already create a new cluster using hostA:IPA HostB:IPB ...

but it does not use these IPs as mon addr also the hostA hostB names 
need to match the hostname this is pretty bad as you cannot change IPs 
or hosts of mons later easily, so i tend to use special names and Ips 
which i can move later to different machines.

The normal ceph config supports:

[mon.a]
    host name = abc
    mon addr = 85.58.34.12

Thanks,
Stefan

Am 01.11.2013 13:54, schrieb Alfredo Deza:
> Hi all,
>
> A new version (1.3) of ceph-deploy is now out, a lot of fixes went
> into this release including the addition of a more robust library to
> connect to remote hosts and it removed the one extra dependency we
> used. Installation should be simpler.
>
> The complete changelog can be found at:
>
> https://github.com/ceph/ceph-deploy/blob/master/docs/source/changelog.rst
>
>
> The highlights for this release are:
>
>
> * We now allow to use `--username` to connect on remote hosts,
> specifying something different than the current user or the SSH
> config.
>
> * Global timeouts for remote commands to be able to disconnect if
> there is no input received (defaults to 5 minutes), but still allowing
> other more granular timeouts for some commands that need to just run a
> simple command without output expectation.
>
>
> Please make sure you update (install instructions:
> http://github.com/ceph/ceph-deploy/#installation) and use the latest
> version!
>
>
> Thanks,
>
>
> Alfredo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

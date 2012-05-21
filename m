From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: reproductible kernel oops with kernel 3.2 inside kvm
Date: Mon, 21 May 2012 14:24:32 +0200
Message-ID: <4FBA3400.4090202@univ-nantes.fr>
References: <4FA290C1.9080808@univ-nantes.fr> <4FB57A03.70309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:36705 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754587Ab2EUMcs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 08:32:48 -0400
In-Reply-To: <4FB57A03.70309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 18/05/2012 00:21, Josh Durgin wrote:
> Hi Yann,
>
> Sorry for the late response.
>
> On 05/03/2012 07:05 AM, Yann Dupont wrote:
>> Hello. I'm stress testing ceph since some time now, with quite good
>> results. I really like ceph and will probably use in in some
>> pre-production services.
>>
>> Anyway I've seen some bugs.
>>
>> One of them is instability if the kernel is running inside KVM, lead=
ing
>> to a very fast (and reproductible) kernel oops. On bare metal this
>> particular oops doesn't happen.
>>
>> The kernel oops itself involve ceph, but it could be a real bug in k=
vm
>> too.
>>
>> The host machine is runnning 3.2.2
>> kvm is quite ancien (0.14)
>> guest OS is ubuntu 12.04 with his standard kernel. Retried with cust=
om
>> 3.2 kernel with the same problem.
>
> I'm not sure how many people are using the kernel client within kvm,
> but I haven't seen this problem before. Since it's in d_prune, it's
> probably Ceph related, but perhaps kvm makes a race condition trigger
> more often in your environment.
>
> I filed http://tracker.newdream.net/issues/2444 to track this.

Ok, thanks.

I'll see the issue in the tracker. As this KVM isn't a production=20
machine, I can make tests very easily on it.


Cheers
--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

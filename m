From: Giulio Fidente <gfidente@redhat.com>
Subject: Re: Ceph & Cinder & HA
Date: Mon, 10 Nov 2014 12:50:27 +0100
Message-ID: <5460A683.9040509@redhat.com>
References: <545B9A53.4040502@dachary.org> <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com> <545C927E.9010807@redhat.com> <CAOGLoJMMHZ3q9VxAG0B0ge6kaVdKZ1xVZLrjAFWZUGHf6kAeew@mail.gmail.com> <11F50ACF-55E9-4D2F-AD08-814FE5998089@enovance.com> <546098C5.4070709@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47275 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbaKJLvk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Nov 2014 06:51:40 -0500
In-Reply-To: <546098C5.4070709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sebastien Han <sebastien.han@enovance.com>, justin@erenkrantz.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/10/2014 11:51 AM, Loic Dachary wrote:
>
>
> On 10/11/2014 11:34, Sebastien Han wrote:
>> Indeed, that=E2=80=99s what we discussed with Giulio, using HAProxy =
for the Monitors is a bit overkill since the client is natively able to=
 switch between different monitor source.
>>
>> Loic, maybe you can elaborate a bit more on the usage of HAProxy for=
 the monitors?
>
> Hi Sebastien,
>
> I can't elaborate because I know nothing about HAProxy (well, close t=
o nothing ;-). I'd like to learn more about how HA (via HAProxy or some=
thing else) can leverage Ceph in a meaningfull way thouhg, hence my int=
erest for the topic.

Thanks all for helping.

Loic explained requests for the non-leader monitors go to the monitor=20
anyway in which case I understand it makes more sense to avoid the=20
complication of balancing the monitors.

--=20
Giulio Fidente
GPG KEY: 08D733BA
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

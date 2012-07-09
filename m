From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 09 Jul 2012 20:21:18 +0200
Message-ID: <4FFB211E.9050707@profihost.ag>
References: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com> <9437d87e-97db-48fc-a133-f25042b21a38@mailpro> <CAPYLRziiFAAv8j=tJM1tmnmjoDQE8qbeLMQ==aE540xCCik7nA@mail.gmail.com> <D104B995-5AA4-46C2-B9D1-0A80878BEF4C@profihost.ag> <CAPYLRziuiGob-6mW+jkf0eC0=HoNYhkSe8LHfJQgviKkQbs1yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50057 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab2GISVW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 14:21:22 -0400
In-Reply-To: <CAPYLRziuiGob-6mW+jkf0eC0=HoNYhkSe8LHfJQgviKkQbs1yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Am 06.07.2012 20:17, schrieb Gregory Farnum:
>> Am 06.07.2012 um 19:11 schrieb Gregory Farnum <greg@inktank.com>:
>>> I'm interested in figuring out why we aren't getting useful data ou=
t
>>> of the admin socket, and for that I need the actual configuration
>>> files. It wouldn't surprise me if there are several layers to this
>>> issue but I'd like to start at the client's endpoint. :)
>>
>> While I'm on holiday I can't send you my ceph.conf but it doesn't co=
ntain anything else than the locations and journal dio false for tmpfs =
and /var/run/ceph_$name.sock
>
> Is that socket in the global area?
Yes

 > Does the KVM process have
> permission to access that directory?
Yes it is also created if i skip $name and set it to /var/run/ceph.sock

>>> Regarding the random IO, you shouldn't overestimate your storage.
>>> Under plenty of scenarios your drives are lucky to do more than 2k
>>> IO/s, which is about what you're seeing....
>>> http://techreport.com/articles.x/22415/9
>> You're fine if the ceph workload is the same as the iometer file ser=
ver workload. I don't know. I've measured the raw random 4k workload. A=
lso I've tested adding another osd and speed still doesn't change but w=
ith a size of 200gb I should hit several osd servers.
> Okay =97 just wanted to point it out.

Thanks also with sheepdog i can get 40 000 IOp/s.

Stefan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

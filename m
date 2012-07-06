From: Gregory Farnum <greg@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 6 Jul 2012 11:17:25 -0700
Message-ID: <CAPYLRziuiGob-6mW+jkf0eC0=HoNYhkSe8LHfJQgviKkQbs1yg@mail.gmail.com>
References: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com>
	<9437d87e-97db-48fc-a133-f25042b21a38@mailpro>
	<CAPYLRziiFAAv8j=tJM1tmnmjoDQE8qbeLMQ==aE540xCCik7nA@mail.gmail.com>
	<D104B995-5AA4-46C2-B9D1-0A80878BEF4C@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57681 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab2GFSR1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 14:17:27 -0400
Received: by lbbgm6 with SMTP id gm6so15714571lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 11:17:25 -0700 (PDT)
In-Reply-To: <D104B995-5AA4-46C2-B9D1-0A80878BEF4C@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Fri, Jul 6, 2012 at 11:09 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 06.07.2012 um 19:11 schrieb Gregory Farnum <greg@inktank.com>:
>
>> On Thu, Jul 5, 2012 at 8:50 PM, Alexandre DERUMIER <aderumier@odiso.=
com> wrote:
>>> Hi,
>>> Stefan is on vacation for the moment,I don't know if he can reply y=
ou.
>>>
>>> But I can reoly for him for the kvm part (as we do same tests toget=
her in parallel).
>>>
>>> - kvm is 1.1
>>> - rbd 0.48
>>> - drive option rbd:pool/volume:auth_supported=3Dcephx;none;keyring=3D=
/etc/pve/priv/ceph/ceph.keyring:mon_host=3DX.X.X.X";
>>> -using writeback
>>>
>>> writeback tuning in ceph.conf on the kvm host
>>>
>>> rbd_cache_size =3D 33554432
>>> rbd_cache_max_age =3D 2.0
>>>
>>> benchmark use in kvm guest:
>>> fio --filename=3D$DISK --direct=3D1 --rw=3Drandwrite --bs=3D4k --si=
ze=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile=
1
>>>
>>> results show max 14000io/s with 1 vm, 7000io/s by vm with 2vm,...
>>> so it doesn't scale
>>>
>>> (bench is with directio, so maybe writeback cache don't help)
>>>
>>> hardware for ceph , is 3 nodes with 4 intel ssd each. (1 drive can =
handle 40000io/s randwrite locally)
>>
>> I'm interested in figuring out why we aren't getting useful data out
>> of the admin socket, and for that I need the actual configuration
>> files. It wouldn't surprise me if there are several layers to this
>> issue but I'd like to start at the client's endpoint. :)
>
> While I'm on holiday I can't send you my ceph.conf but it doesn't con=
tain anything else than the locations and journal dio false for tmpfs a=
nd /var/run/ceph_$name.sock

Is that socket in the global area? Does the KVM process have
permission to access that directory? If you enable logging can you get
any outputs that reference errors opening that file? (I realize you're
on holiday; these are just the questions we'll need answered to get it
working.)

>
>>
>> Regarding the random IO, you shouldn't overestimate your storage.
>> Under plenty of scenarios your drives are lucky to do more than 2k
>> IO/s, which is about what you're seeing....
>> http://techreport.com/articles.x/22415/9
> You're fine if the ceph workload is the same as the iometer file serv=
er workload. I don't know. I've measured the raw random 4k workload. Al=
so I've tested adding another osd and speed still doesn't change but wi=
th a size of 200gb I should hit several osd servers.
Okay =97=A0just wanted to point it out.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

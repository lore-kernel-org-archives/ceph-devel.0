From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Re: Mon identity in a dynamic environment
Date: Thu, 11 May 2017 15:43:30 +0000
Message-ID: <D539D3AE.8B56F%travis.nielsen@quantum.com>
References: <D538DFE2.8B37F%travis.nielsen@quantum.com>
 <alpine.DEB.2.11.1705111521580.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:60896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755662AbdEKPng (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 May 2017 11:43:36 -0400
In-Reply-To: <alpine.DEB.2.11.1705111521580.18953@piezo.novalocal>
Content-Language: en-US
Content-ID: <F5C16CAD0E77F6428DACDB2267EDFEC8@QUANTUM.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Bassam Tabbara <Bassam.Tabbara@Quantum.com>

Thanks Sage for the thoughts on where we should look for #1, it did seem
like the much better option. Bassam started to look into it as well so may
have some perspective on what he had found when digging through the code.

Travis




On 5/11/17, 8:26 AM, "Sage Weil" <sage@newdream.net> wrote:

>Hi Travis,
>
>On Wed, 10 May 2017, Travis Nielsen wrote:
>> How can we get monitors to work in an environment where their
>> identity/endpoint might change? (Kubernetes). On the Rook team we have a
>> few ideas on how to deal with this. What is your recommendation on which
>> one of these we should pursue or if you have another recommendation
>> altogether?
>>
>> Background: Consider the following in Kubernetes:
>>
>> * A monitor runs inside a pod, which has an unstable ip address.
>>Whenever
>> the pod restarts it might get a new ip address. This is not a frequent
>> event, but it also must be an expected part of failure or maintenance
>> * A stable endpoint can be created with a Kubernetes service, which is
>> done by routing to the ip address of the pod. Now you have a stable
>> address routing to the unstable address. You can hand out the service
>> address and theoretically nobody should care there is an unstable
>>address
>> under the covers.
>>
>> Solutions:
>>
>> There are at least two approaches to this problem.
>>
>> 1) Modify Ceph with the concept of an "advertise address" that is
>> different from the "bind address". In other words, the ip address the
>> monitor binds to locally is different than the ip address that is
>> advertised to the monmap. Other monitors and clients would all connect
>>to
>> a mon with its advertise_addr, which would be routed to the the local
>> bind_addr where the mon is actually listening. The monmap would be
>>stable
>> for a given set of mons even if they had a new bind_addr after restart.
>> The main challenge with this is that it would be a non-trivial change
>>for
>> Ceph to support the advertise_addr.
>>
>> This is a pattern followed in other systems such as etcd that support
>>both
>> a bind and advertise address.
>>
>> Today the mons prohibit an advertised address from being different from
>> the bind address with a check for the mon identity in a couple places
>>such
>> as this:
>>
>>https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub=
.c
>>om%2Fceph%2Fceph%2Fblob%2F7f72100be553072d2b8fcf2699296fd2b23f2665%2F&dat
>>a=3D02%7C01%7CTravis.Nielsen%40Quantum.com%7Cbbbdde4dd6e64e008a7808d49882=
10
>>89%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636301131764750926&sdata=
=3D
>>L5VQw0H9GaadP5hhjXemhWHq42tDRn1V4khv9V2u2LY%3D&reserved=3D0
>> src/msg/async/AsyncConnection.cc#L980
>>
>> In a prototype, I confirmed that disabling this error allowed the
>> communication with monitors to be successful with a simulated
>> advertise_addr. Essentially I generated config files with an advertised
>>ip
>> address, except that a mon would start with its own bind_addr in the
>> config. The prototype has the shortcoming that the bind_addr is in the
>>mon
>> map, so there is still a problem as soon as the pod restarts. We still
>> need the advertise_addr to be in the monmap, while the mon binds to a
>> bind_addr.
>
>I think this is the way to go, and I don't think it will be *that*
>involved.  Probably it just requires an option to supplement public_addr
>with bind_addr.  As long as the Messenger myaddr field is populated with
>the public_addr (and not bind_addr) field I suspect everything will Just
>Work.  Peers connecting to us will see the public_addr for their
>getpeeraddr config and that's the one that the messenger will advertise
>during its handshake; bind_addr would be used *only* by the actual bind
>call.  Does that seem reasonable?
>
>> 2) Every time the mons get a new address, inject a new monmap to the
>> changed monitors. This would require no changes in the Ceph codebase,
>>but
>> Rook would implement automation around the monmap injection. Rook would
>> carefully track the health of the monitors. When a mon ip address
>>changes,
>> if quorum has been lost Rook would inject the new address to the monmap
>>of
>> each mon, and the monitors would come up again. This seems feasible, but
>> it's also very difficult to get right.
>>
>> This proposal is along a similar vein as #2 to move the same mon to a
>>new
>> endpoint, but it doesn't seem complete for the scenario.
>>
>>https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Ftrello=
.c
>>om%2Fc%2Fmgmh0YGO%2F214-mon-ceph-mon-move&data=3D02%7C01%7CTravis.Nielsen=
%4
>>0Quantum.com%7Cbbbdde4dd6e64e008a7808d498821089%7C322a135f14fb4d72aede122
>>272134ae0%7C1%7C0%7C636301131764750926&sdata=3Dypx8E97pBxIQZR0OXrzQh01bRi=
%2
>>FL9Q%2F2G0535l5M2yM%3D&reserved=3D0
>
>Yeah, this seems more fragile.  :)
>
>sage

The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through security =
software programs and retain such messages in order to comply with applicab=
le data security and retention requirements. Quantum is not responsible for=
 the proper and complete transmission of the substance of this communicatio=
n or for any delay in its receipt.

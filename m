From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Re: Mon identity in a dynamic environment
Date: Fri, 12 May 2017 15:20:59 +0000
Message-ID: <D53B1DEC.8B655%travis.nielsen@quantum.com>
References: <D538DFE2.8B37F%travis.nielsen@quantum.com>
 <alpine.DEB.2.11.1705111521580.18953@piezo.novalocal>
 <fd53862f-c46a-1669-fa0a-3d914ccb763f@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:19415
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754462AbdELPVG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 May 2017 11:21:06 -0400
In-Reply-To: <fd53862f-c46a-1669-fa0a-3d914ccb763f@suse.de>
Content-Language: en-US
Content-ID: <0D0E482B85879B4D874A88E25FF09406@QUANTUM.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Joao, thanks for the perspective. Regarding the routing questions, I
believe the answer is that the default behavior would still be the same as
today. The advertise and bind address are the same. If they are set to
different addresses, that means you trust the environment to route them
appropriately. In our case, Kubernetes provides that routing.

Travis



On 5/11/17, 4:41 PM, "Joao Eduardo Luis" <joao@suse.de> wrote:

>On 05/11/2017 04:26 PM, Sage Weil wrote:
>> Hi Travis,
>>
>> On Wed, 10 May 2017, Travis Nielsen wrote:
>>> How can we get monitors to work in an environment where their
>>> identity/endpoint might change? (Kubernetes). On the Rook team we have
>>>a
>>> few ideas on how to deal with this. What is your recommendation on
>>>which
>>> one of these we should pursue or if you have another recommendation
>>> altogether?
>>>
>>> Background: Consider the following in Kubernetes:
>>>
>>> * A monitor runs inside a pod, which has an unstable ip address.
>>>Whenever
>>> the pod restarts it might get a new ip address. This is not a frequent
>>> event, but it also must be an expected part of failure or maintenance
>>> * A stable endpoint can be created with a Kubernetes service, which is
>>> done by routing to the ip address of the pod. Now you have a stable
>>> address routing to the unstable address. You can hand out the service
>>> address and theoretically nobody should care there is an unstable
>>>address
>>> under the covers.
>>>
>>> Solutions:
>>>
>>> There are at least two approaches to this problem.
>>>
>>> 1) Modify Ceph with the concept of an "advertise address" that is
>>> different from the "bind address". In other words, the ip address the
>>> monitor binds to locally is different than the ip address that is
>>> advertised to the monmap. Other monitors and clients would all connect
>>>to
>>> a mon with its advertise_addr, which would be routed to the the local
>>> bind_addr where the mon is actually listening. The monmap would be
>>>stable
>>> for a given set of mons even if they had a new bind_addr after restart.
>>> The main challenge with this is that it would be a non-trivial change
>>>for
>>> Ceph to support the advertise_addr.
>>>
>>> This is a pattern followed in other systems such as etcd that support
>>>both
>>> a bind and advertise address.
>>>
>>> Today the mons prohibit an advertised address from being different from
>>> the bind address with a check for the mon identity in a couple places
>>>such
>>> as this:
>>>
>>>https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
>>>com%2Fceph%2Fceph%2Fblob%2F7f72100be553072d2b8fcf2699296fd2b23f2665%2F&d
>>>ata=3D02%7C01%7CTravis.Nielsen%40Quantum.com%7Ca811b4a92b1443204ce408d49=
8c
>>>742a3%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636301428971476119&sd
>>>ata=3DMcDCWlt75b6JLYGJhBsMQe%2FNDm9RBZp6EeNcQuZyQ5o%3D&reserved=3D0
>>> src/msg/async/AsyncConnection.cc#L980
>>>
>>> In a prototype, I confirmed that disabling this error allowed the
>>> communication with monitors to be successful with a simulated
>>> advertise_addr. Essentially I generated config files with an
>>>advertised ip
>>> address, except that a mon would start with its own bind_addr in the
>>> config. The prototype has the shortcoming that the bind_addr is in the
>>>mon
>>> map, so there is still a problem as soon as the pod restarts. We still
>>> need the advertise_addr to be in the monmap, while the mon binds to a
>>> bind_addr.
>>
>> I think this is the way to go, and I don't think it will be *that*
>> involved.  Probably it just requires an option to supplement public_addr
>> with bind_addr.  As long as the Messenger myaddr field is populated with
>> the public_addr (and not bind_addr) field I suspect everything will Just
>> Work.  Peers connecting to us will see the public_addr for their
>> getpeeraddr config and that's the one that the messenger will advertise
>> during its handshake; bind_addr would be used *only* by the actual bind
>> call.  Does that seem reasonable?
>
>I think this is technically feasible on the monitor as well, and I
>really enjoy the idea.
>
>We would have to keep some info about the monitor's addresses in the
>monmap though, even if just for monitor consumption, such as the latest
>address for a given monitor. Unless the point was to have the monitors
>also benefiting from this translation/routing, which hopefully will not
>impact latency between them.
>
>However, in all my ignorance about how the messenger works (and
>networking, generally speaking, baffles me), I wonder whether this would
>open weird attack vectors. E.g., malicious peer handshaking with the
>advertised ip, without having the ip stack to back it up.
>
>I know ip spoofing is a thing, and if we stretch things enough
>everything is a potential problem. May it be ignorance driven, but I
>just worry that we'd be removing a sane check - that a message is
>expected to come from a given address, and if not we should probably
>discard it.
>
>Also, how would routing be implemented? If this is on the network,
>iptables, wtv, then we are introducing a new dependency on this feature
>that goes beyond having a properly configured network (which, in my
>experience, can sometimes be a challenge).


>>> 2) Every time the mons get a new address, inject a new monmap to the
>>> changed monitors. This would require no changes in the Ceph codebase,
>>>but
>>> Rook would implement automation around the monmap injection. Rook would
>>> carefully track the health of the monitors. When a mon ip address
>>>changes,
>>> if quorum has been lost Rook would inject the new address to the
>>>monmap of
>>> each mon, and the monitors would come up again. This seems feasible,
>>>but
>>> it's also very difficult to get right.
>>>
>>> This proposal is along a similar vein as #2 to move the same mon to a
>>>new
>>> endpoint, but it doesn't seem complete for the scenario.
>>>
>>>https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Ftrell=
o.
>>>com%2Fc%2Fmgmh0YGO%2F214-mon-ceph-mon-move&data=3D02%7C01%7CTravis.Niels=
en
>>>%40Quantum.com%7Ca811b4a92b1443204ce408d498c742a3%7C322a135f14fb4d72aede
>>>122272134ae0%7C1%7C0%7C636301428971476119&sdata=3DumPYAj7oO2STcPFPMAdyQw=
UI
>>>JXR47lqe7BBefdA7FMQ%3D&reserved=3D0
>>
>> Yeah, this seems more fragile.  :)
>
>As I see it, the major benefits from this would be maintaining a stable
>set of addresses for clients, such that one would not need to update
>them as monitors move from address to address, and to maintain an up to
>date map with as little - or without - admin intervention as possible.
>
>And with that in mind, injecting monmaps is definitely not the way to
>go. However, I think the 'mon move' could help - or, at least, the
>concept behind it, of having a monitor moving its address from A to B.
>Not necessarily by itself, but certainly paired with routing the
>advertised address to the bind addr.
>
>It's not as transparent as having all the addresses being routed between
>the advertise_addr and the bind_addr, without questions asked, but it
>would allow to keep track of the real addresses of the monitors. If for
>nothing else, at least to prevent loss of quorum in the event of the
>routing failing or being disabled [1].
>
>
>[1] I know this is tangential to the thread, but this could be a good
>use for the optional monmap features: if feature is enabled, use the
>advertised address; if disabled, use the monitor's address.
>
>   -Joao

The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through security =
software programs and retain such messages in order to comply with applicab=
le data security and retention requirements. Quantum is not responsible for=
 the proper and complete transmission of the substance of this communicatio=
n or for any delay in its receipt.

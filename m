From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Mon identity in a dynamic environment
Date: Wed, 10 May 2017 22:21:41 +0000
Message-ID: <D538DFE2.8B37F%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:25950
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751820AbdEJWVq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 May 2017 18:21:46 -0400
Content-Language: en-US
Content-ID: <80EBBE5B7159A548B930E33F16054677@QUANTUM.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

How can we get monitors to work in an environment where their
identity/endpoint might change? (Kubernetes). On the Rook team we have a
few ideas on how to deal with this. What is your recommendation on which
one of these we should pursue or if you have another recommendation
altogether?

Background: Consider the following in Kubernetes:

* A monitor runs inside a pod, which has an unstable ip address. Whenever
the pod restarts it might get a new ip address. This is not a frequent
event, but it also must be an expected part of failure or maintenance
* A stable endpoint can be created with a Kubernetes service, which is
done by routing to the ip address of the pod. Now you have a stable
address routing to the unstable address. You can hand out the service
address and theoretically nobody should care there is an unstable address
under the covers.

Solutions:

There are at least two approaches to this problem.

1) Modify Ceph with the concept of an "advertise address" that is
different from the "bind address". In other words, the ip address the
monitor binds to locally is different than the ip address that is
advertised to the monmap. Other monitors and clients would all connect to
a mon with its advertise_addr, which would be routed to the the local
bind_addr where the mon is actually listening. The monmap would be stable
for a given set of mons even if they had a new bind_addr after restart.
The main challenge with this is that it would be a non-trivial change for
Ceph to support the advertise_addr.

This is a pattern followed in other systems such as etcd that support both
a bind and advertise address.

Today the mons prohibit an advertised address from being different from
the bind address with a check for the mon identity in a couple places such
as this:
https://github.com/ceph/ceph/blob/7f72100be553072d2b8fcf2699296fd2b23f2665/
src/msg/async/AsyncConnection.cc#L980

In a prototype, I confirmed that disabling this error allowed the
communication with monitors to be successful with a simulated
advertise_addr. Essentially I generated config files with an advertised ip
address, except that a mon would start with its own bind_addr in the
config. The prototype has the shortcoming that the bind_addr is in the mon
map, so there is still a problem as soon as the pod restarts. We still
need the advertise_addr to be in the monmap, while the mon binds to a
bind_addr.


2) Every time the mons get a new address, inject a new monmap to the
changed monitors. This would require no changes in the Ceph codebase, but
Rook would implement automation around the monmap injection. Rook would
carefully track the health of the monitors. When a mon ip address changes,
if quorum has been lost Rook would inject the new address to the monmap of
each mon, and the monitors would come up again. This seems feasible, but
it's also very difficult to get right.

This proposal is along a similar vein as #2 to move the same mon to a new
endpoint, but it doesn't seem complete for the scenario.
https://trello.com/c/mgmh0YGO/214-mon-ceph-mon-move



Conclusion

Having a stable identity as in #1 is the only approach that feels right so
far.  Feedback? See this Rook issue for more discussion.
https://github.com/rook/rook/issues/586


Thanks!
Travis

The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through security =
software programs and retain such messages in order to comply with applicab=
le data security and retention requirements. Quantum is not responsible for=
 the proper and complete transmission of the substance of this communicatio=
n or for any delay in its receipt.

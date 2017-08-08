From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Re: Mon time to form quorum
Date: Tue, 8 Aug 2017 19:47:35 +0000
Message-ID: <D5AF6055.9536F%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:46094
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752030AbdHHTri (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Aug 2017 15:47:38 -0400
Content-Language: en-US
Content-ID: <F32D8AD892B3114E8D8F4423539D1603@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

ceph-devel may be a better place for this... This looks related to the
recent change that allows the mon to bind to a different address from the
advertised address. Notice that the config below has different addresses
for "public addr" and "cluster addr". Could this be causing paxos to take
some time to settle?

Another datapoint is that if there is only one mon (instead of three), the
quorum only takes about 10 seconds to establish instead of 60s.


____________________________________________________
From: Travis Nielsen <travis.nielsen@quantum.com>
Date: Tuesday, August 8, 2017 at 10:49 AM
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Subject: Mon time to form quorum



At cluster creation I'm seeing that the mons are taking a while time to
form quorum. It seems like I'm hitting a timeout of 60s somewhere. Am I
missing a config setting that would help paxos establish quorum sooner?
When initializing with the monmap I would have expected the mons to
initialize very quickly.

The scenario is:

* Luminous RC 2
* The mons are initialized with a monmap
* Running in Kubernetes (Rook)

The symptoms are:

* When all three mons start in parallel, they appear to determine their
rank immediately. I assume this means they establish communication. A log
message is seen such as this in each of the mon logs:
  - 2017-08-08 17:03:16.383599 7f8da7c85f40  0
mon.rook-ceph-mon1@-1(probing) e0  my rank is now 0 (was =AD1)

* Now paxos enters a loop that times out every two seconds and lasts about
60s, trying to probe the other monitors. During this wait, I am able to
curl the mon endpoints successfully.
  - 2017-08-08 17:03:17.345877 7f02b779af40 10
mon.rook-ceph-mon0@1(probing) e0 probing other monitors
  - 2017-08-08 17:03:19.346032 7f02ae568700  4
mon.rook-ceph-mon0@1(probing) e0 probe_timeout 0x55c93678bb00

* After about 60 seconds the probe succeeds and the mons start responding
  - 2017-08-08 17:04:17.356928 7f02ae568700 10
mon.rook-ceph-mon0@1(probing) e0 probing other monitors
  - 2017-08-08 17:04:17.366587 7f02a855c700 10
mon.rook-ceph-mon0@1(probing) e0 ms_verify_authorizer 10.0.0.254:6790/0
mon protocol 2


The relevant settings in the config are:
mon initial members  =3D rook-ceph-mon0 rook-ceph-mon1 rook-ceph-mon2
mon host                      =3D
10.0.0.24:6790,10.0.0.163:6790,10.0.0.139:6790
public addr                   =3D 10.0.0.24
cluster addr                  =3D 172.17.0.5

The full log for this mon at debug log level 20 can be found here:
https://gist.github.com/travisn/2c2641a6b80a7479b3b22accb41a5193

Any ideas?

Thanks,
Travis


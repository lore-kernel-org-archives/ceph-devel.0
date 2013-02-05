From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: v0.56.2 released
Date: Tue, 5 Feb 2013 11:30:44 -0800
Message-ID: <CA+jddaPMgRGwQSnyt=xF=46FpO11-Uc8Etjb_-NzSJuyoHFW0g@mail.gmail.com>
References: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39429 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab3BETaq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 14:30:46 -0500
Received: by mail-wi0-f174.google.com with SMTP id hi8so4186587wib.13
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 11:30:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

We are using v0.56.2 and it still seems that the default crushmap is
osd centered.  Here is the crushmap as dumped:

[root@node-172-19-0-15 ~]# cat crush.txt
# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11
device 12 osd.12
device 13 osd.13
device 14 osd.14

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 root

# buckets
host 172.19.0.14 {
id -2 # do not change unnecessarily
# weight 6.000
alg straw
hash 0 # rjenkins1
item osd.0 weight 1.000
item osd.4 weight 1.000
item osd.5 weight 1.000
item osd.12 weight 1.000
item osd.13 weight 1.000
item osd.14 weight 1.000
}
host 172.19.0.13 {
id -4 # do not change unnecessarily
# weight 3.000
alg straw
hash 0 # rjenkins1
item osd.2 weight 1.000
item osd.7 weight 1.000
item osd.9 weight 1.000
}
host 172.19.0.16 {
id -5 # do not change unnecessarily
# weight 3.000
alg straw
hash 0 # rjenkins1
item osd.3 weight 1.000
item osd.6 weight 1.000
item osd.10 weight 1.000
}
host 172.19.0.15 {
id -6 # do not change unnecessarily
# weight 3.000
alg straw
hash 0 # rjenkins1
item osd.1 weight 1.000
item osd.8 weight 1.000
item osd.11 weight 1.000
}
rack 0 {
id -3 # do not change unnecessarily
# weight 15.000
alg straw
hash 0 # rjenkins1
item 172.19.0.14 weight 6.000
item 172.19.0.13 weight 3.000
item 172.19.0.16 weight 3.000
item 172.19.0.15 weight 3.000
}
root default {
id -1 # do not change unnecessarily
# weight 15.000
alg straw
hash 0 # rjenkins1
item 0 weight 15.000
}

# rules
rule data {
ruleset 0
type replicated
min_size 1
max_size 10
step take default
step choose firstn 0 type osd
step emit
}
rule metadata {
ruleset 1
type replicated
min_size 1
max_size 10
step take default
step choose firstn 0 type osd
step emit
}
rule rbd {
ruleset 2
type replicated
min_size 1
max_size 10
step take default
step choose firstn 0 type osd
step emit
}

# end crush map
[root@node-172-19-0-15 ~]# ceph --version
ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)

We do not run any explicit crushtool commands as part of our start up
at this time.  Should we be?

Regards,
Mandell Degerness

On Wed, Jan 30, 2013 at 3:46 PM, Sage Weil <sage@inktank.com> wrote:
> The next bobtail point release is ready, and it's looking pretty good.
> This is an important update for the 0.56.x backport series that fixes a
> number of bugs and several performance issues. All v0.56.x users are
> encouraged to upgrade.
>
> Notable changes since v0.56.1:
>
>  * osd: snapshot trimming fixes
>  * osd: scrub snapshot metadata
>  * osd: fix osdmap trimming
>  * osd: misc peering fixes
>  * osd: stop heartbeating with peers if internal threads are stuck/hung
>  * osd: PG removal is friendlier to other workloads
>  * osd: fix recovery start delay (was causing very slow recovery)
>  * osd: fix scheduling of explicitly requested scrubs
>  * osd: fix scrub interval config options
>  * osd: improve recovery vs client io tuning
>  * osd: improve 'slow request' warning detail for better diagnosis
>  * osd: default CRUSH map now distributes across hosts, not OSDs
>  * osd: fix crash on 32-bit hosts triggered by librbd clients
>  * librbd: fix error handling when talking to older OSDs
>  * mon: fix a few rare crashes
>  * ceph command: ability to easily adjust CRUSH tunables
>  * radosgw: object copy does not copy source ACLs
>  * rados command: fix omap command usage
>  * sysvinit script: set ulimit -n properly on remote hosts
>  * msgr: fix narrow race with message queuing
>  * fixed compilation on some old distros (e.g., RHEL 5.x)
>
> There are a small number of interface changes related to the default CRUSH
> rule and scrub interval configuration options. Please see the full release
> notes.
>
> You can get v0.56.2 in the usual fashion:
>
>  * Git at git://github.com/ceph/ceph.git
>  * Tarball at http://ceph.com/download/ceph-0.56.2.tar.gz
>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>  * For RPMs, see http://ceph.com/docs/master/install/rpm
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

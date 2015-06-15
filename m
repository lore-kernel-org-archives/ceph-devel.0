From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: rbd top
Date: Mon, 15 Jun 2015 10:10:51 -0600
Message-ID: <CAANLjFpCt9tMhkkZ+eECXpvpXOgTCoS8wu6OEuA6S89Vbdfv_Q@mail.gmail.com>
References: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com>
	<CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>
	<alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>
	<557EE94C.10108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34277 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbbFOQKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 12:10:52 -0400
Received: by wgv5 with SMTP id 5so72814067wgv.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 09:10:51 -0700 (PDT)
In-Reply-To: <557EE94C.10108@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

John, let me see if I understand what you are saying...

When a person runs `rbd top`, each OSD would receive a message saying
please capture all the performance, grouped by RBD and limit it to
'X'. That way the OSD doesn't have to constantly update performance
for each object, but when it is requested it starts tracking it?

If so, that is an interesting idea. I wonder if that would be simpler
than tracking the performance of each/MRU objects in some format like
/proc/diskstats where it is in memory and not necessarily consistent.
The benefit is that you could have "lifelong" stats that show up like
iostat and it would be a simple operation. Each object should be able
to reference back to RBD/CephFS upon request and the client could even
be responsible for that load. Client performance data would need stats
in addition to the object stats.

My concern is that adding additional SQL like logic to each op is
going to get very expensive. I guess if we could push that to another
thread early in the op, then it might not be too bad. I'm enjoying the
discussion and new ideas.

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVfvkHCRDmVDuy+mK58QAAc7wP/RqT7tvKd+9IrJEPaYgH
vUgnIDvkPSuq9jyyIwE/bwcTTHQYtv5rc1pmvD22xgK42weQWKpkHwjkH4KJ
LTTgFsNfv2+AL+/chBbYQlhv3qoDtHdFb6ThpDVFTe7UwoZ+l/AG3sib/RES
3/HBXE42pL2uFOKOfodidmu65guFyBKR8iErL2Sk//vuMLyZ+33kVMpSgSsN
J60WvElhLf0NtM7Dn56Qh+QtlAFJvrgIcf1cl1k2AxKVRN5GiIX5nJXSMdMC
PjRh3hIN7ESeShr6cX9D2TypZspR8MZHUYVkqUahFBxFXYCvVP8qB4/Obhil
xn5ZHkCEp1V80qpAO5Qt1T34Mk7rgGlLueEaJK708bqe8kgfcOsxCDa4pMJ9
4j0ZOjlJTbu5JEMiy0/qmfoH7rMBQrKYeit9PIlB+xhQv/5+xUmmnYb4b3hc
iIA3LdgeFs7H83FbnJZoxIZWYtLij+88VUdmEGREhPVyRX6jd25mVVtvtg7d
3H+8AjeVa45EDHkAQqa5t8Kb5+sKr/LyyKBmqw0suD77kqKqWtKs9+sVFd6X
TXOhPKmAnd8TEGE86JzsfFeypfb76jil08MuIzvDvVj8hsRjpRHsZBQi+DPn
VIIbONqNM4CknURJW17rmP0o9l+sF+KAeji0AGivZuawtD+vbThwfWNRyMjN
5IXZ
=Sgkt
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Jun 15, 2015 at 9:03 AM, John Spray <john.spray@redhat.com> wrote:
>
>
> On 15/06/2015 14:52, Sage Weil wrote:
>>
>>
>> I seem to remember having a short conversation about something like this a
>> few CDS's back... although I think it was 'rados top'.  IIRC the basic
>> idea we had was for each OSD to track it's top clients (using some
>> approximate LRU type algorithm) and then either feed this relatively small
>> amount of info (say, top 10-100 clients) back to the mon for summation,
>> or dump via the admin socket for calamari to aggregate.
>>
>> This doesn't give you the rbd image name, but I bet we could infer that
>> without too much trouble (e.g., include a recent object or two with the
>> client).  Or, just assume that client id is enough (it'll include an IP
>> and PID... enough info to find the /var/run/ceph admin socket or the VM
>> process.
>>
>> If we were going to do top clients, I think it'd make sense to also have a
>> top objects list as well, so you can see what the hottest objects in the
>> cluster are.
>
>
> The following is a bit of a tangent...
>
> A few weeks ago I was thinking about general solutions to this problem (for
> the filesystem).  I played with (very briefly on wip-live-query) the idea of
> publishing a list of queries to the MDSs/OSDs, that would allow runtime
> configuration of what kind of thing we're interested in and how we want it
> broken down.
>
> If we think of it as an SQL-like syntax, then for the RBD case we would have
> something like:
>   SELECT read_bytes, write_bytes WHERE pool=rbd GROUP BY rbd_image
>
> (You'd need a protocol-specific module of some kind to define what
> "rbd_image" meant here, which would do a simple mapping from object
> attributes to an identifier (similar would exist for e.g. cephfs inode))
>
> Each time an OSD does an operation, it consults the list of active
> "performance queries" and updates counters according to the value of the
> GROUP BY parameter for the query (so the above example each OSD would be
> keeping a result row for each rbd image touchd).
>
> The LRU part could be implemented as LIMIT BY + SORT parameters, such that
> the result rows would be periodically sorted and the least-touched results
> would drop off the list.  That would probably be used in conjunction with a
> decay operator on the sorted-by field, like:
>   SELECT read_bytes, write_bytes,ops WHERE pool=rbd GROUP BY rbd_image SORT
> BY movingAverage(derivative(ops)) LIMIT 100
>
> Combining WHERE clauses would let the user "drill down" (apologies for
> buzzword) by doing things like identifying the most busy clients, and then
> for each of those clients identify which images/files/objects the client is
> most active on, or vice versa identify busy objects and then see which
> clients are hitting them. Usually keeping around enough stats to enable this
> is prohibitive at scale, but it's fine when you're actively creating custom
> queries for the results you're really interested in, instead of keeping
> N_clients*N_objects stats, and when you have the LIMIT part to ensure
> results never get oversized.
>
> The GROUP BY options would also include metadata sent from clients, e.g. the
> obvious cases like VM instance names, or rack IDs, or HPC job IDs.  Maybe
> also some less obvious ones like decorating cephfs IOs with the inode of the
> directory containing the file, so that OSDs could accumulate per-directory
> bandwidth numbers, and user could ask "which directory is
> bandwidth-hottest?" as well as "which file is bandwidth-hottest?".
>
> Then, after implementing all that craziness, you get some kind of wild
> multicolored GUI that shows you where the action is in your system at a
> cephfs/rgw/rbd level.
>
> Cheers,
> John

From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: [ceph-users] RBD: How many snapshots is too many?
Date: Mon, 18 Sep 2017 15:16:26 +0200
Message-ID: <da31c541-2875-00c0-4a35-5fba159af487@corp.ovh.com>
References: <CAPUexz_P73WZrwBwNqk+=L5o3zEW4FNouE67eVd6vUic7Hb8zQ@mail.gmail.com>
 <CAJ4mKGY9MTmBNJKoutBi66iNPQ=QfSop+MtHLf16Bn3rtdxUNg@mail.gmail.com>
 <ECEDE6B1AAC5D74D8B613E732F8F0C2685217B3C@USCULXMSG08.am.sony.com>
 <CAJ4mKGZeBnpTjLU=bgqMCSqemYbC3kSbvboqW2qZTiRm4n_s8g@mail.gmail.com>
 <ECEDE6B1AAC5D74D8B613E732F8F0C268521A497@USCULXMSG08.am.sony.com>
 <CAJ4mKGYb_8pkTPM_o2dY5Gka2ao5jm1TFcKE+KL7fNZTekcBrw@mail.gmail.com>
 <ECEDE6B1AAC5D74D8B613E732F8F0C26852223CD@USCULXMSG08.am.sony.com>
 <CAPUexz-6iAgW6iZ-Dk3KTxFSiMRnzGBGtcH6wxtGe7_z3A6EEQ@mail.gmail.com>
 <CAJ4mKGbesxs30sKthJk9fBnLLkoJMoz6h2Hv1dtBoq78pJDoMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo301.mail-out.ovh.net ([137.74.110.64]:36043 "EHLO
        1.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdIRNQ3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 09:16:29 -0400
In-Reply-To: <CAJ4mKGbesxs30sKthJk9fBnLLkoJMoz6h2Hv1dtBoq78pJDoMA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On 17-09-16 01:36 AM, Gregory Farnum wrote:
> I got the chance to discuss this a bit with Patrick at the Open Source 
> Summit Wednesday (good to see you!).
> 
> So the idea in the previously-referenced CDM talk essentially involves 
> changing the way we distribute snap deletion instructions from a 
> "deleted_snaps" member in the OSDMap to a "deleting_snaps" member that gets 
> trimmed once the OSDs report to the manager that they've finished removing 
> that snapid. This should entirely resolve the CPU burn they're seeing during 
> OSDMap processing on the nodes, as it shrinks the intersection operation 
> down from "all the snaps" to merely "the snaps not-done-deleting".
> 
> The other reason we maintain the full set of deleted snaps is to prevent 
> client operations from re-creating deleted snapshots — we filter all client 
> IO which includes snaps against the deleted_snaps set in the PG. Apparently 
> this is also big enough in RAM to be a real (but much smaller) problem.
> 
> Unfortunately eliminating that is a lot harder and a permanent fix will 
> involve changing the client protocol in ways nobody has quite figured out 
> how to do. But Patrick did suggest storing the full set of deleted snaps 
> on-disk and only keeping in-memory the set which covers snapids in the range 
> we've actually *seen* from clients. I haven't gone through the code but that 
> seems broadly feasible — the hard part will be working out the rules when 
> you have to go to disk to read a larger part of the deleted_snaps set. 
> (Perfectly feasible.)
> 
> PRs are of course welcome! ;)

There you go: https://github.com/ceph/ceph/pull/17493

We are hitting limitations of current implementation - we have over 9 
thousands of removed snap intervals, with snap counter over 650000. In our 
particular case, this shows up as a bad CPU usage spike every few minutes, 
and it's going to be only worse, as we're going to have more snapshots over 
time. My PR halves that spike, and is a change small enough to be backported 
to both Jewel and Luminous without breaking too much at once - not a final 
solution, but should make life a bit more tolerable until actual, working 
solution is in place.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/

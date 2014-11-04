From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: cephfs survey results
Date: Wed, 05 Nov 2014 12:04:54 +1300
Message-ID: <54595B96.1060702@catalyst.net.nz>
References: <alpine.DEB.2.00.1411030649070.15135@cobra.newdream.net> <CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com> <alpine.DEB.2.00.1411040057280.15135@cobra.newdream.net> <54594119.5000006@catalyst.net.nz> <alpine.DEB.2.00.1411041445550.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:57046 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbaKDXE7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 18:04:59 -0500
In-Reply-To: <alpine.DEB.2.00.1411041445550.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

On 05/11/14 11:47, Sage Weil wrote:
> On Wed, 5 Nov 2014, Mark Kirkwood wrote:
>> On 04/11/14 22:02, Sage Weil wrote:
>>> On Tue, 4 Nov 2014, Blair Bethwaite wrote:
>>>> On 4 November 2014 01:50, Sage Weil <sage@newdream.net> wrote:
>>>>> In the Ceph session at the OpenStack summit someone asked what the
>>>>> CephFS
>>>>> survey results looked like.
>>>>
>>>> Thanks Sage, that was me!
>>>>
>>>>>    Here's the link:
>>>>>
>>>>>           https://www.surveymonkey.com/results/SM-L5JV7WXL/
>>>>>
>>>>> In short, people want
>>>>>
>>>>> fsck
>>>>> multimds
>>>>> snapshots
>>>>> quotas
>>>>
>>>> TBH I'm a bit surprised by a couple of these and hope maybe you guys
>>>> will apply a certain amount of filtering on this...
>>>>
>>>> fsck and quotas were there for me, but multimds and snapshots are what
>>>> I'd consider "icing" features - they're nice to have but not on the
>>>> critical path to using cephfs instead of e.g. nfs in a production
>>>> setting. I'd have thought stuff like small file performance and
>>>> gateway support was much more relevant to uptake and
>>>> positive/pain-free UX. Interested to hear others rationale here.
>>>
>>> Yeah, I agree, and am taking the results with a grain of salt.  I
>>> think the results are heavily influenced by the order they were
>>> originally listed (I whish surveymonkey would randomize is for each
>>> person or something).
>>>
>>> fsck is a clear #1.  Everybody wants multimds, but I think very few
>>> actually need it at this point.  We'll be merging a soft quota patch
>>> shortly, and things like performance (adding the inline data support to
>>> the kernel client, for instance) will probably compete with getting
>>> snapshots working (as part of a larger subvolume infrastructure).  That's
>>> my guess at least; for now, we're really focused on fsck and hard
>>> usability edges and haven't set priorities beyond that.
>>>
>>> We're definitely interested in hearing feedback on this strategy, and on
>>> peoples' experiences with giant so far...
>>>
>>
>> Heh, not necessarily - I put multi mds in there, as we want the cephfs part to
>> be of similar to the rest of ceph in its availability.
>>
>> Maybe its because we are looking at plugging it in with an Openstack setup and
>> for that you want everything to 'just look after itself'. If on the other hand
>> we were wanting merely an nfs replacement, then sure multi mds not so
>> important there.
>
> Important clarification: "multimds" == multiple *active* MDS's.  "single
> mds" means 1 active MDS and N standy's.  One perfectly valid strategy,
> for example, is to run a ceph-mds on *every* node and let the mon pick
> whichever one is active.  (That works as long as you have sufficient
> memory on all nodes.)
>

Righty, so I think I've (plus a few others perhaps) misunderstood the 
nature of the 'promotion mechanism' for 1 active several standby design 
- I was under the (possibly wrong) impression that you needed to 'do 
something' to make a standby active? If not then yeah it would be fine, 
sorry!


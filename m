From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: Re: Thoughts about metadata exposure in Calamari
Date: Fri, 5 Jun 2015 19:33:44 +0000
Message-ID: <73364EFF-DAC3-41F1-816A-DCE5426D4F2B@hp.com>
References: <2C438B34CAC8264398F5C7AF7411910A6349D1E2@G4W3206.americas.hpqcorp.net>,<alpine.DEB.2.00.1506051221440.1217@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:36816 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbFETgG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 15:36:06 -0400
In-Reply-To: <alpine.DEB.2.00.1506051221440.1217@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dan Mick (dmick@redhat.com)" <dmick@redhat.com>

I err in the direction of calling 'osd metadata' too, but it does mean that Calamari will need to add that call in (I'll leave it to Gregory to say if that is particularly undesirable). Do you think it would be worthwhile to better define the metadata bundle into a structure, or is it ok to leave it as a set of string pairs?

Joe



> On Jun 5, 2015, at 2:24 PM, Sage Weil <sweil@redhat.com> wrote:
> 
>> On Fri, 5 Jun 2015, Handzik, Joe wrote:
>> Adding in ceph-devel, this time without html formatting...
>> 
>> Rest-of-community,
>> 
>> After talking to Gregory, we can see any of the solutions in the original email being acceptable, but it depends on what others are using and how changes would affect them. 
>> 
>> 1. Is anyone actively using the 'osd metadata' monitor command?
>> 2. Would anyone be upset if the data from 'osd metadata' came along for the ride in 'osd dump'? (see: https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L3006 and https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L2910 )
>> 3. Or, would a better solution be to push device, partition, and filesystem information into the 'osd dump' dataset, and leave 'osd metadata' out of it? (some of this stuff would move elsewhere: https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L4521 )
>> a. Some of the data in the metadata bundle looked interesting, that's another motivating factor behind carrying it with the device and partition data in my current PR: https://github.com/ceph/ceph/pull/4699. Might be a better fit for a different location though, seems overkill for every OSD to push this much system data up.
>> 4. Or, is everything so fragile that we should just add an 'osd metadata' call into Calamari (alongside the 'osd dump' call: https://github.com/ceph/calamari/blob/0964ec9b82c1182e97f00b13dc157f328f75e294/salt/srv/salt/_modules/ceph.py#L367 )
> 
> It is perhaps an implementation artifact, but: 'osd dump' is dumping 
> (just) the contents of the OSDMap structure, and matches what you would 
> get from
> 
> ceph osd getmap -o foo
> osdmaptool --print foo  (or --print-json)
> 
> We definitely don't want the 'osd metadata' stuff to go in the OSDMap.
> 
> Exposing 'osd metadata' seems like the simplest thing?
> 
> sage
> 
> 
>> Sorry for the link explosion, just trying to carry some context along. Any (well, most) opinions would be appreciated!
>> 
>> Joe
>> 
>> From: Handzik, Joe 
>> Sent: Friday, June 05, 2015 10:28 AM
>> To: gmeno@redhat.com
>> Cc: Dan Mick (dmick@redhat.com)
>> Subject: Thoughts about metadata exposure in Calamari
>> 
>> Hey guys,
>> 
>> I finally feel like I have my head wrapped around how this works. I feel like I have two general paths that I could go down now:
>> 
>> 1. In calamari, use the 'osd metadata' command to pull the metadata up. The task here would be to figure out the right way to arrange that data (this might actually kickoff the start of Gregory's hardware API concept). 
>> a. My concern here is that metadata is a poorly-defined blob of string pairs. It's not a well-defined structure like some of the other data that is exposed today via other commands ('osd dump').
>> 2. Speaking of 'osd dump', another option would be to make the metadata bundle a first-class citizen of the dataset that is exposed via 'osd dump'. This would obviously require changes in OSDMap and probably OSD itself, but then the data would come along for free via the existing 'osd dump' command.
>> 3. A hybrid of these two would be to define the metadata via a structure instead of the set of string pairs that it is today, but still plan to add an 'osd metadata' call into Calamari like in option #1.
>> a. This might be the best option, but requires changes in both Ceph and Calamari. I'd probably make the Ceph changes first, so I don't need to implement option #1 first and then move something more like #3.
>> 
>> Lemme know if any of this seems off. No need to reply now, this is intended as background information to clarify my thought process in the meeting today. Still waiting on Sage to approve my existing pull request, but after a rocky hour earlier in the week (hadn't tested -with-debug, apparently), I believe I'm done.
>> 
>> Joe
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

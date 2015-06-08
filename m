From: Dan Mick <dmick@redhat.com>
Subject: Re: Thoughts about metadata exposure in Calamari
Date: Mon, 08 Jun 2015 13:07:29 -0700
Message-ID: <5575F601.70101@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6349D1E2@G4W3206.americas.hpqcorp.net>,<alpine.DEB.2.00.1506051221440.1217@cobra.newdream.net> <73364EFF-DAC3-41F1-816A-DCE5426D4F2B@hp.com> <5572410E.9060806@redhat.com> <2C438B34CAC8264398F5C7AF7411910A634A8A0E@G9W0731.americas.hpqcorp.net> <5575F2DE.7010306@redhat.com> <2C438B34CAC8264398F5C7AF7411910A634A8A5F@G9W0731.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57991 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbbFHUH3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Jun 2015 16:07:29 -0400
In-Reply-To: <2C438B34CAC8264398F5C7AF7411910A634A8A5F@G9W0731.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>, John Spray <john.spray@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/08/2015 01:02 PM, Handzik, Joe wrote:
> Ok. The code/comment I'm referring to is here: https://github.com/joehandzik/calamari/blob/master/salt/srv/salt/_modules/ceph.py#L393
> 
> I guess your point is that this is all grafted to the OSDMap data anyway, so the osdmap version is the relevant version anyway, yes? If so, is that comment just a slightly paranoid observation?

I just meant "in terms of not having to poll it until the epoch/version
changes, for efficiency".  It would be good also to add an epoch arg to
crush dump to address the fixme.

> Just to make sure I'm understanding everyone correctly, are we saying that I shouldn't bother with the 'osd metadata' call until I have a solid solution to an epoch implementation for osd metadata, or just that I should target a fix for that eventually?

I think the fixes can be independent, but I agree with John that it
would be nice to add an epoch/version to metadata as well (that would
probably be independent of the other versions, unless I'm missing some
coordination).  It ends up being an optimization, but probably a very
useful one.

> Joe
> 
> -----Original Message-----
> From: Dan Mick [mailto:dmick@redhat.com] 
> Sent: Monday, June 08, 2015 2:54 PM
> To: Handzik, Joe; John Spray; Sage Weil
> Cc: gmeno@redhat.com; ceph-devel@vger.kernel.org
> Subject: Re: Thoughts about metadata exposure in Calamari
> 
> The crush map changing causes a change in the osdmap version, I'm pretty
> sure.
> 
> On 06/08/2015 12:50 PM, Handzik, Joe wrote:
>> From what I see in the source file, we'd want to fix 'osd crush dump' somehow too, right? I can take a look while I'm working in this area to see what I can accomplish. 
>>
>> Joe
>>
>> -----Original Message-----
>> From: John Spray [mailto:john.spray@redhat.com] 
>> Sent: Friday, June 05, 2015 7:39 PM
>> To: Handzik, Joe; Sage Weil
>> Cc: gmeno@redhat.com; ceph-devel@vger.kernel.org; Dan Mick (dmick@redhat.com)
>> Subject: Re: Thoughts about metadata exposure in Calamari
>>
>>
>>
>> On 05/06/2015 20:33, Handzik, Joe wrote:
>>> I err in the direction of calling 'osd metadata' too, but it does mean that Calamari will need to add that call in (I'll leave it to Gregory to say if that is particularly undesirable). Do you think it would be worthwhile to better define the metadata bundle into a structure, or is it ok to leave it as a set of string pairs?
>>
>> Versioning of the metadata is something to consider. The "osd metadata" 
>> stuff is outside the osdmap epochs, so anything that is consuming 
>> updates to it is stuck with doing some kind of full polling as it 
>> stands.  It might be that some better interface with versions+deltas is 
>> needed for a management layer to efficiently consume it.
>>
>> A version concept where the version is incremented when an OSD starts or 
>> updates its metadata could make synchronization with a management layer 
>> much more efficient.  Efficiency matters here when we're calling on the 
>> mons to serialize data for potentially 10000s of OSDs into JSON whenever 
>> the management layer wants an update.
>>
>> John
>>
> 


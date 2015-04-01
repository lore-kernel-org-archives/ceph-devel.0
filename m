From: Milosz Tanski <milosz@adfin.com>
Subject: Re: durability model
Date: Wed, 1 Apr 2015 10:18:32 -0400
Message-ID: <CANP1eJE4dcQL=RvGjPnP2AVsqOs0DGECK=P6Ln+XKjCOEBK6Og@mail.gmail.com>
References: <1401131148.7008.YahooMailNeo@web165003.mail.bf1.yahoo.com>
	<CAHxYaFN6R3F6Tn0Vnh9N+pAXhOT8F7+gYLTzTgonn==GJUpX_w@mail.gmail.com>
	<1401197435.39621.YahooMailNeo@web165002.mail.bf1.yahoo.com>
	<5384A010.4080300@dachary.org>
	<1401284130.75330.YahooMailNeo@web165006.mail.bf1.yahoo.com>
	<5385ED0E.9070204@dachary.org>
	<CANP1eJEDD7b78RXGvug+=KqVXM70WsFX+yxoAALo43LYWqH66g@mail.gmail.com>
	<alpine.DEB.2.00.1504010647120.15540@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35503 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbbDAOSe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 10:18:34 -0400
Received: by lahf3 with SMTP id f3so37254058lah.2
        for <ceph-devel@vger.kernel.org>; Wed, 01 Apr 2015 07:18:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1504010647120.15540@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Loic Dachary <loic@dachary.org>, Koleos Fuskus <koleosfuscus@yahoo.com>, Kyle Bader <kyle@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Apr 1, 2015 at 9:49 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 1 Apr 2015, Milosz Tanski wrote:
>> On Wed, May 28, 2014 at 10:05 AM, Loic Dachary <loic@dachary.org> wrote:
>> >
>> >
>> > On 28/05/2014 15:35, Koleos Fuskus wrote:
>> >>
>> >>
>> >>> 1. What will be erasure model unit? Is it a pool or a placement group? I cannot see the best option here yet, probably because my inexperience with Ceph.
>> >>
>> >> A pool.
>> >> OK. this is what I thought but some things are not clear enough. I am deploying Ceph to toying a bit more.
>> >>
>> >>
>> >>> 3. Metadata: Jerasure creates metadata files. How are those files stored in ceph (what kind of
>> >> Jerasure does not create a metadata file.
>> >>
>> >> It does on my machine! at least with jerasure 1.2 on mac os :)
>> >
>> > If you mean the files that are created by the command line examples provided with jerasure (1.2 or 2), they are not required and only meant for test purposes.
>> >
>> > Cheers
>> >
>> >>
>> >>
>> >>
>> >>
>> >> I proposed an update to the documentation to clarify this : https://github.com/ceph/ceph/pull/1856 . Does it look sensible to you ?
>> >>
>> >>
>>
>> Recently while considering a hardware update on the Ceph cluster I've
>> been thinking about the durability model of the new OSD nodes once the
>> cluster is done migrating over. So I came looking through these old
>> emails. I think it might be very useful to have a web tool that
>> describes (or visualizes) the current cluster durability model, or
>> better yet helps you play with the variables to visualize the changes.
>>
>> If we can formulate the rules model based on some common variables
>> (about machines, OSDs, racks) and replication rules (count or erasure
>> coding paramaters). Then we can spit out useful information like:
>> - How many nodes / racks / osds do you need to lose to have data offline
>> - What percentage of data is going to be unavailable if you lose X resources
>> - What's the probability of data loss over time
>> - How does the readability model impact your cluster network traffic,
>> repair traffic
>>
>> I think it would be stair-forward to build the web app. In fact, I'll
>> volunteer myself for that task. Before we start that I would suggest
>> we try to get the model in something like Google Docs Sheets so we can
>> use it as a basis.
>
> If can you haven't seen this:
>
>         https://github.com/ceph/ceph-tools/tree/master/models/reliability
>
> It's not web-based but it probably could be changed to be.  I definitely
> like the idea of having a hosted version.

Somehow I missed this. I'll take a stab to converting it into a web app.

>
> sage



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com

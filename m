From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: monitor dispatch queue seems backed up?
Date: Fri, 4 Mar 2011 12:53:59 -0800
Message-ID: <AANLkTinndgwjSdyZCucUa=rDBXTDOcd0_L3B=8AZisNj@mail.gmail.com>
References: <1299258853.4750.191.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
	<1C3F2964F2314471949A0E8F6C807216@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33134 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446Ab1CDUyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:54:01 -0500
Received: by wyg36 with SMTP id 36so2494457wyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 12:54:00 -0800 (PST)
In-Reply-To: <1C3F2964F2314471949A0E8F6C807216@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 4, 2011 at 12:38 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Friday, March 4, 2011 at 11:48 AM, Sage Weil wrote:
> Hi,
>> >
>> > I'm continuing my testing of the master branch
>> > (commit 1ed2d8c587) against 96 osds.
>> >
>> > I'm having trouble getting a new filesystem to
>> > start up. FWIW this size filesystem starts up
>> > in a minute or two at most under the stable branch.
>>
>> The main thing that's changed since then is the default number of PGs has
>> gone up. Can you try changing the osd_pg_bits to 6 in common/config.cc,
>> rebuild, and re-mkcephfs, and see if that gives you behavior similar to
>> stable? (mkcephfs isn't currently letting you adjust that yet.)
>
> Hmmm, I believe that if you set the osd_pg_bits in your ceph.conf it should get picked up by mkcephfs. :) Otherwise there are command-line options, and I have checked to make sure they work!

you mean 'osd pg bits' in the ceph.conf?

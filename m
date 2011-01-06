From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: unstable crushtool fails to open log file
Date: Wed, 5 Jan 2011 16:30:20 -0800
Message-ID: <AANLkTikGFgpu5OuLPZg27_o1CeTzB5uH=Q-Txyh1D80V@mail.gmail.com>
References: <1294252746.4984.154.camel@sale659.sandia.gov>
	<AANLkTiniHXyQ=vwnwfdNeO4P6+yWiJvZhAWm0FjOQfAB@mail.gmail.com>
	<1294253392.4984.156.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58924 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab1AFAaW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jan 2011 19:30:22 -0500
Received: by fxm20 with SMTP id 20so15595353fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jan 2011 16:30:21 -0800 (PST)
In-Reply-To: <1294253392.4984.156.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

This should be fixed by 8adaa0478a94b5f731ee77e12a8dac29e3a7b46a

Command line (non-daemon) programs should now log to stderr, always,
rather than trying to open logfiles or syslog.

cheers,
Colin


On Wed, Jan 5, 2011 at 10:49 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi Colin,
>
> On Wed, 2011-01-05 at 11:46 -0700, Colin McCabe wrote:
>> Hi Jim,
>>
>> We should be defaulting to sending logs to stderr for command-line
>> tools like crushtool.
>>
>> I'll resolve this in a bit.
>
> Cool, thanks.
>
> -- Jim
>
>>
>> C.
>>
>>
>> On Wed, Jan 5, 2011 at 10:39 AM, Jim Schutt <jaschut@sandia.gov> wro=
te:
>> > Hi,
>> >
>> > unstable branch crushtool is failing for me like this:
>> >
>> > # crushtool --num_osds 32 -o test.crushmap --build shelf uniform 8=
 host uniform 1 root straw 0
>> > failed to open log file '/var/log/ceph/': error 21: Is a directory
>> >
>> > This error seems to happen at crushtool.cc:925:
>> >
>> > 925 =A0 =A0 =A0 =A0 =A0 dout(0) << "layer " << type
>> > 926 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << " =A0" << l.name
>> > 927 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << " =A0bucket type " << l=
=2Ebuckettype
>> > 928 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << " =A0" << l.size
>> > 929 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << dendl;
>> >
>> >
>> > AFAICS commit 986c2af4aeb switched dout to use DoutStreambuf,
>> > and by default (commit 952111451c3) everything now logs to a
>> > file.
>> >
>> > What's the right way to get crushtool to log to stdout or
>> > stderr? =A0Or, how to I get crushtool to use a log file
>> > of my choice?
>> >
>> > Thanks -- Jim
>> >
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

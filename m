From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Thu, 2 Feb 2012 08:38:52 -0700
Message-ID: <4F2AAE0C.6030609@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37525 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab2BBPjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 10:39:25 -0500
In-Reply-To: <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

(resent because I forgot the list on my original reply)

On 02/01/2012 03:33 PM, Gregory Farnum wrote:
> On Wed, Feb 1, 2012 at 7:54 AM, Jim Schutt<jaschut@sandia.gov>  wrote=
:
>> Hi,
>>
>> FWIW, I've been trying to understand op delays under very heavy writ=
e
>> load, and have been working a little with the policy throttler in ho=
pes of
>> using throttling delays to help track down which ops were backing up=
=2E
>> Without much success, unfortunately.
>>
>> When I saw the wip-osd-op-tracking branch, I wondered if any of this
>> stuff might be helpful.  Here it is, just in case.
>
> In general these patches are dumping information to the logs, and par=
t
> of the wip-osd-op-tracking branch is actually keeping track of most o=
f
> the message queueing wait times as part of the message itself
> (although not the information about number of waiters and sleep/wake
> seqs). I'm inclined to prefer that approach to log dumping.

I agree - I've just been using log dumping because I can extract
any relationships I can write a perl script to find :)  So far,
not too helpful.

> Are there any patches you recommend for merging? I'm a little curious
> about the ordered wakeup one =E2=80=94 do you have data about when th=
at's a
> problem?

I've been trying to push the client:osd ratio, and in my testbed
I can run up to 166 linux clients. Right now I'm running them
against 48 OSDs.  The clients are 1 Gb/s ethernet, and the OSDs
have a 10 Gb/s ethernet for clients and another for the cluster.

During sustained write loads I see a factor of 10 oscillation
in aggregate throughput, and during that time I see clients
stuck in the policy throttler for hundreds of seconds, and I
see a number of waiters equal to
   number of clients - (throttler limit) / (msg size)
If I do a histogram of throttler wait times I see a handful of
messages that wait for an extra couple hundreds of seconds
without the ordered wakeup.

I'm not sure what this will look like if my throughput
variations can be fixed.  But, for our HPC loads I expect
we'll often see periods where offered load is much higher
that aggregate bandwidth of any system we can afford to
build, so ordered wakeup may be useful in such cases for
client fairness.

So I'd recommend the ordered wakeup patch if you don't
see any downsides.

Sorry for the noise on the others - mostly I just wanted
to share the sort of things I've been looking at.  I'll
be learning to use your new stuff soon...

-- Jim

> -Greg
>
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

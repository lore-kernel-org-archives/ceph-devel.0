From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: scaling issues
Date: Fri, 9 Mar 2012 12:39:17 -0700
Message-ID: <4F5A5C65.6030705@sandia.gov>
References: <4F59414B.3000403@sandia.gov>
 <Pine.LNX.4.64.1203081625030.21631@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53645 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab2CITkC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 14:40:02 -0500
In-Reply-To: <Pine.LNX.4.64.1203081625030.21631@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/08/2012 05:26 PM, Sage Weil wrote:
> On Thu, 8 Mar 2012, Jim Schutt wrote:
>> Hi,
>>
>> I've been trying to scale up a Ceph filesystem to as big
>> as I have hardware for - up to 288 OSDs right now.
>>
>> (I'm using commit ed0f605365e - tip of master branch from
>> a few days ago.)
>>
>> My problem is that I cannot get a 288 OSD filesystem to go active
>> (that's with 1 mon and 1 MDS).  Pretty quickly I start seeing
>> "mds e4 e4: 1/1/1 up {0=cs33=up:creating(laggy or crashed)}".
>> Note that as this is happening all the OSDs and the MDS are
>> essentially idle; only the mon is busy.
>>
>> While tailing the mon log I noticed there was a periodic pause;
>> after adding a little more debug printing, I learned that the
>> pause was due to encoding pg_stat_t before writing the pg_map to disk.
>>
>> Here's the result of a scaling study I did on startup time for
>> a freshly created filesystem.  I normally run 24 OSDs/server on
>> these machines with no trouble, for small numbers of OSDs.
>>
>>                     seconds from      seconds from     seconds to
>>     OSD       PG   store() mount     store() mount      encode
>>                         to            to all PGs       pg_stat_t   Notes
>>                     up:active        active+clean*
>>
>>      48     9504       58                63              0.30
>>      72    14256       70                89              0.65
>>      96    19008       93               117              1.1
>>     120    23760      132               138              1.7
>>     144    28512       92               165              2.3
>>     168    33264      215               218              3.2       periods of
>> "up:creating(laggy or crashed)"
>>     192    38016      392               344              4.0       periods of
>> "up:creating(laggy or crashed)"
>>     240    47520     1189               644              6.3       periods of
>> "up:creating(laggy or crashed)"
>>     288    57024>14400>14400              9.0       never went
>> active;>200 OSDs out, reporting "wrongly marked me down"
>
> Weird, pg_stat_t really shouldn't be growing quadratically.  Can you look
> at the size of the monitors pg/latest file, and see if those are growing
> quadratically as well?  I would expect it to be proportional to the
> encode time.

Here's the size of the last written mon/pgmap/latest for each run,
and the time it took to encode the pg_stat_t part of that last
instance of the file:

OSDs  size of  pg_stat_t
        latest   encode
                  time

  48   2976397  0.323052
  72   4472477  0.666633
  96   5969461  1.159198
120   7466021  1.738096
144   8963141  2.428229
168  10460309  3.203832
192  11956709  4.083013
240  14950445  6.453171
288  17916589  9.462052

Looks like the file size is growing linearly, but the
encode time is not?

>
> And maybe send us a copy of one of the big ones?

On its way.

-- Jim

>
> Thanks-
> sage
>
>


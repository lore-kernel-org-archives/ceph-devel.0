From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 13:10:16 -0600
Message-ID: <4FEB5A98.6000001@sandia.gov>
References: <4FEB04CC.4050008@profihost.ag>
 <4FEB10DA.7010206@inktank.com> <4FEB1EF8.4050307@sandia.gov>
 <4FEB2480.3080404@profihost.ag> <4FEB4179.8050104@sandia.gov>
 <937453C8-37D5-4708-B81B-CD97B4AF3BF8@profihost.ag>
 <4FEB533B.9040107@sandia.gov> <4FEB557E.7030903@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:55588 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2F0TKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 15:10:36 -0400
In-Reply-To: <4FEB557E.7030903@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/27/2012 12:48 PM, Stefan Priebe wrote:
> Am 27.06.2012 20:38, schrieb Jim Schutt:
>> Actually, when my 166-client test is running,
>> "ps -o pid,nlwp,args -C ceph-osd"
>> tells me that I typically have ~1200 threads/OSD.
>
> huh i see only 124 threads per OSD even with your settings.

FWIW:

2 threads/messenger (reader+writer):
   166 clients
  ~200 OSD data peers (this depends on PG distribution/number)
  ~200 OSD heartbeat peers (ditto)
plus
    24 OSD op threads (my tuning)
    24 OSD disk threads (my tuning)
     6 OSD filestore op threads (my tuning)

So, 2*566 + 54 = 1186 threads/OSD

Plus, there's various other worker threads, such as the
timer, message dispatch threads, monitor/MDS messenger, etc.

>
>> Hmmm. The only other obvious difference, based on
>> what I remember from your other posts, is that you're
>> testing against RBD, right? I've been testing exclusively
>> with the Linux kernel client.
>
> right and SSD. So it might be some timing issues.

I guess so.

-- Jim

>
> Stefan
>
>



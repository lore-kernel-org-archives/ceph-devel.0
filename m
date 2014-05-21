From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [Performance] Improvement on DB Performance
Date: Wed, 21 May 2014 22:05:39 +0200
Message-ID: <537D0713.2020807@profihost.ag>
References: <CACJqLyY5VSQubaPvk2N3BrRx=YZ7EpiyRJZbWnNM=bQMfNA8=w@mail.gmail.com> <CACJqLyYFMAxoVUZCTvPMXFGrYEPmFqTd+pZmsL2V=V1L32CisQ@mail.gmail.com> <alpine.DEB.2.00.1405210821420.1689@cobra.newdream.net> <537CCB49.8060408@cloudapt.com> <alpine.DEB.2.00.1405210857130.16657@cobra.newdream.net> <77004F70-7FE7-4EBE-A34D-46A8DC290936@profihost.ag> <alpine.DEB.2.00.1405211141180.16657@cobra.newdream.net> <18096300-29E6-4BAC-B956-0E5D3F80E379@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:47713 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbaEUUFc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 16:05:32 -0400
In-Reply-To: <18096300-29E6-4BAC-B956-0E5D3F80E379@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

*arg* sorry missed emperor with dumpling.. sorry.

Stefan

Am 21.05.2014 20:51, schrieb Stefan Priebe - Profihost AG:
>
>> Am 21.05.2014 um 20:41 schrieb Sage Weil <sage@inktank.com>:
>>
>>> On Wed, 21 May 2014, Stefan Priebe - Profihost AG wrote:
>>> Hi sage,
>>>
>>> what about cuttlefish customers?
>>
>> We stopped backporting fixes to cuttlefish a while ago.  Please upgrade to
>> dumpling!
>
> Did I miss an information from inktank to update to dumpling? I thought we should stay at cuttlefish and then upgrade to firefly.
>
>>
>> That said, this patch should apply cleanly to cuttlefish.
>>
>> sage
>>
>>
>>>
>>> Greets,
>>> Stefan
>>> Excuse my typo sent from my mobile phone.
>>>
>>> Am 21.05.2014 um 18:15 schrieb Sage Weil <sage@inktank.com>:
>>>
>>>       On Wed, 21 May 2014, Mike Dawson wrote:
>>>             Haomai,
>>>
>>>
>>>             Thanks for finding this!
>>>
>>>
>>>
>>>             Sage,
>>>
>>>
>>>             We have a client that runs an io intensive, closed-source software
>>>             package
>>>
>>>             that seems to issue overzealous flushes which may benefit from this
>>>             patch (or
>>>
>>>             the other methods you mention). If you were to spin a wip build based
>>>             on
>>>
>>>             Dumpling, I'll be a willing tester.
>>>
>>>
>>>       Pushed wip-librbd-flush-dumpling, should be built shortly.
>>>
>>>       sage
>>>
>>>
>>>             Thanks,
>>>
>>>             Mike Dawson
>>>
>>>
>>>             On 5/21/2014 11:23 AM, Sage Weil wrote:
>>>
>>>                   On Wed, 21 May 2014, Haomai Wang wrote:
>>>
>>>                         I pushed the commit to fix this
>>>
>>>                         problem(https://github.com/ceph/ceph/pull/1848).
>>>
>>>
>>>                         With test program(Each sync request is issued
>>>                         with ten write request),
>>>
>>>                         a significant improvement is noticed.
>>>
>>>
>>>                         aio_flush                          sum: 914750
>>>                             avg: 1239   count:
>>>
>>>                         738      max: 4714   min: 1011
>>>
>>>                         flush_set                          sum: 904200
>>>                             avg: 1225   count:
>>>
>>>                         738      max: 4698   min: 999
>>>
>>>                         flush                              sum: 641648
>>>                             avg: 173    count:
>>>
>>>                         3690     max: 1340   min: 128
>>>
>>>
>>>                         Compared to last mail, it reduce each aio_flush
>>>                         request to 1239 ns
>>>
>>>                         instead of 24145 ns.
>>>
>>>
>>>                   Good catch!  That's a great improvement.
>>>
>>>
>>>                   The patch looks clearly correct.  We can probably do even
>>>                   better by
>>>
>>>                   putting the Objects on a list when they get the first dirty
>>>                   buffer so that
>>>
>>>                   we only cycle through the dirty ones.  Or, have a global
>>>                   list of dirty
>>>
>>>                   buffers (instead of dirty objects -> dirty buffers).
>>>
>>>
>>>                   sage
>>>
>>>
>>>
>>>                         I hope it's the root cause for db on rbd
>>>                         performance.
>>>
>>>
>>>                         On Wed, May 21, 2014 at 6:15 PM, Haomai Wang
>>>                         <haomaiwang@gmail.com> wrote:
>>>
>>>                               Hi all,
>>>
>>>
>>>                               I remember there exists discuss
>>>                               about DB(mysql) performance on rbd.
>>>
>>>                               Recently I test mysql-bench with
>>>                               rbd and found awful performance. So
>>>                               I
>>>
>>>                               dive into it and find that main
>>>                               cause is "flush" request from
>>>                               guest.
>>>
>>>                               As we know, applications such as
>>>                               mysql, ceph has own journal for
>>>
>>>                               durable and journal usually send
>>>                               sync&direct io. If fs barrier is
>>>                               on,
>>>
>>>                               each sync io operation make kernel
>>>                               issue "sync"(barrier) request to
>>>
>>>                               block device. Here, qemu will call
>>>                               "rbd_aio_flush" to apply.
>>>
>>>
>>>                               Via systemtap, I found a amazing
>>>                               thing:
>>>
>>>                               aio_flush
>>>                                                        sum:
>>>                               4177085    avg: 24145  count:
>>>
>>>                               173      max: 28172  min: 22747
>>>
>>>                               flush_set
>>>                                                        sum:
>>>                               4172116    avg: 24116  count:
>>>
>>>                               173      max: 28034  min: 22733
>>>
>>>                               flush
>>>                                                            sum:
>>>                               3029910    avg: 4      count:
>>>
>>>                               670477   max: 1893   min: 3
>>>
>>>
>>>                               This statistic info is gathered in
>>>                               5s. Most of consuming time is on
>>>
>>>                               "ObjectCacher::flush". What's more,
>>>                               with time increasing, the flush
>>>
>>>                               count will be increasing.
>>>
>>>
>>>                               After view source, I find the root
>>>                               cause is "ObjectCacher::flush_set",
>>>
>>>                               it will iterator the "object_set"
>>>                               and look for dirty buffer. And
>>>
>>>                               "object_set"  contains all objects
>>>                               ever opened.  For example:
>>>
>>>
>>>                               2014-05-21 18:01:37.959013
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5919 flushed: 5
>>>
>>>                               2014-05-21 18:01:37.999698
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5919 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.038405
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5920 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.080118
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5920 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.119792
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5921 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.162004
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5922 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.202755
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5923 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.243880
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5923 flushed: 5
>>>
>>>                               2014-05-21 18:01:38.284399
>>>                               7f785c7c6700  0 objectcacher
>>>                               flush_set
>>>
>>>                               total: 5923 flushed: 5
>>>
>>>
>>>                               These logs record the iteration
>>>                               info, the loop will check 5920
>>>                               objects
>>>
>>>                               but only 5 objects are dirty.
>>>
>>>
>>>                               So I think the solution is make
>>>                               "ObjectCacher::flush_set" only
>>>
>>>                               iterator the objects which is
>>>                               dirty.
>>>
>>>
>>>                               --
>>>
>>>                               Best Regards,
>>>
>>>
>>>                               Wheat
>>>
>>>
>>>
>>>
>>>                         --
>>>
>>>                         Best Regards,
>>>
>>>
>>>                         Wheat
>>>
>>>                         --
>>>
>>>                         To unsubscribe from this list: send the line
>>>                         "unsubscribe ceph-devel" in
>>>
>>>                         the body of a message to
>>>                         majordomo@vger.kernel.org
>>>
>>>                         More majordomo info at
>>>                          http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>                   --
>>>
>>>                   To unsubscribe from this list: send the line "unsubscribe
>>>                   ceph-devel" in
>>>
>>>                   the body of a message to majordomo@vger.kernel.org
>>>
>>>                   More majordomo info at
>>>                    http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>             --
>>>
>>>             To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>             in
>>>
>>>             the body of a message to majordomo@vger.kernel.org
>>>
>>>             More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>       --
>>>       To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>       the body of a message to majordomo@vger.kernel.org
>>>       More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

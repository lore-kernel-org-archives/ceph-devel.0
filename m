From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Performance] Improvement on DB Performance
Date: Wed, 21 May 2014 20:12:23 +0800
Message-ID: <CACJqLyZJ5BzKgvttik7YZ=sjt9wMucKx97d8A6-pnumkonKvkw@mail.gmail.com>
References: <CACJqLyY5VSQubaPvk2N3BrRx=YZ7EpiyRJZbWnNM=bQMfNA8=w@mail.gmail.com>
	<CACJqLyYFMAxoVUZCTvPMXFGrYEPmFqTd+pZmsL2V=V1L32CisQ@mail.gmail.com>
	<E0E280CCE0E1A44898C992A9190D929A5B17E4@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:60326 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaEUMMY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 08:12:24 -0400
Received: by mail-wg0-f52.google.com with SMTP id l18so1895288wgh.23
        for <ceph-devel@vger.kernel.org>; Wed, 21 May 2014 05:12:23 -0700 (PDT)
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A5B17E4@MBX02-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If rbd cache enabled, I think it should be affected.

On Wed, May 21, 2014 at 8:00 PM, Luke Jing Yuan <jyluke@mimos.my> wrote:
> Hi,
>
> I am just curious would this issue be also applied to other DB like postgresql? My team is currently looking at this but we  are using a VM and install postgresql 9.3 on an attached device using RBD (via libvirt). We had yet to complete our planned tests but initial observations did indicate possible performance issues though we had yet to go through all possible options within postgresql.
>
> Regards,
> Luke
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
> Sent: Wednesday, 21 May, 2014 6:22 PM
> To: ceph-devel@vger.kernel.org
> Subject: Re: [Performance] Improvement on DB Performance
>
> I pushed the commit to fix this problem(https://github.com/ceph/ceph/pull/1848).
>
> With test program(Each sync request is issued with ten write request), a significant improvement is noticed.
>
> aio_flush                          sum: 914750     avg: 1239   count:
> 738      max: 4714   min: 1011
> flush_set                          sum: 904200     avg: 1225   count:
> 738      max: 4698   min: 999
> flush                              sum: 641648     avg: 173    count:
> 3690     max: 1340   min: 128
>
> Compared to last mail, it reduce each aio_flush request to 1239 ns instead of 24145 ns.
>
> I hope it's the root cause for db on rbd performance.
>
> On Wed, May 21, 2014 at 6:15 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Hi all,
>>
>> I remember there exists discuss about DB(mysql) performance on rbd.
>> Recently I test mysql-bench with rbd and found awful performance. So I
>> dive into it and find that main cause is "flush" request from guest.
>> As we know, applications such as mysql, ceph has own journal for
>> durable and journal usually send sync&direct io. If fs barrier is on,
>> each sync io operation make kernel issue "sync"(barrier) request to
>> block device. Here, qemu will call "rbd_aio_flush" to apply.
>>
>> Via systemtap, I found a amazing thing:
>> aio_flush                          sum: 4177085    avg: 24145  count:
>> 173      max: 28172  min: 22747
>> flush_set                          sum: 4172116    avg: 24116  count:
>> 173      max: 28034  min: 22733
>> flush                              sum: 3029910    avg: 4      count:
>> 670477   max: 1893   min: 3
>>
>> This statistic info is gathered in 5s. Most of consuming time is on
>> "ObjectCacher::flush". What's more, with time increasing, the flush
>> count will be increasing.
>>
>> After view source, I find the root cause is "ObjectCacher::flush_set",
>> it will iterator the "object_set" and look for dirty buffer. And
>> "object_set"  contains all objects ever opened.  For example:
>>
>> 2014-05-21 18:01:37.959013 7f785c7c6700  0 objectcacher flush_set
>> total: 5919 flushed: 5
>> 2014-05-21 18:01:37.999698 7f785c7c6700  0 objectcacher flush_set
>> total: 5919 flushed: 5
>> 2014-05-21 18:01:38.038405 7f785c7c6700  0 objectcacher flush_set
>> total: 5920 flushed: 5
>> 2014-05-21 18:01:38.080118 7f785c7c6700  0 objectcacher flush_set
>> total: 5920 flushed: 5
>> 2014-05-21 18:01:38.119792 7f785c7c6700  0 objectcacher flush_set
>> total: 5921 flushed: 5
>> 2014-05-21 18:01:38.162004 7f785c7c6700  0 objectcacher flush_set
>> total: 5922 flushed: 5
>> 2014-05-21 18:01:38.202755 7f785c7c6700  0 objectcacher flush_set
>> total: 5923 flushed: 5
>> 2014-05-21 18:01:38.243880 7f785c7c6700  0 objectcacher flush_set
>> total: 5923 flushed: 5
>> 2014-05-21 18:01:38.284399 7f785c7c6700  0 objectcacher flush_set
>> total: 5923 flushed: 5
>>
>> These logs record the iteration info, the loop will check 5920 objects
>> but only 5 objects are dirty.
>>
>> So I think the solution is make "ObjectCacher::flush_set" only
>> iterator the objects which is dirty.
>>
>> --
>> Best Regards,
>>
>> Wheat
>
>
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
> DISCLAIMER:
>
>
> This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).
>
>
> MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.
> ------------------------------------------------------------------
> -
> -
> DISCLAIMER:
>
> This e-mail (including any attachments) is for the addressee(s)
> only and may contain confidential information. If you are not the
> intended recipient, please note that any dealing, review,
> distribution, printing, copying or use of this e-mail is strictly
> prohibited. If you have received this email in error, please notify
> the sender  immediately and delete the original message.
> MIMOS Berhad is a research and development institution under
> the purview of the Malaysian Ministry of Science, Technology and
> Innovation. Opinions, conclusions and other information in this e-
> mail that do not relate to the official business of MIMOS Berhad
> and/or its subsidiaries shall be understood as neither given nor
> endorsed by MIMOS Berhad and/or its subsidiaries and neither
> MIMOS Berhad nor its subsidiaries accepts responsibility for the
> same. All liability arising from or in connection with computer
> viruses and/or corrupted e-mails is excluded to the fullest extent
> permitted by law.
>
>



-- 
Best Regards,

Wheat

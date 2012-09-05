From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Port no For data Transfer between OSDs
Date: Wed, 05 Sep 2012 15:04:46 +0200
Message-ID: <50474DEE.6060304@widodh.nl>
References: <CAGfy=6mz04CoytQdt4Zj-RdOqU+0XEv3eHAuPQ1E-Pu=6gAa+g@mail.gmail.com> <50471810.6000608@widodh.nl> <CAGfy=6koSdDSVSiYMwwm5Fm2JeQSCP8Pm4S8UAfSna45Gp0Ntw@mail.gmail.com> <50473CA2.3050806@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60654 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab2IENEt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 09:04:49 -0400
In-Reply-To: <50473CA2.3050806@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 09/05/2012 01:50 PM, Wido den Hollander wrote:
> On 09/05/2012 01:20 PM, hemant surale wrote:
>> Hi Wido , Community ,
>>
>> if we use number =2
>> in cmd as follows
>> "ceph osd pool set <poolname>  size <#no>"
>>
>> does it means for perticular Object we have 2 replica Or total 2
>> copies in cluster?
>>
>
> That will set replication to "2". That means, every object stored in the
> cluster will be stored twice.
>

Sorry, I have to correct myself there.

Every object in that (RADOS) POOL is stored twice, not the cluster. This 
is a pool specific setting, not cluster-wide.

Wido

> It is NOT object + 2, no it's object * 2.
>
> Wido
>
>>
>> Regards,
>> Hemant Surale.
>>
>> On Wed, Sep 5, 2012 at 2:44 PM, Wido den Hollander <wido@widodh.nl>
>> wrote:
>>> On 09/05/2012 07:30 AM, hemant surale wrote:
>>>>
>>>> Hi Community ,
>>>>               I want to trace the data transfer rates occurring between
>>>> osds while injecting data into ceph cluster. Can you please tell me
>>>> what ports should I monitor or keep track of?
>>>>               Thanks !
>>>
>>>
>>> OSDs start binding from port 6800 and counting up from there.
>>>
>>> For example, a machine with 4 OSDs running:
>>>
>>> root@atom0:~# netstat -nap|grep LISTEN|grep -E ^tcp|grep ceph-osd
>>> tcp6       0      0 :::6800                 :::* LISTEN
>>> 24329/ceph-osd
>>> tcp6       0      0 :::6801                 :::* LISTEN
>>> 24329/ceph-osd
>>> tcp6       0      0 :::6802                 :::* LISTEN
>>> 24329/ceph-osd
>>> tcp6       0      0 :::6803                 :::* LISTEN
>>> 24596/ceph-osd
>>> tcp6       0      0 :::6804                 :::* LISTEN
>>> 24596/ceph-osd
>>> tcp6       0      0 :::6805                 :::* LISTEN
>>> 24596/ceph-osd
>>> tcp6       0      0 :::6806                 :::* LISTEN
>>> 25316/ceph-osd
>>> tcp6       0      0 :::6807                 :::* LISTEN
>>> 25316/ceph-osd
>>> tcp6       0      0 :::6808                 :::* LISTEN
>>> 25316/ceph-osd
>>> tcp6       0      0 :::6809                 :::* LISTEN
>>> 25839/ceph-osd
>>> tcp6       0      0 :::6810                 :::* LISTEN
>>> 25839/ceph-osd
>>> tcp6       0      0 :::6811                 :::* LISTEN
>>> 25839/ceph-osd
>>> root@atom0:~#
>>>
>>> Wido
>>>
>>>>
>>>> Regards,
>>>> Hemant Surale.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


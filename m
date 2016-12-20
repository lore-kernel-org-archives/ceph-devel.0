From: Shubhendu Tripathi <shtripat@redhat.com>
Subject: Re: Feeding pool utilization data to time series for trending
Date: Tue, 20 Dec 2016 15:47:04 +0530
Message-ID: <a9d3de3f-ba6f-3baf-5772-08765a502414@redhat.com>
References: <0dafd5ff-1ed6-cb05-05d3-dff3afb43c44@redhat.com>
 <c0ef7893-2bd2-d11f-b008-db566145ce84@redhat.com>
 <aa72804e-767e-aaba-a2a8-e6df0e0a0536@redhat.com>
 <640241856.4849.1482224383452@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933423AbcLTKRI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Dec 2016 05:17:08 -0500
In-Reply-To: <640241856.4849.1482224383452@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/20/2016 02:29 PM, Wido den Hollander wrote:
>> Op 20 december 2016 om 5:19 schreef Shubhendu Tripathi <shtripat@redhat.com>:
>>
>>
>> Hi Team,
>>
>> Our team is currently working on project named "tendrl" [1][2].
>> Tendrl is a management platform for software defined storage system like
>> Ceph, Gluster etc.
>>
>> As part of tendrl we are integrating with collectd to collect
>> performance data and we maintain the time series data in graphite.
>>
>> I have a question at this juncture regarding pool utilization data.
>> As our thought process goes, we think of using output from command "ceph
>> df" and parse it to figure out pool utilization data and push it to
>> graphite using collectd.
>> The question here is what is/would be performance impact of running
>> "ceph df" command on ceph nodes. We should be running this command only
>> on mon nodes I feel.
>>
> Correct, that data comes from the MONs and is not that heavy.
>
>> Wanted to verify with the team here if this thought process is in right
>> direction and if so what ideally should be frequency of running the
>> command "ceph df" from collectd.
>>
> Running the command means forking a process every time and also going through the whole cephx authentication and client <> MON process.
>
>> This is just from our point of view and we are open to any other
>> foolproof solution (if any).
> The best would be to keep a open connection to a MON and run the 'df' command directly on the MONs in a loop.
>
> I wrote something like that in Python a while ago for 'ceph status': https://gist.github.com/wido/ac53ae01d661dd57f4a8
>
> cmd = {"prefix":"status", "format":"json"}
>
> If you change that to:
>
> cmd = {"prefix":"df", "format":"json"}
>
> You ask the MON for 'df' and get back a JSON. Run that in a loop where you sleep every 1 or 5 seconds and you should have very real-time information.

Thanks Wido. This is for sure a good suggestion.
I would try to incorporate this and test once.

Regards,
Shubhendu

>
> Wido
>
>> Kindly guide us.
>>
>> Regards,
>> Shubhendu Tripathi
>>
>> [1] http://tendrl.org/
>> [2] https://github.com/tendrl/
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


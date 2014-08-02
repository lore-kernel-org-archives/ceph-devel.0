From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Non existing monitor
Date: Sat, 02 Aug 2014 13:17:58 +0000
Message-ID: <53DCE506.6050106@inktank.com>
References: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2FE35@SACMBXIP01.sdcorp.global.sandisk.com> <CAPYLRzjRw-wTcv3Q2ZAKjmXKwNsLwL6gsj5BAJfSVSNcEg3New@mail.gmail.com> <68A06213B74F1742A2C48216AE1BB6B803FEDE4F@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:57944 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaHBNSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Aug 2014 09:18:02 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so5474640wes.38
        for <ceph-devel@vger.kernel.org>; Sat, 02 Aug 2014 06:18:01 -0700 (PDT)
In-Reply-To: <68A06213B74F1742A2C48216AE1BB6B803FEDE4F@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>, Gregory Farnum <greg@inktank.com>, Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On 01/08/14 18:20, Pavan Rallabhandi wrote:
> Greg,
>
> The commands used were to start monitor for an instance id that is non existing, for which a leveldb store error is thrown:
>
> <snip>
>
> src/ceph-mon -i foo
> 2014-08-01 02:47:08.210208 7f7341c3c800 -1 failed to create new leveldb store
>
> <\snip>
>
> The idea is to fix this behavior by throwing a relevant error.

The infrastructure is there (ceph_mon.cc) but is not doing what I 
believe it should.  It was introduced in 
1eafe8dc45419a6b7d319345cac7fbc0d684d1b1.  I'm fixing it now.

   -Joao

>
> Thanks,
> -Pavan.
>
> -----Original Message-----
> From: Gregory Farnum [mailto:greg@inktank.com]
> Sent: Friday, August 01, 2014 6:16 PM
> To: Aanchal Agrawal
> Cc: ceph-devel@vger.kernel.org; Pavan Rallabhandi; Samuel Just; Joao Luis
> Subject: Re: Non existing monitor
>
> On Fri, Aug 1, 2014 at 6:03 AM, Aanchal Agrawal <Aanchal.Agrawal@sandisk.com> wrote:
>> Any help on this ...
>>
>> -----Original Message-----
>> From: Aanchal Agrawal
>> Sent: Wednesday, July 30, 2014 3:37 PM
>> To: 'ceph-devel@vger.kernel.org'
>> Cc: Pavan Rallabhandi
>> Subject: Non existing monitor
>>
>> Hi,
>>
>> We found a case(bug?) in ceph mon code, where in, an attempt to start a non-existing monitor is throwing up a levelDB error saying "failed to create new leveldb store", instead we thought an appropriate message say "No Monitor present with that id" would do, by checking for the monitor existence way ahead.
>>
>> It seems that 'mon_exists()' checks for the existence of the mon data directory(via 'mon_data_exists()') and also for the non-empty nature of that directory(via 'mon_data_empty()'). The fix seemed pretty simple, as to flag the appropriate message if 'mon_data_exists()' were to set 'exists' to 'false', in case mkfs is not set.
>>
>> The other behavior that we are seeking clarity, again in case of mkfs not being set is, if 'mon_data_exists()' sets 'exists' to 'true' and 'mon_data_empty()' sets 'exists' to 'false' (meaning the mon data directory is present, but it is empty), then the current code seems to be going ahead in an attempt to open the 'store.db', and when open fails, it tries to create a new 'store.db' (though mkfs is not set) and eventually gives up throwing "unable to read magic from mon data".
>>
>> The questions we had around this were:
>>
>> 1) Though in case of mkfs not being set, what is the reason for creating a new levelDB store in case an attempt to open the 'store.db' is a failure, as levelDB anyways seem to be throwing 'magic' error going forward. Are there any use cases for this scenario?
>> 2) And also, is it valid to flag "No Monitor present" in case the mon data directory is existing, but with no data('store.db') in it, in case mkfs is not set?
>
> This is a little unclear to me. Can you describe exactly what commands you're running and what the response from the monitor is?
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com

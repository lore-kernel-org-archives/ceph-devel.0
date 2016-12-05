From: Yang Joseph <joseph.yang@xtaotech.com>
Subject: Re: [ceph-users] rgw: how to prevent rgw user from creating a new
 bucket?
Date: Mon, 5 Dec 2016 11:01:23 +0800
Message-ID: <5844D883.7060806@xtaotech.com>
References: <584158A2.9020303@xtaotech.com>
 <CADRKj5Rt6gDPXwQH9UivgWhLRqzbzVD7VECogU7iTmKUAihBHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:9225 "EHLO
        m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbcLEDB2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Dec 2016 22:01:28 -0500
In-Reply-To: <CADRKj5Rt6gDPXwQH9UivgWhLRqzbzVD7VECogU7iTmKUAihBHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Javen Wu <javen.wu@xtaotech.com>

Thank you very much for your response.

I‘m confused about what this cap related to?

On 12/03/2016 12:13 AM, Yehuda Sadeh-Weinraub wrote:
> On Fri, Dec 2, 2016 at 3:18 AM, Yang Joseph <joseph.yang@xtaotech.com> wrote:
>> Hello,
>>
>> I would like only to allow the user to read the object in a already existed
>> bucket, and not allow users
>> to create new bucket. It supposed to execute the following command:
>>
>> $ radosgw-admin metadata put user:test3 < ...
>>    ...
>>          "caps": [
>>              {
>>                  "type": "buckets",
>>                  "perm": "read"
>>              }
>>
>> But why user test3 can still create new bucket after I have set its caps to
>> "buckets=read"?
>>
>
> Because this cap is unrelated. iirc starting at jewel you can do:
>
> $ radosgw-admin user modify --uid=test3 --max-buckets=-1
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


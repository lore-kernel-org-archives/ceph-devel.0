From: Alex Gorbachev <ag@iss-integration.com>
Subject: Re: [ceph-users] mon health status gone from display
Date: Fri, 15 Sep 2017 14:49:17 -0400
Message-ID: <CADb9450NpZYn0ZkjRBY0Vqx37RnbsqD3Sgd-s100JNKDqvpj0w@mail.gmail.com>
References: <CADb9450qop5MYwHeg-Gw4GR=3bDNx-BPzFNC37kvpLbwpVTnMg@mail.gmail.com>
 <CALe9h7cEAXP+iKxmDesW9W7WC3Yhz3RzrHQY+5b92CgizZvamw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:53462 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdIOStT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 14:49:19 -0400
Received: by mail-pf0-f180.google.com with SMTP id x78so1868609pff.10
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 11:49:18 -0700 (PDT)
In-Reply-To: <CALe9h7cEAXP+iKxmDesW9W7WC3Yhz3RzrHQY+5b92CgizZvamw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi John,


On Fri, Sep 15, 2017 at 2:41 PM, John Spray <jspray@redhat.com> wrote:
> On Fri, Sep 15, 2017 at 7:01 PM, Alex Gorbachev <ag@iss-integration.com> wrote:
>> In Jewel and prior there was a health status for MONs in ceph -s JSON
>> output, this seems to be gone now.  Is there a place where a status of
>> a given monitor is shown in Luminous?
>
> Can you say which fields specifically you're missing?  We still have
> the quorum/quorum_names bits that let you work out whether the mon
> cluster is up by comparison to the mon map.

Old style: each mon shows if it's OK or not:

 "timechecks": {
            "epoch": 968,
            "round": 238,
            "round_status": "finished",
            "mons": [
                {
                    "name": "lab2-mon1",
                    "skew": 0.000000,
                    "latency": 0.000000,
                    "health": "HEALTH_OK"
                },
                {
                    "name": "lab2-mon2",
                    "skew": 0.000650,
                    "latency": 0.000595,
                    "health": "HEALTH_OK"
                },
                {
                    "name": "lab2-mon3",
                    "skew": 0.001890,
                    "latency": 0.000557,
                    "health": "HEALTH_OK"
                }



>
> I think we also used to have the clock skew data there, but I think we
> dropped it because it was kind of an obscure thing and didn't fit
> neatly into the new health checks format.
>
> John
>
>>
>> Thank you
>> --
>> Alex Gorbachev
>> Storcium
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

From: Alex Gorbachev <ag@iss-integration.com>
Subject: Re: [ceph-users] mon health status gone from display
Date: Fri, 15 Sep 2017 15:13:45 -0400
Message-ID: <CADb9451zU0mzNVwv71apEmg4jr-8StkBmq8wc8UxYHW4AOW1Gw@mail.gmail.com>
References: <CADb9450qop5MYwHeg-Gw4GR=3bDNx-BPzFNC37kvpLbwpVTnMg@mail.gmail.com>
 <CALe9h7cEAXP+iKxmDesW9W7WC3Yhz3RzrHQY+5b92CgizZvamw@mail.gmail.com>
 <CADb9450NpZYn0ZkjRBY0Vqx37RnbsqD3Sgd-s100JNKDqvpj0w@mail.gmail.com> <alpine.DEB.2.11.1709151850270.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:56315 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdIOTNr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 15:13:47 -0400
Received: by mail-pg0-f45.google.com with SMTP id b11so2021843pgn.12
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 12:13:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709151850270.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 15, 2017 at 2:51 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 15 Sep 2017, Alex Gorbachev wrote:
>> Hi John,
>>
>>
>> On Fri, Sep 15, 2017 at 2:41 PM, John Spray <jspray@redhat.com> wrote:
>> > On Fri, Sep 15, 2017 at 7:01 PM, Alex Gorbachev <ag@iss-integration.com> wrote:
>> >> In Jewel and prior there was a health status for MONs in ceph -s JSON
>> >> output, this seems to be gone now.  Is there a place where a status of
>> >> a given monitor is shown in Luminous?
>> >
>> > Can you say which fields specifically you're missing?  We still have
>> > the quorum/quorum_names bits that let you work out whether the mon
>> > cluster is up by comparison to the mon map.
>>
>> Old style: each mon shows if it's OK or not:
>>
>>  "timechecks": {
>>             "epoch": 968,
>>             "round": 238,
>>             "round_status": "finished",
>>             "mons": [
>>                 {
>>                     "name": "lab2-mon1",
>>                     "skew": 0.000000,
>>                     "latency": 0.000000,
>>                     "health": "HEALTH_OK"
>>                 },
>>                 {
>>                     "name": "lab2-mon2",
>>                     "skew": 0.000650,
>>                     "latency": 0.000595,
>>                     "health": "HEALTH_OK"
>>                 },
>>                 {
>>                     "name": "lab2-mon3",
>>                     "skew": 0.001890,
>>                     "latency": 0.000557,
>>                     "health": "HEALTH_OK"
>>                 }
>
> These time checks were moved to the 'ceph time-sync-status' command, which
> shows similar detail.  Note that if there is a skew we also trigger a
> new-style health warning/error that shows up in ceph health and ceph -s.
>
> sage

Thanks Sage, perfect.  Looks like if a mon is down it just does not
show up in  time-sync-status

Regards,
Alex

>
>
>
>>
>>
>>
>> >
>> > I think we also used to have the clock skew data there, but I think we
>> > dropped it because it was kind of an obscure thing and didn't fit
>> > neatly into the new health checks format.
>> >
>> > John
>> >
>> >>
>> >> Thank you
>> >> --
>> >> Alex Gorbachev
>> >> Storcium
>> >> _______________________________________________
>> >> ceph-users mailing list
>> >> ceph-users@lists.ceph.com
>> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

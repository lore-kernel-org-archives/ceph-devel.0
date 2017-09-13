From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: clearing unfound objects
Date: Tue, 12 Sep 2017 17:07:54 -0700
Message-ID: <CAKRxpuuMbavH4V7zEDaOzJFzG=eLU0XH2KjgF6EJh1EWevxxQw@mail.gmail.com>
References: <CAKRxpuu-P_Hp4F9KZTN_=OGaN_gHLUgLAosXE09716yAX9Wrag@mail.gmail.com>
 <alpine.DEB.2.11.1709122248360.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37574 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdIMAH4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 20:07:56 -0400
Received: by mail-it0-f44.google.com with SMTP id o200so3021667itg.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 17:07:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709122248360.24068@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I attached the complete output with the previous email.

...
    "objects": [
        {
            "oid": {
                "oid": "200.0000052d",
                "key": "",
                "snapid": -2,
                "hash": 2728386690,
                "max": 0,
                "pool": 6,
                "namespace": ""
            },
            "need": "1496'15853",
            "have": "0'0",
            "flags": "none",
            "locations": []
        }


So it goes Filename -> OID -> PG -> OSD? So if I trace down
"200.0000052d" I should be able to clear the problem? I seem to get
files in the lost+found directory think from fsck. Does the deep
scrubbing eventually clear these after a week or will they always
require manual intervention?

On Tue, Sep 12, 2017 at 3:48 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 12 Sep 2017, Two Spirit wrote:
>> >On Tue, 12 Sep 2017, Two Spirit wrote:
>> >> I don't have any OSDs that are down, so the 1 unfound object I think
>> >> needs to be manually cleared. I ran across a webpage a while ago that
>> >> talked about how to clear it, but if you have a reference, would save
>> >> me a little time.
>> >
>> >http://docs.ceph.com/docs/master/rados/troubleshooting/troubleshooting-pg/#failures-osd-unfound
>>
>> Thanks. That was the page I had read earlier.
>>
>> I've attached the full outputs to this mail and show just clips below.
>>
>> # ceph health detail
>> OBJECT_UNFOUND 1/731529 unfound (0.000%)
>>     pg 6.2 has 1 unfound objects
>>
>> There looks like one number that shouldn't be there...
>> # ceph pg 6.2 list_missing
>> {
>>     "offset": {
>> ...
>>         "pool": -9223372036854775808,
>>         "namespace": ""
>>     },
>> ...
>
> I think you've snipped out the bit that has the name of the unfound
> object?
>
> sage
>
>>
>> # ceph -s
>>     osd: 6 osds: 6 up, 6 in; 10 remapped pgs
>>
>> This shows under the pg query that something believes that osd "2" is
>> down, but all OSDs are up, as seen in the previous ceph -s command.
>> # ceph pg 6.2 query
>>     "recovery_state": [
>>         {
>>             "name": "Started/Primary/Active",
>>             "enter_time": "2017-09-12 10:33:11.193486",
>>             "might_have_unfound": [
>>                 {
>>                     "osd": "0",
>>                     "status": "already probed"
>>                 },
>>                 {
>>                     "osd": "1",
>>                     "status": "already probed"
>>                 },
>>                 {
>>                     "osd": "2",
>>                     "status": "osd is down"
>>                 },
>>                 {
>>                     "osd": "4",
>>                     "status": "already probed"
>>                 },
>>                 {
>>                     "osd": "5",
>>                     "status": "already probed"
>>                 }
>>
>>
>> If i go to a couple other OSDs, and run the same command,
>> the osd "2" is listed as "already probed". They are not in sync. I
>> double checked that all the OSDs were up on all 3 times I ran the
>> command.
>>
>> Now. my question to debug this to figure out if I want to
>> "revert|delete", is what in the heck are these file(s)/object(s)
>> associated with the pg? I assume this might be in the MDS, but I'd
>> like to see a file name associated with this to make a further
>> determination of what I should do.  I don't have enough information at
>> this point to figure out how I should recover.
>>

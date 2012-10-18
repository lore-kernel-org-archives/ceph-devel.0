From: Christian Huang <ythuang@gmail.com>
Subject: Re: limit of maximum number of rbd devices that can be mapped
Date: Thu, 18 Oct 2012 11:12:58 +0800
Message-ID: <CAP5wSLeXJ-dggxnMC4a=B0oPd6KwnE_MN+4N4xs8y=cwVvXTig@mail.gmail.com>
References: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com>
	<507F66F1.4000509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63752 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab2JRDM7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 23:12:59 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so5991720iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 20:12:59 -0700 (PDT)
In-Reply-To: <507F66F1.4000509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
    i see,
    could this be relevant?
    SCSI disk limitations: Defining the number of disk devices on Linux
    http://publib.boulder.ibm.com/infocenter/dsichelp/ds6000ic/index.jsp?topic=%2Fcom.ibm.storage.smric.help.doc%2Ff2c_linuxscsilimit_2hsag9.html

    also from the description of the following 2 sections, it seems
this limit can be made much higher?
    http://www.makelinux.net/ldd3/chp-3-sect-2
    http://www.makelinux.net/ldd3/chp-16-sect-1

Best Regards.


On Thu, Oct 18, 2012 at 10:18 AM, Alex Elder <elder@inktank.com> wrote:
> On 10/17/2012 09:15 PM, Christian Huang wrote:
>> Hi,
>>     what is the maximum number of rbd devices that can be mapped on a
>> single host?
>>     we recently did a test to mount a large number of rbd devices and
>> hit a wall around 230
>>     with the following message
>
> That sounds about right.  We were just discussing this earlier
> this week.  It's limited at the moment by the number of major
> device numbers available on the system, and I think you found
> that limit.  We would obviously like to have a solution for
> this but we've only just started considering options.
>
>                                         -Alex
>
>> with 230 rbd devices already mapped, the next one yielded this.
>> Console output
>> wistor@wistor-002:~$ sudo rbd map test299
>> add failed: (16) Device or resource busy
>>
>> dmesg
>> [77962.346749] register_blkdev: failed to get major for rbd229
>>
>> Chris.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

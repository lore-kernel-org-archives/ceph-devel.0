From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: feature request to "ceph osd status"
Date: Tue, 29 Aug 2017 21:51:41 -0700
Message-ID: <CAKRxpuuDuEDtkuCkuBUYi-mhteLEOznWE5uhw7Qr5kTykT1zyA@mail.gmail.com>
References: <CAKRxpuuGOHvvrkg+XkDo3jWnbr2o4eObru5yBEuChyJpD=e=ew@mail.gmail.com>
 <CALe9h7c-zu=nSARjS1kf8xEqde_bg0FaRkqF8e-Zo=zn8MrBUg@mail.gmail.com> <CAKRxpuuS+9ZpE-LagAg6HG01gcCf0XwXxLWBAMOhO3OPUuThDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:37505 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdH3Evm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 00:51:42 -0400
Received: by mail-io0-f176.google.com with SMTP id d78so134721ioe.4
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 21:51:42 -0700 (PDT)
In-Reply-To: <CAKRxpuuS+9ZpE-LagAg6HG01gcCf0XwXxLWBAMOhO3OPUuThDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I found "ceph pg dump" also gives the same OSD disk usage information.
It has summary row, as well as 3 columns.
The bad thing is that the numbers in ceph pg dump and ceph osd status
do not match. I'm guessing someone isn't dividing by 1024.
I think for consistency the PG stuff should go under ceph pg, and OSD
info go under ceph osd.

As an IT person, I like to to write perl scripts around the outputs,
and so persistence of the output format is desired

On Tue, Aug 29, 2017 at 2:50 PM, Two Spirit <twospirit6905@gmail.com> wrote:
> I agree the information is redundant, but when I'm trying to figure
> out what is going on, it is very nice to have all info right in front
> of my face instead of uber bare bones. Running 'df -kh' shows  [Total]
> Size, Used, Avail and Use%. That is one step past redundant, but it is
> aweful nice to see whatever information I want quickly as well as in a
> familiar format and bit of info I think unix it guys are use to. I can
> pick the columns of information I need based on what I'm trying to
> debug. just my two bits on a feature request.
>
> On Mon, Aug 28, 2017 at 5:01 AM, John Spray <jspray@redhat.com> wrote:
>> On Sat, Aug 26, 2017 at 7:07 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>>> Hi. I found this command by accident. it doesn't seem to be undocumented.
>>>
>>> ceph osd status
>>>
>>> There is a very similiar command "ceph osd stat" with different info
>>>
>>> The status command is very useful command and I'd like to see it stay
>>> around even tho it seems to be an undocumented command.
>>>
>>> It would be nice to have a 3rd column "total" which is used+avail
>>> columns and then another row at the bottom subtotaling the "used",
>>> "avail", and "total" columns.
>>
>> I prefer to pick two of avail/used/total, rather than printing all
>> three -- otherwise the information is a bit redundant.
>>
>> Putting some totals at the bottom is an interesting idea though.  The
>> "osd status" and "fs status" commands are implemented in a python
>> module[1], so anyone who knows a little python could add that.
>>
>> John
>>
>> 1. https://github.com/ceph/ceph/blob/master/src/pybind/mgr/status/module.py
>>
>>>
>>> I know all these could be be calculated, but with more OSDs, it is
>>> convenient to have it all available at a glance<div
>>> id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
>>> <table style="border-top: 1px solid #D3D4DE;">
>>>         <tr>
>>>         <td style="width: 55px; padding-top: 13px;"><a
>>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>>> target="_blank"><img
>>> src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
>>> alt="" width="46" height="29" style="width: 46px; height: 29px;"
>>> /></a></td>
>>>                 <td style="width: 470px; padding-top: 12px; color: #41424e;
>>> font-size: 13px; font-family: Arial, Helvetica, sans-serif;
>>> line-height: 18px;">Virus-free. <a
>>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>>> target="_blank" style="color: #4453ea;">www.avg.com</a>
>>>                 </td>
>>>         </tr>
>>> </table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
>>> height="1"></a></div>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

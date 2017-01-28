From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: End of life for Ceph Hammer 0.94.x ?
Date: Sat, 28 Jan 2017 10:08:03 -0500
Message-ID: <CA+aFP1AdmMPXwg9ukAo38SXKaBm+CFOY=rTf9pq36J--QeWqow@mail.gmail.com>
References: <CAH7C+PqR_gGMp06QT3cZwND3Ju5RZPdqFreA-EnixLhn8rAHYQ@mail.gmail.com>
 <CAMMFjmEkWx7sr_2VD+V-jDycr_0LrKEMqN0UyieR3KOTsX3K7Q@mail.gmail.com> <5d96f9ed-fcbe-10df-08ea-3bebe373ac2f@suse.cz>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34662 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdA1PIs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jan 2017 10:08:48 -0500
Received: by mail-lf0-f50.google.com with SMTP id v186so175470807lfa.1
        for <ceph-devel@vger.kernel.org>; Sat, 28 Jan 2017 07:08:05 -0800 (PST)
In-Reply-To: <5d96f9ed-fcbe-10df-08ea-3bebe373ac2f@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Yuri Weinstein <yweinste@redhat.com>, David Moreau Simard <dms@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.org

I think the same release page states that an LTS release will continue
to receive updates until two subsequent LTS releases are available
(i.e. Hammer would EOL when Luminous is released).  If we are EOLing
Hammer due to the release of Kraken (or because Jewel is a necessary
upgrade stepping point), should the release page verbiage be tweaked
as well?

On Fri, Jan 27, 2017 at 6:20 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi David:
>
> As Yuri said, 0.94.10 is currently in final testing prior to release. I have
> a PR [1] open to set the "actual retirement" date.
>
> Nathan
>
> [1] https://github.com/ceph/ceph/pull/13069
>
>
> On 01/27/2017 09:55 PM, Yuri Weinstein wrote:
>>
>> We are testing a RC of 0.94.10 [1], I suspect that'd be "real" EOL of
>> hammer.
>>
>> [1]: http://tracker.ceph.com/issues/17151
>>
>> Thx
>> YuriW
>>
>> On Fri, Jan 27, 2017 at 11:44 AM, David Moreau Simard <dms@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> Hammer, as per the releases page [1] was scheduled to be EOL in November
>>> 2016.
>>> However, there is no "actual retirement" listed for Hammer yet.
>>>
>>> The latest version, 0.94.9, was released at the end of August 2016.
>>>
>>> I'd like to know if there is a plan for a formal/official EOL of
>>> Hammer and, if so, if there will be a final dot release (ex: 0.94.10)
>>> to flush whatever backports/bugfixes may be in the pipe.
>>>
>>> Thanks,
>>>
>>> [1]: http://docs.ceph.com/docs/master/releases/
>>>
>>> David Moreau Simard
>>> Senior Software Engineer | Openstack RDO
>>>
>>> dmsimard = [irc, github, twitter]
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason

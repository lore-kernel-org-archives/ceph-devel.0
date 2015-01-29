From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw + s3 + keystone + Browser-Based POST bug
Date: Thu, 29 Jan 2015 09:28:07 -0800
Message-ID: <CABBk=J-Z1e70oWoAz7x9Gd7AnE-6bAk1sGQ3t97MmA6dRyZ4-Q@mail.gmail.com>
References: <54CA50CF.5010109@switch.ch>
	<87k3054irn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36297 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbbA2R2I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 12:28:08 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so41583171pab.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 09:28:07 -0800 (PST)
In-Reply-To: <87k3054irn.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Valery Tschopp <valery.tschopp@switch.ch>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 29, 2015 at 9:09 AM, Abhishek L
<abhishek.lekshmanan@gmail.com> wrote:
> Hi
>
> Valery Tschopp writes:
>
>> Hi guys,
>>
>> We have integrated our radosgw (v0.80.7) with our OpenStack Keystone
>> server (icehouse) successfully.
>>
>> The "normal" S3 operations can be executed with the Keystone user's EC2
>> credentials (EC2_ACCESS_KEY, EC2_SECRET_KEY). The radosgw correctly
>> handles these user credentials, ask keystone to validate them, and the
>> resulting objects belong to the Keystone tenant/project or the user
>> (user is member of the tenant/project).
>>
>> But for the "Browser-based upload POST" [1] it doesn't work! The user is
>> not correctly resolved, and the radosgw returns a 403 code!
>>
>> It looks like the s3 keystone integration doesn't work correctly when a
>> S3 browser-based upload POST is used.
>>
>> See the attached log file (radosgw.log), you can clearly see the user
>> lookup failing, and the status being set to 403:
>>
>>
>> 2015-01-29 15:11:30.151157 7f25616fa700  0 User lookup failed!
>> 2015-01-29 15:11:30.151171 7f25616fa700 15 Read
>> RGWCORSConfiguration<CORSConfiguration><CORSRule><AllowedMethod>POST</AllowedMethod><AllowedOrigin>https://staging.tube.switch.ch</AllowedOrigin><AllowedHeader>*</AllowedHeader></CORSRule></CORSConfiguration>
>> 2015-01-29 15:11:30.151184 7f25616fa700 10 Method POST is supported
>> 2015-01-29 15:11:30.151195 7f25616fa700  2 req 1123:0.013204:s3:POST
>> /:post_obj:http status=403
>>
>>
>> Is this a bug? Or did we miss something else?
>
> Looks like you may be hitting http://tracker.ceph.com/issues/10062,
> where s3 POST requests were failing with keystone. There is a patch that
> is merged in master[1] that addresses this. We would also love
> to see this ported back to firefly/giant.

I just set it to get backported for firefly and giant.

Thanks,
Yehuda

>
> [1] https://github.com/ceph/ceph/pull/3251
>
>
> Regards
> --
> Abhishek

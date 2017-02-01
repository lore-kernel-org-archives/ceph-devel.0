From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Wed, 1 Feb 2017 12:23:52 -0500
Message-ID: <CAGbvivLcCvcKXjECm4AXb11MCnx57QS+ZF8xRt3--CV416hkyg@mail.gmail.com>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz> <654478439.8953.1485969439774@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36840 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdBARXx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 12:23:53 -0500
Received: by mail-io0-f169.google.com with SMTP id j13so161555629iod.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 09:23:53 -0800 (PST)
In-Reply-To: <654478439.8953.1485969439774@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Any chance this one gets fixed in 10.2.6?

http://tracker.ceph.com/issues/14115

On Wed, Feb 1, 2017 at 12:17 PM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 1 februari 2017 om 16:35 schreef Nathan Cutler <ncutler@suse.cz>:
>>
>>
>> Hi Abhishek:
>>
>> The stable releases and backports team has been working to prepare the
>> Jewel 10.2.6 release and so far we have merged a large number of
>> bugfixes and even some features that were judged to be worth backporting.
>>
>> I don't have a full list, yet, because I'm still merging RGW backports
>> and there a few more miscellaneous backports still in the queue. The
>> integration tests are looking better and better, and I expect these will
>> be merged within the next week or two.
>>
>> Do you think it's time to publish a 10.2.6 point release?
>
> I would ask to wait a bit. Some long outstanding issues with RGW are data leaks and the orphan scan not working.
>
> These issues:
>
> - http://tracker.ceph.com/issues/18331
> - http://tracker.ceph.com/issues/18258
>
> As 10.2.7 might take a long time I would ask to wait for Yehuda. He says to be close. I and many other users would like to see this fixed sooner then later.
>
> Wido
>
>>
>> Nathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

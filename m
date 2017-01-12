From: John Spray <jspray@redhat.com>
Subject: Re: XmlFormatter: space isn't allowed in xml tag
Date: Thu, 12 Jan 2017 10:34:19 +0000
Message-ID: <CALe9h7e_8fLMyRpn_Ro1yTd6iNiE79ie=Kh5qyGpUgFT7WFMcw@mail.gmail.com>
References: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
 <CACKY0b_9aC4J7yz45u1p4pYvCDXXx5fRACjjez82X7Fuba7HgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36737 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdALKep (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 05:34:45 -0500
Received: by mail-oi0-f45.google.com with SMTP id u143so17810511oif.3
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 02:34:40 -0800 (PST)
In-Reply-To: <CACKY0b_9aC4J7yz45u1p4pYvCDXXx5fRACjjez82X7Fuba7HgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2017 at 6:15 AM, liuchang0812 <liuchang0812@gmail.com> wrote:
> sorry, Our XMLFormatter has this feature, but lowercased_underscored
> is false default.
>
>
> XMLFormatter(bool pretty = false, bool lowercased_underscored = false);

I see this was added in this commit:
commit 4ea0c7c65d9e627acb73524afdc7f51ac02aa25d
Author: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Date:   Thu Oct 22 18:56:14 2015 +0200

    rgw: XMLFormatter may print XML tags lowercased and underscored now.


...but I can't see why the parameter was ever optional -- I think we
should just always do this transformation?

John


>
> 2017-01-12 13:27 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
>> hi, all
>>
>> an XML tag cannot contains space in it. see
>> https://www.w3.org/TR/2008/REC-xml-20081126/#NT-NameChar.
>>
>> Ceph uses `xmlformatter` to dump XML text, and there are a lot of
>> space in xml tag currently. so, need we fix this?
>>
>> We could fix this as :
>> 1. simple solution: replace `space` with `_`
>> 2. urlencode: \n = &#xA; \r = &#xD; \t = &#x9; space = &#x20;
>>
>> any comments are appreciated!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

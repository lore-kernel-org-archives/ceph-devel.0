From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: XmlFormatter: space isn't allowed in xml tag
Date: Thu, 12 Jan 2017 14:15:37 +0800
Message-ID: <CACKY0b_9aC4J7yz45u1p4pYvCDXXx5fRACjjez82X7Fuba7HgA@mail.gmail.com>
References: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35834 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbdALGPi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 01:15:38 -0500
Received: by mail-yw0-f171.google.com with SMTP id l19so6162298ywc.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2017 22:15:38 -0800 (PST)
In-Reply-To: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

sorry, Our XMLFormatter has this feature, but lowercased_underscored
is false default.


XMLFormatter(bool pretty = false, bool lowercased_underscored = false);

2017-01-12 13:27 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
> hi, all
>
> an XML tag cannot contains space in it. see
> https://www.w3.org/TR/2008/REC-xml-20081126/#NT-NameChar.
>
> Ceph uses `xmlformatter` to dump XML text, and there are a lot of
> space in xml tag currently. so, need we fix this?
>
> We could fix this as :
> 1. simple solution: replace `space` with `_`
> 2. urlencode: \n = &#xA; \r = &#xD; \t = &#x9; space = &#x20;
>
> any comments are appreciated!

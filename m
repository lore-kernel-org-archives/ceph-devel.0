From: liuchang0812 <liuchang0812@gmail.com>
Subject: XmlFormatter: space isn't allowed in xml tag
Date: Thu, 12 Jan 2017 13:27:33 +0800
Message-ID: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35795 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750700AbdALF1e (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 00:27:34 -0500
Received: by mail-yw0-f172.google.com with SMTP id l19so5681833ywc.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2017 21:27:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi, all

an XML tag cannot contains space in it. see
https://www.w3.org/TR/2008/REC-xml-20081126/#NT-NameChar.

Ceph uses `xmlformatter` to dump XML text, and there are a lot of
space in xml tag currently. so, need we fix this?

We could fix this as :
1. simple solution: replace `space` with `_`
2. urlencode: \n = &#xA; \r = &#xD; \t = &#x9; space = &#x20;

any comments are appreciated!

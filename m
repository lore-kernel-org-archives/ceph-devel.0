From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: mon config update
Date: Thu, 11 Jan 2018 12:18:09 -0800
Message-ID: <CA+2bHPY1_EeFMpSMUBG=EwLnhtTmjzT=dFnWcscUPryAOoYyVQ@mail.gmail.com>
References: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal>
 <2b36d420-2646-4955-24ae-ed4a3688c094@corp.ovh.com> <alpine.DEB.2.11.1801111509180.20939@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:40182 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932766AbeAKUSl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jan 2018 15:18:41 -0500
Received: by mail-qk0-f181.google.com with SMTP id d18so5942249qke.7
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jan 2018 12:18:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801111509180.20939@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 11, 2018 at 7:10 AM, Sage Weil <sage@newdream.net> wrote:
> 2. 'config dump' and 'config get' have a new "RW" column (suggestions for
> a better short column name are welcome!):

"RO" (read-only) is a bit more common I think and clear in intent.
(i.e. RW false mean no reads?)

-- 
Patrick Donnelly

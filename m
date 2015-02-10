From: Gregory Farnum <greg@gregs42.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 09:31:00 -0800
Message-ID: <CAC6JEv-_w1QXFrAEo8CoZncdkK5Wr6h0414zWSK+4b56-3ECGw@mail.gmail.com>
References: <54DA3A5B.5050509@dachary.org>
	<54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>
	<54DA3E72.9010600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39308 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbbBJRbB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 12:31:01 -0500
Received: by iecvy18 with SMTP id vy18so7034040iec.6
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 09:31:01 -0800 (PST)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com. [209.85.213.180])
        by mx.google.com with ESMTPSA id qd2sm8196389igc.22.2015.02.10.09.31.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 09:31:00 -0800 (PST)
Received: by mail-ig0-f180.google.com with SMTP id b16so25096172igk.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 09:31:00 -0800 (PST)
In-Reply-To: <54DA3E72.9010600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 10, 2015 at 9:22 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 10/02/2015 18:19, Yuri Weinstein wrote:>
>> Loic,
>>
>> The only difference between options if we run suits on merged dumpling vs dumpling-backports first - is time.
>> We will have to run suites on the final branch after the merge anyway.
>
> Could you explain why ? After merging dumpling and dumpling-backports will be exactly the same.

"Ship what you test." :) That definitely needs to happen.

I don't have a dog in this, but given our historic usage patterns and
the testing it's already gone through I think it's probably fine to do
the merge and then final testing.
-Greg

From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next firefly release
Date: Sun, 1 Mar 2015 08:54:09 -0800
Message-ID: <CAC6JEv_oDvfnMJZZ-52E-pZ1VW52owvbVAvv-wuJCAsq0OE+vg@mail.gmail.com>
References: <54F1CE4B.5020004@dachary.org>
	<CAC6JEv9C0g7Kz2eXhzP8-ENVADnHvc+AiRnMvRi6-GwYerEwjA@mail.gmail.com>
	<54F2E787.90003@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:45741 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbCAQyL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Mar 2015 11:54:11 -0500
Received: by igjz20 with SMTP id z20so11672585igj.4
        for <ceph-devel@vger.kernel.org>; Sun, 01 Mar 2015 08:54:10 -0800 (PST)
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com. [209.85.223.172])
        by mx.google.com with ESMTPSA id n17sm5599025igi.2.2015.03.01.08.54.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2015 08:54:10 -0800 (PST)
Received: by iecat20 with SMTP id at20so42333378iec.12
        for <ceph-devel@vger.kernel.org>; Sun, 01 Mar 2015 08:54:09 -0800 (PST)
In-Reply-To: <54F2E787.90003@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Mar 1, 2015 at 2:18 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> On 01/03/2015 06:00, Gregory Farnum wrote:
>> On Sat, Feb 28, 2015 at 6:18 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi Greg,
>>>
>>> The fs teuthology suite for the next firefly release as found in https://github.com/ceph/ceph/commits/firefly-backports came back with three failures : http://tracker.ceph.com/issues/10641#fs. Do you think it is ready for QE to start their own round of testing ?
>>>
>>> Cheers
>>>
>>> P.S. I'll include the fs suite as part of the pre-QE round of testing from now on, unless you think it is redundant or not useful.
>>
>> It'd be nice to see those tests run on a new enough kernel that they
>> pass,
>
> Is there an open issue for this or should I create one ?

Not to do it automatically, no. That's made difficult since it just
runs as part of the generic workunits (which otherwise don't need a
kernel of any particular kind) and we actually want to run across a
variety of kernels to detect other bugs.
-Greg

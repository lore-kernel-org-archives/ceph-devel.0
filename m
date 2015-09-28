From: Yazen Ghannam <yazen.ghannam@linaro.org>
Subject: Re: aarch64 not using crc32?
Date: Mon, 28 Sep 2015 10:04:00 -0400
Message-ID: <CA+dbMpuhRhgqBHjx=2dgYAr228O5hi4LYiKd3BXp4Ss6bC_89Q@mail.gmail.com>
References: <alpine.DEB.2.00.1509240514480.13834@cobra.newdream.net>
	<04fe95b7-75f4-46bf-9b05-baa3bb5ceef7@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35043 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbbI1OEB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 10:04:01 -0400
Received: by ioiz6 with SMTP id z6so175345332ioi.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 07:04:00 -0700 (PDT)
In-Reply-To: <04fe95b7-75f4-46bf-9b05-baa3bb5ceef7@email.android.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pankaj Garg <pankaj.garg@caviumnetworks.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

HWCAP_CRC32 and others were added to the Kernel with this commit
4bff28ccda2b7a3fbdf8e80aef7a599284681dc6; it looks like this first
landed in v3.14. Are you using the stock Kernel on Trusty (v3.13?)?
Can you update to a later version for gitbuilder? For regular testing
v3.19 (lts-vivid) may be a good choice since this also includes the
arm64 CRC32 Kernel module.

Thanks,
Yazen

On Thu, Sep 24, 2015 at 9:35 AM, Pankaj Garg
<pankaj.garg@caviumnetworks.com> wrote:
> Hi Sage,
> I actually had the same issue just a couple weeks back. The hardware actually has the CRC32 capability and we have tested it. This issue lies the toolchain on the machine. There are several versions of .h files present with different HWCAP #defines. We need to fix it so that we are using the right one. There is a version of that file present which defines this capability, but is not being included. I will look into this issue and let you know. Since my builds were just being tested on ARM, I hardcoded the presence of CRC.
>
> Thanks,
> -Pankaj
>
> On Sep 24, 2015 5:17 AM, Sage Weil <sweil@redhat.com> wrote:
>>
>> Hi Pankaj,
>>
>> In order to get the build going on the new trusty gitbuilder I had to make
>> this change:
>>
>> https://github.com/ceph/ceph/commit/3123b2c5d3b72c9d43b10d8f296305d41b68b730
>>
>> It was clearly a bug, but what worries me is that the fact that I hit it
>> means the HWCAP_CRC32 is not present.  Is there a problem with the
>> hardware feature detection or is that feature simply missing from the box
>> we're using?
>>
>> Thanks!
>> sage

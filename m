From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 25 Jan 2016 14:20:11 -0800
Message-ID: <CAFMfnwrq_UWWkcRJxA060UQ8rg8JACZE7Ks2DC_xsv2xVRrHLg@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<20151215142304.GI31644@suse.de>
	<CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
	<alpine.DEB.2.00.1512161431530.10312@cobra.newdream.net>
	<CAHMeWhHfiakLOJ6BDosXm1P1GDA0TR-pYt+UpZOeQJv4LFYtXA@mail.gmail.com>
	<CAHMeWhHn-8dD_5+1zDizBijwwMZNS7K9ukHk_y_EQQxjKgM88g@mail.gmail.com>
	<20160118122116.GH26972@suse.de>
	<CA+H5UW0jK58c5-n3TjkdN=WXkAp+exhWEUBePdCTfVB56_sHrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33696 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcAYWUM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 17:20:12 -0500
Received: by mail-yk0-f169.google.com with SMTP id k129so179840308yke.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 14:20:11 -0800 (PST)
In-Reply-To: <CA+H5UW0jK58c5-n3TjkdN=WXkAp+exhWEUBePdCTfVB56_sHrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Lars Marowsky-Bree <lmb@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

> I can agree that in case of HDDs full disk encryption is an affordable
> solution. This is a consequence of relatively low throughput of a magnetic
> carrier in comparison to modern crypto performance.
> However, the status quo is challenged by proliferation of fast SSDs.
> It drives demand for crypto performance much higher. HW acceleration
> would become must-have.

Right, most workloads are likely bottlenecked by seeks - not math.

>> Implementation of this API may be based on AF_ALG kernel
>> interface. This assures the ability to use hardware accelerations
>> already implemented in Linux kernel. Moreover, due to working on
>> bigger chunks (dm-crypt operates on 512 byte long sectors) the raw
>> encryption performance may be even higher.
>
> There are at least three approaches that can be combined to form a holistic
> solution:
>  1) minimizing amount of plaintext through per-poor granulation,
>  2) skipping repetitive encryption,
>  3) utilizing full performance of an accelerator.
>
> dm-crypt is not optimized for advanced HW accelerators. Using the same
> accelerator in different way gives more performance gain.

What hardware accelerators are we talking about here?

Intel's AES_NI instructions are already helping accelerate dm-crypt, and
you don't need AF_ALG in userland to use them either. Is there a significant
difference in cost between crypto PCIe card(s), and simply buying SED SSDs?

It seems to me that if you are willing to trust a black box (crypto
card), you might
as well trust the drive manufacturer to do your encryption. The benefit of SED
would be that the crypo throughput increases linearly with the storage.

-- 

Kyle Bader

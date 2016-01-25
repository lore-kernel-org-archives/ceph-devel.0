From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 25 Jan 2016 20:05:11 +0100
Message-ID: <CA+H5UW0jK58c5-n3TjkdN=WXkAp+exhWEUBePdCTfVB56_sHrA@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<20151215142304.GI31644@suse.de>
	<CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
	<alpine.DEB.2.00.1512161431530.10312@cobra.newdream.net>
	<CAHMeWhHfiakLOJ6BDosXm1P1GDA0TR-pYt+UpZOeQJv4LFYtXA@mail.gmail.com>
	<CAHMeWhHn-8dD_5+1zDizBijwwMZNS7K9ukHk_y_EQQxjKgM88g@mail.gmail.com>
	<20160118122116.GH26972@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35782 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933029AbcAYTFM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 14:05:12 -0500
Received: by mail-wm0-f51.google.com with SMTP id r129so76843268wmr.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 11:05:12 -0800 (PST)
In-Reply-To: <20160118122116.GH26972@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hello Lars,

> By not encrypting the entire OSD device, one becomes susceptible to
> metadata analysis (on the file store), data exposure, etc.

Agreed, filesystem-related metadata like mtime, ctime and size will be
available.

Alll data related to a RADOS object will be encrypted. This includes:
 * object name,
 * object data,
 * user attributes names,
 * user attributes values,
 * OMAP header content,
 * OMAP attributes names (keys),
 * OMAP values.
Metadata of RADOS object that will be available: data size, OMAP header
size, existence of user/OMAP attributes. For many use cases (eg. RBD)
this isn't an issue.

> I'd obviously be delighted to see this all sped up (and consume less
> power), but as long as the system is fast enough to encrypt at
> near-device speeds, this seems preferable.

I can agree that in case of HDDs full disk encryption is an affordable
solution. This is a consequence of relatively low throughput of a magnetic
carrier in comparison to modern crypto performance.
However, the status quo is challenged by proliferation of fast SSDs.
It drives demand for crypto performance much higher. HW acceleration
would become must-have.

There are at least three approaches that can be combined to form a holistic
solution:
 1) minimizing amount of plaintext through per-poor granulation,
 2) skipping repetitive encryption,
 3) utilizing full performance of an accelerator.

dm-crypt is not optimized for advanced HW accelerators. Using the same
accelerator in different way gives more performance gain.

In summary: expected performance benefits may justify introducing mechanism
targeting those use cases where covering full set of filesystem metadata (ctime,
mtime, size) isn't required.

Best regards,
Adam Kupczyk,
Radoslaw Zarzynski

From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Probable memory leak in Hammer write path ?
Date: Wed, 1 Jul 2015 17:07:14 +0100
Message-ID: <CAC6JEv9WmQ5=5Z=bZmMEjMF5o34WkUeabjEzsZujKVS4TNxQ5w@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB0142@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAC6JEv9sfdLtMKjpSJzRxgOjLOMH-kvj0MtA1i4jnCne4FtStA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB08F9@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34697 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbGAQHZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jul 2015 12:07:25 -0400
Received: by igcsj18 with SMTP id sj18so138569169igc.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jul 2015 09:07:25 -0700 (PDT)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com. [209.85.223.180])
        by mx.google.com with ESMTPSA id o19sm1617262igi.14.2015.07.01.09.07.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 09:07:24 -0700 (PDT)
Received: by iebmu5 with SMTP id mu5so37811643ieb.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jul 2015 09:07:14 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB08F9@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 29, 2015 at 4:39 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Greg,
> Updating to the new kernel updating the gcc version too. Recent kernel is changing tcmalloc version too, but, 3.16 has old tcmalloc but still exhibiting the issue.
> Yes, the behavior is very confusing and compiler is main variable I could think of from application perspective.
> If you have a 3.16/3.19 kernel, you could reproduce this following these steps.
>
> 1. Build ceph-hammer code base
>
> 2. Run with single OSD.
>
> 3. Create an image and run a fio-bed workload from client (say 16K bs, 8 num_jobs)
>
> 4. run 'dstat -m' and observe the memory usage.
>
> What I am thinking of doing is to install ceph from ceph.com and see the behavior.

In addition to that, I'd look for if there are any known bugs in the
tcmalloc version you're using on the leaky systems, and check the
tcmalloc stats to see if they have a bunch of free memory which hasn't
been released to the OS yet.
-Greg

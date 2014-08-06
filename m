From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: rework rbd_request_fn()
Date: Wed, 06 Aug 2014 14:10:58 -0500
Message-ID: <53E27DC2.2090009@ieee.org>
References: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>	<53E274AF.8030901@ieee.org>	<CALFYKtBxee2=8W_6uWT74i1GeOyuNwX85AHWVJ2-CZD3bOj_zA@mail.gmail.com> <CALFYKtDyDawX87v6uudM-_VCBTB0j6r1SPA+P_krA3V22iy-EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:40887 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbaHFTLB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Aug 2014 15:11:01 -0400
Received: by mail-ig0-f169.google.com with SMTP id r2so10871346igi.0
        for <ceph-devel@vger.kernel.org>; Wed, 06 Aug 2014 12:11:00 -0700 (PDT)
In-Reply-To: <CALFYKtDyDawX87v6uudM-_VCBTB0j6r1SPA+P_krA3V22iy-EA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 08/06/2014 02:09 PM, Ilya Dryomov wrote:
>>> Off topic...  If you supply "--patience" to your git diff command
>>> >> you'll get an easier-to-read result in some cases (like this one).
>>> >> If you like that you can just do:
>>> >>     git config --global --add diff.algorithm patience
>> >
>> > I'm generally using (and used to review this patch in particular)
>> > --histogram.  In my experience it gives slightly better results than
>> > --patience.  Didn't think of putting it into .gitconfig though.
> Looks like --histogram beats --patience in this case too.
> alloc_workqueue() hunk is much better, otherwise identical.

I didn't know about histogram...  I guess I should update
my git config.

					-Alex

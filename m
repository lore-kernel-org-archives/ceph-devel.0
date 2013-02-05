From: Gregory Farnum <greg@inktank.com>
Subject: Re: Throttle::wait use case clarification
Date: Mon, 4 Feb 2013 16:22:42 -0800
Message-ID: <CAPYLRzjy+5=Ui+C5b5d4QFttOSYz-n6nm+ObPibeTqMF7EmFdg@mail.gmail.com>
References: <50FBF3A4.4010200@dachary.org>
	<6AF9B5AC8C404CFBB78E54BA8C7FA1D2@inktank.com>
	<50FD4635.9040301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:42050 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab3BEAWo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 19:22:44 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so2910471qcq.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 16:22:43 -0800 (PST)
In-Reply-To: <50FD4635.9040301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,
Sorry for the delay in getting back to you about these patches. :( I
finally got some time to look over them, and in general it's all good!
I do have some comments, though.

On Mon, Jan 21, 2013 at 5:44 AM, Loic Dachary <loic@dachary.org> wrote:
>> Looking through the history of that test (in _reset_max), I think it's an accident and we actually want to be waking up the front if the maximum increases (or possibly in all cases, in case the front is a very large request we're going to let through anyway). Want to submit a patch? :)
> :-) Here it is. "make check" does not complain. I've not run teuthology + qa-suite though. I figured out how to run teuthology but did not yet try qa-suite.
>
> http://marc.info/?l=ceph-devel&m=135877502606311&w=4

This patch to reverse the conditional is obviously fine.

>> The other possibility I was trying to investigate is that it had something to do with handling get() requests larger than the max correctly, but I can't find any evidence of that one...
> I've run the Throttle unit tests after uncommenting
> https://github.com/ceph/ceph/pull/34/files#L3R269
> and commenting out
> https://github.com/ceph/ceph/pull/34/files#L3R266
> and it passes.

Regarding these unit tests, I have a few questions which I left on
Github. Can you address them and then give a single pull request which
includes both the Throttle fix and the tests? :)
Thanks!
-Greg

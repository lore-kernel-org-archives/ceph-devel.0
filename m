From: John Spray <jspray@redhat.com>
Subject: Re: Backporting from Infernalis and c++11
Date: Tue, 15 Sep 2015 11:02:26 +0100
Message-ID: <CALe9h7ex+31ouk+ed0d8XyuzuCw+BscM4bj8TWZ0w-RNgFa-hQ@mail.gmail.com>
References: <55F7C70B.4000308@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35425 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbbIOKCq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 06:02:46 -0400
Received: by oiww128 with SMTP id w128so91954091oiw.2
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 03:02:46 -0700 (PDT)
In-Reply-To: <55F7C70B.4000308@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 15, 2015 at 8:21 AM, Loic Dachary <loic@dachary.org> wrote:
> With Infernalis Ceph move to c++11 (and CMake), we will see more conflicts when backporting bug fixes to Hammer. Any ideas you may have to better deal with this would be most welcome. Since these conflicts will be mostly cosmetic, they should not be too difficult to resolve. The trick will be for someone not familiar with the codebase to separate what is cosmetic and what is not.
>
> This does not happen yet, no immediate concern :-) Maybe if we think about that well in advance we'll be in a better position to deal with it later on ?

I think this came up in conversation but wasn't necessarily made
official policy yet -- my understanding is that we are (already)
endeavouring to avoid c++11isms in bug fixes, along with the usual
principle of fixing bugs in the smallest/neatest patch we can.

Perhaps in cases where those of us working on master mistakenly put
something un-backportable in a bug fix, it would be reasonable for the
backporter to point it out and poke us for a clean version of the
patch.

John

From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Proposal to rename ceph-qa-suite project in tracker.ceph.com
Date: Mon, 13 Feb 2017 23:19:18 +0100
Message-ID: <ea073ca0-d439-aa6d-2b4b-f85b7cda7c06@suse.cz>
References: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
 <CAMMFjmGbCxdHtU5red8_VtOBd9KQE52b81RB-rwuab978yuysA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdBMWTV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 17:19:21 -0500
In-Reply-To: <CAMMFjmGbCxdHtU5red8_VtOBd9KQE52b81RB-rwuab978yuysA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> how do we identify make check tests  now?

Presumably, bugs in "make check" tests are currently filed under the 
appropriate project (Ceph, fs, rbd, rgw, etc.) for the code they are 
testing. In my mind, however, test bugs fall into a fundamentally 
different category than bugs in the code being tested.

> I have no objection, just FYI it maybe more complicated for downstream
> QE to easily separate make tests from "functional" tests.

We could of course make two projects, one for teuthology tests and 
another for make check tests, but that seems like overkill.

From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph v10.2.4 QE validation status
Date: Sun, 13 Nov 2016 13:34:52 +0100
Message-ID: <0f317cd4-1d50-215f-c91b-ebb5f0278e57@suse.cz>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CALe9h7dGfVTYfp0grQ3=Xq=0f01S2zN=ttJjoOKES6qmUg7wSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58001 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933747AbcKMMe4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 13 Nov 2016 07:34:56 -0500
In-Reply-To: <CALe9h7dGfVTYfp0grQ3=Xq=0f01S2zN=ttJjoOKES6qmUg7wSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Durgin, Josh" <jdurgin@redhat.com>

>> fs - http://tracker.ceph.com/issues/17832 (Greg pls review/approve)
>
> OK.  BTW feel free to backport the patch from master that disables the
> unstable flock tests.

Here's the backport:

* http://tracker.ceph.com/issues/17885
* https://github.com/ceph/ceph/pull/11953

Nathan

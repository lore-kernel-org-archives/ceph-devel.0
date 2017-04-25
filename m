From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Ceph Package Repo on Ubuntu Precise(12.04) is broken
Date: Tue, 25 Apr 2017 08:17:38 +0200
Message-ID: <bd1e7894-619d-34a0-b599-5167f52663fd@suse.cz>
References: <CAEYCsVL3SAwAr26nVFJcZqwXJM2skj5AztFSj15VRGQXvRrEvQ@mail.gmail.com>
 <CALJWc2vwBSniKR0_-dD8pK2bNmMRvj7xMD-t2qYWNrt1qy_5iQ@mail.gmail.com>
 <CAEYCsVK1YWb-0ihZ_hCz_NRYwPcosCBcL0Gq8y06VNy2gV7h0A@mail.gmail.com>
 <CAC-Np1y2ohw7NCWjthpwpZp0JL8Yn14UAxsbh6fVWtcZ1GgNkg@mail.gmail.com>
 <CAC-Np1wPAnB2gWkmdvrvk6Wf7_OUofmg3Q9D85K49JBZvfBAHQ@mail.gmail.com>
 <CAC-Np1xyYM4p=WzX7AfQF4tfqu0KpZNhPW94SzKxDk2BN9anZg@mail.gmail.com>
 <CAEYCsVJYuOx6of6ooiKfC7_o2e8mDwt49VMvpqmHQFCZ7v0oVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53187 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S980586AbdDYGRl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 25 Apr 2017 02:17:41 -0400
In-Reply-To: <CAEYCsVJYuOx6of6ooiKfC7_o2e8mDwt49VMvpqmHQFCZ7v0oVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>, Alfredo Deza <adeza@redhat.com>
Cc: xiaoguang fan <fanxiaoguang008@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi Xiaoxi

>      Just wanna to confirm again, according to the definition of
> "LTS" in ceph, Hammer suppose not EOL till Luminous is released,

This is correct.

> before that, can we expecting  hammer upgrades and packages on
> Precise/Other old OS will still be provided?
>
>       We have all our server side ceph cluster on Jewel but the pain
> point is there are still a few thousands hypervisors still on Ubuntu
> 12.04 , thus have to maintain hammer for these old stuffs.

Luminous release (and, hence, hammer EOL) is very close. Now would be a 
good time to test the upgrade and let us know which hammer fixes you 
need, if any.

Nathan

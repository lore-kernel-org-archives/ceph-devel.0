From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Object consistent when EC overwrite rollback happen?
Date: Fri, 10 Mar 2017 13:24:00 -0800
Message-ID: <CAJ4mKGYk1rCSy1FLP_Lv2p0Vobm=h2RYLotKdy5j5vVPDJA+9Q@mail.gmail.com>
References: <F0858C043E80304FBFA0A767AC8DE5E7463DA19B@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33708 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754391AbdCJVYC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Mar 2017 16:24:02 -0500
Received: by mail-ot0-f175.google.com with SMTP id 19so84843174oti.0
        for <ceph-devel@vger.kernel.org>; Fri, 10 Mar 2017 13:24:01 -0800 (PST)
In-Reply-To: <F0858C043E80304FBFA0A767AC8DE5E7463DA19B@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wangwenfeng <wang.wenfeng@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 3, 2017 at 3:08 AM, Wangwenfeng <wang.wenfeng@h3c.com> wrote:
> Hi, all
>   I have a trouble with in EC overwrite. In the function ‘generate_transactions’, using the clone_range to prepare the rollback data of EC overwrite. The clone_range is clone NO_GEN data to version data, and the new date will write after it.
> If a transaction contain the clone_range and write, and it has submit to journal, now is applying to data disk.
> If the Host power off suddenly, the transaction has apply to data, but the journal not know this. When the Host power on, maybe journal will replay the transaction which contain clone_range and write date to data disk. If this happen, the second clone_range’ data is error, it is the write data.
> The rollback to the object will cause the data error.
> Would you explain this will happen or not? And the rollback to object will cause the data error or not?

I don't understand the problem you're describing. If we replay the
journal, it will clone_range from the original (i.e., untouched) data
and just redo all the work. Where does cloning the wrong thing come
in?
(You can come up with more complicated scenarios that involve
overwriting the data we originally cloned from, but that is all
protected by versions we store in the filesystem that let us detect
these scenarios and account for them.)
-Greg

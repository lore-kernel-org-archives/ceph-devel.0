From: Tianshan Qu <qutianshan@gmail.com>
Subject: Re: Object consistent when EC overwrite rollback happen?
Date: Wed, 15 Mar 2017 16:09:30 +0800
Message-ID: <CAEv+sP7KYjO_AB3rfS0N5yR3FRLRsv7FxqfiDgoH=KR2Gn81rw@mail.gmail.com>
References: <F0858C043E80304FBFA0A767AC8DE5E7463DA19B@H3CMLB12-EX.srv.huawei-3com.com>
 <CAJ4mKGYk1rCSy1FLP_Lv2p0Vobm=h2RYLotKdy5j5vVPDJA+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33364 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdCOIJw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Mar 2017 04:09:52 -0400
Received: by mail-qt0-f179.google.com with SMTP id i34so6608332qtc.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Mar 2017 01:09:51 -0700 (PDT)
In-Reply-To: <CAJ4mKGYk1rCSy1FLP_Lv2p0Vobm=h2RYLotKdy5j5vVPDJA+9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wangwenfeng <wang.wenfeng@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I may get your point, and answer is replay guard ensure clone_range
not do again, so this problem will not happen.

2017-03-11 5:24 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Fri, Mar 3, 2017 at 3:08 AM, Wangwenfeng <wang.wenfeng@h3c.com> wrote:
>> Hi, all
>>   I have a trouble with in EC overwrite. In the function =E2=80=98genera=
te_transactions=E2=80=99, using the clone_range to prepare the rollback dat=
a of EC overwrite. The clone_range is clone NO_GEN data to version data, an=
d the new date will write after it.
>> If a transaction contain the clone_range and write, and it has submit to=
 journal, now is applying to data disk.
>> If the Host power off suddenly, the transaction has apply to data, but t=
he journal not know this. When the Host power on, maybe journal will replay=
 the transaction which contain clone_range and write date to data disk. If =
this happen, the second clone_range=E2=80=99 data is error, it is the write=
 data.
>> The rollback to the object will cause the data error.
>> Would you explain this will happen or not? And the rollback to object wi=
ll cause the data error or not?
>
> I don't understand the problem you're describing. If we replay the
> journal, it will clone_range from the original (i.e., untouched) data
> and just redo all the work. Where does cloning the wrong thing come
> in?
> (You can come up with more complicated scenarios that involve
> overwriting the data we originally cloned from, but that is all
> protected by versions we store in the filesystem that let us detect
> these scenarios and account for them.)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

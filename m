From: kefu chai <tchaikov@gmail.com>
Subject: Re: debug coredump on teuthology
Date: Tue, 14 Feb 2017 00:07:00 +0800
Message-ID: <CAJE9aOPuR=Sc12jHZ2-vM862i8LrgQkfG2FN=-JnF7FOYy=0aQ@mail.gmail.com>
References: <CAJE9aOOy503R8HAjhqOKA0RCfZA9y67h0JQfFzcXaFSZr6Fs5g@mail.gmail.com>
 <alpine.DEB.2.11.1611041319550.20331@piezo.us.to> <CAJE9aOOQSuO2Wmu0dasUxJ1mht1gcrUcckfNcsHDEKQ6ubG5wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33716 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdBMQHB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 11:07:01 -0500
Received: by mail-ua0-f171.google.com with SMTP id i68so68380999uad.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 08:07:01 -0800 (PST)
In-Reply-To: <CAJE9aOOQSuO2Wmu0dasUxJ1mht1gcrUcckfNcsHDEKQ6ubG5wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>

hey cephers who use gdb on teuthology,

i just gave the sepia_bt.sh[0] an overhaul. now it can accept only one
parameter -- the absolute path to the core-file[1]. and it will take
care of the rest to setup the gdb. if you want to check the backtrace
and poke around the coredump with gdb on teuthology, i'd recommend
sepia_bt.sh to you.

---
[0] https://github.com/ceph/ceph/blob/master/src/script/sepia_bt.sh
[1] like
$ sepia_bt.sh -c
/a/kchai-2017-02-07_18:40:28-rados-wip-16091-monc-in-parallel---basic-mira/=
796457/remote/mira051/coredump/*



On Mon, Nov 7, 2016 at 8:31 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Fri, Nov 4, 2016 at 9:22 PM, Sage Weil <sweil@redhat.com> wrote:
>> On Fri, 4 Nov 2016, kefu chai wrote:
>>> hi ceph developers,
>>>
>>> i just pulled together a simple script at
>>> https://github.com/tchaikov/sepia-bt/blob/master/bt.sh for debugging
>>> the coredump on teuthology. what it does is
>>>
>>> 1. download the ceph packages
>>> 2. extract them so we have the debugged executable and symbols
>>> 3. launch gdb and set the necessary paths
>>>
>>> et voil=C3=A0!
>>>
>>> the idea of this script comes from badone (Brad). i just translate it
>>> into a shell script.
>>>
>>> pull requests welcomed!
>>
>> This is great!  Maybe we should put it in ceph.git/src/scripts?
>
> sure, will do.
>
>
> --
> Regards
> Kefu Chai



--=20
Regards
Kefu Chai

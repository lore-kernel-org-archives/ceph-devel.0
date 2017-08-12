From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: Luminous 12.1.3 upgrade mgr nits
Date: Fri, 11 Aug 2017 17:54:26 -0700
Message-ID: <CAKPXa=aMQ+w6f6c_9E+Lgux1RY5Qw8oSR=Dj4JZZQmgTJNwaRQ@mail.gmail.com>
References: <c7dc985e-0df7-cf4c-577e-255e94315ba0@catalyst.net.nz> <558a9637-e254-6e9d-edbe-7ac2c5ac7c19@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36319 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdHLAy1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Aug 2017 20:54:27 -0400
Received: by mail-oi0-f45.google.com with SMTP id g131so46896950oic.3
        for <ceph-devel@vger.kernel.org>; Fri, 11 Aug 2017 17:54:27 -0700 (PDT)
In-Reply-To: <558a9637-e254-6e9d-edbe-7ac2c5ac7c19@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 11, 2017 at 5:26 PM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
>
> It is possible I caused this - suspect I left a rogue 'ceph-deploy mgr create...' in the script that set up the Jewel install. Will recheck and report back.

Nothing wrong with ceph-deploy, It is known, hopefully should get
fixed soon in next RC candidate: http://tracker.ceph.com/issues/20950

>
>
>
> On 12/08/17 12:22, Mark Kirkwood wrote:
>
>> Hi,
>>
>> Just had a go at this - 12.1.3 from a freshly deployed Jewel (10.2.9) on Ubuntu 16.04, following the notes in http://ceph.com/releases/v12-1-3-luminous-rc-released/
>>
>> It all worked nicely *except* for the the mgr deploy (arrrg - again)! This time it is a new wrinkle, it appears that the bootstrap-mgr auth key does not match the on disk keyring:
>>
>> markir@ceph0:~$ sudo cat /var/lib/ceph/bootstrap-mgr/ceph.keyring
>> [client.bootstrap-mgr]
>>         key = AQBWP45ZZVsOKRAAQoLg48bT6niU/dI8BmGqJQ==
>>
>>
>> markir@ceph0:~$ sudo ceph auth get client.bootstrap-mgr
>> exported keyring for client.bootstrap-mgr
>> [client.bootstrap-mgr]
>>         key = AQC7RY5ZsEHRKRAAOhUNB2rc8r/Xdg7xXIAteA==
>>         caps mon = "allow profile bootstrap-mgr"
>>
>> Editing the on disk key to make it match the one 'ceph auth get' shows solves the problem, so pretty simple to work around - if you think to check that file and auth get for differences!
>>
>> regards
>>
>> Mark
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: kefu chai <tchaikov@gmail.com>
Subject: Re: debug coredump on teuthology
Date: Mon, 7 Nov 2016 20:31:14 +0800
Message-ID: <CAJE9aOOQSuO2Wmu0dasUxJ1mht1gcrUcckfNcsHDEKQ6ubG5wg@mail.gmail.com>
References: <CAJE9aOOy503R8HAjhqOKA0RCfZA9y67h0JQfFzcXaFSZr6Fs5g@mail.gmail.com>
 <alpine.DEB.2.11.1611041319550.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36844 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbcKGMbQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2016 07:31:16 -0500
Received: by mail-qt0-f173.google.com with SMTP id w33so85701950qtc.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2016 04:31:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611041319550.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>

On Fri, Nov 4, 2016 at 9:22 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 4 Nov 2016, kefu chai wrote:
>> hi ceph developers,
>>
>> i just pulled together a simple script at
>> https://github.com/tchaikov/sepia-bt/blob/master/bt.sh for debugging
>> the coredump on teuthology. what it does is
>>
>> 1. download the ceph packages
>> 2. extract them so we have the debugged executable and symbols
>> 3. launch gdb and set the necessary paths
>>
>> et voil=C3=A0!
>>
>> the idea of this script comes from badone (Brad). i just translate it
>> into a shell script.
>>
>> pull requests welcomed!
>
> This is great!  Maybe we should put it in ceph.git/src/scripts?

sure, will do.


--=20
Regards
Kefu Chai

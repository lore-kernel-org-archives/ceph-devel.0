From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: Question about Logging Level
Date: Thu, 12 Jan 2017 22:03:32 +0800
Message-ID: <CACKY0b8SD24j7bv_Vn_AD-dA1o-fVJyjkjyXNc0-iKrbQ==jEQ@mail.gmail.com>
References: <CACKY0b-_ZaLCVUwdW4-p6BtPeaAHQ10B-KqjmxuM+Nh5h_xj5A@mail.gmail.com>
 <CALe9h7eF77h5RA8UYGv6ryC5rLwHJewZjVf8d_eKqNoMnPg6wQ@mail.gmail.com> <alpine.DEB.2.11.1701121338090.5745@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35709 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdALODe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 09:03:34 -0500
Received: by mail-yw0-f193.google.com with SMTP id 17so1481726ywk.2
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 06:03:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1701121338090.5745@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

OK, I would like to do it.

Thanks for comments.

2017-01-12 21:41 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Thu, 12 Jan 2017, John Spray wrote:
>> On Thu, Jan 12, 2017 at 8:12 AM, liuchang0812 <liuchang0812@gmail.com> w=
rote:
>> > Hi, all
>> >
>> > In our documentation, it says that:
>> >
>> >         Ceph=E2=80=99s logging levels operate on a scale of 1 to 20, w=
here 1
>> > is terse and 20 is verbose.
>> >
>> > http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/#=
subsystem-log-and-debug-settings
>> >
>> >
>> > But, it seems that there are some logging levels 25 :
>> >
>> >
>> > mds/MDBalancer.cc:276:  dout(25) << "=3D=3D=3D got heartbeat " <<
>> > m->get_beat() << " from " << m->get_source().num() << " " <<
>> > m->get_load() << dendl;
>> > mds/CInode.cc:4189:  dout(25) << __func__ << dendl;
>> > mds/MDCache.cc:11656:    //dout(25) << "saw depth " << d << " " <<
>> > *dir << dendl;
>> > mds/MDCache.cc:11666:   //dout(25) << " saw sub " << **p << dendl;
>> > mds/journal.cc:373:      dout(25) << "EMetaBlob::add_dir_context(" <<
>> > dir << ")      maybe " <<
>> >
>> >
>> > So, shoud we update our documentation, or update logging level to 20?
>>
>> Probably neither -- the >20 log messages are intentionally obscure
>> things (although I do accept that there is a reasonable argument that
>> if we would never turn something on in a real system then we perhaps
>> should not have it in the code...)
>
> FWIW, the guideline I tend to use:
>
>  10 - O(requests)
>  20 - O(requests) or O(internal structures).  e.g., we dump pg log entrie=
s
> and dump every element other ptoential large data structures at 20
>  30 - O(bytes).  several bits of code hexdump actual read/write data at
> 30)
>
> You could update the doc to mention that there are levels >20 in some rar=
e
> cases and that they are extremely verbose.
>
> sage

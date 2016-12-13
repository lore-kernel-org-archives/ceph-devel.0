From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore with ZS
Date: Tue, 13 Dec 2016 20:58:18 +0000
Message-ID: <BY2PR02MB396F6FA5C8A06E86A698208F49B0@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
 <ca516a6a-0089-2b7c-95aa-3a21de181f35@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:48393
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935220AbcLMU6W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 15:58:22 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Mark,
Multi kv sync code is quite stable and giving > 2x performance bump for ZS =
than single threaded code. If you are planning to try out ZS I would highly=
 recommend to try with the following code base.

https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thread

Add the following in the ceph.conf in addition to what I mentioned below.

bluestore_num_kv_sync_threads =3D <number>

Let me know how it goes for you.

Thanks & Regards
Somnath


-----Original Message-----
From: Somnath Roy=20
Sent: Wednesday, December 07, 2016 2:37 AM
To: 'Mark Nelson'
Cc: 'ceph-devel'
Subject: RE: Bluestore with ZS

Sage,
Here is the multi kv sync code for your review.

https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thread

It is giving ZS significant performance boost but we believe we can optimiz=
e shim further. We are working on that.

BTW, I have coded on top of your allocator changes (https://github.com/ceph=
/ceph/pull/12343)

Thanks & Regards
Somnath


-----Original Message-----
From: Somnath Roy
Sent: Tuesday, December 06, 2016 7:56 AM
To: 'Mark Nelson'
Cc: ceph-devel
Subject: RE: Bluestore with ZS

No Problem , take your time..Hopefully, by then we can give you stable mult=
i_kv version.

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com]
Sent: Tuesday, December 06, 2016 7:54 AM
To: Somnath Roy
Cc: ceph-devel
Subject: Re: Bluestore with ZS

Excellent Somnath!

I will attempt to test this today, though I also am going to be looking at =
the new RBD erasure coding stuff so it might be a day or two.

Mark

On 12/06/2016 02:33 AM, Somnath Roy wrote:
> Mark,
> Please find the Bluestore + ZS integrated code synced with today's master=
 in the following location.
>
> https://github.com/somnathr/ceph/tree/wip-bluestore-zs
>
> As discussed in the standup , this is with single kv_sync_thread.
> I am still cleaning up multi kv_sync_thread  version and will send out a =
pull request for Sage to review hopefully by tomorrow.
>
> Here is the steps you need to follow to use this.
>
> 1.  ./do_cmake.sh -DWITH_ZS=3D1
>
> 2. make and make install
>
> 3. In the ceph.conf , use the following option.
>
> enable experimental unrecoverable data corrupting features =3D bluestore=
=20
> zs rocksdb bluestore_sync_submit_transaction =3D false=20
> bluestore_kvbackend=3Dzs
>
> With smaller volumes you will be seeing rocks outperforming ZS , but, for=
 bigger volumes ZS is catching up fast.
> The code (shim layer and thus BlueStore)  is no way optimally using ZS ye=
t and we are in process of optimizing it further (with multi kv_sync, more =
batching etc. etc.).
> Will keep community posted on this.
>
> Thanks & Regards
> Somnath
>
>
>
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
>

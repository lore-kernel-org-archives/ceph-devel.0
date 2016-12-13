From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore with ZS
Date: Tue, 13 Dec 2016 21:44:28 +0000
Message-ID: <BY2PR02MB3968021B4711649E7D72C04F49B0@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
 <ca516a6a-0089-2b7c-95aa-3a21de181f35@redhat.com>
 <BY2PR02MB396F6FA5C8A06E86A698208F49B0@BY2PR02MB396.namprd02.prod.outlook.com>
 <f8bc4a5c-1c7e-c311-e9d3-c3f54b77ac24@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934927AbcLMWSy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 17:18:54 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ohh, for compilation ?
Hmm, strange , for me make -j<core> is not much different. Need to see..

-----Original Message-----
From: Somnath Roy=20
Sent: Tuesday, December 13, 2016 1:40 PM
To: 'Mark Nelson'
Cc: ceph-devel
Subject: RE: Bluestore with ZS

Have you set bluestore_num_kv_sync_threads =3D <number> (say 4 ?)

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com]
Sent: Tuesday, December 13, 2016 1:13 PM
To: Somnath Roy
Cc: ceph-devel
Subject: Re: Bluestore with ZS

I'm compiling it now in fact, though for some reason it's only using a sing=
le thread to compile so it's going *very* slow.

Mark

On 12/13/2016 02:58 PM, Somnath Roy wrote:
> Mark,
> Multi kv sync code is quite stable and giving > 2x performance bump for Z=
S than single threaded code. If you are planning to try out ZS I would high=
ly recommend to try with the following code base.
>
> https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thre
> ad
>
> Add the following in the ceph.conf in addition to what I mentioned below.
>
> bluestore_num_kv_sync_threads =3D <number>
>
> Let me know how it goes for you.
>
> Thanks & Regards
> Somnath
>
>
> -----Original Message-----
> From: Somnath Roy
> Sent: Wednesday, December 07, 2016 2:37 AM
> To: 'Mark Nelson'
> Cc: 'ceph-devel'
> Subject: RE: Bluestore with ZS
>
> Sage,
> Here is the multi kv sync code for your review.
>
> https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thre
> ad
>
> It is giving ZS significant performance boost but we believe we can optim=
ize shim further. We are working on that.
>
> BTW, I have coded on top of your allocator changes
> (https://github.com/ceph/ceph/pull/12343)
>
> Thanks & Regards
> Somnath
>
>
> -----Original Message-----
> From: Somnath Roy
> Sent: Tuesday, December 06, 2016 7:56 AM
> To: 'Mark Nelson'
> Cc: ceph-devel
> Subject: RE: Bluestore with ZS
>
> No Problem , take your time..Hopefully, by then we can give you stable mu=
lti_kv version.
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Tuesday, December 06, 2016 7:54 AM
> To: Somnath Roy
> Cc: ceph-devel
> Subject: Re: Bluestore with ZS
>
> Excellent Somnath!
>
> I will attempt to test this today, though I also am going to be looking a=
t the new RBD erasure coding stuff so it might be a day or two.
>
> Mark
>
> On 12/06/2016 02:33 AM, Somnath Roy wrote:
>> Mark,
>> Please find the Bluestore + ZS integrated code synced with today's maste=
r in the following location.
>>
>> https://github.com/somnathr/ceph/tree/wip-bluestore-zs
>>
>> As discussed in the standup , this is with single kv_sync_thread.
>> I am still cleaning up multi kv_sync_thread  version and will send out a=
 pull request for Sage to review hopefully by tomorrow.
>>
>> Here is the steps you need to follow to use this.
>>
>> 1.  ./do_cmake.sh -DWITH_ZS=3D1
>>
>> 2. make and make install
>>
>> 3. In the ceph.conf , use the following option.
>>
>> enable experimental unrecoverable data corrupting features =3D=20
>> bluestore zs rocksdb bluestore_sync_submit_transaction =3D false=20
>> bluestore_kvbackend=3Dzs
>>
>> With smaller volumes you will be seeing rocks outperforming ZS , but, fo=
r bigger volumes ZS is catching up fast.
>> The code (shim layer and thus BlueStore)  is no way optimally using ZS y=
et and we are in process of optimizing it further (with multi kv_sync, more=
 batching etc. etc.).
>> Will keep community posted on this.
>>
>> Thanks & Regards
>> Somnath
>>
>>
>>
>> PLEASE NOTE: The information contained in this electronic mail message i=
s intended only for the use of the designated recipient(s) named above. If =
the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, di=
ssemination, distribution, or copying of this message is strictly prohibite=
d. If you have received this communication in error, please notify the send=
er by telephone or e-mail (as shown above) immediately and destroy any and =
all copies of this message in your possession (whether hard copies or elect=
ronically stored copies).
>>

From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 07:44:47 -0500
Message-ID: <55D47A3F.9060001@redhat.com>
References: <55D409F0.3050802@redhat.com>	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1171B@SACMBXIP01.sdcorp.global.sandisk.com> <CACJqLyatyLmdf0ptSuJ5fGrvkQiy-5pOPHFA=h9vuG54xKrngw@mail.gmail.com> <55D473D9.3020706@redhat.com> <90559C83A9C7FA45B5846C975DFA612DDB536537B6@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbbHSMou (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Aug 2015 08:44:50 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB536537B6@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?IkRhxYJlaywgUGlvdHIi?= <Piotr.Dalek@ts.fujitsu.com>, Haomai Wang <haomaiwang@gmail.com>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/19/2015 07:36 AM, Da=C5=82ek, Piotr wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Wednesday, August 19, 2015 2:17 PM
>>
>>> The RSS memory usage in the report is per OSD I guess(really?). It
>>> can't be ignored since it's really a great improvement memory usage=
=2E
>>
>> Do you mean with tcmalloc?  I think it's a tough decision.  For jema=
lloc, 300MB
>> more of RSS per OSD does add up (about 18GB for 60 OSDs).  On the ot=
her
>> hand, the cost of memory is such a small fraction of the overall cos=
t of
>> systems like this that it might be worth it to switch over anyway.  =
In the 4K
>> write tests it's pretty clear that even with 128MB TC, TCMalloc is s=
uffering
>> and jemalloc appears to still have headroom left.  It's possible tha=
t bumping
>> the thread cache even higher might help TCMalloc close the gap thoug=
h.  It's
>> also possible that jemalloc might have worse memory behavior under
>> recovery scenarios as we discussed at the hackathon (And Somnath
>> mentioned above), so I think we probably need to run the tests.
>
> Have you tried running these tests again with TCMalloc after applying=
 patches from https://github.com/ceph/ceph/pull/5534? Because switching=
 to jemalloc alone won't fix the root issues, only make it less painful=
=2E

Not yet, my first goal was to simply replicate the tests that have=20
already been done using hammer to get a baseline on the new cluster.  I=
t=20
definitely looks like that's (yet another!) good next step.

Mark

>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

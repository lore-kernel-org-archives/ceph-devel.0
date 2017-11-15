From: Huang Zhiteng <winston.d@gmail.com>
Subject: Re: SMART disk monitoring
Date: Wed, 15 Nov 2017 08:09:26 +0800
Message-ID: <CAE7zfpOVvxC1G2=FbszoFV9PoCz7LH0mxf87G7-2QuuUPWJBJg@mail.gmail.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com> <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal>
 <3ac76cc3-92f2-5180-4389-c5334506fac4@corp.ovh.com> <ce55d8a4-040f-e107-9d86-0b3f2456988d@redhat.com>
 <096024a3-7aea-5f07-b915-ed35fc867cf9@corp.ovh.com> <alpine.DEB.2.11.1711141320110.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:45159 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdKOAJ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 19:09:27 -0500
Received: by mail-io0-f176.google.com with SMTP id i38so11804623iod.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 16:09:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711141320110.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, Ric Wheeler <rwheeler@redhat.com>, Lars Marowsky-Bree <lmb@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Another work done (probably against similar dataset from BackBlaze) by
IBM, which is pretty impressive:
https://www.ibm.com/blogs/research/2016/08/predicting-disk-failures-reliabl=
e-clouds/

On Tue, Nov 14, 2017 at 10:19 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 14 Nov 2017, Piotr Da=C5=82ek wrote:
>> On 17-11-14 05:09 AM, Ric Wheeler wrote:
>> > On 11/13/2017 05:23 PM, Piotr Da=C5=82ek wrote:
>> > > This may not work anyway, because  many controllers (including JBOD
>> > > controllers) don't pass-through SMART data, or the data don't make s=
ense.
>> >
>> > You are right that many controllers don't pass this information withou=
t
>> > going through their non-open source tools. The libstoragemgmt project =
-
>> > https://github.com/libstorage/libstoragemgmt - has added support for d=
oing
>> > some types of access for the physical back end drives. It is worth syn=
cing
>> > up with them I think to see how we might be able to extract interestin=
g
>> > bits.
>>
>> There's another problem - bcache/flashcache/<insert your favorite vendor=
>
>> cache - osds often reside on top of some cache device, and accessing SMA=
RT
>> values for that might not work, or might not return all required values.
>
> For devicemapper devices at least it is pretty straightforward to work ou=
t
> the underlying physical device.
>
> I'm sure there will always be some devices and stacks that successfully
> obscure the reliablity data, but most deployments will benefit.
>
>> > There is also a lot of information about drive failures (SSD and spinn=
ing)
>> > at USENIX FAST over many years. Things have improved a lot over the ye=
ars,
>> > especially with modern SSD's and NVME where a lot of hard work has hap=
pened
>> > to add improved metrics to the data.
>>
>> That's my point. That's a lot of statistics to chew through and most of =
it
>> relies on assumptions that can be already wrong or be wrong some time af=
ter.
>> All it takes is a brand-new product line with different characteristics.
>> SSDs are different - you just measure number of erase/program cycles and
>> (again) do assumptions based on that - that's easier and more reliable.
>> Still, I would be *very* unhappy if I'd be woken up in the middle of the=
 night
>> just to realize that cluster incorrectly predicted disk failure and my c=
ompany
>> (and I'm pretty sure not only my company) wouldn't be happy either if cl=
uster
>> would force it to throw away perfectly good disks, because reusing them =
would
>> yield the same result.
>> On the other hand, this creates a back door for vendors to force device
>> replacement even if it's perfectly fine, some SSD vendors already do thi=
s with
>> their devices going into read-only mode even when there's a whole lot of=
 p/e
>> cycles left in flash cells. I don't think we need Ceph to go this way.
>
> OT: I view building good prediction models as an orthogonal problem, and
> one that relies on collecting a large data set.  Patrick McGarry and
> several others are working on a related project to build a public data se=
t
> of SMART etc reliability data so that such models can be built for use in
> open systems.  Current data sets from backblaze suffer from a small set o=
f
> device models, which means only large cloud providers or system vendor
> with large deployments are able to gather enough healthy metrics and
> failure data to build good models.  The goal of the other project is to
> allow regular users (of systmes like Ceph) to opt into sharing reliabilit=
y
> data so that better models can be built--ones that cover a broader range
> of devices.
>
>> tl;dr - I'm fine with that feature as long as there'll be a possibility =
to
>> disable it entirely.
>
> Of course!
>
> sage



--=20
Regards
Huang Zhiteng

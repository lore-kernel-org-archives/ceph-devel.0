From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph-fs tests
Date: Wed, 5 Sep 2012 09:52:59 -0700
Message-ID: <CAPYLRzgw00hKRHj16YJdmffrvECfsBotKPUEbJ1nRqQEPF7taA@mail.gmail.com>
References: <50468E0E.6070807@smart-weblications.de>
	<CADvuQRGy9gCSwy3jMw+DGAF0MfoeohhYNgR2PJ+vDU1WW9cM+A@mail.gmail.com>
	<504780FF.6020305@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab2IEQxA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:53:00 -0400
Received: by iahk25 with SMTP id k25so1007833iah.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:52:59 -0700 (PDT)
In-Reply-To: <504780FF.6020305@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 9:42 AM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
> Am 05.09.2012 18:22, schrieb Tommi Virtanen:
>> On Tue, Sep 4, 2012 at 4:26 PM, Smart Weblications GmbH - Florian
>> Wiessner <f.wiessner@smart-weblications.de> wrote:
>>> i set up a 3 node ceph cluster 0.48.1argonaut to test ceph-fs.
>>>
>>> i mount ceph via fuse, then i downloaded kernel tree and decompress=
ed a few
>>> times, then stopping one osd (osd.1), afer a while of recovering, s=
uddenly:
>
>>
>> Please provide English error messages when you share things with the
>> list. In this case I can figure out what the message is, but really,
>> we're all pattern matching animals and the specific strings in
>> /usr/include/asm-generic/errno.h are what we know.
>>
>
> OK, will change locales.
>
>>> no space left on device, but:
>>>
>>> 2012-09-04 18:46:38.242840 mon.0 [INF] pgmap v2883: 576 pgs: 512 ac=
tive+clean,
>>> 64 active+recovering; 1250 MB data, 14391 MB used, 844 MB / 15236 M=
B avail;
>>> 36677/215076 degraded (17.053%)
>>>
>>> there is space left?
>>
>> Only 844 MB available, with the pseudo-random placement policies,
>> means you practically are out of space.
>>
>> It looks like you had only 15GB to begin with, and with typical
>> replication, that's <5GB usable space. That is dangerously small for
>> any real use; Ceph currently does not cope very well with running ou=
t
>> of space.
>>
>
> It is a test-cluster running on my thinkpad, its main purpose is to t=
est cephfs,
> there is no need for real space. I added osd.1 again, then after reco=
very the
> problem went away. I forced this situation to check how cephfs will b=
ehave when
> cluster is near-full, osd fails and ceph tries to recover until backf=
ill fills
> up other osds so ceph is full.
>
> I observed on the client that no IO was possible anymore so that the =
client was
> unusable.
>
> Is there a smarter way to handle this? It is bad that cephfs then sta=
lls, it
> would be better if it just returns that there is no space left, but s=
till allow
> read access... can this be tuned somewhere?

What client were you using? I believe it does allow reads while full =97
but your client can pretty easily get itself into a situation where it
needs to perform writes in order to continue doing reads.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

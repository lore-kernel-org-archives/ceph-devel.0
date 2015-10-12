From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next hammer release v0.94.4
Date: Mon, 12 Oct 2015 16:05:18 -0700
Message-ID: <CADRKj5QrJtjfTHNj5ye-GVxcxmVF8EaQV+vg1GSSSSxgC81q2g@mail.gmail.com>
References: <560EE98C.5090202@dachary.org>
	<561C3AB8.2090808@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33564 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbbJLXFT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 19:05:19 -0400
Received: by obbbh8 with SMTP id bh8so601798obb.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 16:05:18 -0700 (PDT)
In-Reply-To: <561C3AB8.2090808@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Yeah, it should be fine.

On Mon, Oct 12, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> After todays private discussion and the merge of https://github.com/c=
eph/ceph/pull/6161, I will assume the current hammer branch (7f485ed5aa=
620fe982561663bf64356b7e2c38f2) is ready for QE to start their own roun=
d of testing. If I misinterpreted what you wrote, please speak up and I=
'll do what's needed ;-)
>
> Cheers
>
> On 02/10/2015 22:31, Loic Dachary wrote:
>> Hi Yehuda,
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tre=
e/hammer passed the rgw suite (http://tracker.ceph.com/issues/12701#not=
e-58).
>> Do you think the hammer branch is ready for QE to start their own ro=
und of testing ?
>>
>> Cheers
>>
>> P.S. http://tracker.ceph.com/issues/12701#Release-information has di=
rect links to the pull requests merged into hammer since v0.94.3 in cas=
e you need more context about one of them.
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph benchmarks
Date: Wed, 29 Aug 2012 00:16:28 +0200
Message-ID: <CAOLwVU=HYFOVegVsRTKjF9deq4r3VAvHOdkdLKMxt+Fu0sWt=Q@mail.gmail.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
 <CADvuQRGvz3Fy=vxAFfETMkcLRVBBROCUxXFDdF4C1Mupf5oPHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43568 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab2H1WQu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 18:16:50 -0400
Received: by lbbgj3 with SMTP id gj3so3610729lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 15:16:48 -0700 (PDT)
In-Reply-To: <CADvuQRGvz3Fy=vxAFfETMkcLRVBBROCUxXFDdF4C1Mupf5oPHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

@Mark Nelson: thanks for the precision, I'll think about that the next
time I'll build an array. It was raid1 with 2 disks (no broken array)

@Plaetinck, Dieter: Sorry I made a little mistake, I was referring
about the system cache (page cache), the one which considers write
operations to the storage system complete after the data has been
copied into it. Secondly the disk write cache (hard drive disk), the
one stored into the hard drive disk. I'm going to make the sentence
clearer and remove the disk write cache part.

@Jerker Nyberg: I performed some measure on each system during a write
but it's more in my head than on the paper. As I can say, the
commodity cluster was struggling during the write. The other machines
barely showed a load, even when I deactivated every cores and kept
only 1 or 2 it was ok. The CPU load from the OSD wasn't so high.

@Tommi Virtanen: nice catch! I'm gonna update the article :)

Thank you for all the feedback, I'll try to perform some of the tests
guys mentioned above :)

On Tue, Aug 28, 2012 at 3:11 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Aug 27, 2012 at 1:47 PM, S=E9bastien Han <han.sebastien@gmail=
=2Ecom> wrote:
>> For those of you who are interested, I performed several benchmarks =
of
>> RADOS and RBD on different types of hardware and use case.
>> You can find my results here:
>> http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/
>
> Nice!
>
> Minor nit: "sudo echo 3 | tee /proc/sys/vm/drop_caches && sudo sync"
> you probably want "say echo 3 | sudo tee ... && sync"
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

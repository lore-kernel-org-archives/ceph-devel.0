From: Vasilakakos Giorgos <sugoruyo@gmail.com>
Subject: Re: Question: How does Ceph go from filename to object?
Date: Mon, 4 Jul 2011 22:30:43 +0300
Message-ID: <CANJmCGKS4-zirR3zAhS7SuTRdFddKXxdhq3A7ciHxKXEvhv4Pg@mail.gmail.com>
References: <CANJmCGLt2hPjETaa5bGt71Ewyo4Z-q6XXYsegRUAZNZb-h7J3A@mail.gmail.com>
 <CANJmCG+HZWWnEmpJ+pY4fjweBckRMPh+b6OiD=kk1egwT9B3=Q@mail.gmail.com> <1309801784.2518.12.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40781 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab1GDTbY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 15:31:24 -0400
Received: by qwk3 with SMTP id 3so2565985qwk.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 12:31:23 -0700 (PDT)
In-Reply-To: <1309801784.2518.12.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

I've read the thesis, but not the papers! Didn't even know they existed=
=2E..
I just looked them over, there's a lot of overlap with the thesis, I'm
still not sure how everything works.
If someone could outline/clarify the process (for example in a
numbered list of steps) I would be very grateful. I'll still go over
the papers in detail - I just find the papers and thesis a little
confusing on this.
I'd say the definitive source for this would be the actual code, but I
have neither the time nor the experience with C++ to be able to go
over it...

btw, thanks for the links :P

On Mon, Jul 4, 2011 at 20:49, Wido den Hollander <wido@widodh.nl> wrote=
:
> Hi,
>
> On Mon, 2011-07-04 at 20:17 +0300, Vasilakakos Giorgos wrote:
>> Hello folks, I have a question:
>> I know files get mapped to objects and those objects to OSDs but how
>> exactly do we go from one to the other?
>> What I mean is, given the filename I want to access how does Ceph fi=
nd
>> the relevant objects? What exactly does CRUSH do?
>> Supposedly, the client first asks the MDS for an inode number, what =
then?
>> How are the object and PG IDs constructed and where exactly does CRU=
SH come in?
>> My impression is that the OID is made from the name, inode and
>> probably some kind of information about the striping of the file,
>> what about the mapping of an object to a PG?
>> Are PGs mapped to OSDs by means of CRUSH, or are objects mapped to P=
Gs
>> by CRUSH? How are PGs assigned to OSDs then?
>>
>> Could someone clarify this part for me?
>
> Have you read the RADOS, CRUSH and Ceph thesis on the website?
>
> Try:
> * http://ceph.newdream.net/weil-thesis.pdf
> * http://ceph.newdream.net/papers/weil-rados-pdsw07.pdf
> * http://ceph.newdream.net/papers/weil-ceph-osdi06.pdf
> * http://ceph.newdream.net/papers/weil-crush-sc06.pdf
>
> I think that should cover most of it.
>
>>
>> Thanks in advance
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

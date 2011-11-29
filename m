From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Re: Ceph stripe reading and writing question
Date: Mon, 28 Nov 2011 20:56:50 -0800
Message-ID: <CAND_vCa-q8nPNkFjyDKAZ75O8mJTckwSP_AkJ8OEVwpZbH=VdA@mail.gmail.com>
References: <CAND_vCbozehy2107R9+BrcK+wx1ReVot9hQ9VY0HjebDuigwdQ@mail.gmail.com>
 <CAND_vCbSBya4Cok21FPTrE-2SJ3XsXjTX0xD2NyqYkWCkyV9fw@mail.gmail.com> <-6796339341470921814@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59322 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab1K2E5V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 23:57:21 -0500
Received: by iage36 with SMTP id e36so10013520iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 20:57:21 -0800 (PST)
In-Reply-To: <-6796339341470921814@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 28, 2011 at 7:48 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> (Added list for future reference.)
> On Nov 28, 2011, at 5:47 PM, Xiaofei Du <xiaofei.du008@gmail.com> wro=
te:
>
> Do you remember we talked several days before about the problem I
> encountered for testing ceph on ec2? The reason I ask this question i=
s
> I am still confused with one of the results.=A0The following is what =
you
> told me.
>
> You have two nodes that write at 20MB/s and six that write at 45MB/s.
>
> Journaling cuts each of those in half: two nodes at 10MB/s, six at
>
> 23MB/s. That's an aggregate 158MB/s of write bandwidth, but each writ=
e
>
> goes to two OSDs so you only get half of that, or 79MB/s of write
>
> bandwidth. You are getting about the bandwidth I would expect out of =
a
>
> slow and unbalanced cluster.
>
> My question is since journaling cuts the bandwidth of each node into
> half. When I did the test for writing a single file. Why could I stil=
l
> achieve a bandwidth around 45MB/s. If it goes to the 45MB/s node, it
> could only achieve 23MB/s. My question is why it could still achieve
> 45MB/s for writing a single file? Thanks a lot
>
> As you reference below, Ceph stripes files over objects (4MB by defau=
lt).
> When you write an object, it can buffer the write, and when it flushe=
s the
> buffer out to disk it can send objects out to multiple OSDs simultane=
ously.
Awesome, Ceph's design is really nice in many details

>
>
> On Nov 28, 2011, at 5:27 PM, Xiaofei Du <xiaofei.du008@gmail.com> wro=
te:
>
> Hi Gregory,
> I have a question about Ceph's read and write mechanism. If I only wr=
ite one
> file or read one file at a time. Does it doing the read and the write
> concurrently for each of the stripe? For example. I have a 160 MB fil=
e.
> Ceph's stripe is 16MB, which means this file will be striped into 10
> objects. My question is when I do reading or writing for this file, w=
ill it
> do it concurrently?
>
> Have you adjusted the stripe size? The default is 4MB.
> In any case, yes, it will do concurrent IOs.
> -Greg
No. I didn't adjust the stripe size. Because I saw 16MB on the Ceph
paper. So I thought the default one was 16MB. Thanks a lot again. Greg

Best,
Xiaofei


--=20
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

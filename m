From: huang jun <hjwsm1989@gmail.com>
Subject: Re: osd deployment affects samba read performance
Date: Wed, 12 Oct 2011 09:01:02 +0800
Message-ID: <CABAwU-ZoDeF9rChNtooUa1Mpt21MuhP07DMfQdtQvQ8zNToCLQ@mail.gmail.com>
References: <CABAwU-afNz4NDyKAGz+9OiFH57WQ0AsPi4HCOTM6B+OjAnsoYg@mail.gmail.com>
	<Pine.LNX.4.64.1110110830050.20977@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57670 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab1JLBBC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 21:01:02 -0400
Received: by pzk1 with SMTP id 1so391419pzk.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 18:01:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110110830050.20977@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

we are using kernel client.
in the condition 1), read rate can reach 110MB/s,that indicate we have
added  the readhead into the kernel client code.
the problem is: in the conditon 2) the kernel client's read rate also
declined 10~20MB/s, that confused us very much, any opinions?

thanks

2011/10/11 Sage Weil <sage@newdream.net>:
> On Tue, 11 Oct 2011, huang jun wrote:
>> hi,all
>> Recently, we test the samba read performance,and find something stra=
nge.
>> there are two groups to test:
>> the cluster include 1 MON and 1 MDS,and
>> 1) 2 OSDs on the same machine
>> 2) 2 OSDs on the different machine
>> when we use samba to test read,
>> in the first condition =A0it is about 110MB/s, but in the second
>> condition it is only 60MB/s.
>>
>> we anlysed it from the debug log /var/log/ceph/osd.*.log,
>> in the condition 1), the OSD spends about 7~8ms (from sending
>> osd_op_reply to getting the next client read request)
>> but in 2) we spends about 12~14ms.
>
> The osd_op_reply message shows up in the osd log when the message is
> queued. =A0Since these are reads, the messages are large (they carry =
the
> data payload), and will take more time to send over the wire when pas=
sing
> over the network.
>
> It sounds like the problem is that only a single read is being issued=
 at a
> time (i.e. readahead isn't working). =A0Are you using the kernel clie=
nt or
> libceph/cfuse? =A0Readahead was only recently fixed in the kernel cli=
ent.
> The patches are in the master branch of ceph-client.git, but are not =
yet
> upstream; they should be merged in 3.2-rc1 in the upcoming merge wind=
ow.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

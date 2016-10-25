From: Abhishek L <abhishek@suse.com>
Subject: Re: jewel 10.2.4 freeze
Date: Tue, 25 Oct 2016 11:31:06 +0200
Message-ID: <87y41cixlx.fsf@suse.com>
References: <580E1C53.6060503@dachary.org> <87funlerf5.fsf@suse.com> <CABo9giRJpEcMJjLeAHWivJGXYtpsTnN72Nwvej0CoMtRvGYkQg@mail.gmail.com> <618111920.22040164.1477360917772.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:45849 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755405AbcJYJbT (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 25 Oct 2016 05:31:19 -0400
In-reply-to: <618111920.22040164.1477360917772.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Orit Wasserman <owasserm@redhat.com>
Cc: Abhishek L <abhishek@suse.com>, Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>


Matt Benjamin writes:

> This would really be a wise idea.
>
> Matt
>
> ----- Original Message -----
>> From: "Orit Wasserman" <owasserm@redhat.com>
>> To: "Abhishek L" <abhishek@suse.com>
>> Cc: "Loic Dachary" <loic@dachary.org>, "Abhishek L" <abhishek.lekshmanan@gmail.com>, "Ceph Development"
>> <ceph-devel@vger.kernel.org>, "Abhishek Varshney" <abhishek.varshney@flipkart.com>
>> Sent: Monday, October 24, 2016 4:21:40 PM
>> Subject: Re: jewel 10.2.4 freeze
>>
>> Hi,
>> Will it be possible to include https://github.com/ceph/ceph/pull/11626 ?
>>
>> Orit

There are a few valgrind failures for RGW on the teuthology run scheduled,
http://pulpito.ceph.com/owasserm-2016-10-24_20:21:59-rgw-wip-jewel-11567---basic-vps/

(and maybe related to the patch?)
>>
>> On Mon, Oct 24, 2016 at 4:46 PM, Abhishek L <abhishek@suse.com> wrote:
>> >
>> > Loic Dachary writes:
>> >
>> >> Hi Abhishek,
>> >>
>> >> If we were to freeze jewel 10.2.4 today it would have 115 backports[0]. Do
>> >> you think it we should stop merging new backports and prepare for the
>> >> release ? If so, I'll ask the lead of each component to make sure nothing
>> >> is missing from their point of view.
>> >
>> > Yes, lets start getting the ack from the leads
>> >>
>> >> You can find the progress of the jewel 10.2.4 release in the
>> >> ttp://tracker.ceph.com/issues/17487.
>> >>
>> >> Cheers
>> >>
>> >> [0] issues backported and merged in jewel 10.2.4
>> >> http://tracker.ceph.com/versions/524
>> >>
>> >> --
>> >> Loïc Dachary, Artisan Logiciel Libre
>> >
>> >
>> > Best,
>> > Abhishek
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

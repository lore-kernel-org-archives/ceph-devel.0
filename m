From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: jewel 10.2.4 freeze
Date: Mon, 24 Oct 2016 22:21:40 +0200
Message-ID: <CABo9giRJpEcMJjLeAHWivJGXYtpsTnN72Nwvej0CoMtRvGYkQg@mail.gmail.com>
References: <580E1C53.6060503@dachary.org> <87funlerf5.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37829 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932580AbcJXUVn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 16:21:43 -0400
Received: by mail-wm0-f44.google.com with SMTP id d199so8105997wmd.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 13:21:42 -0700 (PDT)
In-Reply-To: <87funlerf5.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi,
Will it be possible to include https://github.com/ceph/ceph/pull/11626 ?

Orit

On Mon, Oct 24, 2016 at 4:46 PM, Abhishek L <abhishek@suse.com> wrote:
>
> Loic Dachary writes:
>
>> Hi Abhishek,
>>
>> If we were to freeze jewel 10.2.4 today it would have 115 backports[0]. Do you think it we should stop merging new backports and prepare for the release ? If so, I'll ask the lead of each component to make sure nothing is missing from their point of view.
>
> Yes, lets start getting the ack from the leads
>>
>> You can find the progress of the jewel 10.2.4 release in the ttp://tracker.ceph.com/issues/17487.
>>
>> Cheers
>>
>> [0] issues backported and merged in jewel 10.2.4 http://tracker.ceph.com/versions/524
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>
>
> Best,
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

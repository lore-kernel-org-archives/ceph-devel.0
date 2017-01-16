From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Request for advice on ceph compile time.
Date: Mon, 16 Jan 2017 15:30:31 -0500
Message-ID: <CA+aFP1AS-vKtW9c-hy00eOoKUoq3At4ky-pYTEYJofiXvpL-LQ@mail.gmail.com>
References: <CA+hcxJR65Ux2J+nUyFAXz08aZkrWVBKrSKeH-kH-Rqd-FLXNqg@mail.gmail.com>
 <85210ecc-191d-ac31-7d0b-ee9be562c83c@mirantis.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36513 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdAPUaz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2017 15:30:55 -0500
Received: by mail-lf0-f51.google.com with SMTP id z134so88809375lff.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2017 12:30:33 -0800 (PST)
In-Reply-To: <85210ecc-191d-ac31-7d0b-ee9be562c83c@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

3) lots of RAM and a fast SSD/NVMe drive
4) ensure ccache is configured and in-use

On Mon, Jan 16, 2017 at 2:51 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> My best choices are:
>
> 1) Use  -j switch for make
>
> 2) Make specific target(s) only, e.g. some UT for the code I'm working on
> and proceed with the full build when most of the patch is ready.
>
>
>
> On 1/16/2017 10:19 PM, Victor Denisov wrote:
>>
>> Cephers,
>>
>> Could you please give me some advice on how to have a faster turn
>> around for change - compile process. Currently I usually do a change
>> and then compile which often takes quite a while and gets in the way
>> of being in the flow. I'm trying to mitigate it by changing as big
>> chunks as possible before compiling, but it's not a very pleasant
>> experience. So, I thought may be you could share your experience.
>>
>> Thanks in advance.
>> Victor.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason

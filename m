From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cephfs in kernel 4.9: NULL pointer deref
Date: Mon, 11 Dec 2017 10:32:48 -0800
Message-ID: <CAJ4mKGb5dCLTNaGLgU9GHU9H2H5=94G78GvAhyOHBHVV=Q33Og@mail.gmail.com>
References: <50304bd9-4d80-5665-ad24-7b547c70c085@m-privacy.de> <CAAM7YAmh9TZx7griYS96q85dU=bP329tr+QQXDSfceg06fTiNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:40751 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLKSct (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Dec 2017 13:32:49 -0500
Received: by mail-it0-f54.google.com with SMTP id f190so18047309ita.5
        for <ceph-devel@vger.kernel.org>; Mon, 11 Dec 2017 10:32:49 -0800 (PST)
In-Reply-To: <CAAM7YAmh9TZx7griYS96q85dU=bP329tr+QQXDSfceg06fTiNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 11, 2017 at 4:48 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Mon, Dec 11, 2017 at 8:13 PM, Amon Ott <a.ott@m-privacy.de> wrote:
>> Hello Ceph folks,
>>
>> when running latest Stable 64 Bit Google Chrome under Linux with home
>> dirs on cephfs, I get the attached kernel trace and cephfs access hangs
>> afterwards. Umounting cephfs no longer works, only a hard system reset
>> helps. Since it only happens on cephfs, I hope to get some help here.
>>
>> Kernel versions tested are 4.9.67 and 4.9.68, each with RSBAC patched
>> in. However, RSBAC does not touch these funktions. Since 4.9.68 just had
>> a fix related to page_mkwrite(), it might be related. The trace can be
>> reproduced with every start of Chrome, but we have not seen anything
>> similar with other applications, e.g. Firefox. Ceph backend lives on xfs
>> or btrfs on the same system, crash happens with both.
>>
>> Thanks for all your good work,
>
> it's likely caused by following code in ceph_read_iter()
>
> current->journal_info = filp;
> ret = generic_file_read_iter(iocb, to);
> current->journal_info = NULL;
>
> ceph set current->journal_info, which confuses ext4. I will try
> writing a fix tomorrow.

I don't understand how Ceph code changing a ceph inode can confuse
ext4. Can you provide a little more background here?
-Greg

>
> Regards
> Yan, Zheng
>
>>
>> Amon Ott
>> --
>> Dr. Amon Ott
>> m-privacy GmbH           Tel: +49 30 24342334
>> Werner-Voß-Damm 62       Fax: +49 30 99296856
>> 12101 Berlin             http://www.m-privacy.de
>>
>> Amtsgericht Charlottenburg, HRB 84946
>>
>> Geschäftsführer:
>>  Dipl.-Kfm. Holger Maczkowsky,
>>  Roman Maczkowsky
>>
>> GnuPG-Key-ID: 0x2DD3A649
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

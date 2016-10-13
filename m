From: Zack Cerza <zack@redhat.com>
Subject: Re: teuthology-suite argument puzzle
Date: Thu, 13 Oct 2016 11:51:56 -0600
Message-ID: <CACk6FjkrVwSOyonPCoOQKiX83d+0zbxYQJ4hCOj4a2_HQ_MJdQ@mail.gmail.com>
References: <57FF8326.4040209@dachary.org> <0ff53e69-64f2-bb73-11dc-111f9e638232@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33172 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932943AbcJMR6V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 13:58:21 -0400
Received: by mail-lf0-f46.google.com with SMTP id x79so151982233lff.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 10:57:14 -0700 (PDT)
In-Reply-To: <0ff53e69-64f2-bb73-11dc-111f9e638232@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Yesterday afternoon Yuri pointed out that in some cases --rerun is
generating the wrong amount of jobs. I've looked into it but haven't
yet found the cause. There's definitely a bug there, though it appears
to only affect some suites. I'll try to sort it out in the next few
days.

On Thu, Oct 13, 2016 at 10:14 AM, David Zafman <dzafman@redhat.com> wrote:
>
> I was trying --rereun today too.  I do know that you wanted to eliminate the
> --suite option.  But I have 10 failed jobs, but a --dry-run said it would
> have only scheduled 1 job.
>
> David
>
>
> On 10/13/16 5:50 AM, Loic Dachary wrote:
>>
>> Hi Zack,
>>
>> I wanted to try --rerun and ran into a cryptic error message:
>>
>> run=loic-2016-10-13_09:20:07-rgw-jewel-backports-distro-basic-smithi
>> teuthology-suite -k distro --priority 101 --suite rgw --rerun $run
>> --suite-branch jewel --email loic@dachary.org --ceph jewel-backports
>> --machine-type smithi
>> usage: teuthology-suite --help
>>         teuthology-suite [-v | -vv ] --suite <suite> [options]
>> [<config_yaml>...]
>>         teuthology-suite [-v | -vv ] --rerun <name>  [options]
>> [<config_yaml>...]
>>
>> What did I do wrong ?
>>
>> Cheers
>
>

From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: standby_count_wanted
Date: Thu, 18 May 2017 20:12:43 -0400
Message-ID: <CA+2bHPaJsPQayPBcWBnswJKtePvoU=gXUg0JRKCeg9YBkdHQuw@mail.gmail.com>
References: <062f5224-fe69-ca4c-9180-5964cd6609b0@redhat.com> <CA+2bHPa=WbeJ5Hsmr2DAQYou7QSTifCj5UuD9t1xw3p1mkBbMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32828 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbdESANP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 20:13:15 -0400
Received: by mail-qk0-f182.google.com with SMTP id y201so49750384qka.0
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 17:13:14 -0700 (PDT)
In-Reply-To: <CA+2bHPa=WbeJ5Hsmr2DAQYou7QSTifCj5UuD9t1xw3p1mkBbMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

+ ceph-devel

On Thu, May 18, 2017 at 8:11 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> Hi David,
>
> That should be fixed by: https://github.com/ceph/ceph/pull/15126
>
> Sorry for the trouble.
>
> On Thu, May 18, 2017 at 8:10 PM, David Zafman <dzafman@redhat.com> wrote:
>>
>> Patrick,
>>
>>
>>     It looks like a commit which tests the standby_count_wanted option has
>> been committed, but it fails and I don't see the implementation anywhere.
>>
>>
>> 2017-05-18T22:58:43.585 INFO:teuthology.orchestra.run.smithi161:Running:
>> 'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage
>> timeout 120 ceph --cluster ceph fs set cephfs standby_count_wanted 0'
>> 2017-05-18T22:58:43.725
>> INFO:teuthology.orchestra.run.smithi161.stderr:Invalid command:
>> standby_count_wanted not in
>> max_mds|max_file_size|allow_new_snaps|inline_data|cluster_down|allow_multimds|allow_dirfrags
>> 2017-05-18T22:58:43.725 INFO:teuthology.orchestra.run.smithi161.stderr:fs
>> set <fs_name>
>> max_mds|max_file_size|allow_new_snaps|inline_data|cluster_down|allow_multimds|allow_dirfrags
>> <val> {<confirm>} :  set mds parameter <var> to <val>
>> 2017-05-18T22:58:43.725 INFO:teuthology.orchestra.run.smithi161.stderr:Error
>> EINVAL: invalid command
>>
>>
>> http://pulpito.ceph.com/dzafman-2017-05-18_15:46:40-rados-wip-zafman-testing-distro-basic-smithi/1193530

-- 
Patrick Donnelly
